# vim:fileencoding=utf-8:noet
from __future__ import (unicode_literals, division, absolute_import, print_function)

import json
import os

from powerline.lib.url import urllib_read, urllib_urlencode
from powerline.lib.threaded import KwThreadedSegment
from powerline.segments import with_docstring


# XXX Warning: module name must not be equal to the segment name as long as this
# segment is imported into powerline.segments.common module.

WEATHER_UNIT_ENV = "POWERLINE_SEGMENT_WTTR_UNIT"

Celcius = "m"
Fahrenheit = "u"

unit_mappings = {
  "c": Celcius,
  "C": Celcius,
  "M": Celcius,
  "m": Celcius,
  "f": Fahrenheit,
  "F": Fahrenheit,
  "u": Fahrenheit,
  "U": Fahrenheit,
}


WEATHER_SYMBOL = {
    "Unknown":             u"✨",
    "Cloudy":              u"☁️",
    "Fog":                 u"🌫",
    "HeavyRain":           u"🌧",
    "HeavyShowers":        u"🌧",
    "HeavySnow":           u"❄️",
    "HeavySnowShowers":    u"❄️",
    "LightRain":           u"🌦",
    "LightShowers":        u"🌦",
    "LightSleet":          u"🌧",
    "LightSleetShowers":   u"🌧",
    "LightSnow":           u"🌨",
    "LightSnowShowers":    u"🌨",
    "PartlyCloudy":        u"⛅️",
    "Sunny":               u"☀️",
    "ThunderyHeavyRain":   u"🌩",
    "ThunderyShowers":     u"⛈",
    "ThunderySnowShowers": u"⛈",
    "VeryCloudy": u"☁️",
}

WEATHER_NAME = {v: k for k, v in WEATHER_SYMBOL.items()}

class WeatherSegment(KwThreadedSegment):
	interval = 600
	default_location = None
	location_urls = {}

	@staticmethod
	def key(location_query=None, **kwargs):
		return location_query

	@staticmethod
	def get_unit():
		return unit_mappings.get(
			os.environ.get(WEATHER_UNIT_ENV)
			,Celcius
		)

	def get_request_url(self, location_query):
		try:
			return self.location_urls[location_query]
		except KeyError:
			if location_query is None:
				location_data = json.loads(urllib_read('http://geoip.nekudo.com/api/'))
				location = ','.join((
					location_data['city'],
					location_data['country']['name'],
					location_data['country']['code']
				))
				self.info('Location returned by nekudo is {0}', location)
			else:
				location = location_query
			format_ = "%c||+%l:+%t"
			self.location_urls[location_query] = url = (
				'http://wttr.in/{location}?format={format_}&{units}'.format(
					location=location,
					units=self.get_unit(),
					format_=format_
				)
			)
			return url

	def compute_state(self, location_query):
		url = self.get_request_url(location_query)
		raw_response = urllib_read(url)
		if not raw_response:
			self.error('Failed to get response')
			return None

		return raw_response

	def render_one(self, weather, **kwargs):
		if not weather:
			return None

		response = weather.split("\n")[0]
		icon, rest = response.split("||")
		with open("/mnt/Profiles/ahughes@netflix.local/output.txt", "wb") as fh:
				fh.write(bytes(response, "utf-8"))
				fh.write(bytes(weather, "unicode-escape"))

		groups = ['weather_conditions', 'weather']
		return [
			{
				"contents": bytes(bytes(icon, "utf-16"), "utf-16")
			}
			{
				"contents": WEATHER_NAME.get(icon, "Unknown")

			},
			{
				'contents': rest,
				'highlight_groups': groups,
				'divider_highlight_group': 'background:divider',
			},
		]


weather = with_docstring(WeatherSegment(),
'''Return weather from wttr.in.

Uses GeoIP lookup from http://geoip.nekudo.com to automatically determine
your current location. This should be changed if you’re in a VPN or if your
IP address is registered at another location.

Returns a list of colorized icon and temperature segments depending on
weather conditions.

:param str unit:
	temperature unit, can be one of ``F``, ``C`` or ``K``
:param str location_query:
	location query for your current location, e.g. ``oslo, norway``

Divider highlight group used: ``background:divider``.

Highlight groups used: ``weather_conditions`` or ``weather``, ``weather_temp_gradient`` (gradient) or ``weather``.
''')

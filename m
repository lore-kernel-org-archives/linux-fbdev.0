From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Sep 2015 11:47:08 +0000
Subject: Re: [PATCHv2 3/3] devicetree: Add led-backlight binding
Message-Id: <55F01C3C.5030406@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xsNXfj7kXXbxf44MxdWNtauAk8N77q7L8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441711176-4258-1-git-send-email-tomi.valkeinen@ti.com>
 <1441711176-4258-4-git-send-email-tomi.valkeinen@ti.com>
 <20150908134140.GH30736@lunn.ch>
In-Reply-To: <20150908134140.GH30736@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org

--xsNXfj7kXXbxf44MxdWNtauAk8N77q7L8
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 08/09/15 16:41, Andrew Lunn wrote:
> On Tue, Sep 08, 2015 at 02:19:36PM +0300, Tomi Valkeinen wrote:
>> Add DT binding for led-backlight.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>  .../bindings/video/backlight/led-backlight.txt     | 30 +++++++++++++=
+++++++++
>>  1 file changed, 30 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/video/backlight/=
led-backlight.txt
>>
>> diff --git a/Documentation/devicetree/bindings/video/backlight/led-bac=
klight.txt b/Documentation/devicetree/bindings/video/backlight/led-backli=
ght.txt
>> new file mode 100644
>> index 000000000000..fb77051ac230
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/video/backlight/led-backlight.=
txt
>> @@ -0,0 +1,30 @@
>> +led-backlight bindings
>> +
>> +Required properties:
>> +  - compatible: "led-backlight"
>> +  - leds: phandle to a led OF node [0]
>> +  - brightness-levels: Array of distinct LED brightness levels. These=

>> +      are in the range from 0 to 255, passed to the LED class driver.=

>> +  - default-brightness-level: the default brightness level (index int=
o the
>> +      array defined by the "brightness-levels" property)
>> +  - power-supply: regulator for supply voltage
>=20
> Hi Tomi
>=20
> Maybe this regulator should be optional? I could imagine blacklights
> without one, in none power sensitive cases, e.g. industrial PC with a
> touch screen display, train ticket machine, etc.

Yes, I think so. Especially in this case as this led-backlight device is
not exactly a specific HW device, but more of a virtual device.

 Tomi


--xsNXfj7kXXbxf44MxdWNtauAk8N77q7L8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV8Bw8AAoJEPo9qoy8lh71I1EP/iN9GLtI9guJq2BDj5nbwElY
DLwFncpwaSq76ZDSrtX9nl4Q06njlMGB7hK9u2bFkqJcpGyxHo4vyeKuoknyHarD
weHQdL4iu5cFgy7SJqVjqlq2yFzh/WdbS779AHQzKFjJ0dy+ztWHekljuchGIBt4
bYgNwhAaZaP88cm3OCNw7aR4Ll3G67MqlZQmj2G1nI3FjDlDGax85CHf77akMcFj
iwVYBZ9g8m9GvqF/XZAWE5MICDADgu3Tw3tajV3rOj2l/Bz/5HA0w1Mb+KfXaJaN
YrWTrB1HDGj3c2Jjj1Q0X79xlsEFf77Z125Q+DMYoJJOSQ0L+10w+bsSexP4tNGE
gWv0RhtHlATDhNIM0kzBydGZYom8C/fDTW0e3tP++/KR2OlVsLJ8B2S02xfqJMTt
TNP54mQ31+5tdzutTP1vJs1sTKIH24pG0cS1iY+j/ZorhUseZutvLCFzyqT4lSAU
6/UX4O9tA1oHp7ECJntNuOE05d2T5hlKopfoQLeI3XoDjQG+rh5776g5AFSn0kSp
BqhLTuaZ39q7kJq+OGGOdW/ppsdNcxkAjNS/qrtEV7YRa4rk6BDAxzPL39BeyJ+L
1SjUxLgWPaCz4LvGLfqwgpTPJkMW2UNFLN+xVxs9rjAB9aGvNdyU8Vh+I3m4G+LW
j6b0knzmo9NokO8vw1Ih
=0FfK
-----END PGP SIGNATURE-----

--xsNXfj7kXXbxf44MxdWNtauAk8N77q7L8--

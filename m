From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 28 Feb 2014 16:30:42 +0000
Subject: Re: [PATCH 9/9] Doc/DT: Add DT binding documentation for tpd12s015 encoder
Message-Id: <5310B9B2.6030008@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ju2boOKpostCmGQcRnub3MkrjROaqQskd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-10-git-send-email-tomi.valkeinen@ti.com>
 <20140228161343.GS21483@n2100.arm.linux.org.uk>
In-Reply-To: <20140228161343.GS21483@n2100.arm.linux.org.uk>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--ju2boOKpostCmGQcRnub3MkrjROaqQskd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/02/14 18:13, Russell King - ARM Linux wrote:
> On Fri, Feb 28, 2014 at 02:20:16PM +0200, Tomi Valkeinen wrote:
>> Add DT binding documentation for tpd12s015 encoder
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Reviewed-by: Archit Taneja <archit@ti.com>
>> ---
>>  .../devicetree/bindings/video/ti,tpd12s015.txt     | 44 +++++++++++++=
+++++++++
>>  1 file changed, 44 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/video/ti,tpd12s0=
15.txt
>>
>> diff --git a/Documentation/devicetree/bindings/video/ti,tpd12s015.txt =
b/Documentation/devicetree/bindings/video/ti,tpd12s015.txt
>> new file mode 100644
>> index 000000000000..26e6d32e3f20
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/video/ti,tpd12s015.txt
>> @@ -0,0 +1,44 @@
>> +TPD12S015 HDMI level shifter and ESD protection chip
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> +
>> +Required properties:
>> +- compatible: "ti,tpd12s015"
>> +
>> +Optional properties:
>> +- gpios: CT CP HPD, LS OE and HPD gpios
>=20
> If this is supposed to give people a clue about what these GPIOs are,
> it completely fails to do this.  CT CP?  HPD is obviously the hotplug
> detect signal, but why are there two - HDMI only has a single detect
> pin on the connector.

No, it's not supposed to give a clue. But if you have a TPD chip on your
board, and you use it and write a dts file, you need to know what those
GPIOs are and where they are connected. They're described in the TPD
spec and should be visible on your boards schematics.

I did stop a few times when writing the binding docs, trying to decide
when I should go to details and when not. I usually decided that if the
particular information is 100% if you have the component spec sheet, I'm
not describing it here.

I don't even know what "CT CP" is short for, and I don't remember the
spec telling it... It does tell how to use it, though.

> While it makes sense to stick all three into one property, is it
> possible that not all of these may be routed to a GPIO?  If so, how
> do you specify that one (or more) of these does not exist?

The normal way, leave it out. From
Documentation/devicetree/bindings/gpio/gpio.txt:

chipsel-gpios =3D <&gpio1 12 0>,
                <&gpio1 13 0>,
                <0>, /* holes are permitted, means no GPIO 2 */
                <&gpio2 2>;

> Another issue here is that other HDMI encoders are available - should
> every encoder define its own set of bindings, or should there be a
> base set of bindings which all encoders should conform to - such as
> always having a HDMI output port?

The TPD is not an actual HDMI encoder, it's a level shifter, ESD
protection companion chip for the actual HDMI encoder.

But as for your question... I don't know. I don't know how much common
things there are. An HDMI encoder could have, say, two output ports. And
the encoder could have various number of input ports, so you can't say
either that the second port is always an output port.

If I had to make a guess right now, I'd guess that there are not enough
common things to justify defining common parts for all HDMI encoders.
But I have only dealt with the OMAP HDMI encoders, and a few one's from
Toshiba (DPI to HDMI and DSI to HDMI).

 Tomi



--ju2boOKpostCmGQcRnub3MkrjROaqQskd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTELmyAAoJEPo9qoy8lh71wTkP/RLpIfnNYPqSvNh4kn2zHnQ0
OyiF+8Xa7gqSgoAIPBOtTbzBo97eJfivTAyxfGitRljBLKWqsBak4JF/uAC+PwXW
YUwIyhi8TtR/4OdKE1FeYUcqweFTGZxNbAIuQvuwtFLhm1+X++rtUzmfoTQ57JxD
o9v6n6/Gbo8D7i+TGQPkIqPIJBHaXAeds4jfWGh6wOEv8QpTrM0Mh+BoHbCFb9dy
v+/RgpSW8OIxRSvhdPHMW+Y+58yHN+/6vtaU0bd++VFswmaujdD3lSZX9Iqz0QMP
O/BPEhcrEK+X8vrp/FcpkOOduvU/xtWjb+cDi9qxypqt5y0HFBiHy8VoXyb2nqtJ
9mD6A0Vgsa/HBpDOCWmcb75kyR+v/7GVCtsGz7W5vF6hxuFmE/VRLFKFriPz2OV3
5T+oEqsonrBtPWAm2kMK3mPQeQ0FMqDWNGmQ3Lm65AYTkAXypS5ZgmCfNmnypTEY
FBHal7eSMdry3Tb7YK/H6UqFOgbZ+oIFkX9vscR7vf8rzqnJaarlb6UMSP4zbujU
RNx/2F1+Mh+A2vvmc4pxbYKF0UHrJmqPB7wJbwYSomO9iVkrTKGv2ttU0reNEOpG
vrbDztA0Ha9Sz7MeZ7HzZkUgvHUJBcHHr2yeacYGhZDefCz61jWOW2eYiSAqbYMC
KQrzrMH+y0E76G0eejtg
=8Buf
-----END PGP SIGNATURE-----

--ju2boOKpostCmGQcRnub3MkrjROaqQskd--

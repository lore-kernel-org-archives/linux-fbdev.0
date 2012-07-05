From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 05 Jul 2012 10:37:02 +0000
Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <20120705103702.GN4111@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0yM48dKbQb4SmPLM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340976167-27298-1-git-send-email-acourbot@nvidia.com>
 <20120704104840.GJ24458@pengutronix.de>
 <4FF43692.2040805@nvidia.com>
 <20120704130056.GC30009@pengutronix.de>
 <4FF45DDF.9000306@nvidia.com>
 <20120704152451.GA7333@sirena.org.uk>
 <4FF4FDC0.8020405@nvidia.com>
 <20120705062011.GI30009@pengutronix.de>
 <4FF53368.6090805@nvidia.com>
In-Reply-To: <4FF53368.6090805@nvidia.com>
To: Alex Courbot <acourbot@nvidia.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@avionic-design.de>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>


--0yM48dKbQb4SmPLM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2012 at 03:25:44PM +0900, Alex Courbot wrote:
> On 07/05/2012 03:20 PM, Sascha Hauer wrote:

> >I think the only way doing this is to add a flag to platform_data. I
> >don't know if that's accepted though.

> I thought about just checking if devm_get_regulator returned -ENODEV
> and happily continue if that was the case, assuming no regulator was
> declared.

No, that's really not a good idea - as I keep saying if we really want
to go down that line we should remove all error checking instead, it's
the end result.

--0yM48dKbQb4SmPLM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9W5EAAoJEBus8iNuMP3d+xUQAJQYpdXLcHom2ndCFBK1YVj9
UwZb6FuOrC2c25Cz7eSnEJyNjgHfjwl6UY3ld3GbCP9boxHl81jkK58DEeRdl4D5
ZdPIkTHt5Md3mQ8NsHZAj4st9MXSPri2vVc2i7w0LXA0WI+HU76fb/OOf34I+uf0
8W0+3G55BXcrqGqSduiaxDxOO5yoZ+BYhctyybpv8lqvUWTw8PoXueTedgQSLuve
rB437Ijj6Kkm3V/mxUQ3B7T92f+yZP0xlVQkwRJYqUBYJI8RI0SDc/zYhF/Z1glU
TEfEIrFqgLhow5Rmnm1fov54D3F+OHQrcLkearvPMN4432aSBQZ58Ne5T0pOpv7x
0gDAI4xM4xEwbGI8oSgNQvlwxVkL/93mTJnsKtlnNSVFF4a+2kKx0svbLUdxTj4d
baFXA4P7ZZCEmp39jcyPbwA/U3gbKNoJ5B+uhRHPu1qMS8HGad+D3xVYYRP6CMVR
lj9iFDMElowwg7Q2stMgd+3EzZKHhp+aoh+/f4uO7K0brmIwb74+a4kBbI4wrSCL
oEJCVx2LdQDU2IOpoeWeR4Qa9ALliD0I5QZAe3x+tVIPelnihnpTjDr6i0ZkD4Cb
T7TXK6Lalmc5XIIt/mB+v0TpkW/vuJqstVgX0ClA+lTYGEdHlq7KWafgUZj3TM85
aPdveLK83z5TawkIqKVj
=a9/B
-----END PGP SIGNATURE-----

--0yM48dKbQb4SmPLM--

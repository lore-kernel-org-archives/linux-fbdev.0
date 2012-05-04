From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 04 May 2012 10:30:42 +0000
Subject: Re: [PATCH] i2c: Split I2C_M_NOSTART support out of I2C_FUNC_PROTOCOL_MANGLING
Message-Id: <20120504103042.GC14230@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PuGuTyElPB9bOcsM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336042416-28330-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120503203617.31179f9b@endymion.delvare>
In-Reply-To: <20120503203617.31179f9b@endymion.delvare>
To: Jean Delvare <khali@linux-fr.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2012 at 08:36:17PM +0200, Jean Delvare wrote:

> This is all correct, but it should be documented in
> Documentation/i2c/i2c-protocol. At the moment documentation still says
> that I2C_M_NOSTART is a weird protocol quirk nobody should be using.

> When you update the documentation, I think it is important to stress
> that there are now two use cases of I2C_M_NOSTART. If direction
> changes, it is a rarely needed protocol quirk. If direction doesn't
> change, it is used for buffer gathering.

Hrm, actually rereading the documentation it wasn't all that clear that
these were particularly disrecommended - it just mentioned that the
flags existed and might be needed.  I strengthened the documentation
here as well.

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPo6/LAAoJEBus8iNuMP3dsFIP/RroZa2h/8L7kGNYDuQl0iWc
ZK8fYaQh8FVLadhX0LrPCQxEXsq3NT1rEIpGnj06qK4F2c2Nqp8tVshzqidLrsOs
/d3CPBPX0fB7VV0W1IGMG5eknTm2TlhRfF4/gdsUUPnnjIknFYJgA7X297ztMzMJ
kVegN6PPzo05htCstv6ID7Jj1qCT/UHw5ZT5inwAjSJxBZL5j2+1Y+XjYVq27FuQ
G1uEocZjUAkSfnrBkAc1rsl/oBdBAsq5rouqUYvS8mThWl0EFXYOtEqNtDKJIYjb
E2wmeW5WxVE3zQIBIKB8oDISond/wynqd6Rg4IKW5jkj6ovQZRjW3U+j3Rn4fil/
7EXbFI1E+cR5TDVPMhEOK1BrAYRRHwlT7Lo3dbUjZjIKJ6etE7oZdo5tQXA5ODme
ixGWzju0u9Q/hPxK+TL6w6WPPCBncocxWMYs1flbyz5rGEzxkKrOQaxEy3xXp+4+
VJwJE3mtZ4VeEf71vgZ4d9UI5YCPQk3UVDBq3VaeXnSLN8boeDN2C4F5jDjYOgBO
vrYnf9kXOJzB0X3dtn6ajnblEYfdGT2zEPoxdA0VBTh4NSYZJTpm0ME7/jFkEI55
Df6UEYJAINumKVh54ggkY33igO23F+yWKCXnG6QJemH7kQs599TEMmGHfL3dUfca
S81zEhRo/FajR81WQ6I+
=w9PF
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--

From: Mark Brown <broonie@kernel.org>
Date: Mon, 21 Sep 2015 21:13:32 +0000
Subject: Re: [PATCH v3 11/12] regulator: pwm: implement ->enable(), ->disable() and ->is_enabled methods
Message-Id: <20150921211332.GG30445@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CDSQlumANh/CoDwR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1442828009-6241-12-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1442828009-6241-12-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org


--CDSQlumANh/CoDwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2015 at 11:33:28AM +0200, Boris Brezillon wrote:

> Implement the ->enable(), ->disable() and ->is_enabled methods and remove
> the PWM call in ->set_voltage_sel().

I'll apply this so it definitely makes it into mainline, I'm happy to
provide a tag for this so it can be merged into the PWM tree if the rest
of the series is ready.

--CDSQlumANh/CoDwR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWAHL8AAoJECTWi3JdVIfQ73wH/j0fbEJX3vPNyXB22VMHCssS
fBG9/LvW6vJDSHbGQQJZMTImpHST6Lop2bpKZPtB+bbw/QdmXD3hBsX6rDHcbfDH
ztCO6zya6CEFNjyhPjDe1+PpQ6mJIo2pF3ugcEnL0YYMwIiBnE+5yJ5RNwOokdl+
iKdwSaQTShgAn0WaMUlAxlapjF4OJZSO1PVpOnTHjaJE9eET0kQcAsnMrQfPyp02
m+A2Jox/sgsZcQDSmGcfl7mqMDKY+DGqOAZ2R7UFQzGjwXeEwH2FbvhY8k9HLz7o
RtYY9GeF2A2LUNrzCm75O9lL5nBpRXBSLj6JEms2TBXJ4gAGSGBoNKgffEECD/U=
=3aFF
-----END PGP SIGNATURE-----

--CDSQlumANh/CoDwR--

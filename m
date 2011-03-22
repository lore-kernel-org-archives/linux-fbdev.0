From: Wolfram Sang <w.sang@pengutronix.de>
Date: Tue, 22 Mar 2011 09:10:27 +0000
Subject: Re: [PATCH v6 6/6] powerpc, tqm5200: update tqm5200_defconfig to
Message-Id: <20110322091027.GC2134@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RIYY1s2vRbPFwWeW"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
 <1300782452-528-1-git-send-email-hs@denx.de>
 <1300782452-528-7-git-send-email-hs@denx.de>
In-Reply-To: <1300782452-528-7-git-send-email-hs@denx.de>
To: Heiko Schocher <hs@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org, Ben Dooks <ben@simtec.co.uk>, Vincent Sanders <vince@simtec.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, Wolfgang Denk <wd@denx.de>, Paul Mundt <lethal@linux-sh.org>


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>     As this board is tqm5200 based, added necessary changes
>     to the tqm5200_defconfig. In previous patchserie I added
>     the changes to mpc5200_defconfig, as Wolfram Sang mentioned,
>     but as tqm5200_defconfig is in mainline, and the board is
>     tqm5200 based, I think, thats the appropriate place, as

I'd think the perfect solution would have been to merge the
tqm-defconfig into the mpc5200-defconfig entirely and get rid of it.
That being said, I don't think this issue is big enough to block this
series, so fine enough with me.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2IZ4MACgkQD27XaX1/VRu7cQCfWpwfinmAeGn8hGBfiiU0IqlG
MkoAoLaw5f0WowSPgUmyBzmU9YvG4B6b
=7p51
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--

From: Wolfram Sang <w.sang@pengutronix.de>
Date: Tue, 22 Mar 2011 09:06:35 +0000
Subject: Re: [PATCH v1 1/6] powerpc, 5200: add support for charon board
Message-Id: <20110322090635.GB2134@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5I6of5zJg18YgZEa"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
 <1300782452-528-1-git-send-email-hs@denx.de>
 <1300782452-528-2-git-send-email-hs@denx.de>
In-Reply-To: <1300782452-528-2-git-send-email-hs@denx.de>
To: Heiko Schocher <hs@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org, Ben Dooks <ben@simtec.co.uk>, Vincent Sanders <vince@simtec.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, Wolfgang Denk <wd@denx.de>, Paul Mundt <lethal@linux-sh.org>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 22, 2011 at 09:27:27AM +0100, Heiko Schocher wrote:
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> cc: Wolfram Sang <w.sang@pengutronix.de>
> cc: Grant Likely <grant.likely@secretlab.ca>
> cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> cc: linux-fbdev@vger.kernel.org
> cc: devicetree-discuss@ozlabs.org
> cc: Ben Dooks <ben@simtec.co.uk>
> cc: Vincent Sanders <vince@simtec.co.uk>
> cc: Samuel Ortiz <sameo@linux.intel.com>
> cc: linux-kernel@vger.kernel.org
> cc: Randy Dunlap <rdunlap@xenotime.net>
> cc: Wolfgang Denk <wd@denx.de>
> cc: Paul Mundt <lethal@linux-sh.org>
> ---
> - changes since v1:
>   add comments from Wolfram Sang
>   - no defconfig file
>   - comment corrected in DTS
>   - boardlist sorted alphabetically
>   - commit log without boardinfo
> - changes for v6:
>   - rebased against current head
>   - repost complete patchserie
>   - added Acked-by from Benjamin Herrenschmidt
>=20
>  arch/powerpc/boot/dts/charon.dts             |  226 ++++++++++++++++++++=
++++++
>  arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
>  2 files changed, 227 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/charon.dts

AFAICR all my concerns have been addressed, so

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2IZpsACgkQD27XaX1/VRs9NACgr8W3jgII/9j+wwDHI0DxGQkf
WigAoJSodGGj2+gxQNZDayA3A1skv4oa
=EIfN
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--

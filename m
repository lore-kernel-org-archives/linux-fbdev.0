From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 05 Oct 2012 12:33:53 +0000
Subject: Re: [PATCH V4 4/5] OMAPDSS: Replace multi part debug prints with pr_debug
Message-Id: <1349440433.5836.0.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-t94y7/dOEZp7pJDtvPDe"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1348826106.git.cmahapatra@ti.com>
	 <cover.1348914940.git.cmahapatra@ti.com>
	 <8fb0b3848f5d6148889f2b5160b8aa40e764f409.1348914940.git.cmahapatra@ti.com>
In-Reply-To: <8fb0b3848f5d6148889f2b5160b8aa40e764f409.1348914940.git.cmahapatra@ti.com>
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-t94y7/dOEZp7pJDtvPDe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-09-29 at 16:19 +0530, Chandrabhanu Mahapatra wrote:
> The omap_dispc_unregister_isr() and _dsi_print_reset_status() consist of =
a
> number of debug prints which need to be enabled all at once or none at al=
l. So,
> these debug prints in corresponding functions are replaced with one dynam=
ic
> debug enabled pr_debug() each.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   32 +++++++++++++-------------------
>  drivers/video/omap2/dss/dsi.c   |   30 ++++++++++++++----------------
>  2 files changed, 27 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/di=
spc.c
> index a173a94..67d9f3b 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -3675,26 +3675,20 @@ static void print_irq_status(u32 status)
>  	if ((status & dispc.irq_error_mask) =3D=3D 0)
>  		return;
> =20
> -	printk(KERN_DEBUG "DISPC IRQ: 0x%x: ", status);
> -
> -#define PIS(x) \
> -	if (status & DISPC_IRQ_##x) \
> -		printk(#x " ");
> -	PIS(GFX_FIFO_UNDERFLOW);
> -	PIS(OCP_ERR);
> -	PIS(VID1_FIFO_UNDERFLOW);
> -	PIS(VID2_FIFO_UNDERFLOW);
> -	if (dss_feat_get_num_ovls() > 3)
> -		PIS(VID3_FIFO_UNDERFLOW);
> -	PIS(SYNC_LOST);
> -	PIS(SYNC_LOST_DIGIT);
> -	if (dss_has_feature(FEAT_MGR_LCD2))
> -		PIS(SYNC_LOST2);
> -	if (dss_has_feature(FEAT_MGR_LCD3))
> -		PIS(SYNC_LOST3);
> +#define PIS(x) (status & DISPC_IRQ_##x) ? (#x " ") : ""
> +
> +	pr_debug("DISPC IRQ: 0x%x: %s%s%s%s%s%s%s%s%s\n",
> +		status,
> +		PIS(OCP_ERR),
> +		PIS(GFX_FIFO_UNDERFLOW),
> +		PIS(VID1_FIFO_UNDERFLOW),
> +		PIS(VID2_FIFO_UNDERFLOW),
> +		dss_feat_get_num_ovls() > 3 ? PIS(VID3_FIFO_UNDERFLOW) : "",
> +		PIS(SYNC_LOST),
> +		PIS(SYNC_LOST_DIGIT),
> +		dss_has_feature(FEAT_MGR_LCD2) ? PIS(SYNC_LOST2) : "",
> +		dss_has_feature(FEAT_MGR_LCD3) ? PIS(SYNC_LOST3) : "");
>  #undef PIS
> -
> -	printk("\n");
>  }
>  #endif

There's similar irq printing code in dsi.c that should also be converted
to the above style.

 Tomi


--=-t94y7/dOEZp7pJDtvPDe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQbtOxAAoJEPo9qoy8lh71pncP/3CIWb370Ny3+wD8KQJhf4o+
5qFNr5X/EyG+d8HVihC6VGLKe3xy0ca+avUDbPuiVRiat4M5o1fLvYSkKDVjBM/B
3grPRYUDs4xJmm0jhTRP4JejZzXM9WFvZyBnXU9JTDcxwPQJ0MDofV8kDVWgvKy/
KOEXF2kQveAhl+mliQoBqR6n147Yu03TQbfNAgaEWswtKpMVBTLg7zyFYVrUqk6+
uhhI0LlEvTWw3IO3oDlLITIZBrqNlfTsufUole0opwAV79fEIfvfbOOb0yTiw1E3
890Fq4GJ2pFJVDmV4UJw1km18q9Grlz2y3Kx3lIZRXEHUvGbQ8jhI0ndtsQ8N77f
XFMqH0yYjYMUzix/5YsPx6seErpKQqAbiShzo2bjjeME3rVsV5egQrvLIfNnS2Dz
8GkRzYxdbfT7Gz9KDw5X+SviQKNrdbuPmPbf+1uqXlbxoXayw/xW6dMmiUd2OMd3
IH5TeoBHsV8/s4uH9tYZ9c3pzkFpzsYLMHzTOkZYrV4mRjKHXUn0h0mNRHQmWAsI
iGLQuz+boGJjbTIDvWV6mPep/FrCpvWCnzjfEiJA7Ee1b4vmJWcidzNBfNi7B1aA
cg4E7WkCJigmnIlWrBeDbWBljC7CW8znpj6tK4fpURJyYEyKpMdNCi/UKo0WmdMS
UMdYkuPrG+xro02ADML3
=Xt61
-----END PGP SIGNATURE-----

--=-t94y7/dOEZp7pJDtvPDe--


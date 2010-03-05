From: "Aguirre, Sergio" <saaguirre@ti.com>
Date: Fri, 05 Mar 2010 15:19:44 +0000
Subject: RE: [PATCH 4/4] DSS2: clear spurious SYNC_LOST_DIGIT interrupts
Message-Id: <A24693684029E5489D1D202277BE894453CC5CA0@dlee02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
 <1267795582-21004-4-git-send-email-ville.syrjala@nokia.com>
In-Reply-To: <1267795582-21004-4-git-send-email-ville.syrjala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "ville.syrjala@nokia.com" <ville.syrjala@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Ville,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of ville.syrjala@nokia.com
> Sent: Friday, March 05, 2010 7:26 AM
> To: Tomi Valkeinen
> Cc: linux-fbdev@vger.kernel.org; linux-omap@vger.kernel.org; Ville Syrj=
=E4l=E4
> Subject: [PATCH 4/4] DSS2: clear spurious SYNC_LOST_DIGIT interrupts
>=20
> From: Ville Syrj=E4l=E4 <ville.syrjala@nokia.com>
>=20
> When DSS transitions from off mode to on VENC may generate a spurious
> SYNC_LOST_DIGIT error. Just ack it when restoring the context. Also
> restore IRQENABLE last to avoid triggering interrupts before the
> context is fully restored.

(Tomi or anyone can correct me if I'm wrong)

AFAIK, The solution for spurious interrupts is to flush posted bus writes d=
uring interrupt handling, which can be achieved by reading the same registe=
r just after you have written it.

Tomi, what do you think?

Regards,
Sergio

>=20
> Signed-off-by: Ville Syrj=E4l=E4 <ville.syrjala@nokia.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c
> b/drivers/video/omap2/dss/dispc.c
> index e777e35..b8c1603 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -335,7 +335,7 @@ void dispc_save_context(void)
>  void dispc_restore_context(void)
>  {
>  	RR(SYSCONFIG);
> -	RR(IRQENABLE);
> +	/*RR(IRQENABLE);*/
>  	/*RR(CONTROL);*/
>  	RR(CONFIG);
>  	RR(DEFAULT_COLOR0);
> @@ -472,6 +472,15 @@ void dispc_restore_context(void)
>=20
>  	/* enable last, because LCD & DIGIT enable are here */
>  	RR(CONTROL);
> +
> +	/* clear spurious SYNC_LOST_DIGIT interrupts */
> +	dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
> +
> +	/*
> +	 * enable last so IRQs won't trigger before
> +	 * the context is fully restored
> +	 */
> +	RR(IRQENABLE);
>  }
>=20
>  #undef SR
> --
> 1.6.4.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Sat, 19 Oct 2013 11:08:53 +0000
Subject: Re: [Patch v2][ 05/37] fbdev: Add the lacking FB_SYNC_* for matching the DISPLAY_FLAGS_*
Message-Id: <20131019110853.GO18477@ns203013.ovh.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-6-git-send-email-denis@eukrea.com>
In-Reply-To: <1382022155-21954-6-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 17:02 Thu 17 Oct     , Denis Carikli wrote:
> Without that fix, drivers using the fb_videomode_from_videomode
>   function will not be able to get certain information because
>   some DISPLAY_FLAGS_* have no corresponding FB_SYNC_*.
>=20
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree@vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Eric B=E9nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
>  drivers/video/fbmon.c   |    4 ++++
>  include/uapi/linux/fb.h |    2 ++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
> index 6103fa6..29a9ed0 100644
> --- a/drivers/video/fbmon.c
> +++ b/drivers/video/fbmon.c
> @@ -1402,6 +1402,10 @@ int fb_videomode_from_videomode(const struct video=
mode *vm,
>  		fbmode->sync |=3D FB_SYNC_HOR_HIGH_ACT;
>  	if (vm->flags & DISPLAY_FLAGS_VSYNC_HIGH)
>  		fbmode->sync |=3D FB_SYNC_VERT_HIGH_ACT;
> +	if (vm->flags & DISPLAY_FLAGS_DE_HIGH)
> +		fbmode->sync |=3D FB_SYNC_DE_HIGH_ACT;
> +	if (vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> +		fbmode->sync |=3D FB_SYNC_PIXDAT_HIGH_ACT;
>  	if (vm->flags & DISPLAY_FLAGS_INTERLACED)
>  		fbmode->vmode |=3D FB_VMODE_INTERLACED;
>  	if (vm->flags & DISPLAY_FLAGS_DOUBLESCAN)
> diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
> index fb795c3..30487df 100644
> --- a/include/uapi/linux/fb.h
> +++ b/include/uapi/linux/fb.h
> @@ -215,6 +215,8 @@ struct fb_bitfield {
>  					/* vtotal =3D 144d/288n/576i =3D> PAL  */
>  					/* vtotal =3D 121d/242n/484i =3D> NTSC */
>  #define FB_SYNC_ON_GREEN	32	/* sync on green */
> +#define FB_SYNC_DE_HIGH_ACT	64	/* data enable high active */
> +#define FB_SYNC_PIXDAT_HIGH_ACT	64	/* data enable high active */
> =20
>  #define FB_VMODE_NONINTERLACED  0	/* non interlaced */
>  #define FB_VMODE_INTERLACED	1	/* interlaced	*/
> --=20
> 1.7.9.5
>=20

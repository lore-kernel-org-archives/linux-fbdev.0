From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Mon, 10 Jun 2013 14:22:00 +0000
Subject: Re: [PATCH 3/4] fb: Make fb_get_options() 'name' parameter const
Message-Id: <20130610142200.GA305@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370619787-15341-1-git-send-email-ville.syrjala@linux.intel.com>
	<1370619787-15341-3-git-send-email-ville.syrjala@linux.intel.com>
In-Reply-To: <1370619787-15341-3-git-send-email-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ville.syrjala@linux.intel.com
Cc: intel-gfx@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On 18:43 Fri 07 Jun     , ville.syrjala@linux.intel.com wrote:
> From: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
>=20
> The string isn't modified so make it const.
>=20
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>

Applied

Best Regards,
J.
> ---
>  drivers/video/fbmem.c | 2 +-
>  include/linux/fb.h    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 098bfc6..d8d5779 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -1881,7 +1881,7 @@ static int ofonly __read_mostly;
>   *
>   * NOTE: Needed to maintain backwards compatibility
>   */
> -int fb_get_options(char *name, char **option)
> +int fb_get_options(const char *name, char **option)
>  {
>  	char *opt, *options =3D NULL;
>  	int retval =3D 0;
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index d49c60f..ffac70a 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -624,7 +624,7 @@ extern void fb_pad_aligned_buffer(u8 *dst, u32 d_pitc=
h, u8 *src, u32 s_pitch, u3
>  extern void fb_set_suspend(struct fb_info *info, int state);
>  extern int fb_get_color_depth(struct fb_var_screeninfo *var,
>  			      struct fb_fix_screeninfo *fix);
> -extern int fb_get_options(char *name, char **option);
> +extern int fb_get_options(const char *name, char **option);
>  extern int fb_new_modelist(struct fb_info *info);
> =20
>  extern struct fb_info *registered_fb[FB_MAX];
> --=20
> 1.8.1.5
>=20

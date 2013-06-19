From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Wed, 19 Jun 2013 07:33:41 +0000
Subject: Re: [PATCH 1/2] video: fbmem: Use 'const char' in fb_get_options()
Message-Id: <20130619073341.GF5004@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371561988-30989-1-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1371561988-30989-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Tue, Jun 18, 2013 at 10:26:27AM -0300, Fabio Estevam wrote:
> Commit d20d31748 (drm: Constify the pretty-print functions) causes the fo=
llowing
> build warning:
>=20
> drivers/gpu/drm/drm_fb_helper.c:127:3: warning: passing argument 1 of 'fb=
_get_options' discards 'const' qualifier from pointer target type [enabled =
by default]
>=20
> Let's change the first argument of fb_get_options from 'char *' to 'const=
 char *'=20
> so that we can get rid of this warning.

I already sent the same patch alongside the drm constify patches. It
just needs to trickle back into the drm tree via the fbdev folks.

>=20
> Cc: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
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
> 1.8.1.2
>=20

--=20
Ville Syrj=E4l=E4
Intel OTC

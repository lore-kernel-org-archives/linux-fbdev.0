From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 27 Nov 2019 18:18:40 +0000
Subject: Re: [Intel-gfx] [PATCH 02/13] drm/fb-helper: don't preserve fb_ops across deferred IO use
Message-Id: <20191127181840.GH406127@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
 <e2b1685703878612093a37189d37685303fa15e9.1574871797.git.jani.nikula@intel.com>
In-Reply-To: <e2b1685703878612093a37189d37685303fa15e9.1574871797.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org

On Wed, Nov 27, 2019 at 06:31:58PM +0200, Jani Nikula wrote:
> Deferred IO now preserves the fb_ops.
>=20
> Cc: Noralf Tr=F8nnes <noralf@tronnes.org>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_fb_helper.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_hel=
per.c
> index 0c088ea70ad0..a5a2a538d085 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1954,7 +1954,6 @@ static int drm_fbdev_fb_release(struct fb_info *inf=
o, int user)
>  static void drm_fbdev_cleanup(struct drm_fb_helper *fb_helper)
>  {
>  	struct fb_info *fbi =3D fb_helper->fbdev;
> -	struct fb_ops *fbops =3D NULL;
>  	void *shadow =3D NULL;
> =20
>  	if (!fb_helper->dev)
> @@ -1963,15 +1962,11 @@ static void drm_fbdev_cleanup(struct drm_fb_helpe=
r *fb_helper)
>  	if (fbi && fbi->fbdefio) {
>  		fb_deferred_io_cleanup(fbi);
>  		shadow =3D fbi->screen_buffer;
> -		fbops =3D fbi->fbops;
>  	}
> =20
>  	drm_fb_helper_fini(fb_helper);
> =20
> -	if (shadow) {
> -		vfree(shadow);
> -		kfree(fbops);
> -	}
> +	vfree(shadow);
> =20
>  	drm_client_framebuffer_delete(fb_helper->buffer);
>  }
> @@ -2062,23 +2057,14 @@ static int drm_fb_helper_generic_probe(struct drm=
_fb_helper *fb_helper,
>  	drm_fb_helper_fill_info(fbi, fb_helper, sizes);
> =20
>  	if (drm_fbdev_use_shadow_fb(fb_helper)) {
> -		struct fb_ops *fbops;
>  		void *shadow;
> =20
> -		/*
> -		 * fb_deferred_io_cleanup() clears &fbops->fb_mmap so a per
> -		 * instance version is necessary.
> -		 */
> -		fbops =3D kzalloc(sizeof(*fbops), GFP_KERNEL);
>  		shadow =3D vzalloc(fbi->screen_size);
> -		if (!fbops || !shadow) {
> -			kfree(fbops);
> +		if (!shadow) {
>  			vfree(shadow);
>  			return -ENOMEM;
>  		}
> =20
> -		*fbops =3D *fbi->fbops;
> -		fbi->fbops =3D fbops;
>  		fbi->screen_buffer =3D shadow;
>  		fbi->fbdefio =3D &drm_fbdev_defio;
> =20
> --=20
> 2.20.1
>=20
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

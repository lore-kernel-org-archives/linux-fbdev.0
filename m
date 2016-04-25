From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 25 Apr 2016 09:03:44 +0000
Subject: Re: [PATCH v2 3/8] drm/qxl: Change drm_fb_helper_sys_*() calls to sys_*()
Message-Id: <20160425090344.GP2510@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461530942-22485-1-git-send-email-noralf@tronnes.org>
 <1461530942-22485-4-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461530942-22485-4-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com

On Sun, Apr 24, 2016 at 10:48:57PM +0200, Noralf Tr=F8nnes wrote:
> Now that drm_fb_helper gets deferred io support, the
> drm_fb_helper_sys_{fillrect,copyarea,imageblit} functions will schedule
> a worker that will call the (struct drm_framebuffer *)->funcs->dirty()
> function. This will break this driver so use the
> sys_{fillrect,copyarea,imageblit} functions directly.
>=20
> Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>

For patches 2&3: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/qxl/qxl_fb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
> index 7136e52..06f032d 100644
> --- a/drivers/gpu/drm/qxl/qxl_fb.c
> +++ b/drivers/gpu/drm/qxl/qxl_fb.c
> @@ -199,7 +199,7 @@ static void qxl_fb_fillrect(struct fb_info *info,
>  {
>  	struct qxl_fbdev *qfbdev =3D info->par;
> =20
> -	drm_fb_helper_sys_fillrect(info, rect);
> +	sys_fillrect(info, rect);
>  	qxl_dirty_update(qfbdev, rect->dx, rect->dy, rect->width,
>  			 rect->height);
>  }
> @@ -209,7 +209,7 @@ static void qxl_fb_copyarea(struct fb_info *info,
>  {
>  	struct qxl_fbdev *qfbdev =3D info->par;
> =20
> -	drm_fb_helper_sys_copyarea(info, area);
> +	sys_copyarea(info, area);
>  	qxl_dirty_update(qfbdev, area->dx, area->dy, area->width,
>  			 area->height);
>  }
> @@ -219,7 +219,7 @@ static void qxl_fb_imageblit(struct fb_info *info,
>  {
>  	struct qxl_fbdev *qfbdev =3D info->par;
> =20
> -	drm_fb_helper_sys_imageblit(info, image);
> +	sys_imageblit(info, image);
>  	qxl_dirty_update(qfbdev, image->dx, image->dy, image->width,
>  			 image->height);
>  }
> --=20
> 2.2.2
>=20

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

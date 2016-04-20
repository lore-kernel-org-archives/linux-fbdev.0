From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 20 Apr 2016 17:42:41 +0000
Subject: Re: [PATCH 2/8] drm/udl: Change drm_fb_helper_sys_*() calls to sys_*()
Message-Id: <20160420174241.GP2510@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
 <1461165929-11344-3-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461165929-11344-3-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com

On Wed, Apr 20, 2016 at 05:25:23PM +0200, Noralf Tr=F8nnes wrote:
> Now that drm_fb_helper gets deferred io support, the
> drm_fb_helper_sys_{fillrect,copyarea,imageblit} functions will schedule
> the worker that calls the deferred_io callback. This will break this
> driver so use the sys_{fillrect,copyarea,imageblit} functions directly.
>=20
> Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>

I think this intermediately breaks the build, if you disable fbdev
support. That's now supported in the fbdev helpers core generically across
all drivers.

Not sure how to best fix this up, since the only way would be to squash
these patches, plus generic deferred io plus the conversion patches for
udl/qxl all into one. Tricky.
-Daniel

> ---
>  drivers/gpu/drm/udl/udl_fb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
> index fd1eb9d..a52de2f 100644
> --- a/drivers/gpu/drm/udl/udl_fb.c
> +++ b/drivers/gpu/drm/udl/udl_fb.c
> @@ -287,7 +287,7 @@ static void udl_fb_fillrect(struct fb_info *info, con=
st struct fb_fillrect *rect
>  {
>  	struct udl_fbdev *ufbdev =3D info->par;
> =20
> -	drm_fb_helper_sys_fillrect(info, rect);
> +	sys_fillrect(info, rect);
> =20
>  	udl_handle_damage(&ufbdev->ufb, rect->dx, rect->dy, rect->width,
>  			  rect->height);
> @@ -297,7 +297,7 @@ static void udl_fb_copyarea(struct fb_info *info, con=
st struct fb_copyarea *regi
>  {
>  	struct udl_fbdev *ufbdev =3D info->par;
> =20
> -	drm_fb_helper_sys_copyarea(info, region);
> +	sys_copyarea(info, region);
> =20
>  	udl_handle_damage(&ufbdev->ufb, region->dx, region->dy, region->width,
>  			  region->height);
> @@ -307,7 +307,7 @@ static void udl_fb_imageblit(struct fb_info *info, co=
nst struct fb_image *image)
>  {
>  	struct udl_fbdev *ufbdev =3D info->par;
> =20
> -	drm_fb_helper_sys_imageblit(info, image);
> +	sys_imageblit(info, image);
> =20
>  	udl_handle_damage(&ufbdev->ufb, image->dx, image->dy, image->width,
>  			  image->height);
> --=20
> 2.2.2
>=20

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

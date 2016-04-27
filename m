From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 27 Apr 2016 19:24:46 +0000
Subject: Re: [PATCH v3 0/7] drm: Add fbdev deferred io support to helpers
Message-Id: <20160427192446.GI2558@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461780996-8612-1-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461780996-8612-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com

On Wed, Apr 27, 2016 at 08:16:29PM +0200, Noralf Tr=F8nnes wrote:
> This patchset adds fbdev deferred io support to drm_fb_helper and
> drm_fb_cma_helper.
>=20
> It channels fbdev mmap and fb_{write,fillrect,copyarea,imageblit} damage
> through the (struct drm_framebuffer_funcs)->dirty callback on the
> fb_helper framebuffer which will always run in process context.
>=20
> I have also added patches that converts qxl and udl to use this
> deferred io support. I have only compile tested it, no functional testing.
> I know that qxl is purely a software thing so I could actually test it, b=
ut
> I have never used qemu so I'm not keen on spending a lot of time on that.
>=20
> This was originally part of the tinydrm patchset.
>=20
> Changes since v2:
> - drm/rect: Add some drm_clip_rect utility functions
>   - This patch is dropped
> - drm/fb-helper: Add fb_deferred_io support
>   - FB_DEFERRED_IO is now always selected by DRM_KMS_FB_HELPER, ifdef rem=
oved
>   - The drm_clip_rect utility functions are dropped, so open code it
>   - docs: use & to denote structs
> - drm/qxl: Use drm_fb_helper deferred_io support
>   - The drm_clip_rect_{width/height} functions are dropped, so open code =
it

Found two tiny nit in the drm fbdev helper patch. Otherwise I think just ne=
eds
an ack from Tomi for the fbdev patch, and from Laurent Pinchart for the
cma one (you've forgotten to cc him) and this is good to land imo.
-Daniel

>=20
> Changes since v1:
> - drm/fb-helper: Add fb_deferred_io support
>   - Use a dedicated worker to run the framebuffer flushing like qxl does
>   - Add parameter descriptions to drm_fb_helper_deferred_io
> - fbdev: fb_defio: Export fb_deferred_io_mmap
>   - Expand commit message
> - drm/qxl: Use drm_fb_helper deferred_io support
>   - Add FIXME about special dirty() callback for fbdev
>   - Remove note in commit message about deferred worker, drm_fb_helper
>     is similar to qxl now.
> - drm/udl: Use drm_fb_helper deferred_io support
>   - No need to enable deferred_io by default since drm_fb_helper uses
>     a dedicated worker for flushing
>=20
> Changes since RFC:
> - Fix drm_clip_rect use to be exclusive on x2/y2
> - Put drm_clip_rect functions in drm_rect.{h,c}
> - Take into account that (struct fb_ops *)->fb_{write,...}() can be called
>   from atomic context (spin_lock_irqsave)
> - Export fb_deferred_io_mmap()
> - Add some more documentation
> - Add qxl and udl patches
>=20
> Noralf Tr=F8nnes (7):
>   drm/udl: Change drm_fb_helper_sys_*() calls to sys_*()
>   drm/qxl: Change drm_fb_helper_sys_*() calls to sys_*()
>   drm/fb-helper: Add fb_deferred_io support
>   fbdev: fb_defio: Export fb_deferred_io_mmap
>   drm/fb-cma-helper: Add fb_deferred_io support
>   drm/qxl: Use drm_fb_helper deferred_io support
>   drm/udl: Use drm_fb_helper deferred_io support
>=20
>  drivers/gpu/drm/Kconfig             |   1 +
>  drivers/gpu/drm/drm_fb_cma_helper.c | 178 ++++++++++++++++++++++++++--
>  drivers/gpu/drm/drm_fb_helper.c     | 109 +++++++++++++++++-
>  drivers/gpu/drm/qxl/qxl_display.c   |   9 +-
>  drivers/gpu/drm/qxl/qxl_drv.h       |   7 +-
>  drivers/gpu/drm/qxl/qxl_fb.c        | 223 +++++++++---------------------=
------
>  drivers/gpu/drm/qxl/qxl_kms.c       |   4 -
>  drivers/gpu/drm/udl/udl_drv.h       |   2 -
>  drivers/gpu/drm/udl/udl_fb.c        | 140 +---------------------
>  drivers/video/fbdev/core/fb_defio.c |   3 +-
>  include/drm/drm_fb_cma_helper.h     |  14 +++
>  include/drm/drm_fb_helper.h         |  15 +++
>  include/linux/fb.h                  |   1 +
>  13 files changed, 378 insertions(+), 328 deletions(-)
>=20
> --
> 2.2.2
>=20

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

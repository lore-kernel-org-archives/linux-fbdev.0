From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 28 Apr 2016 07:17:53 +0000
Subject: Re: [PATCH v3 3/7] drm/fb-helper: Add fb_deferred_io support
Message-Id: <20160428071753.GJ2558@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461780996-8612-1-git-send-email-noralf@tronnes.org>
 <1461780996-8612-4-git-send-email-noralf@tronnes.org>
 <20160427192052.GG2558@phenom.ffwll.local>
 <57211204.7080703@tronnes.org>
In-Reply-To: <57211204.7080703@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Wed, Apr 27, 2016 at 09:24:52PM +0200, Noralf Tr=F8nnes wrote:
>=20
> Den 27.04.2016 21:20, skrev Daniel Vetter:
> >On Wed, Apr 27, 2016 at 08:16:32PM +0200, Noralf Tr=F8nnes wrote:
> >>This adds deferred io support to drm_fb_helper.
> >>The fbdev framebuffer changes are flushed using the callback
> >>(struct drm_framebuffer *)->funcs->dirty() by a dedicated worker
> >>ensuring that it always runs in process context.
> >>
> >>Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> >>---
> >>
> >>Changes since v2:
> >>- FB_DEFERRED_IO is now always selected by DRM_KMS_FB_HELPER, ifdef rem=
oved
> >>- The drm_clip_rect utility functions are dropped, so open code it
> >>- docs: use & to denote structs
> >>
> >>Changes since v1:
> >>- Use a dedicated worker to run the framebuffer flushing like qxl does
> >>- Add parameter descriptions to drm_fb_helper_deferred_io
> >>
> >>  drivers/gpu/drm/Kconfig         |   1 +
> >>  drivers/gpu/drm/drm_fb_helper.c | 109 +++++++++++++++++++++++++++++++=
++++++++-
> >>  include/drm/drm_fb_helper.h     |  15 ++++++
> >>  3 files changed, 124 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> >>index 9e4f2f1..8e6f34b 100644
> >>--- a/drivers/gpu/drm/Kconfig
> >>+++ b/drivers/gpu/drm/Kconfig
> >>@@ -52,6 +52,7 @@ config DRM_KMS_FB_HELPER
> >>  	select FB_CFB_FILLRECT
> >>  	select FB_CFB_COPYAREA
> >>  	select FB_CFB_IMAGEBLIT
> >>+	select FB_DEFERRED_IO
> >>  	help
> >>  	  FBDEV helpers for KMS drivers.
> >>
> >>diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_h=
elper.c
> >>index 855108e..5112b5d 100644
> >>--- a/drivers/gpu/drm/drm_fb_helper.c
> >>+++ b/drivers/gpu/drm/drm_fb_helper.c
> >>@@ -48,6 +48,8 @@ MODULE_PARM_DESC(fbdev_emulation,
> >>
> >>  static LIST_HEAD(kernel_fb_helper_list);
> >>
> >>+static void drm_fb_helper_dirty_init(struct drm_fb_helper *helper);
> >Instead of this forward decl just inline the few setup commands into
> >drm_fb_helper_prepare.
>=20
> That would mean that I have to forward declare drm_fb_helper_dirty_work()
> instead. Is that better?
> Or should I relocate the functions?

Yeah, just move them all I think. This means that usually the setup
function for a component is at the very bottom, and also that you have the
inverted reading order with first reading leaf/helper functions, then the
bigger ones that assemble things together. Personally I find that
backwards, but otoh consistency is more important. And avoid forward decls
for static functions is standard style in the kernel.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

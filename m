From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 26 Apr 2016 17:19:02 +0000
Subject: Re: [PATCH v2 4/8] drm/fb-helper: Add fb_deferred_io support
Message-Id: <20160426171902.GA2558@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461530942-22485-1-git-send-email-noralf@tronnes.org>
 <1461530942-22485-5-git-send-email-noralf@tronnes.org>
 <20160425090957.GQ2510@phenom.ffwll.local>
 <571F9656.1090506@tronnes.org>
In-Reply-To: <571F9656.1090506@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Tue, Apr 26, 2016 at 06:24:54PM +0200, Noralf Tr=F8nnes wrote:
>=20
> Den 25.04.2016 11:09, skrev Daniel Vetter:
> >On Sun, Apr 24, 2016 at 10:48:58PM +0200, Noralf Tr=F8nnes wrote:
> >>This adds deferred io support if CONFIG_FB_DEFERRED_IO is enabled.
> >>The fbdev framebuffer changes are flushed using the callback
> >>(struct drm_framebuffer *)->funcs->dirty() by a dedicated worker
> >>ensuring that it always runs in process context.
> >>
> >>Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> >>---
> >>
> >>Changes since v1:
> >>- Use a dedicated worker to run the framebuffer flushing like qxl does
> >>- Add parameter descriptions to drm_fb_helper_deferred_io
> >>
> >>  drivers/gpu/drm/drm_fb_helper.c | 127 +++++++++++++++++++++++++++++++=
++++++++-
> >>  include/drm/drm_fb_helper.h     |  17 ++++++
> >>  2 files changed, 143 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_h=
elper.c
> >>index 855108e..46ee6f8 100644
> >>--- a/drivers/gpu/drm/drm_fb_helper.c
> >>+++ b/drivers/gpu/drm/drm_fb_helper.c
> >>@@ -40,6 +40,7 @@
> >>  #include <drm/drm_crtc_helper.h>
> >>  #include <drm/drm_atomic.h>
> >>  #include <drm/drm_atomic_helper.h>
> >>+#include <drm/drm_rect.h>
> >>
> >>  static bool drm_fbdev_emulation =3D true;
> >>  module_param_named(fbdev_emulation, drm_fbdev_emulation, bool, 0600);
> >>@@ -48,6 +49,10 @@ MODULE_PARM_DESC(fbdev_emulation,
> >>
> >>  static LIST_HEAD(kernel_fb_helper_list);
> >>
> >>+static void drm_fb_helper_dirty_init(struct drm_fb_helper *helper);
> >>+static void drm_fb_helper_dirty(struct fb_info *info, u32 x, u32 y,
> >>+				u32 width, u32 height);
> >>+
> >>  /**
> >>   * DOC: fbdev helpers
> >>   *
> >>@@ -84,6 +89,16 @@ static LIST_HEAD(kernel_fb_helper_list);
> >>   * and set up an initial configuration using the detected hardware, d=
rivers
> >>   * should call drm_fb_helper_single_add_all_connectors() followed by
> >>   * drm_fb_helper_initial_config().
> >>+ *
> >>+ * If CONFIG_FB_DEFERRED_IO is enabled and
> >>+ * (struct drm_framebuffer *)->funcs->dirty is set, the
> >>+ * drm_fb_helper_{cfb,sys}_{write,fillrect,copyarea,imageblit} functio=
ns
> >>+ * will accumulate changes and schedule (struct fb_helper).dirty_work =
to run
> >>+ * right away. This worker then calls the dirty() function ensuring th=
at it
> >>+ * will always run in process context since the fb_*() function could =
be
> >>+ * running in atomic context. If drm_fb_helper_deferred_io() is used a=
s the
> >>+ * deferred_io callback it will also schedule dirty_work with the dama=
ge
> >>+ * collected from the mmap page writes.
> >One thing to consider (and personally I don't care either way) is whether
> >we shouldn't just select CONFIG_FB_DEFERRED_IO if the fbdev helpers are
> >enabled. Pushing that out to drivers is imo a bit fragile.
> >
> >But like I said I'm ok with either way.
>=20
> My concern was adding code and data that only a few drivers would
> actually use. But of course there's the tradeoff with complexity.
> I use this to enable it:
>         select FB_DEFERRED_IO if DRM_KMS_FB_HELPER
>=20
> I guess the maintainer has to make this choice between size and complexity
> :-)
> I can enable it by default if you want, drm is both huge and complex so I
> don't know what's best.
>=20
> As a sidenote, I have also put all the fbdev code in a file of it's own to
> make it simple with regards to the DRM_FBDEV_EMULATION user option:
> tinydrm-$(CONFIG_DRM_KMS_FB_HELPER)     +=3D tinydrm-fbdev.o

Ok, if you ask maintainers then please nuke the #ifdef from .c files. If
you select CONFIG_DRM_KMS_FB_HELPER, then you get hdmi, edid, dp aux, dp
mst and whatever else helpers, even if you don't need them. Adding 3
functions for defio when you select fbdev helpers and maybe don't need
them is totally harmless. And removing the #ifdef will look so much better
;-)

>=20
> >>   */
> >>
> >>  /**
> >>@@ -401,11 +416,14 @@ backoff:
> >>  static int restore_fbdev_mode(struct drm_fb_helper *fb_helper)
> >>  {
> >>  	struct drm_device *dev =3D fb_helper->dev;
> >>+	struct fb_info *info =3D fb_helper->fbdev;
> >>  	struct drm_plane *plane;
> >>  	int i;
> >>
> >>  	drm_warn_on_modeset_not_all_locked(dev);
> >>
> >>+	drm_fb_helper_dirty(info, 0, 0, info->var.xres, info->var.yres);
> >Why is this needed? If you do a modeset (or pageflip or whatever) drivers
> >are supposed to re-upload the entire screen. We've talked about adding a
> >dirty rectangle to atomic to allow userspace to optimize this, but there
> >should _never_ be a need to do a dirtyfb call around a modeset. Probably
> >just a driver bug in your panel drm drivers?
>=20
> Ok, in tinydrm I now set a flag in &drm_simple_display_pipe_funcs
> ->plane_update to indicate that the next dirty() should do the whole
> framebuffer which seems to work fine.
> Should I actually perform the update as well?
> If so I would need to add a worker in tinydrm to do that.

Yes, plane update should always do a full update. Not sure how you get
away with delaying that to ->dirty, maybe modesetting isn't
double-buffering when you don't have a GL that could do glamour.

->dirty is _only_ for frontbuffer rendering, not for page-flipping to an
entirely new buffer. In short if someone calls ->dirty on a buffer which
is currently not being displayed than a) they're silly b) drivers should
treat it as a no-op. Maybe we need a helper to do that ...
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 21 Apr 2016 07:49:39 +0000
Subject: Re: [PATCH 7/8] drm/qxl: Use drm_fb_helper deferred_io support
Message-Id: <20160421074939.GZ2510@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
 <1461165929-11344-8-git-send-email-noralf@tronnes.org>
 <20160420174710.GR2510@phenom.ffwll.local>
 <5717D2C6.7060806@tronnes.org>
 <20160421074134.GY2510@phenom.ffwll.local>
In-Reply-To: <20160421074134.GY2510@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, laurent.pinchart@ideasonboard.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org

On Thu, Apr 21, 2016 at 09:41:34AM +0200, Daniel Vetter wrote:
> On Wed, Apr 20, 2016 at 09:04:38PM +0200, Noralf Tr=F8nnes wrote:
> >=20
> > Den 20.04.2016 19:47, skrev Daniel Vetter:
> > >On Wed, Apr 20, 2016 at 05:25:28PM +0200, Noralf Tr=F8nnes wrote:
> > >>Use the fbdev deferred io support in drm_fb_helper.
> > >>The (struct fb_ops *)->fb_{fillrect,copyarea,imageblit} functions will
> > >>now be deferred in the same way that mmap damage is, instead of being
> > >>flushed directly.
> > >>This patch has only been compile tested.
> > >>
> > >>Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> > >>---
> > >>  drivers/gpu/drm/qxl/qxl_display.c |   9 +-
> > >>  drivers/gpu/drm/qxl/qxl_drv.h     |   7 +-
> > >>  drivers/gpu/drm/qxl/qxl_fb.c      | 220 ++++++++++-----------------=
-----------
> > >>  drivers/gpu/drm/qxl/qxl_kms.c     |   4 -
> > >>  4 files changed, 62 insertions(+), 178 deletions(-)
> > >>
> > >>diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/=
qxl_display.c
> > >>index 030409a..9a03524 100644
> > >>--- a/drivers/gpu/drm/qxl/qxl_display.c
> > >>+++ b/drivers/gpu/drm/qxl/qxl_display.c
> > >>@@ -465,7 +465,7 @@ static const struct drm_crtc_funcs qxl_crtc_funcs=
 =3D {
> > >>  	.page_flip =3D qxl_crtc_page_flip,
> > >>  };
> > >>-static void qxl_user_framebuffer_destroy(struct drm_framebuffer *fb)
> > >>+void qxl_user_framebuffer_destroy(struct drm_framebuffer *fb)
> > >>  {
> > >>  	struct qxl_framebuffer *qxl_fb =3D to_qxl_framebuffer(fb);
> > >>@@ -527,12 +527,13 @@ int
> > >>  qxl_framebuffer_init(struct drm_device *dev,
> > >>  		     struct qxl_framebuffer *qfb,
> > >>  		     const struct drm_mode_fb_cmd2 *mode_cmd,
> > >>-		     struct drm_gem_object *obj)
> > >>+		     struct drm_gem_object *obj,
> > >>+		     const struct drm_framebuffer_funcs *funcs)
> > >There should be no need at all to have a separate fb funcs table for t=
he
> > >fbdev fb. Both /should/ be able to use the exact same (already existin=
g)
> > >->dirty() callback. We need this only in CMA because CMA is a midlayer
> > >used by multiple drivers.
> >=20
> > I don't see how I can avoid it.
> >=20
> > fbdev framebuffer flushing:
> >=20
> > static void qxl_fb_dirty_flush(struct fb_info *info)
> > {
> >         qxl_fb_image_init(&qxl_fb_image, qdev, info, NULL);
> >         qxl_draw_opaque_fb(&qxl_fb_image, stride);
> > }
> >=20
> > drm framebuffer flushing:
> >=20
> > static int qxl_framebuffer_surface_dirty(...)
> > {
> >         qxl_draw_dirty_fb(...);
> > }
> >=20
> > qxl_draw_opaque_fb() and qxl_draw_dirty_fb() differ so much that it's w=
ay
> > over my head to see if they can be combined.
> > Here's an online diff of the two functions:
> > https://www.diffchecker.com/jqbbalux
>=20
> Imo nuke the fbdev one entirely. If it breaks then it's either a bug in
> your generic fbdefio code, or the qxl ->dirty implementation has a bug. It
> should work ;-)
>=20
> Ok, slightly more seriously the difference seems to be that the fbdev one
> support paletted mode too. But since qxl has 0 pixel format checking
> anywhere I have no idea whether that's dead code (i.e. broken) or actually
> working. I guess keeping the split is ok, if we add a big FIXME comment to
> it that this is very fishy.

Ok, I read around a bit more. The only things qxl seems to support are
bits_per_pixel of 1, 24 and 32 (see qxl_image_init_helper). And drm has no
way to pass in 1 bpp images. And it doesn't support 8 bit paletted, which
is the only paletted thing drm supports.

So if you totally feel like I think we could add format checking for
DRM_FORMAT_XRGB8888 and DRM_FORMAT_RGB888 in qxl_framebuffer_init and then
rip out all that code. But that's a few more patches and probably should
be tested actually ;-)

FIXME plus explaing it all in the commit message is fine with me too.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

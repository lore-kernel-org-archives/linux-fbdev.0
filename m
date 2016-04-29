From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 29 Apr 2016 14:55:24 +0000
Subject: Re: [PATCH v4 3/7] drm/fb-helper: Add fb_deferred_io support
Message-Id: <20160429145524.GC14148@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461856717-6476-1-git-send-email-noralf@tronnes.org>
 <1461856717-6476-4-git-send-email-noralf@tronnes.org>
 <572358A0.8010002@ti.com>
In-Reply-To: <572358A0.8010002@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, laurent.pinchart@ideasonboard.com

On Fri, Apr 29, 2016 at 03:50:40PM +0300, Tomi Valkeinen wrote:
> Hi,
>=20
> On 28/04/16 18:18, Noralf Tr=F8nnes wrote:
> > This adds deferred io support to drm_fb_helper.
> > The fbdev framebuffer changes are flushed using the callback
> > (struct drm_framebuffer *)->funcs->dirty() by a dedicated worker
> > ensuring that it always runs in process context.
> >=20
> > Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > ---
>=20
> Thanks for the series! Unfortunately I haven't been able to follow the
> discussions properly, so I hope my questions haven't been covered earlier.
>=20
> > Changes since v3:
> > - Don't use forward decl, move drm_fb_helper_dirty_work()
> > - Use DIV_ROUND_UP in drm_fb_helper_deferred_io()
> >=20
> > Changes since v2:
> > - FB_DEFERRED_IO is now always selected by DRM_KMS_FB_HELPER, ifdef rem=
oved
> > - The drm_clip_rect utility functions are dropped, so open code it
> > - docs: use & to denote structs
> >=20
> > Changes since v1:
> > - Use a dedicated worker to run the framebuffer flushing like qxl does
> > - Add parameter descriptions to drm_fb_helper_deferred_io
> >=20
> >  drivers/gpu/drm/Kconfig         |   1 +
> >  drivers/gpu/drm/drm_fb_helper.c | 103 ++++++++++++++++++++++++++++++++=
+++++++-
> >  include/drm/drm_fb_helper.h     |  15 ++++++
> >  3 files changed, 118 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index 9e4f2f1..8e6f34b 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -52,6 +52,7 @@ config DRM_KMS_FB_HELPER
> >  	select FB_CFB_FILLRECT
> >  	select FB_CFB_COPYAREA
> >  	select FB_CFB_IMAGEBLIT
> > +	select FB_DEFERRED_IO
> >  	help
> >  	  FBDEV helpers for KMS drivers.
> >=20
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_h=
elper.c
> > index 855108e..62f849f 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -84,6 +84,15 @@ static LIST_HEAD(kernel_fb_helper_list);
> >   * and set up an initial configuration using the detected hardware, dr=
ivers
> >   * should call drm_fb_helper_single_add_all_connectors() followed by
> >   * drm_fb_helper_initial_config().
> > + *
> > + * If CONFIG_FB_DEFERRED_IO is enabled and &drm_framebuffer_funcs ->di=
rty is
> > + * set, the drm_fb_helper_{cfb,sys}_{write,fillrect,copyarea,imageblit}
> > + * functions will accumulate changes and schedule &fb_helper .dirty_wo=
rk to run
> > + * right away. This worker then calls the dirty() function ensuring th=
at it
> > + * will always run in process context since the fb_*() function could =
be
> > + * running in atomic context. If drm_fb_helper_deferred_io() is used a=
s the
>=20
> Who's calling {write,fillrect,copyarea,imageblit} in an atomic context?
> That sounds like a very bad idea to me...
>=20
> If this is only for accumulating changes, I think it may be better to
> leave that to the driver as it may have better idea of how to accumulate.
>=20
> But, of course, this is a helper, so if all the drivers use this kind of
> accumulation, it makes sense =3D).

Apparently panic context and cursor timer and stuff like that. I think
this started with udl, and just to make sure (it's fbdev after all, no one
wants to read the code itself) we've put those checks onto all entry
points that draw stuff. It could be overkill, but this is what udl/qxl
already do, so better to keep imo for now.

I guess if it's really not needed we could later on change that, but not
sure that's worth the effort. And we can't get rid of it entirely.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

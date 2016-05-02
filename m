From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 02 May 2016 14:26:23 +0000
Subject: Re: [PATCH v4 0/7] drm: Add fbdev deferred io support to helpers
Message-Id: <20160502142623.GP14148@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461856717-6476-1-git-send-email-noralf@tronnes.org>
 <20160429145705.GD14148@phenom.ffwll.local>
In-Reply-To: <20160429145705.GD14148@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, laurent.pinchart@ideasonboard.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org

On Fri, Apr 29, 2016 at 04:57:05PM +0200, Daniel Vetter wrote:
> On Thu, Apr 28, 2016 at 05:18:30PM +0200, Noralf Tr=F8nnes wrote:
> > This patchset adds fbdev deferred io support to drm_fb_helper and
> > drm_fb_cma_helper.
> >=20
> > It channels fbdev mmap and fb_{write,fillrect,copyarea,imageblit} damage
> > through the (struct drm_framebuffer_funcs)->dirty callback on the
> > fb_helper framebuffer which will always run in process context.
> >=20
> > I have also added patches that converts qxl and udl to use this
> > deferred io support. I have only compile tested it, no functional testi=
ng.
> > I know that qxl is purely a software thing so I could actually test it,=
 but
> > I have never used qemu so I'm not keen on spending a lot of time on tha=
t.
> >=20
> > This was originally part of the tinydrm patchset.
> >=20
> > Changes since v3:
> > - drm/fb-helper: Add fb_deferred_io support
> >   - Don't use forward decl, move drm_fb_helper_dirty_work()
> >   - Use DIV_ROUND_UP in drm_fb_helper_deferred_io()
> >=20
> > Changes since v2:
> > - drm/rect: Add some drm_clip_rect utility functions
> >   - This patch is dropped
> > - drm/fb-helper: Add fb_deferred_io support
> >   - FB_DEFERRED_IO is now always selected by DRM_KMS_FB_HELPER, ifdef r=
emoved
> >   - The drm_clip_rect utility functions are dropped, so open code it
> >   - docs: use & to denote structs
> > - drm/qxl: Use drm_fb_helper deferred_io support
> >   - The drm_clip_rect_{width/height} functions are dropped, so open cod=
e it
> >=20
> > Changes since v1:
> > - drm/fb-helper: Add fb_deferred_io support
> >   - Use a dedicated worker to run the framebuffer flushing like qxl does
> >   - Add parameter descriptions to drm_fb_helper_deferred_io
> > - fbdev: fb_defio: Export fb_deferred_io_mmap
> >   - Expand commit message
> > - drm/qxl: Use drm_fb_helper deferred_io support
> >   - Add FIXME about special dirty() callback for fbdev
> >   - Remove note in commit message about deferred worker, drm_fb_helper
> >     is similar to qxl now.
> > - drm/udl: Use drm_fb_helper deferred_io support
> >   - No need to enable deferred_io by default since drm_fb_helper uses
> >     a dedicated worker for flushing
> >=20
> > Changes since RFC:
> > - Fix drm_clip_rect use to be exclusive on x2/y2
> > - Put drm_clip_rect functions in drm_rect.{h,c}
> > - Take into account that (struct fb_ops *)->fb_{write,...}() can be cal=
led
> >   from atomic context (spin_lock_irqsave)
> > - Export fb_deferred_io_mmap()
> > - Add some more documentation
> > - Add qxl and udl patches
> >=20
> > Noralf Tr=F8nnes (7):
> >   drm/udl: Change drm_fb_helper_sys_*() calls to sys_*()
> >   drm/qxl: Change drm_fb_helper_sys_*() calls to sys_*()
> >   drm/fb-helper: Add fb_deferred_io support
> >   fbdev: fb_defio: Export fb_deferred_io_mmap
> >   drm/fb-cma-helper: Add fb_deferred_io support
> >   drm/qxl: Use drm_fb_helper deferred_io support
> >   drm/udl: Use drm_fb_helper deferred_io support
>=20
> Scrolled through them all once more, and didn't spot anything else. Great
> work! I plan to pull it all into drm-misc next week for 4.7 still. Please
> ping me in case I forget.

And done, thanks a lot for your work!

Cheers, Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

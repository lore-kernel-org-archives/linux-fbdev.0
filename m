From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Wed, 27 Apr 2016 19:49:49 +0000
Subject: Re: [PATCH v3 0/7] drm: Add fbdev deferred io support to helpers
Message-Id: <572117DD.9020403@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461780996-8612-1-git-send-email-noralf@tronnes.org>
 <20160427192446.GI2558@phenom.ffwll.local>
In-Reply-To: <20160427192446.GI2558@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, laurent.pinchart@ideasonboard.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


Den 27.04.2016 21:24, skrev Daniel Vetter:
> On Wed, Apr 27, 2016 at 08:16:29PM +0200, Noralf Tr=F8nnes wrote:
>> This patchset adds fbdev deferred io support to drm_fb_helper and
>> drm_fb_cma_helper.
>>
>> It channels fbdev mmap and fb_{write,fillrect,copyarea,imageblit} damage
>> through the (struct drm_framebuffer_funcs)->dirty callback on the
>> fb_helper framebuffer which will always run in process context.
>>
>> I have also added patches that converts qxl and udl to use this
>> deferred io support. I have only compile tested it, no functional testin=
g.
>> I know that qxl is purely a software thing so I could actually test it, =
but
>> I have never used qemu so I'm not keen on spending a lot of time on that.
>>
>> This was originally part of the tinydrm patchset.
>>
>> Changes since v2:
>> - drm/rect: Add some drm_clip_rect utility functions
>>    - This patch is dropped
>> - drm/fb-helper: Add fb_deferred_io support
>>    - FB_DEFERRED_IO is now always selected by DRM_KMS_FB_HELPER, ifdef r=
emoved
>>    - The drm_clip_rect utility functions are dropped, so open code it
>>    - docs: use & to denote structs
>> - drm/qxl: Use drm_fb_helper deferred_io support
>>    - The drm_clip_rect_{width/height} functions are dropped, so open cod=
e it
> Found two tiny nit in the drm fbdev helper patch. Otherwise I think just =
needs
> an ack from Tomi for the fbdev patch, and from Laurent Pinchart for the
> cma one (you've forgotten to cc him) and this is good to land imo.
> -Daniel

Laurent has been cc'ed on the entire patchset.
Should I have added cc: laurent.pinchart@ideasonboard.com in the
cma commit message instead?

I'm not sure who should get what in a patchset like this.
I use git send-email, and have included all parties for the entire patchset,
but should Tomi for instance have received only the fbdev patch and
nothing else?

Noralf.

>> Changes since v1:
>> - drm/fb-helper: Add fb_deferred_io support
>>    - Use a dedicated worker to run the framebuffer flushing like qxl does
>>    - Add parameter descriptions to drm_fb_helper_deferred_io
>> - fbdev: fb_defio: Export fb_deferred_io_mmap
>>    - Expand commit message
>> - drm/qxl: Use drm_fb_helper deferred_io support
>>    - Add FIXME about special dirty() callback for fbdev
>>    - Remove note in commit message about deferred worker, drm_fb_helper
>>      is similar to qxl now.
>> - drm/udl: Use drm_fb_helper deferred_io support
>>    - No need to enable deferred_io by default since drm_fb_helper uses
>>      a dedicated worker for flushing
>>
>> Changes since RFC:
>> - Fix drm_clip_rect use to be exclusive on x2/y2
>> - Put drm_clip_rect functions in drm_rect.{h,c}
>> - Take into account that (struct fb_ops *)->fb_{write,...}() can be call=
ed
>>    from atomic context (spin_lock_irqsave)
>> - Export fb_deferred_io_mmap()
>> - Add some more documentation
>> - Add qxl and udl patches
>>
>> Noralf Tr=F8nnes (7):
>>    drm/udl: Change drm_fb_helper_sys_*() calls to sys_*()
>>    drm/qxl: Change drm_fb_helper_sys_*() calls to sys_*()
>>    drm/fb-helper: Add fb_deferred_io support
>>    fbdev: fb_defio: Export fb_deferred_io_mmap
>>    drm/fb-cma-helper: Add fb_deferred_io support
>>    drm/qxl: Use drm_fb_helper deferred_io support
>>    drm/udl: Use drm_fb_helper deferred_io support
>>
>>   drivers/gpu/drm/Kconfig             |   1 +
>>   drivers/gpu/drm/drm_fb_cma_helper.c | 178 ++++++++++++++++++++++++++--
>>   drivers/gpu/drm/drm_fb_helper.c     | 109 +++++++++++++++++-
>>   drivers/gpu/drm/qxl/qxl_display.c   |   9 +-
>>   drivers/gpu/drm/qxl/qxl_drv.h       |   7 +-
>>   drivers/gpu/drm/qxl/qxl_fb.c        | 223 +++++++++-------------------=
--------
>>   drivers/gpu/drm/qxl/qxl_kms.c       |   4 -
>>   drivers/gpu/drm/udl/udl_drv.h       |   2 -
>>   drivers/gpu/drm/udl/udl_fb.c        | 140 +---------------------
>>   drivers/video/fbdev/core/fb_defio.c |   3 +-
>>   include/drm/drm_fb_cma_helper.h     |  14 +++
>>   include/drm/drm_fb_helper.h         |  15 +++
>>   include/linux/fb.h                  |   1 +
>>   13 files changed, 378 insertions(+), 328 deletions(-)
>>
>> --
>> 2.2.2
>>


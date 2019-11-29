From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 29 Nov 2019 15:40:19 +0000
Subject: Re: [PATCH v2 00/14] video, drm, etc: constify fbops in struct fb_info
Message-Id: <20191129154019.GI624164@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <cover.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jani Nikula <jani.nikula@intel.com>
Cc: Steve Glendinning <steve.glendinning@shawell.net>, linux-fbdev@vger.kernel.org, Andy Walls <awalls@md.metrocast.net>, kvm@vger.kernel.org, linux-omap@vger.kernel.org, Robin van der Gracht <robin@protonic.nl>, intel-gfx@lists.freedesktop.org, linux-input@vger.kernel.org, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, ivtv-devel@ivtvdriver.org, Kirti Wankhede <kwankhede@nvidia.com>, linux-media@vger.kernel.org, Jaya Kumar <jayalk@intworks.biz>

On Fri, Nov 29, 2019 at 12:29:30PM +0200, Jani Nikula wrote:
> This is v2 of https://patchwork.freedesktop.org/series/70119/
>=20
> I wanted to make our struct fb_ops const because we don't modify
> it... and this is what I ended up with to fix it and a bunch of others.
>=20
> I would appreciate acks to merge all this via the drm-misc tree. This is
> especially important for patches 1-8 to reasonably get the job
> done. Patches 9-14 are somewhat easier to merge at leisure afterwards,
> but there really isn't much conflict potential IMO.

Only patches 11-14 need acks, drivers/video is already officially
maintained in drm-misc.

> Daniel, please double-check me adding your Reviewed-by on the later
> patches wasn't overzealous.

Yeah, looks all neat&tidy.
-Daniel

>=20
> BR,
> Jani.
>=20
>=20
> Cc: Andy Walls <awalls@md.metrocast.net>
> Cc: Bernie Thompson <bernie@plugable.com>
> Cc: Bruno Pr=E9mont <bonbons@linux-vserver.org>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Cc: Jaya Kumar <jayalk@intworks.biz>
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> Cc: Noralf Tr=F8nnes <noralf@tronnes.org>
> Cc: Robin van der Gracht <robin@protonic.nl>
> Cc: Steve Glendinning <steve.glendinning@shawell.net>
> Cc: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: ivtv-devel@ivtvdriver.org
> Cc: kvm@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
>=20
>=20
> Jani Nikula (14):
>   video: fb_defio: preserve user fb_ops
>   drm/fb-helper: don't preserve fb_ops across deferred IO use
>   video: smscufx: don't restore fb_mmap after deferred IO cleanup
>   video: udlfb: don't restore fb_mmap after deferred IO cleanup
>   video: fbdev: vesafb: modify the static fb_ops directly
>   video: fbmem: use const pointer for fb_ops
>   video: omapfb: use const pointer for fb_ops
>   video: fbdev: make fbops member of struct fb_info a const pointer
>   drm: constify fb ops across all drivers
>   video: constify fb ops across all drivers
>   HID: picoLCD: constify fb ops
>   media: constify fb ops across all drivers
>   samples: vfio-mdev: constify fb ops
>   auxdisplay: constify fb ops
>=20
>  drivers/auxdisplay/cfag12864bfb.c             |  2 +-
>  drivers/auxdisplay/ht16k33.c                  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c        |  2 +-
>  drivers/gpu/drm/armada/armada_fbdev.c         |  2 +-
>  drivers/gpu/drm/drm_fb_helper.c               | 27 +++----------------
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c     |  2 +-
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c |  2 +-
>  drivers/gpu/drm/i915/display/intel_fbdev.c    |  2 +-
>  drivers/gpu/drm/msm/msm_fbdev.c               |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_fbcon.c       |  4 +--
>  drivers/gpu/drm/omapdrm/omap_fbdev.c          |  2 +-
>  drivers/gpu/drm/radeon/radeon_fb.c            |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c |  2 +-
>  drivers/gpu/drm/tegra/fb.c                    |  2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_fb.c            |  2 +-
>  drivers/hid/hid-picolcd_fb.c                  |  3 +--
>  drivers/media/pci/ivtv/ivtvfb.c               |  3 +--
>  drivers/media/platform/vivid/vivid-osd.c      |  3 +--
>  drivers/video/fbdev/68328fb.c                 |  2 +-
>  drivers/video/fbdev/acornfb.c                 |  2 +-
>  drivers/video/fbdev/amba-clcd.c               |  2 +-
>  drivers/video/fbdev/amifb.c                   |  2 +-
>  drivers/video/fbdev/arcfb.c                   |  2 +-
>  drivers/video/fbdev/arkfb.c                   |  2 +-
>  drivers/video/fbdev/asiliantfb.c              |  2 +-
>  drivers/video/fbdev/atmel_lcdfb.c             |  2 +-
>  drivers/video/fbdev/aty/aty128fb.c            |  2 +-
>  drivers/video/fbdev/aty/atyfb_base.c          |  2 +-
>  drivers/video/fbdev/aty/radeon_base.c         |  2 +-
>  drivers/video/fbdev/au1100fb.c                |  2 +-
>  drivers/video/fbdev/au1200fb.c                |  2 +-
>  drivers/video/fbdev/broadsheetfb.c            |  2 +-
>  drivers/video/fbdev/bw2.c                     |  2 +-
>  drivers/video/fbdev/carminefb.c               |  2 +-
>  drivers/video/fbdev/cg14.c                    |  2 +-
>  drivers/video/fbdev/cg3.c                     |  2 +-
>  drivers/video/fbdev/cg6.c                     |  2 +-
>  drivers/video/fbdev/chipsfb.c                 |  2 +-
>  drivers/video/fbdev/cirrusfb.c                |  2 +-
>  drivers/video/fbdev/clps711x-fb.c             |  2 +-
>  drivers/video/fbdev/cobalt_lcdfb.c            |  2 +-
>  drivers/video/fbdev/controlfb.c               |  2 +-
>  drivers/video/fbdev/core/fb_defio.c           |  3 ---
>  drivers/video/fbdev/core/fbmem.c              | 19 ++++++++-----
>  drivers/video/fbdev/cyber2000fb.c             |  2 +-
>  drivers/video/fbdev/da8xx-fb.c                |  2 +-
>  drivers/video/fbdev/dnfb.c                    |  2 +-
>  drivers/video/fbdev/efifb.c                   |  2 +-
>  drivers/video/fbdev/ep93xx-fb.c               |  2 +-
>  drivers/video/fbdev/fb-puv3.c                 |  2 +-
>  drivers/video/fbdev/ffb.c                     |  2 +-
>  drivers/video/fbdev/fm2fb.c                   |  2 +-
>  drivers/video/fbdev/fsl-diu-fb.c              |  2 +-
>  drivers/video/fbdev/g364fb.c                  |  2 +-
>  drivers/video/fbdev/gbefb.c                   |  2 +-
>  drivers/video/fbdev/geode/gx1fb_core.c        |  2 +-
>  drivers/video/fbdev/geode/gxfb_core.c         |  2 +-
>  drivers/video/fbdev/geode/lxfb_core.c         |  2 +-
>  drivers/video/fbdev/goldfishfb.c              |  2 +-
>  drivers/video/fbdev/grvga.c                   |  2 +-
>  drivers/video/fbdev/gxt4500.c                 |  2 +-
>  drivers/video/fbdev/hecubafb.c                |  2 +-
>  drivers/video/fbdev/hgafb.c                   |  2 +-
>  drivers/video/fbdev/hitfb.c                   |  2 +-
>  drivers/video/fbdev/hpfb.c                    |  2 +-
>  drivers/video/fbdev/hyperv_fb.c               |  2 +-
>  drivers/video/fbdev/i740fb.c                  |  2 +-
>  drivers/video/fbdev/imsttfb.c                 |  2 +-
>  drivers/video/fbdev/imxfb.c                   |  2 +-
>  drivers/video/fbdev/intelfb/intelfbdrv.c      |  2 +-
>  drivers/video/fbdev/kyro/fbdev.c              |  2 +-
>  drivers/video/fbdev/leo.c                     |  2 +-
>  drivers/video/fbdev/macfb.c                   |  2 +-
>  drivers/video/fbdev/matrox/matroxfb_crtc2.c   |  2 +-
>  drivers/video/fbdev/maxinefb.c                |  2 +-
>  drivers/video/fbdev/mb862xx/mb862xxfbdrv.c    |  2 +-
>  drivers/video/fbdev/mbx/mbxfb.c               |  2 +-
>  drivers/video/fbdev/metronomefb.c             |  2 +-
>  drivers/video/fbdev/mmp/fb/mmpfb.c            |  2 +-
>  drivers/video/fbdev/mx3fb.c                   |  5 ++--
>  drivers/video/fbdev/neofb.c                   |  2 +-
>  drivers/video/fbdev/nvidia/nvidia.c           |  2 +-
>  drivers/video/fbdev/ocfb.c                    |  2 +-
>  drivers/video/fbdev/offb.c                    |  2 +-
>  drivers/video/fbdev/omap/omapfb_main.c        |  2 +-
>  .../video/fbdev/omap2/omapfb/omapfb-main.c    |  2 +-
>  drivers/video/fbdev/p9100.c                   |  2 +-
>  drivers/video/fbdev/platinumfb.c              |  2 +-
>  drivers/video/fbdev/pm2fb.c                   |  2 +-
>  drivers/video/fbdev/pm3fb.c                   |  2 +-
>  drivers/video/fbdev/pmag-aa-fb.c              |  2 +-
>  drivers/video/fbdev/pmag-ba-fb.c              |  2 +-
>  drivers/video/fbdev/pmagb-b-fb.c              |  2 +-
>  drivers/video/fbdev/ps3fb.c                   |  2 +-
>  drivers/video/fbdev/pvr2fb.c                  |  2 +-
>  drivers/video/fbdev/pxa168fb.c                |  2 +-
>  drivers/video/fbdev/pxafb.c                   |  4 +--
>  drivers/video/fbdev/q40fb.c                   |  2 +-
>  drivers/video/fbdev/riva/fbdev.c              |  2 +-
>  drivers/video/fbdev/s3c-fb.c                  |  2 +-
>  drivers/video/fbdev/s3c2410fb.c               |  2 +-
>  drivers/video/fbdev/s3fb.c                    |  2 +-
>  drivers/video/fbdev/sa1100fb.c                |  2 +-
>  drivers/video/fbdev/savage/savagefb_driver.c  |  2 +-
>  drivers/video/fbdev/sh7760fb.c                |  2 +-
>  drivers/video/fbdev/sh_mobile_lcdcfb.c        |  4 +--
>  drivers/video/fbdev/simplefb.c                |  2 +-
>  drivers/video/fbdev/sis/sis_main.c            |  2 +-
>  drivers/video/fbdev/skeletonfb.c              |  2 +-
>  drivers/video/fbdev/sm712fb.c                 |  2 +-
>  drivers/video/fbdev/smscufx.c                 |  3 +--
>  drivers/video/fbdev/ssd1307fb.c               |  2 +-
>  drivers/video/fbdev/sstfb.c                   |  2 +-
>  drivers/video/fbdev/stifb.c                   |  2 +-
>  drivers/video/fbdev/sunxvr1000.c              |  2 +-
>  drivers/video/fbdev/sunxvr2500.c              |  2 +-
>  drivers/video/fbdev/sunxvr500.c               |  2 +-
>  drivers/video/fbdev/tcx.c                     |  2 +-
>  drivers/video/fbdev/tdfxfb.c                  |  2 +-
>  drivers/video/fbdev/tgafb.c                   |  2 +-
>  drivers/video/fbdev/tmiofb.c                  |  2 +-
>  drivers/video/fbdev/tridentfb.c               |  2 +-
>  drivers/video/fbdev/udlfb.c                   |  1 -
>  drivers/video/fbdev/uvesafb.c                 |  2 +-
>  drivers/video/fbdev/valkyriefb.c              |  2 +-
>  drivers/video/fbdev/vesafb.c                  |  6 ++---
>  drivers/video/fbdev/vfb.c                     |  2 +-
>  drivers/video/fbdev/vga16fb.c                 |  2 +-
>  drivers/video/fbdev/vt8500lcdfb.c             |  2 +-
>  drivers/video/fbdev/vt8623fb.c                |  2 +-
>  drivers/video/fbdev/w100fb.c                  |  2 +-
>  drivers/video/fbdev/wm8505fb.c                |  2 +-
>  drivers/video/fbdev/xen-fbfront.c             |  2 +-
>  drivers/video/fbdev/xilinxfb.c                |  2 +-
>  include/linux/fb.h                            |  2 +-
>  samples/vfio-mdev/mdpy-fb.c                   |  2 +-
>  136 files changed, 156 insertions(+), 175 deletions(-)
>=20
> --=20
> 2.20.1
>=20

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

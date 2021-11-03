Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAA9C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  3 Nov 2021 12:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7789D610EA
	for <linux-fbdev@archiver.kernel.org>; Wed,  3 Nov 2021 12:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhKCM7Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 3 Nov 2021 08:59:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:47805 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhKCM7X (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 3 Nov 2021 08:59:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="212239588"
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="212239588"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 05:56:46 -0700
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="501045631"
Received: from bmagdala-mobl.ger.corp.intel.com (HELO localhost) ([10.251.215.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 05:56:38 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "Pan\, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org,
        spice-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RESEND PATCH 2/5] drm: Move nomodeset kernel parameter handler to the DRM subsystem
In-Reply-To: <20211103122809.1040754-3-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211103122809.1040754-1-javierm@redhat.com> <20211103122809.1040754-3-javierm@redhat.com>
Date:   Wed, 03 Nov 2021 14:56:36 +0200
Message-ID: <87tugtbdob.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 03 Nov 2021, Javier Martinez Canillas <javierm@redhat.com> wrote:
> The "nomodeset" kernel cmdline parameter is handled by the vgacon driver
> but the exported vgacon_text_force() symbol is only used by DRM drivers.
>
> It makes much more sense for the parameter logic to be in the subsystem
> of the drivers that are making use of it. Let's move that to DRM.
>
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
>  drivers/gpu/drm/Makefile                |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 +--
>  drivers/gpu/drm/ast/ast_drv.c           |  1 -
>  drivers/gpu/drm/drm_nomodeset.c         | 26 +++++++++++++++++++++++++
>  drivers/gpu/drm/i915/i915_module.c      |  2 --
>  drivers/gpu/drm/mgag200/mgag200_drv.c   |  1 -
>  drivers/gpu/drm/nouveau/nouveau_drm.c   |  1 -
>  drivers/gpu/drm/qxl/qxl_drv.c           |  1 -
>  drivers/gpu/drm/radeon/radeon_drv.c     |  1 -
>  drivers/gpu/drm/tiny/bochs.c            |  1 -
>  drivers/gpu/drm/tiny/cirrus.c           |  1 -
>  drivers/gpu/drm/vboxvideo/vbox_drv.c    |  1 -
>  drivers/gpu/drm/virtio/virtgpu_drv.c    |  1 -
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  1 -
>  drivers/video/console/vgacon.c          | 21 --------------------
>  include/drm/drm_mode_config.h           |  6 ++++++
>  include/linux/console.h                 |  6 ------
>  17 files changed, 35 insertions(+), 41 deletions(-)
>  create mode 100644 drivers/gpu/drm/drm_nomodeset.c
>
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 1c41156deb5f..0e2d60ea93ca 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -33,6 +33,8 @@ drm-$(CONFIG_DRM_PRIVACY_SCREEN) += drm_privacy_screen.o drm_privacy_screen_x86.
>  
>  obj-$(CONFIG_DRM_DP_AUX_BUS) += drm_dp_aux_bus.o
>  
> +obj-y += drm_nomodeset.o

This is a subtle functional change. With this, you'll always have
__setup("nomodeset", text_mode) builtin and the parameter available. And
using nomodeset will print out the pr_warn() splat from text_mode(). But
removing nomodeset will have no impact if CONFIG_VGA_CONSOLE=n as that
leads to vgacon_text_force() always returning false.

To not make functional changes, this should be:

obj-$(CONFIG_VGA_CONSOLE) += drm_nomodeset.o

Now, going with the cleanup in this series, maybe we should make the
functional change, and break the connection to CONFIG_VGA_CONSOLE
altogether, also in the header?

(Maybe we'll also need a proxy drm kconfig option to only have
drm_modeset.o builtin when CONFIG_DRM != n.)

> +
>  drm_cma_helper-y := drm_gem_cma_helper.o
>  obj-$(CONFIG_DRM_GEM_CMA_HELPER) += drm_cma_helper.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index c718fb5f3f8a..2680a2aaa877 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -31,7 +31,6 @@
>  #include "amdgpu_drv.h"
>  
>  #include <drm/drm_pciids.h>
> -#include <linux/console.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/vga_switcheroo.h>
> @@ -2515,7 +2514,7 @@ static int __init amdgpu_init(void)
>  	int r;
>  
>  	if (vgacon_text_force()) {
> -		DRM_ERROR("VGACON disables amdgpu kernel modesetting.\n");
> +		DRM_ERROR("amdgpu kernel modesetting disabled.\n");
>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
> index 86d5cd7b6318..048be607b182 100644
> --- a/drivers/gpu/drm/ast/ast_drv.c
> +++ b/drivers/gpu/drm/ast/ast_drv.c
> @@ -26,7 +26,6 @@
>   * Authors: Dave Airlie <airlied@redhat.com>
>   */
>  
> -#include <linux/console.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  
> diff --git a/drivers/gpu/drm/drm_nomodeset.c b/drivers/gpu/drm/drm_nomodeset.c
> new file mode 100644
> index 000000000000..1ac9a8d5a8fe
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_nomodeset.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +
> +static bool vgacon_text_mode_force;
> +
> +bool vgacon_text_force(void)
> +{
> +	return vgacon_text_mode_force;
> +}
> +EXPORT_SYMBOL(vgacon_text_force);
> +
> +static int __init text_mode(char *str)
> +{
> +	vgacon_text_mode_force = true;
> +
> +	pr_warn("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
> +	pr_warn("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
> +	pr_warn("Unless you actually understand what nomodeset does, you should reboot without enabling it\n");
> +
> +	return 1;
> +}
> +
> +/* force text mode - used by kernel modesetting */
> +__setup("nomodeset", text_mode);
> diff --git a/drivers/gpu/drm/i915/i915_module.c b/drivers/gpu/drm/i915/i915_module.c
> index c7507266aa83..14a59226519d 100644
> --- a/drivers/gpu/drm/i915/i915_module.c
> +++ b/drivers/gpu/drm/i915/i915_module.c
> @@ -4,8 +4,6 @@
>   * Copyright © 2021 Intel Corporation
>   */
>  
> -#include <linux/console.h>
> -
>  #include "gem/i915_gem_context.h"
>  #include "gem/i915_gem_object.h"
>  #include "i915_active.h"
> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
> index 6b9243713b3c..685e766db6a4 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_drv.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
> @@ -6,7 +6,6 @@
>   *          Dave Airlie
>   */
>  
> -#include <linux/console.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/vmalloc.h>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 1f828c9f691c..029997f50d1a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -22,7 +22,6 @@
>   * Authors: Ben Skeggs
>   */
>  
> -#include <linux/console.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index fc47b0deb021..3cd6bd9f059d 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -29,7 +29,6 @@
>  
>  #include "qxl_drv.h"
>  
> -#include <linux/console.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/vgaarb.h>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index b74cebca1f89..9b606c1b11ec 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -31,7 +31,6 @@
>  
>  
>  #include <linux/compat.h>
> -#include <linux/console.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/vga_switcheroo.h>
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index 2ce3bd903b70..04333f78be55 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  
> -#include <linux/console.h>
>  #include <linux/pci.h>
>  
>  #include <drm/drm_aperture.h>
> diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
> index 4611ec408506..8bd674f0d682 100644
> --- a/drivers/gpu/drm/tiny/cirrus.c
> +++ b/drivers/gpu/drm/tiny/cirrus.c
> @@ -16,7 +16,6 @@
>   * Copyright 1999-2001 Jeff Garzik <jgarzik@pobox.com>
>   */
>  
> -#include <linux/console.h>
>  #include <linux/dma-buf-map.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.c b/drivers/gpu/drm/vboxvideo/vbox_drv.c
> index a6c81af37345..e6d983121d0b 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
> @@ -7,7 +7,6 @@
>   *          Michael Thayer <michael.thayer@oracle.com,
>   *          Hans de Goede <hdegoede@redhat.com>
>   */
> -#include <linux/console.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/vt_kern.h>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 749db18dcfa2..cd4c170236f1 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -27,7 +27,6 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/console.h>
>  #include <linux/pci.h>
>  #include <linux/poll.h>
>  #include <linux/wait.h>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index ab9a1750e1df..fcc4b5a7f639 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -25,7 +25,6 @@
>   *
>   **************************************************************************/
>  
> -#include <linux/console.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
> index ef9c57ce0906..d4320b147956 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -97,30 +97,9 @@ static int 		vga_video_font_height;
>  static int 		vga_scan_lines		__read_mostly;
>  static unsigned int 	vga_rolled_over; /* last vc_origin offset before wrap */
>  
> -static bool vgacon_text_mode_force;
>  static bool vga_hardscroll_enabled;
>  static bool vga_hardscroll_user_enable = true;
>  
> -bool vgacon_text_force(void)
> -{
> -	return vgacon_text_mode_force;
> -}
> -EXPORT_SYMBOL(vgacon_text_force);
> -
> -static int __init text_mode(char *str)
> -{
> -	vgacon_text_mode_force = true;
> -
> -	pr_warn("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
> -	pr_warn("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
> -	pr_warn("Unless you actually understand what nomodeset does, you should reboot without enabling it\n");
> -
> -	return 1;
> -}
> -
> -/* force text mode - used by kernel modesetting */
> -__setup("nomodeset", text_mode);
> -
>  static int __init no_scroll(char *str)
>  {
>  	/*
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 48b7de80daf5..e1d2042a7b77 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -969,4 +969,10 @@ static inline int drm_mode_config_init(struct drm_device *dev)
>  void drm_mode_config_reset(struct drm_device *dev);
>  void drm_mode_config_cleanup(struct drm_device *dev);
>  
> +#ifdef CONFIG_VGA_CONSOLE
> +extern bool vgacon_text_force(void);
> +#else
> +static inline bool vgacon_text_force(void) { return false; }
> +#endif
> +

As said, maybe the CONFIG_VGA_CONSOLE ifdef should be dropped.

Also, this seems like a completely arbitrary choice of header to place
this.


BR,
Jani.


>  #endif
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 20874db50bc8..d4dd8384898b 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -217,12 +217,6 @@ extern atomic_t ignore_console_lock_warning;
>  #define VESA_HSYNC_SUSPEND      2
>  #define VESA_POWERDOWN          3
>  
> -#ifdef CONFIG_VGA_CONSOLE
> -extern bool vgacon_text_force(void);
> -#else
> -static inline bool vgacon_text_force(void) { return false; }
> -#endif
> -
>  extern void console_init(void);
>  
>  /* For deferred console takeover */

-- 
Jani Nikula, Intel Open Source Graphics Center

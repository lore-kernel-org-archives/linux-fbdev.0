Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CD7C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209EB600D4
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 13:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242210AbhJ0Noi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Oct 2021 09:44:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:29346 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242227AbhJ0Noh (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Oct 2021 09:44:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="227617391"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="227617391"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 06:42:04 -0700
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="497870033"
Received: from smaharan-mobl.gar.corp.intel.com (HELO localhost) ([10.251.214.195])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 06:41:59 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>, dri-devel@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Auld <matthew.auld@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] [v2] i915: fix backlight configuration issue
In-Reply-To: <20211027132732.3993279-3-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211027132732.3993279-1-arnd@kernel.org> <20211027132732.3993279-3-arnd@kernel.org>
Date:   Wed, 27 Oct 2021 16:41:55 +0300
Message-ID: <87r1c6h9ek.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 27 Oct 2021, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The i915 driver can use the backlight subsystem as an option, and usually
> selects it when CONFIG_ACPI is set. However it is possible to configure
> a kernel with modular backlight classdev support and a built-in i915
> driver, which leads to a linker error:
>
> drivers/gpu/drm/i915/display/intel_panel.o: In function `intel_backlight_device_register':
> intel_panel.c:(.text+0x2f58): undefined reference to `backlight_device_register'
> drivers/gpu/drm/i915/display/intel_panel.o: In function `intel_backlight_device_unregister':
> intel_panel.c:(.text+0x2fe4): undefined reference to `backlight_device_unregister'
>
> Change i915 to just 'depends on' for both BACKLIGHT_CLASS_DEVICE
> and ACPI_VIDEO, which avoids a lot of the problems.
>
> Link: https://lore.kernel.org/all/20200108140227.3976563-1-arnd@arndb.de/
> Link: https://lore.kernel.org/all/20200417155553.675905-1-arnd@arndb.de/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This change depends on cleaning up drivers/video/fbdev to no longer
> 'select' I2C and BACKLIGHT_CLASS_DEVICE, otherwise it causes
> dependency loops.
> ---
>  drivers/gpu/drm/i915/Kconfig | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
> index 84b6fc70cbf5..f427e6d50d9b 100644
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@ -3,6 +3,8 @@ config DRM_I915
>  	tristate "Intel 8xx/9xx/G3x/G4x/HD Graphics"
>  	depends on DRM
>  	depends on X86 && PCI
> +	depends on ACPI_VIDEO || !ACPI
> +	depends on BACKLIGHT_CLASS_DEVICE || !BACKLIGHT_CLASS_DEVICE
>  	select INTEL_GTT
>  	select INTERVAL_TREE
>  	# we need shmfs for the swappable backing store, and in particular
> @@ -16,10 +18,6 @@ config DRM_I915
>  	select IRQ_WORK
>  	# i915 depends on ACPI_VIDEO when ACPI is enabled
>  	# but for select to work, need to select ACPI_VIDEO's dependencies, ick

The comment needs updating as well.

Other than that,

Acked-by: Jani Nikula <jani.nikula@intel.com>

on the series.

> -	select BACKLIGHT_CLASS_DEVICE if ACPI
> -	select INPUT if ACPI
> -	select ACPI_VIDEO if ACPI
> -	select ACPI_BUTTON if ACPI
>  	select SYNC_FILE
>  	select IOSF_MBI
>  	select CRC32

-- 
Jani Nikula, Intel Open Source Graphics Center

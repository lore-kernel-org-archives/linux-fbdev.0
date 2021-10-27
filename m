Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FACC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 13:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E131660E54
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 13:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242129AbhJ0Nar (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Oct 2021 09:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233118AbhJ0Nar (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Oct 2021 09:30:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A41A60462;
        Wed, 27 Oct 2021 13:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635341301;
        bh=PGO1sKMkFxhSgafCfuIdDyaWHOAra0sduE/qroUyhJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gh6LrMhVRb+w8cc6fASkt85HSUDcujVbPOdJf+kYKM4c10OkGaWKz0tej4i/v3gqL
         gqIpguIZ+CYCEkX8TMK1GyLQbICCXX8D3hVYu84Wn0s8UH3S16wO6eRz+4zepH+vZ+
         yjfArY3xgIAwyH8kYC5jkIQ28ZeLXvkParFkxkxSzroPleW5KcOAvnt/V+vK6xwsrO
         4k5WYVVKieMsJfrOe+vNpBAnsNhu7nEztCQqf/Q9FCiTcppHLm6f/7/iPdD4feBbeU
         m6EmfbImK972UruDY/qXwXB7qC9tmGF3gPJu4JWrykH2pXYQ4LAYB3ovC7PgfBauuc
         mL315UjXldK2g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
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
Subject: [PATCH 3/3] [v2] i915: fix backlight configuration issue
Date:   Wed, 27 Oct 2021 15:27:14 +0200
Message-Id: <20211027132732.3993279-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211027132732.3993279-1-arnd@kernel.org>
References: <20211027132732.3993279-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The i915 driver can use the backlight subsystem as an option, and usually
selects it when CONFIG_ACPI is set. However it is possible to configure
a kernel with modular backlight classdev support and a built-in i915
driver, which leads to a linker error:

drivers/gpu/drm/i915/display/intel_panel.o: In function `intel_backlight_device_register':
intel_panel.c:(.text+0x2f58): undefined reference to `backlight_device_register'
drivers/gpu/drm/i915/display/intel_panel.o: In function `intel_backlight_device_unregister':
intel_panel.c:(.text+0x2fe4): undefined reference to `backlight_device_unregister'

Change i915 to just 'depends on' for both BACKLIGHT_CLASS_DEVICE
and ACPI_VIDEO, which avoids a lot of the problems.

Link: https://lore.kernel.org/all/20200108140227.3976563-1-arnd@arndb.de/
Link: https://lore.kernel.org/all/20200417155553.675905-1-arnd@arndb.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This change depends on cleaning up drivers/video/fbdev to no longer
'select' I2C and BACKLIGHT_CLASS_DEVICE, otherwise it causes
dependency loops.
---
 drivers/gpu/drm/i915/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 84b6fc70cbf5..f427e6d50d9b 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -3,6 +3,8 @@ config DRM_I915
 	tristate "Intel 8xx/9xx/G3x/G4x/HD Graphics"
 	depends on DRM
 	depends on X86 && PCI
+	depends on ACPI_VIDEO || !ACPI
+	depends on BACKLIGHT_CLASS_DEVICE || !BACKLIGHT_CLASS_DEVICE
 	select INTEL_GTT
 	select INTERVAL_TREE
 	# we need shmfs for the swappable backing store, and in particular
@@ -16,10 +18,6 @@ config DRM_I915
 	select IRQ_WORK
 	# i915 depends on ACPI_VIDEO when ACPI is enabled
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select BACKLIGHT_CLASS_DEVICE if ACPI
-	select INPUT if ACPI
-	select ACPI_VIDEO if ACPI
-	select ACPI_BUTTON if ACPI
 	select SYNC_FILE
 	select IOSF_MBI
 	select CRC32
-- 
2.29.2


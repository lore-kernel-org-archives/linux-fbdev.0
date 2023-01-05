Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E010EC678D6
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 Jan 2023 13:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjAENrc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 Jan 2023 08:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjAENrK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 Jan 2023 08:47:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABB340863;
        Thu,  5 Jan 2023 05:47:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47C9461A8A;
        Thu,  5 Jan 2023 13:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3F5C433EF;
        Thu,  5 Jan 2023 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926426;
        bh=kCdt9zcWy5Z7iBU2hEYAS5q9hfAuSycaoJsMghPPkTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/Uq82a7wjGYOlAB2yEoZCR0RZ5zMqdRv7BhzgrX55PC+FXvDjhN/2+qUsOui/X/J
         FxhNSex0pPlmit+fN6Q+ZQzpwS8RzmxCKaw2qJmR5NjPulnR3paSfT+4efe/5nNkgq
         93sx1WUAdy0epj5JNt14gmBLLdbARS003W/ePPDxzCEZtWEfulLkx/Nub+0iq3sIRR
         uKrX7oihiV2b5KWAIJ+QP93WkCdDcTS1a8CMVzIdOwkByqCgUupeTrSZ67DpEosa3i
         S1SxlNCTWeBpN2DRtxfIWBlfGdxPVHrsgdy4xG1/cdYj9uioLx1Bpv76xXEy4N/E4r
         48Ku0/y/pmy0Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org
Subject: [PATCH 09/27] backlight: remove pxa tosa support
Date:   Thu,  5 Jan 2023 14:46:04 +0100
Message-Id: <20230105134622.254560-10-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The PXA tosa machine was removed, so this backlight driver is no
longer needed.

Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/backlight/Kconfig    |  14 --
 drivers/video/backlight/Makefile   |   2 -
 drivers/video/backlight/tosa_bl.c  | 172 -----------------
 drivers/video/backlight/tosa_bl.h  |   8 -
 drivers/video/backlight/tosa_lcd.c | 284 -----------------------------
 5 files changed, 480 deletions(-)
 delete mode 100644 drivers/video/backlight/tosa_bl.c
 delete mode 100644 drivers/video/backlight/tosa_bl.h
 delete mode 100644 drivers/video/backlight/tosa_lcd.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 936ba1e4d35e..01804847c39f 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -90,13 +90,6 @@ config LCD_PLATFORM
 	  This driver provides a platform-device registered LCD power
 	  control interface.
 
-config LCD_TOSA
-	tristate "Sharp SL-6000 LCD Driver"
-	depends on I2C && SPI && MACH_TOSA
-	help
-	  If you have an Sharp SL-6000 Zaurus say Y to enable a driver
-	  for its LCD.
-
 config LCD_HP700
 	tristate "HP Jornada 700 series LCD Driver"
 	depends on SA1100_JORNADA720_SSP && !PREEMPTION
@@ -288,13 +281,6 @@ config BACKLIGHT_APPLE
 	  If you have an Intel-based Apple say Y to enable a driver for its
 	  backlight.
 
-config BACKLIGHT_TOSA
-	tristate "Sharp SL-6000 Backlight Driver"
-	depends on I2C && MACH_TOSA && LCD_TOSA
-	help
-	  If you have an Sharp SL-6000 Zaurus say Y to enable a driver
-	  for its backlight
-
 config BACKLIGHT_QCOM_WLED
 	tristate "Qualcomm PMIC WLED Driver"
 	select REGMAP
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index e815f3f1deff..2a9126dbfe79 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -15,7 +15,6 @@ obj-$(CONFIG_LCD_LTV350QV)		+= ltv350qv.o
 obj-$(CONFIG_LCD_OTM3225A)		+= otm3225a.o
 obj-$(CONFIG_LCD_PLATFORM)		+= platform_lcd.o
 obj-$(CONFIG_LCD_TDO24M)		+= tdo24m.o
-obj-$(CONFIG_LCD_TOSA)			+= tosa_lcd.o
 obj-$(CONFIG_LCD_VGG2432A4)		+= vgg2432a4.o
 
 obj-$(CONFIG_BACKLIGHT_88PM860X)	+= 88pm860x_bl.o
@@ -53,7 +52,6 @@ obj-$(CONFIG_BACKLIGHT_QCOM_WLED)	+= qcom-wled.o
 obj-$(CONFIG_BACKLIGHT_RT4831)		+= rt4831-backlight.o
 obj-$(CONFIG_BACKLIGHT_SAHARA)		+= kb3886_bl.o
 obj-$(CONFIG_BACKLIGHT_SKY81452)	+= sky81452-backlight.o
-obj-$(CONFIG_BACKLIGHT_TOSA)		+= tosa_bl.o
 obj-$(CONFIG_BACKLIGHT_TPS65217)	+= tps65217_bl.o
 obj-$(CONFIG_BACKLIGHT_WM831X)		+= wm831x_bl.o
 obj-$(CONFIG_BACKLIGHT_ARCXCNN) 	+= arcxcnn_bl.o
diff --git a/drivers/video/backlight/tosa_bl.c b/drivers/video/backlight/tosa_bl.c
deleted file mode 100644
index 77b71f6c19b5..000000000000
diff --git a/drivers/video/backlight/tosa_bl.h b/drivers/video/backlight/tosa_bl.h
deleted file mode 100644
index 589e17e6fdb2..000000000000
diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
deleted file mode 100644
index 23d6c6bf0f54..000000000000
-- 
2.39.0


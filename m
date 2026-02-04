Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E1538F94A
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196529; cv=none; b=Q3wNA8CQeZsAUv8QDirEJE+cdRgWrvUF4ZeQSORinjXSoq5m3MgrXN9DMDDeANh5fYXh256ePt/5Wz76D1SkE0CvduSlHVpdIJ0fFXmpSeJ44qZBwIp993ZVj2OohSkPEGJdpaBNw7qCZkupHLJEK0XC99VHi+hw/ZMor69HBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196529; c=relaxed/simple;
	bh=cPVhSbaKKwE/mVA44liy3bFETtVffod2InS5RMEx/bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nad31f11MzuT+GE1DCZ5nDRz+zic7fyP5WeKCiWeDQKuMNIRxC944O+lM2/gl+sl9PVTJh8WDMPh57bvDFtOABRacRP062K3BGH6JRmjO6KVwojRwFpqrDHHi8N/qWvw1YbBKzvFMNDsVTyBHb77CcDieg1jTY+x0ciwiLKoHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XLXf4zTK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XLXf4zTK"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806f9e61f9so34243365e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 01:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770196527; x=1770801327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVIJCtTMtWwQCW2wYe5bKPfH9ZMqWjUcFGZghQ6tSuE=;
        b=XLXf4zTKArXWzQGsq035HwRvZdSGH1A6dG9sbC2I7iMfJuAnBa2M+hnpNJtodr1f9Z
         9//u37uTz69NYq44dRFnzSI6f3BNIls7iupcbHEhjxPk7d93hsluLg19svR4AMI/krtw
         9XV/6Yv9X2QEIvzkQCjeoa+DRxXax7mQsemNsKBVsWXyu+lSfcx1fJRpY8S2i10tRe/Z
         RbMAh81sSK4zKmOgdprJLLxt/y/5klzqiJqypxusPg0CL/uYhc1e7FFEsBS143bAqNdD
         aqkI0rPB4LNPYUYBaSAyeUVfpsW+pIWE1kwO6QXx5gxnqUIFuDuxfPMcng9LZeDSKLMH
         xrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770196527; x=1770801327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DVIJCtTMtWwQCW2wYe5bKPfH9ZMqWjUcFGZghQ6tSuE=;
        b=hqUOkb0yrZk5xnMO4E3s1I7mhWuwDkAMpNssJW6YjUtZP9WewnSLYNDUQ30M959ksm
         JwE59Ci8+xpi0iikMBIVSvbMFvtcPDqfDXH/J1z1EX2fYoTgdXH1flchUD+omIv/UBm4
         cgU0rTqknbrTbCr1MqtbkWdLvMqQICDlg3ANnOvYj5zr411/T417mtr01mMTG9VSHXes
         c/It2661f4aYa9SFSOEp8yt8N7xaDBIYz7l1a/jS/ZV+QpYKkqSOXxFWKdJDy7VBjt2F
         QvpJG8ccEFCvcZAKkvgCwEm84QlPyQuVqUnpyn2cHZOF5cEJu1hLuaKhC/rGGbEsPPeQ
         nVFA==
X-Forwarded-Encrypted: i=1; AJvYcCUmyriJrKM+M3VaWsmnM/MlU8DL9pMztW7hUG6dWUVNmgAMkL0PLZ/GzMSv8OLGV8O8kkKFuwQ/0CJAqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeDiB8+BoRkex4tFhjvZGw2ToVzDNCz6+1l8qmAK+MXEX+XUXq
	p5klHIbi1jkpmCdnBBRVuDiiK9zY0jK8Zg+/VFDHmmbgRLv6LHg9iX0SgezHoQgnQyQ=
X-Gm-Gg: AZuq6aJ7/Ckqw3brypBM5JgRp3zv9QwmTZIdJ5fYu5L2HHW/+vuVV3lXPWyhMBT8ckE
	qjfANnR/DpwBBVr+Ktuw0g9rOmEz0+fzEQcFXZ93YgwcVSESaJKRUEZEhQHcq4ot3D+E41PlTID
	XpdixLG+ArtL1T3xzZd6QxeoKSO2+niGEzMA+Vj6BVG5XuImgz4q3hE8oYka8X4eXITkd2Rk4jz
	ggeRRpk3xoZDbMarszDx4RUS0omYwjEoRiEc2pBKLuwzScr8YpVy7mRbCuhx2CiTg1K3tTqerI1
	DFuEuKWwRIiOH6F/OYho3w3XaeZI3iNlko1SQbATZ1QM6r1EYxED5lyRPLRt3y4/LFYq0A1pa6J
	Fk+hpM2wsTFXBDbxcDeKzION8jWSBkwCtTqmcZJfp4g0s6C2dysj7Db3xta2t4H/fyjMT8AzmPb
	b9KN7kEWyoAx7cLlIEGaCARQBww9a2F/3Pb10apTJbwzk52iD3FjqRdJXA70T4y+zcfWHY1hSMr
	cKn0Uo5yyMiXw==
X-Received: by 2002:a05:600c:468b:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-4830e99c72emr29701385e9.36.1770196527057;
        Wed, 04 Feb 2026 01:15:27 -0800 (PST)
Received: from localhost (p200300f65f20eb0470629fa1229c2efb.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:7062:9fa1:229c:2efb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48310894f18sm44778865e9.13.2026.02.04.01.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:15:26 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v1 2/3] fbdev: au1100fb: Make driver compilable on non-mips platforms
Date: Wed,  4 Feb 2026 10:15:12 +0100
Message-ID:  <474eca0c9ecb8a2e610e82922ad22ad7e8ff0b8b.1770196161.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770196161.git.u.kleine-koenig@baylibre.com>
References: <cover.1770196161.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2451; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=cPVhSbaKKwE/mVA44liy3bFETtVffod2InS5RMEx/bM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpgw4km6H91iYpizGBPVphON+1gkIa0V/my2vo9 /ygVx+d5sqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYMOJAAKCRCPgPtYfRL+ TtfuB/4lTOsl//F0pUN1BEkc63+KXjrQvUVmA3zrlN8WSJ4dZVS3EcYBJbpyy8nGt4A6qCN76P5 uxBpskZx+8g6nM9BuMPNXHynD+PF/d7C4igOs04MAJ0vGOAuRthbuEgEau3gwayspBt7sowHPyN OiVIKBq0EjVKmSa11vFUzP/yVsN5MoN833MWpLMnVSvmRXhJZQClcqbBvngxoHcGLUaxKF8CTaF zSQRXWrGCsplOmCHClvEE6QjXyOHjDcmI3vUpueDjYcnrAXMlfyOEb9iQhtmrHPguMyzbV4dXMd ReFqlO3wRLd7Hp/tF5uzYp2KfQep/6p1MolYb+qJ/MqQrAU0
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The header asm/mach-au1x00/au1000.h is unused apart from pulling in
<linux/delay.h> (for mdelay()) and <linux/io.h> (for KSEG1ADDR()). Then
the only platform specific part in the driver is the usage of the KSEG1ADDR
macro, which for the non-mips case can be stubbed.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/Kconfig    | 3 ++-
 drivers/video/fbdev/au1100fb.c | 9 +++++++--
 drivers/video/fbdev/au1100fb.h | 2 --
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 45733522ff48..4514c42db9fa 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1345,7 +1345,8 @@ endchoice
 
 config FB_AU1100
 	bool "Au1100 LCD Driver"
-	depends on (FB = y) && MIPS_ALCHEMY
+	depends on FB
+	depends on MIPS_ALCHEMY || COMPILE_TEST
 	select FB_IOMEM_HELPERS
 	help
 	  This is the framebuffer driver for the AMD Au1100 SOC.  It can drive
diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 4df470878b42..94514625965b 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -42,6 +42,8 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -55,12 +57,15 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <asm/mach-au1x00/au1000.h>
-
 #define DEBUG 0
 
 #include "au1100fb.h"
 
+#if defined(CONFIG_COMPILE_TEST) && !defined(CONFIG_MIPS)
+/* This is only defined to be able to compile this driver on non-mips platforms */
+#define KSEG1ADDR(x) (x)
+#endif
+
 #define DRIVER_NAME "au1100fb"
 #define DRIVER_DESC "LCD controller driver for AU1100 processors"
 
diff --git a/drivers/video/fbdev/au1100fb.h b/drivers/video/fbdev/au1100fb.h
index 79f4048726f1..8b29e424d017 100644
--- a/drivers/video/fbdev/au1100fb.h
+++ b/drivers/video/fbdev/au1100fb.h
@@ -30,8 +30,6 @@
 #ifndef _AU1100LCD_H
 #define _AU1100LCD_H
 
-#include <asm/mach-au1x00/au1000.h>
-
 #define print_err(f, arg...) printk(KERN_ERR DRIVER_NAME ": " f "\n", ## arg)
 #define print_warn(f, arg...) printk(KERN_WARNING DRIVER_NAME ": " f "\n", ## arg)
 #define print_info(f, arg...) printk(KERN_INFO DRIVER_NAME ": " f "\n", ## arg)
-- 
2.47.3


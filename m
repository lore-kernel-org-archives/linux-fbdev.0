Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDF301039
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Dec 2025 04:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765254504; cv=none; b=jWGC/+FDTBpNiDYUYKPgO3mmhgDXvHdZCyymAe4GyeFUr1oV18OLPH+niV1cSw0tLZFz7xTzXdqL7zB1ydIWe9rKGHdjvqdGlD6P80Oyn6wXtXNR1o8+Q447LE5YU7anePYLvEOgZRUQ+TMEm6dcWVHxonSLj/nonp1wPdoKiw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765254504; c=relaxed/simple;
	bh=3pidgD9TpcdjmuGEM4+2gj7Du8pBd7MRvFriroyxajI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=echuS9xXMKCedamdyF2bEez6lrk6Fvz0owemWGzlXEv7rGvrRw4PT2SXdZTOxyw2I16LtbkWnQYdGlqTqtWYsH9NZWFsLd5teDVlulD3UmzztxuWhgaU3/ipmbuvFxMkOLCdkj3J8efFaE0j3awsKTWXEQqB52ukqPMyvOCJpck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTpVjikD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTpVjikD"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29853ec5b8cso66313285ad.3
        for <linux-fbdev@vger.kernel.org>; Mon, 08 Dec 2025 20:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765254502; x=1765859302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoV8ebquCT6L/RZ0AqbPbGv9Gx9G1WrRRbUTSZpd9fE=;
        b=dTpVjikD2Nh9Nc85uX18Y/CF7eeymtNW82EdDmUYat0Nn0eaW3hWy2d1mDIg8raI0N
         vBYPWMW4+VI/KgaBRhNBMhFJ1138Gu2S+xIAnSwHV+O5n5+iMJ5L/pWbth2xJANeNL2/
         hiU+8+W1RTyvh2mBjgezwdSjVp0GPD8w1StXgX9lPsgCYfW+p/7OKUsz3wIaF2yAJcnd
         ljpa4rcpo7whB7tK0lKapQTP+zMQgESlRSc4LACfyEkhbZOUFCo8POPJbJ7pI38uaTOb
         Tr1tzz0U+Ab40qF1zCoMhfBY0pW/132j99/8IyleurMrGYc3l2XLBawcHT9u7bMxtjTu
         qpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765254502; x=1765859302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DoV8ebquCT6L/RZ0AqbPbGv9Gx9G1WrRRbUTSZpd9fE=;
        b=bpxRX+2XRq5oiw2+kNXdQ+y750J1HKBFBT5OMjIg+gYpExzPmivLgmg+n5Zxldpvhv
         QFJNmUx2+VkzqRzjdrvde92I/tN8uavvYUtR7SbxA3Mec3SWI9xOuLBn1SsC+ItXeW1l
         bZa5NhdqU14jlD80+2vKgvkYABEP0b05orvRUZb2W9wsPfPkCJqBNx70TxGn+mC26Van
         hN0GontBFAM1afIQf2CZfm2cttxJiGquV/RJv+1BJ2iDtjufEplr9+MMXP5L6Zgrwxgt
         OEB2R/3IebWYumM1drB7fWJBUJyCYoYXKYPN7e0U/is7QMoY8qkfi92m/+eZqRZ6fBIZ
         J0eQ==
X-Gm-Message-State: AOJu0YzLlN2D603HN/is7/u/3in1gUyAfmAMaWU2VqER1IUrCbvws11p
	mhaaFLrNA6jiK1kWxLjFMWixEVCkTyBIz+Y8+W45nM2CGrUQZtazZxr/3eGHtWPPlw8=
X-Gm-Gg: ASbGncu64ol7kJYBdFcsqxoDUEfvLX2qUP+oH/l9YRlEW0kW9DYcwNfenxECSlX2pG+
	ujI6MYTkHaYRS8CWulEsqEOwZxr7+z1/Ht9kDKJyN+avqRHplwJAPY/l0iQVd+LFIJ5N1atDFD3
	ZGSYyStJe9zURlZDEns2b6UUnz60at7YJ494+ffJdt2IwA0vKFKadgqYvNa3r0fBl/flgxDp8U7
	r7TgDCIuIo1yCp5yLEse7IJFjGYDgcAgbFjliotgCc9trrSBitGy0zKhy8/3tJBtqQtEBZWA3MA
	V+nCDDD77s5bm9aTl/EmGCYNzw5EBuignLf1Q6K6lK4uur6/B0X/L6BSbqGf7Ku2gf+4eS3aM+d
	2V9xK79RHpT0l6ucPlTPTPFey3vMGj4MU6FAlGHCQWCMkuhsrpcB2MYe/maFWX6HDwxUTWj+eud
	zhoiBhMFY9MZJ7fjMWEostLpeU9q1YkmUIKjJYInNdKO4=
X-Google-Smtp-Source: AGHT+IGhZ172wJMCe8Y+hl9H/FCCQtSdsSpkHLmThykFWMzH/YAfrcNiqXS6r43YyTp5Eyv9aHLeZg==
X-Received: by 2002:a17:90b:1a8b:b0:343:f509:aa4a with SMTP id 98e67ed59e1d1-349a260a9d0mr7994609a91.36.1765254501596;
        Mon, 08 Dec 2025 20:28:21 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:b455:298d:48bb:1784])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a49b90fd5sm765185a91.10.2025.12.08.20.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 20:28:21 -0800 (PST)
From: Chintan Patel <chintanlike@gmail.com>
To: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	tzimmermann@suse.de,
	andy@kernel.org,
	deller@gmx.de,
	gregkh@linuxfoundation.org,
	Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH 2/3] omapfb: Guard sysfs code under CONFIG_FB_DEVICE
Date: Mon,  8 Dec 2025 20:27:43 -0800
Message-ID: <20251209042744.7875-3-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209042744.7875-1-chintanlike@gmail.com>
References: <20251209042744.7875-1-chintanlike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omapfb implements multiple sysfs attributes for framebuffer rotation,
overlays, and debug information. These interfaces depend on FB_DEVICE
being enabled.

This patch wraps all sysfs attribute definitions, registration, and
removal in #ifdef CONFIG_FB_DEVICE. For FB_DEVICE=n, lightweight stub
functions are provided so that the driver builds and runs without
exposing sysfs interfaces.

Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/Kconfig        |  2 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/Kconfig b/drivers/video/fbdev/omap2/omapfb/Kconfig
index f4cdf999a080..ee664decbb64 100644
--- a/drivers/video/fbdev/omap2/omapfb/Kconfig
+++ b/drivers/video/fbdev/omap2/omapfb/Kconfig
@@ -5,7 +5,6 @@ config OMAP2_VRFB
 menuconfig FB_OMAP2
 	tristate "OMAP2+ frame buffer support"
 	depends on FB
-	depends on FB_DEVICE
 	depends on DRM_OMAP = n
 	depends on GPIOLIB
 	select FB_OMAP2_DSS
@@ -13,6 +12,7 @@ menuconfig FB_OMAP2
 	select FB_IOMEM_HELPERS
 	help
 	  Frame buffer driver for OMAP2+ based boards.
+	  Selecting FB_DEVICE enables additional sysfs interfaces.
 
 if FB_OMAP2
 
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c b/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
index 831b2c2fbdf9..0a340f69484f 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
@@ -24,6 +24,7 @@
 
 #include "omapfb.h"
 
+#ifdef CONFIG_FB_DEVICE
 static ssize_t show_rotate_type(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -585,4 +586,14 @@ void omapfb_remove_sysfs(struct omapfb2_device *fbdev)
 					&omapfb_attrs[t]);
 	}
 }
+#else
+int omapfb_create_sysfs(struct omapfb2_device *fbdev)
+{
+	return 0;
+}
+
+void omapfb_remove_sysfs(struct omapfb2_device *fbdev)
+{
+}
+#endif
 
-- 
2.43.0


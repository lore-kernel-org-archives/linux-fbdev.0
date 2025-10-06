Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E42DC76D
	for <linux-fbdev@vger.kernel.org>; Mon,  6 Oct 2025 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768923; cv=none; b=cDfBtVpji8PCZ6IyVUWR0wbSiFwS/m+koI69F2iQOpJJgasT6YaVXY4vgAbBp2+X0aO+qxiJX1eZLvFKaUlDNbPook5bxQYk3In0//CxACJG3nPg303OZV9xpvInCWBI15nYxhNx/RvuK4aoyOijE4zNLqkKwxGaidJtpVEv5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768923; c=relaxed/simple;
	bh=C7FdrotOExkG/5eyy10xgPUDVdT72B01GXJ62Fs4G10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jc6acWvrZQjSAXi9gRAYHyI5phXiF3OfBQ1k9gvILfQsrkRHj1Nfd+PYVqjwOnnStwoR7bYjfLtP/jknDwIDcSeqvXiGcM63Y2fyYdvczHl3PmHlZqQ1HcXehq33pjK6M5m0y1p6OZXLB3ei4Fs7qafse2L/aNkxGMP2849ofF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmhvIIDj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmhvIIDj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so30823165e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 06 Oct 2025 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759768920; x=1760373720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B1m3A2SK0UP4dwSyRm6Qf6w7bJhm1Ficb4+Tgp0EQaQ=;
        b=hmhvIIDj11XsG1lWO95MdMBx3Gx5I8dCOJXPraTTmvsRRrggmx8Z3cQ/2eEeK/dq6R
         dI086l4YLb11fuyHgc5mqYY7yLXSNRh1ugeLn672htOjDz//sGM2DZLm59miZqVqCztf
         AalJlg8l7zrGiTw75Bz4hlJTpRRddBmGQKR4k6VZTGeioMq5EFZKcMqeir/NVkNtvPTV
         ns2gKEdfcWfmRwV3BslWsl+WBMTvuxQ9lHPVoddTWtY8eZCE8G43rN3uNZhufw/kOZu5
         CyQExYDXDY63XzowI7GzXorjnhw93GZTX3HtJ+rFt18rIn6yP2LD9ivA4m1rIXVRIB8E
         Gf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759768920; x=1760373720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1m3A2SK0UP4dwSyRm6Qf6w7bJhm1Ficb4+Tgp0EQaQ=;
        b=FxG1ONnvt59Hd+7WJG4NjEgZ+eCzhxiV2+P/MDic6pNgPdR9o9o84QvuZwaT9baFIa
         RqvmC4uHOGg9MzHmbEQAuQaKeR7+7jE/My18qBsI3sYM1nlNyey3SISxkatHZZ1asUwa
         NK4hspF2t4V6msfkzHXLP2vVUULD3vGjMSWNpkylW5rFw7x8WneyX2B4d6enVqL2g2pl
         ppD6+kG90DDbk5y6QN2wSaBLEMtnU/LftdLDN596u0EQsMwJ5si81bxTN3e7NHNfHh9Y
         gLU58RArV/1TuN/AX6ZEReUqmg73XZE+efS4yxnOZnp+smadsUqfVeStr4QjjcFu84Mh
         H+Hg==
X-Gm-Message-State: AOJu0YxYm13m+1AEjXkDBxZIhWBmrvjZS4ZGvKZBC8J0OXLEAltayKfI
	Pr5p3TRXb0C5x+eKgcoyHQPrLdnroLOBlOki53frW9ZMlncJmmJZZfnB
X-Gm-Gg: ASbGncto0007fcSliost6TzwEElW4/NNCfHI+FT5nOe50R0NFi5A4TR32BzJMxCEJF/
	rPvAJ7Qs9WbREWEOmXejUSSLULU/oF+KQkHMT8nWlJ3uoY/9GCQ5TUXbKVx/LCKaZi7rulKEqr8
	n5TnXph4lTs6vHrj4QK+dZGwNWdGodMw4JXgMaSN9aoNIiAbjaUxAbyOIlyMwE9gKxl1o96MjXq
	PGhmkfOOwk9RFGF1mqtCtcMOkkFo+Y4CiAaOzFRSAVYTBYZpDHqjqBDRfUYehIYvWlxZ/qWozg1
	UCMEFafFJt5yaXzZPpMUulW0T9Gk9boFsd6RnVDeqYNpnY7ez6xnk+z7F3WfJn/0P52EwSYEND9
	tEzL9B3s4UrUR1qabGkNWHkou2Jln7XiQw1g9ZfiApjIZoeH2TmuWkTXFNaTihNQozNhtIDZyGy
	px16j6ulraFYCW4Qn+JO/ZttVM
X-Google-Smtp-Source: AGHT+IHm3Tu9iRyGiCt6V9SEZWDXWNqwJokz4bgw1HkknIkQ71kli9dOgCeRNWFNMzpZwV0p36UR6Q==
X-Received: by 2002:a05:600c:628b:b0:46e:456e:ada5 with SMTP id 5b1f17b1804b1-46e71146994mr75585645e9.28.1759768920064;
        Mon, 06 Oct 2025 09:42:00 -0700 (PDT)
Received: from dell (117.red-81-33-123.dynamicip.rima-tde.net. [81.33.123.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b5f3015sm151246565e9.1.2025.10.06.09.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:41:59 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de,
	u.kleine-koenig@baylibre.com,
	tzimmermann@suse.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH v2] fbdev: mb862xxfbdrv: Make CONFIG_FB_DEVICE optional
Date: Mon,  6 Oct 2025 18:41:43 +0200
Message-ID: <20251006164143.1187434-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch wraps the relevant code blocks with `IS_ENABLED(ifdef CONFIG_FB_DEVICE)`,
allowing the driver to be built and used even if CONFIG_FB_DEVICE is not selected.

The sysfs only give access to show some controller and cursor registers so
it's not needed to allow driver works correctly.

This align with Documentation/drm/todo.rst
"Remove driver dependencies on FB_DEVICE"

Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
v1 -> v2:
      * Fix error and improvement , thanks Uwe Kleine-Koenig.
      * v1 https://lore.kernel.org/lkml/20251005173812.1169436-1-rampxxxx@gmail.com


 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
index ade88e7bc760..dc99b8c9ff0f 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include "linux/kconfig.h"
 #include <linux/pci.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -759,7 +760,7 @@ static int of_platform_mb862xx_probe(struct platform_device *ofdev)
 
 	dev_set_drvdata(dev, info);
 
-	if (device_create_file(dev, &dev_attr_dispregs))
+	if (IS_ENABLED(CONFIG_FB_DEVICE) && device_create_file(dev, &dev_attr_dispregs))
 		dev_err(dev, "Can't create sysfs regdump file\n");
 	return 0;
 
@@ -801,7 +802,8 @@ static void of_platform_mb862xx_remove(struct platform_device *ofdev)
 	free_irq(par->irq, (void *)par);
 	irq_dispose_mapping(par->irq);
 
-	device_remove_file(&ofdev->dev, &dev_attr_dispregs);
+	if(IS_ENABLED(CONFIG_FB_DEVICE))
+		device_remove_file(&ofdev->dev, &dev_attr_dispregs);
 
 	unregister_framebuffer(fbi);
 	fb_dealloc_cmap(&fbi->cmap);
@@ -1101,7 +1103,7 @@ static int mb862xx_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, info);
 
-	if (device_create_file(dev, &dev_attr_dispregs))
+	if (IS_ENABLED(CONFIG_FB_DEVICE) && device_create_file(dev, &dev_attr_dispregs))
 		dev_err(dev, "Can't create sysfs regdump file\n");
 
 	if (par->type == BT_CARMINE)
@@ -1151,7 +1153,8 @@ static void mb862xx_pci_remove(struct pci_dev *pdev)
 
 	mb862xx_i2c_exit(par);
 
-	device_remove_file(&pdev->dev, &dev_attr_dispregs);
+	if(IS_ENABLED(CONFIG_FB_DEVICE))
+		device_remove_file(&pdev->dev, &dev_attr_dispregs);
 
 	unregister_framebuffer(fbi);
 	fb_dealloc_cmap(&fbi->cmap);
-- 
2.50.1


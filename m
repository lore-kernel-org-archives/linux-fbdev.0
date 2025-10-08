Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AAD2147EF
	for <linux-fbdev@vger.kernel.org>; Wed,  8 Oct 2025 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759948594; cv=none; b=A9f5BEcDFl9rJRn/5O2E7QaIiDgzF9shdauB0ma2LIvlQSh5TJywn/M9I2sfOBdWgcYH92b3DeO6GlrPTWuQMibTYIE+41IGlr4CCFjksyj+orNKEvUIdkkEYvqqGCy5KwrEDar1H/0C+Me+BJncCIYFdosg/9PesJKbZ0bWPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759948594; c=relaxed/simple;
	bh=TbhdRPExR52xBVb5XUSrHLPhu33n97/eTTgshWJPXH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4MEWnykRnAERD9F4O6uckSHa3MrrLaVRWhGcDTn2GkOXni7G6kZu9VZFgCww2SqsYalWDvzPidis8vBsAdtBdZ7bT23nxiXRb++sF3WA9ROMB9Ft9Q3FrYhc8Cozaav9KGm/jCPu3GRBtW6YO1OV8TowuxmkqRHmfto8CNqj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqAB52VY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqAB52VY"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso1033675e9.3
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Oct 2025 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759948591; x=1760553391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXl25NV/bCKQtXQE+8UoQ32n8mgGUsnabyuLmYWSLFM=;
        b=OqAB52VYLzFAl3wTIKxU1mmcD5YGezU9o8+CUA7SqbidnyDiJZ3FkTRthSgsnL3ohZ
         KmEt7j09N5ZCYdPBSfCLCB4s1sIox5xWGNun1a1BU4t/HhaR+IDi6YrtXrC2+V4uwQWh
         gx7SKq4KDF5JQuKxgvnesqexbdFCxChKeyXv4SpyiVX5NwFt8r5irFRKmfGsjfYmRGIq
         gE3kQ/zqkEMZCA9JJixnsJX0WN49RzNIIIZeBErbx/ynABy1NoT9EhopcKb3BgewrRY6
         fzv4eEtFgcXcE2z0hBsNvvIhtacE4jEJmMMHpzfSP0djDubon+JWpeV5MWSGSXX1HR8x
         7zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759948591; x=1760553391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXl25NV/bCKQtXQE+8UoQ32n8mgGUsnabyuLmYWSLFM=;
        b=FpryliOx6gXcKhFR0bNIDP/2kN3AJm7Mz/B+QUjBp+Jf74EejCs4G5+V1MUoEuBpHg
         GoTvrrC6cpwLrFRSEoBFA/RY5Y1HeSmYiLNnASB3yKduBCPBLmOT6vWh3/ihWK3reJxb
         QliGaTJGRFVEZPrcr2bmmidCuZR1u/kzDDFIQgOR7zc7k8SEw1uSiZN0aGIradQEeFea
         RHndu5U4x8oICsxvlQ7jaO/J61GH5AbpUntHnazHaJzIJL+PmkcaeBLRSXloEMVl+KWI
         79efKZ9jhws6O6hEX6uT+YJnTgmDdKYQGkyEhI+sXcQq+HxqxW1fQI3XfhdVD+BHoC20
         8Lag==
X-Gm-Message-State: AOJu0YxNVoi42FfMTN/FnptXYYodRNUZlYPjH+CYqaSITCy5C/PiC7Ul
	CFaN54xOwEmVw/BxhYfxXmA/tfK2fsinCkanDlIPsq7bS5TmEp9DE36P
X-Gm-Gg: ASbGncvZfWWovva9fngkl6JSmyETyi+mF44tqNy88qN4LtmGjRmmJilAyNhWMQTtRlK
	9Q5/cWe3oKhRIQM7OqRa9aMEsuIrkQT0w99F+QeuN9M+lR/YSP4K3PmruME6+eRPOpnKxy+85xi
	gkN/4luoM5oyo0IH0Xu3fY4jEyuEZfHkhzgZzQ0JaRNU5fTqoLs7/NKGX11I0o3qK53pAbBvLzq
	IimP6+CmE7yuD14aFbLzDGUBb9l+LgcB1zmUqHhNW8Toq3zAf8O/iIYbdXpNbmD7JRzP3y2JCuZ
	llAlQtL82WPQoPnoUnafft557vxK5Q9jnP8yf2rHwVGMxr5SQ2my3sI3qYNhX4lBCyiBsnupy0W
	ANp10EETosChNMJzj35cZQrZRd7Ok3/9eFwx7UtBjiKjJAhsK1vEa9pi2TDos91+m4/7DKI6bQz
	GvfVg=
X-Google-Smtp-Source: AGHT+IHMaf049Vy0bK5HqZ7v24YZjjYWkYmfKtcVF11hqH5XCAA615OXjCUg7WY+wO3hElGgf+q6Og==
X-Received: by 2002:a05:600c:1e87:b0:46f:a95d:e9e7 with SMTP id 5b1f17b1804b1-46fa9a22e8cmr29602565e9.0.1759948590639;
        Wed, 08 Oct 2025 11:36:30 -0700 (PDT)
Received: from dell (117.red-81-33-123.dynamicip.rima-tde.net. [81.33.123.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab5250ddsm18839465e9.6.2025.10.08.11.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:36:30 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de,
	u.kleine-koenig@baylibre.com,
	tzimmermann@suse.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH v3] fbdev: mb862xxfbdrv: Make CONFIG_FB_DEVICE optional
Date: Wed,  8 Oct 2025 20:36:27 +0200
Message-ID: <20251008183627.1279115-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251006164143.1187434-1-rampxxxx@gmail.com>
References: <20251006164143.1187434-1-rampxxxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch wraps the relevant code blocks with `IS_ENABLED(CONFIG_FB_DEVICE)`.

Allows the driver to be used for framebuffer text console, even if
support for the /dev/fb device isn't compiled-in (CONFIG_FB_DEVICE=n).

This align with Documentation/drm/todo.rst
"Remove driver dependencies on FB_DEVICE"

I've not the card so I was not able to test it.

Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
v2 -> v3:
      * Change commit msg , thanks Helge Deller.
      * Delete not used include , thanks Uwe Kleine-Koenig.
      * v1 https://lore.kernel.org/lkml/20251006164143.1187434-1-rampxxxx@gmail.com/
v1 -> v2:
      * Fix error and improvement , thanks Uwe Kleine-Koenig.
      * v1 https://lore.kernel.org/lkml/20251005173812.1169436-1-rampxxxx@gmail.com

 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
index ade88e7bc760..3f79dfc27a53 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -759,7 +759,7 @@ static int of_platform_mb862xx_probe(struct platform_device *ofdev)
 
 	dev_set_drvdata(dev, info);
 
-	if (device_create_file(dev, &dev_attr_dispregs))
+	if (IS_ENABLED(CONFIG_FB_DEVICE) && device_create_file(dev, &dev_attr_dispregs))
 		dev_err(dev, "Can't create sysfs regdump file\n");
 	return 0;
 
@@ -801,7 +801,8 @@ static void of_platform_mb862xx_remove(struct platform_device *ofdev)
 	free_irq(par->irq, (void *)par);
 	irq_dispose_mapping(par->irq);
 
-	device_remove_file(&ofdev->dev, &dev_attr_dispregs);
+	if (IS_ENABLED(CONFIG_FB_DEVICE))
+		device_remove_file(&ofdev->dev, &dev_attr_dispregs);
 
 	unregister_framebuffer(fbi);
 	fb_dealloc_cmap(&fbi->cmap);
@@ -1101,7 +1102,7 @@ static int mb862xx_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, info);
 
-	if (device_create_file(dev, &dev_attr_dispregs))
+	if (IS_ENABLED(CONFIG_FB_DEVICE) && device_create_file(dev, &dev_attr_dispregs))
 		dev_err(dev, "Can't create sysfs regdump file\n");
 
 	if (par->type == BT_CARMINE)
@@ -1151,7 +1152,8 @@ static void mb862xx_pci_remove(struct pci_dev *pdev)
 
 	mb862xx_i2c_exit(par);
 
-	device_remove_file(&pdev->dev, &dev_attr_dispregs);
+	if (IS_ENABLED(CONFIG_FB_DEVICE))
+		device_remove_file(&pdev->dev, &dev_attr_dispregs);
 
 	unregister_framebuffer(fbi);
 	fb_dealloc_cmap(&fbi->cmap);
-- 
2.50.1


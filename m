Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30D311C16
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Oct 2025 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898197; cv=none; b=cic+/2rsPS5a4zNRGbz/eM1HqAgM22s2qr2YNHpia8EQ4nIfcEHDk0TJ5/ZRcy/t4BhUyEyF8v8FHAWjrsNKcqrzEwkx0vU5U7uoMIVMZf19WSaE7apInH0v2pv5QCdactORHeDUnBkO82dyDUyGB5qnrkseVtmhLNl9Rg6YH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898197; c=relaxed/simple;
	bh=6VABkFcdL4pP7sAm/yTHqwl6N6WhkVJoAUECazfWono=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eOKULreEK2qiCCEbLiNrnf/O18Ef2GD5rHKF49bRJZzkUAMicLmIOKkPDb6QCwWc2EkFRaVmdbWQI292tZH+WybUREg6vkuO+O3BmLKqHF2nhpvOfwRTwIOem0nuXxJK68nQ3p6tpAq+s1lpXHYIkiId/4P6hcAswt2nqI+OOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZP7IkYKn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP7IkYKn"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so2011792b3a.1
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Oct 2025 01:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761898195; x=1762502995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5yjTzpVAIcEmdotVWgALP9aimDetWuj08C3OGruDkEs=;
        b=ZP7IkYKnPruSHniXH7gcFfP/CbkXhj5K0EySkKRIiOIRy29DbgeAND4WTHYbgL6Scg
         cTm8wscxFU5KFsQKpqBQUoO9qU05zk/PaqCLEC6PM3KZhubvoq1c2rSRISFuW/lq8XG0
         Ublq+vhrsU5uqAkl2eq6OlvGUHC3srHkAwWmHTCyJTlNoTPz3yzr7IQ89fSMlTqGpzgb
         1aPbcZAoPamahuWbd45yFSDhDmaf1JFVe7HEiLRVzH1cJ1aelCplBsvmdorbym4JMJkb
         KPI6l2BGsLcalrZYATNydvE9hKkut3VvNCtkNCF3fj1QPa8AzP9xrYuj8eGQe2yd0WHE
         2Onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761898195; x=1762502995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yjTzpVAIcEmdotVWgALP9aimDetWuj08C3OGruDkEs=;
        b=Otjy1evJWNclZ3OP/tjwRhzjONBgiR/FenLYLysvb+AN8zDgBPjwtr/qfzvhISZk1w
         jyopoFcYe8plP4HceBKA8N2IRtR1AwzMuVuv3rJ9FJ3NiawhkSwpxtPzPiTfl0ViKXDo
         TqWCfi7f+pLpA8KmeDAJ9Yj/kUd2KVw1CPhP+JFaIqqXiuFc2hktVpCduLExEX3stsK+
         7wR3AqGToi1ynvvQhK5MviZZ1CYR8/H3N5Ox/6XX6NYoAESTBi4+AUzdn9fDRTkTwosI
         YydM/cXsVoVNYu0CTvHr0qVgJp6FUIJ3TyjjXYbY2rUxZYBRfFElxTjWta3zFnfmp6zE
         C9kg==
X-Gm-Message-State: AOJu0YwKiSGIwZvWoCzkV1G8HdRzPWHkNSRdIzvkvecQxDwA/YptgRdP
	x8XzHXDxT5guS35vSVLyMqUhYhNH5TZXbD5U06Kf6dKkqpfVk0FvdH5IycgNdA==
X-Gm-Gg: ASbGncseWFdQwhQcgUfXoD7wXBYP/Frd5Lm+sbkVKk5asD/T/Cfxiv9yDtjEXJ3Z3WZ
	jRWgzygYnYkVBE/Tfld8TY5AVU8DUooT9qQdG1IBGPJUyKYU8/Jajb/RYcqCKj6e+v7CxErpS3Z
	cha/7/BGbMbv0RZkh+oZujrN8r3l+RqVTyjkF9ikWST8DaCt4GCRpx3OXLTS69/RsAkVM38jxmG
	EOUrtAHd52Wgiuzona1iO+1rvaCqueaXj+CNDfz8MjFVCSgaD0iv4xTcfbe5SLYbazijNs6gVnp
	Ei6p7oqo68WdyzRmr4QeclC+X8bR92bynJr3kO4/wvGfKGVpyP17JcqoP5RDxGJSuLbtSWfd2jW
	QQ1s2g7CeupmfNJihbsX+cHvnTQ3BjN7uMNEe6380jG3oUDjtbcsZ0zh5k/4eT4tVnLUsngP5Hk
	siEug5feEQtm9D
X-Google-Smtp-Source: AGHT+IG+jjw5n2v8QevhSrZ53DsQ1U593U2bn2lanUX2sGqPkPrpdNzon5zxAsGiKnBgq/jOXhIkIQ==
X-Received: by 2002:a05:6a20:1585:b0:342:1265:158f with SMTP id adf61e73a8af0-348cc6f4f2fmr4037368637.51.1761898194825;
        Fri, 31 Oct 2025 01:09:54 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:68ad:2e67:289c:5dac:46fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86cdd2sm1265276b3a.58.2025.10.31.01.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:09:54 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	deller@gmx.de,
	linux-kernel@vger.kernel.org,
	adaplas@gmail.com,
	i.shihao.999@gmail.com
Subject: [PATCH] fbdev: i810: use appopriate log interface dev_info
Date: Fri, 31 Oct 2025 13:39:42 +0530
Message-ID: <20251031080942.14112-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There were many printk log interfaces which do no had
any KERN_INFO with them and they can be replaced with
dev_info which will allow better log level handling
making messages clear and manageable.

No functional changes to the driver behavior are introduced.
Only the logging method has been replaced as per modern
kernel coding guidelines.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/video/fbdev/i810/i810_main.c | 46 ++++++++++++++--------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/video/fbdev/i810/i810_main.c b/drivers/video/fbdev/i810/i810_main.c
index d73a795fe1be..cc5d09e3bd2b 100644
--- a/drivers/video/fbdev/i810/i810_main.c
+++ b/drivers/video/fbdev/i810/i810_main.c
@@ -1012,7 +1012,7 @@ static int i810_check_params(struct fb_var_screeninfo *var,
 						      var->bits_per_pixel);
 			vidmem = line_length * info->var.yres;
 			if (vxres < var->xres) {
-				printk("i810fb: required video memory, "
+				dev_info(&par->dev->dev, "i810fb: required video memory, "
 				       "%d bytes, for %dx%d-%d (virtual) "
 				       "is out of range\n",
 				       vidmem, vxres, vyres,
@@ -1067,9 +1067,9 @@ static int i810_check_params(struct fb_var_screeninfo *var,
 				|(info->monspecs.hfmax-HFMAX)
 				|(info->monspecs.vfmin-VFMIN)
 				|(info->monspecs.vfmax-VFMAX);
-			printk("i810fb: invalid video mode%s\n",
-			       default_sync ? "" : ". Specifying "
-			       "vsyncN/hsyncN parameters may help");
+			dev_err(&par->dev->dev, "i810fb: invalid video mode%s\n",
+				default_sync ? "" : ". Specifying "
+				"vsyncN/hsyncN parameters may help");
 			retval = -EINVAL;
 		}
 	}
@@ -1674,19 +1674,19 @@ static int i810_alloc_agp_mem(struct fb_info *info)
 	size = par->fb.size + par->iring.size;

 	if (!(bridge = agp_backend_acquire(par->dev))) {
-		printk("i810fb_alloc_fbmem: cannot acquire agpgart\n");
+		dev_warn(&par->dev->dev, "i810fb_alloc_fbmem: cannot acquire agpgart\n");
 		return -ENODEV;
 	}
 	if (!(par->i810_gtt.i810_fb_memory =
 	      agp_allocate_memory(bridge, size >> 12, AGP_NORMAL_MEMORY))) {
-		printk("i810fb_alloc_fbmem: can't allocate framebuffer "
+		dev_warn(&par->dev->dev, "i810fb_alloc_fbmem: can't allocate framebuffer "
 		       "memory\n");
 		agp_backend_release(bridge);
 		return -ENOMEM;
 	}
 	if (agp_bind_memory(par->i810_gtt.i810_fb_memory,
 			    par->fb.offset)) {
-		printk("i810fb_alloc_fbmem: can't bind framebuffer memory\n");
+		dev_warn(&par->dev->dev, "i810fb_alloc_fbmem: can't bind framebuffer memory\n");
 		agp_backend_release(bridge);
 		return -EBUSY;
 	}
@@ -1694,14 +1694,14 @@ static int i810_alloc_agp_mem(struct fb_info *info)
 	if (!(par->i810_gtt.i810_cursor_memory =
 	      agp_allocate_memory(bridge, par->cursor_heap.size >> 12,
 				  AGP_PHYSICAL_MEMORY))) {
-		printk("i810fb_alloc_cursormem:  can't allocate "
+		dev_warn(&par->dev->dev, "i810fb_alloc_cursormem:  can't allocate "
 		       "cursor memory\n");
 		agp_backend_release(bridge);
 		return -ENOMEM;
 	}
 	if (agp_bind_memory(par->i810_gtt.i810_cursor_memory,
 			    par->cursor_heap.offset)) {
-		printk("i810fb_alloc_cursormem: cannot bind cursor memory\n");
+		dev_warn(&par->dev->dev, "i810fb_alloc_cursormem: cannot bind cursor memory\n");
 		agp_backend_release(bridge);
 		return -EBUSY;
 	}
@@ -1844,7 +1844,7 @@ static int i810_allocate_pci_resource(struct i810fb_par *par,
 	int err;

 	if ((err = pci_enable_device(par->dev))) {
-		printk("i810fb_init: cannot enable device\n");
+		dev_err(&par->dev->dev, "i810fb_init: cannot enable device\n");
 		return err;
 	}
 	par->res_flags |= PCI_DEVICE_ENABLED;
@@ -1859,14 +1859,14 @@ static int i810_allocate_pci_resource(struct i810fb_par *par,
 		par->mmio_start_phys = pci_resource_start(par->dev, 0);
 	}
 	if (!par->aperture.size) {
-		printk("i810fb_init: device is disabled\n");
+		dev_warn(&par->dev->dev, "i810fb_init: device is disabled\n");
 		return -ENOMEM;
 	}

 	if (!request_mem_region(par->aperture.physical,
 				par->aperture.size,
 				i810_pci_list[entry->driver_data])) {
-		printk("i810fb_init: cannot request framebuffer region\n");
+		dev_warn(&par->dev->dev, "i810fb_init: cannot request framebuffer region\n");
 		return -ENODEV;
 	}
 	par->res_flags |= FRAMEBUFFER_REQ;
@@ -1874,14 +1874,14 @@ static int i810_allocate_pci_resource(struct i810fb_par *par,
 	par->aperture.virtual = ioremap_wc(par->aperture.physical,
 					   par->aperture.size);
 	if (!par->aperture.virtual) {
-		printk("i810fb_init: cannot remap framebuffer region\n");
+		dev_warn(&par->dev->dev, "i810fb_init: cannot remap framebuffer region\n");
 		return -ENODEV;
 	}

 	if (!request_mem_region(par->mmio_start_phys,
 				MMIO_SIZE,
 				i810_pci_list[entry->driver_data])) {
-		printk("i810fb_init: cannot request mmio region\n");
+		dev_warn(&par->dev->dev, "i810fb_init: cannot request mmio region\n");
 		return -ENODEV;
 	}
 	par->res_flags |= MMIO_REQ;
@@ -1889,7 +1889,7 @@ static int i810_allocate_pci_resource(struct i810fb_par *par,
 	par->mmio_start_virtual = ioremap(par->mmio_start_phys,
 						  MMIO_SIZE);
 	if (!par->mmio_start_virtual) {
-		printk("i810fb_init: cannot remap mmio region\n");
+		dev_warn(&par->dev->dev, "i810fb_init: cannot remap mmio region\n");
 		return -ENODEV;
 	}

@@ -1921,12 +1921,12 @@ static void i810fb_find_init_mode(struct fb_info *info)
 	}

 	if (!err)
-		printk("i810fb_init_pci: DDC probe successful\n");
+		dev_info(&par->dev->dev, "i810fb_init_pci: DDC probe successful\n");

 	fb_edid_to_monspecs(par->edid, specs);

 	if (specs->modedb == NULL)
-		printk("i810fb_init_pci: Unable to get Mode Database\n");
+		dev_info(&par->dev->dev, "i810fb_init_pci: Unable to get Mode Database\n");

 	fb_videomode_to_modelist(specs->modedb, specs->modedb_len,
 				 &info->modelist);
@@ -2072,7 +2072,7 @@ static int i810fb_init_pci(struct pci_dev *dev,

 	if (err < 0) {
     		i810fb_release_resource(info, par);
-		printk("i810fb_init: cannot register framebuffer device\n");
+		dev_warn(&par->dev->dev, "i810fb_init: cannot register framebuffer device\n");
     		return err;
     	}

@@ -2084,10 +2084,10 @@ static int i810fb_init_pci(struct pci_dev *dev,
 	vfreq = hfreq/(info->var.yres + info->var.upper_margin +
 		       info->var.vsync_len + info->var.lower_margin);

-      	printk("I810FB: fb%d         : %s v%d.%d.%d%s\n"
-      	       "I810FB: Video RAM   : %dK\n"
-	       "I810FB: Monitor     : H: %d-%d KHz V: %d-%d Hz\n"
-	       "I810FB: Mode        : %dx%d-%dbpp@%dHz\n",
+	dev_info(&par->dev->dev, "I810FB: fb%d         : %s v%d.%d.%d%s\n"
+		"I810FB: Video RAM   : %dK\n"
+		"I810FB: Monitor     : H: %d-%d KHz V: %d-%d Hz\n"
+		"I810FB: Mode        : %dx%d-%dbpp@%dHz\n",
 	       info->node,
 	       i810_pci_list[entry->driver_data],
 	       VERSION_MAJOR, VERSION_MINOR, VERSION_TEENIE, BRANCH_VERSION,
@@ -2137,7 +2137,7 @@ static void i810fb_remove_pci(struct pci_dev *dev)

 	unregister_framebuffer(info);
 	i810fb_release_resource(info, par);
-	printk("cleanup_module:  unloaded i810 framebuffer device\n");
+	dev_info(&par->dev->dev, "cleanup_module:  unloaded i810 framebuffer device\n");
 }

 #ifndef MODULE
--
2.51.0


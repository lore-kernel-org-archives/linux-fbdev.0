Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82717E016
	for <linux-fbdev@vger.kernel.org>; Tue, 15 Oct 2024 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979489; cv=none; b=pd9nX+MIOQ3jSwoKaJyiULJ5EnunNragRER4ScJJkeAot8XKZkZMv/GmHNeyK3jkeCrIh5wbvP27Fbwbj15tjYssTH5hD7/e6iqDBZD4pkXFGsK+n2IwyVHvhGRG8TKKW3uv9nahGUVayiYWL6JYjQrUQSteBWZyKQ+QiMZgwbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979489; c=relaxed/simple;
	bh=A83+YLW1mV1Hc4grbvw6uZJgmxfBqfmzqE2qdw3tiOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r5qvo7zMPRWr8iTQvdzRxqCu26Ri+bi8yIfIjSEQ2iiQK+Uu8aoc46xWx+KxKlS6J7ZPrwdpBsvtuj1tYoW2CH2weA2HSknv1xFSUCZB6O4em4AfcdmcRa4EWd09nTsZeAlOnvAO78URx/7ot4Fl+rAMZIpW0vUxqekm6jrQ41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNJYwpUA; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNJYwpUA"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43056d99a5aso39428445e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Oct 2024 01:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728979486; x=1729584286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0caYVR1pg5Rq1O4FBXQi9SrRUN2FQI8Lj8s2gNiWkqI=;
        b=WNJYwpUAjO38T14xdb/w+sZITDVlntx3PKOih0Hu7ELc0tkvebI9Dcs+1klg3XsEn1
         FL3FBDY1S8aefXhCE3b/Q81zIjdiLVkCyXhKyCnaxpgVi47e4YQpg3dh3Qen5BTy9kWk
         95xHOlKtMzfzVebwCyFrEAqIvjbGZiCYiu1uznDqzQz3iMr2FZRr/UeQde6tr6SDWs1B
         LjevsX9vjEowC5srrebf0z+JPsbfwlLdgDY1U0sv5jUzcCy6Ih2meuue8YqfoXSctA7D
         4LNskeb0obLr1O0vFNCUx+tD9lWRX/EPuiPxm7COW0Z+jBM7ngXCmf5EROkCZ7zdXm5s
         Jp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979486; x=1729584286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0caYVR1pg5Rq1O4FBXQi9SrRUN2FQI8Lj8s2gNiWkqI=;
        b=fw7nBrnD73qJ0AHfxxnQQ7DK8FdBZYxj62KepE5SxLUPkFSurNTVjA9tCX+3RtNw+R
         hDS7CzUBLLGdeTec3pEkOu0bjkWdq+89n17iywU9ZBoXAwmUfIseeHui1jzoxsoIRzO4
         P8cQsyyXcTKicw94u2Y9SDcHOG8SHE5+XBWvrkZZu8E8RU/GfPrt6IQJKCL2X62SY5lI
         8MlQFFJN7LipIQUXAeaQx0EfJU9WXfvTJbmy9OVv0+t3AoN/Ioe0RKWyg1wlNudMBIIi
         ma4RLR4mScG7ApClEE/bqvoYWNUNBXiAdsXZVewKuwBOAzjtH1avD5sT/QOCdYBJjOI0
         NurA==
X-Gm-Message-State: AOJu0YyGt51+aaC5Pu+2m/XeXSHBJerHKNOE3ygkWP7AsWngsZWCAGpt
	ObfNeBmOi8Hq6d5VvXEYH+l27vcgJypNIIne5OK4BVmmfPdLr89N9RCXDER0azo=
X-Google-Smtp-Source: AGHT+IFvKR0+6x9JX7Vh87yg9VTlpuo2dLXkWy9dO/nzv74nZCjMSHoVP+4Tig2IGJk2shTsmfOLgA==
X-Received: by 2002:a05:600c:4f14:b0:42c:b826:a26c with SMTP id 5b1f17b1804b1-43115aa7323mr144439565e9.8.1728979485844;
        Tue, 15 Oct 2024 01:04:45 -0700 (PDT)
Received: from Gonzalo.udc.pri (natpw271.usc.es. [193.144.81.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56f24csm10040635e9.28.2024.10.15.01.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 01:04:45 -0700 (PDT)
From: Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	thomas.zimmermann@suse.de,
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>
Subject: [PATCH v3] fbdev: sstfb: Make CONFIG_FB_DEVICE optional and update Kconfig dependency
Date: Tue, 15 Oct 2024 10:04:39 +0200
Message-Id: <20241015080439.5931-1-gonzalo.silvalde@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sstfb driver currently depends on CONFIG_FB_DEVICE to create sysfs
entries and access info->dev. This patch wraps the relevant code blocks
with #ifdef CONFIG_FB_DEVICE, allowing the driver to be built and used
even if CONFIG_FB_DEVICE is not selected.

Additionally, the dependency on CONFIG_FB_DEVICE in the Kconfig file
has been removed for the FB_VOODOO1 driver, allowing it to be selected
independently of the FB_DEVICE option. This is because the sysfs setting
only controls the VGA pass-through state and is not required for the
display to function properly.

For more information on VGA pass-through, see:
http://vogonswiki.com/index.php/VGA_passthrough_cable

Tested by building with and without CONFIG_FB_DEVICE enabled, and both
configurations compiled successfully without issues.

Signed-off-by: Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>
---
 drivers/video/fbdev/Kconfig |  1 -
 drivers/video/fbdev/sstfb.c | 13 ++++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ea36c6956bf3..44a8fdbab6df 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1236,7 +1236,6 @@ config FB_3DFX_I2C
 config FB_VOODOO1
 	tristate "3Dfx Voodoo Graphics (sst1) support"
 	depends on FB && PCI
-	depends on FB_DEVICE
 	select FB_IOMEM_HELPERS
 	help
 	  Say Y here if you have a 3Dfx Voodoo Graphics (Voodoo1/sst1) or
diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index f8ae54ca0cc3..1d6ef97f1a84 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -716,6 +716,7 @@ static void sstfb_setvgapass( struct fb_info *info, int enable )
 	pci_write_config_dword(sst_dev, PCI_INIT_ENABLE, tmp);
 }
 
+#ifdef CONFIG_FB_DEVICE
 static ssize_t store_vgapass(struct device *device, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
@@ -736,10 +737,10 @@ static ssize_t show_vgapass(struct device *device, struct device_attribute *attr
 	struct sstfb_par *par = info->par;
 	return sprintf(buf, "%d\n", par->vgapass);
 }
-
 static struct device_attribute device_attrs[] = {
 	__ATTR(vgapass, S_IRUGO|S_IWUSR, show_vgapass, store_vgapass)
-	};
+};
+#endif
 
 static int sstfb_ioctl(struct fb_info *info, unsigned int cmd,
 			unsigned long arg)
@@ -1435,10 +1436,10 @@ static int sstfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	sstfb_clear_screen(info);
-
+#ifdef CONFIG_FB_DEVICE
 	if (device_create_file(info->dev, &device_attrs[0]))
 		printk(KERN_WARNING "sstfb: can't create sysfs entry.\n");
-
+#endif
 
 	fb_info(info, "%s frame buffer device at 0x%p\n",
 		fix->id, info->screen_base);
@@ -1467,8 +1468,9 @@ static void sstfb_remove(struct pci_dev *pdev)
 
 	info = pci_get_drvdata(pdev);
 	par = info->par;
-
+#ifdef CONFIG_FB_DEVICE
 	device_remove_file(info->dev, &device_attrs[0]);
+#endif
 	sst_shutdown(info);
 	iounmap(info->screen_base);
 	iounmap(par->mmio_vbase);
@@ -1536,3 +1538,4 @@ MODULE_PARM_DESC(slowpci, "Uses slow PCI settings (0 or 1) (default=0)");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Initial video mode (default=" DEFAULT_VIDEO_MODE ")");
 
+
-- 
2.39.5


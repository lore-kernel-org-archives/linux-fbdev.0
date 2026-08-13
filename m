Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D0D43DA26;
	Thu, 13 Aug 2026 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625470; cv=none; b=li8hlUYoc6uzvLP8jxSOeKemAAUHDUidPXPSGYN0vZhBS8BSvysmCc3w/aIR8cQLP0Glyk2jy4915xCcIS8WJlWk4t7D/ux9MAUUNyvSSnKy40ZbfxHUQzY7GZSxg0HoAcO4sgZ2lxrRW0dEkr8K0/j0D/pEdKS6MjB2tw62geY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625470; c=relaxed/simple;
	bh=IcwJnBRxFX5If4qsDd2j+jWhM9mf3NcwSfst0gBemjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RfSuvg6VGDkKqaccX2Lzb3KevZz4gAleOAPLKNR1hlH+8Bref32UCdXNx5Ll834V3nYicb1nAakwpTSrVfKZdS7MrE0MMdKJrTpkm388tuXL+BxouymD5go5Tg5YLmRKJ2IQqEtGD1rkR3oA5xJB+ffkbXJA+P5lkb/EQynm9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OqT5pkfv; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OqT5pkfv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ld
	gRe+8c28l0pZpsvHDBdbSNCsT8XeELOsgW9kViHgI=; b=OqT5pkfvRf2f3wEgiY
	Y7NMVfi0uPHkJn9e+qyXu2lCvCwGFFYNz0qfCFucaZ5eYvl0v9HFVDlNbOX1/U/r
	8yui+jlMlc72QS5AsuJX8IDqaIaWvN5Dn+gj4ESVDrEM/zGdMHunG9KdK7j+i7oZ
	Emr8qG15AF/ySlKyNO0Unffms=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3lO2JvX1qxfeJMA--.22540S4;
	Thu, 13 Aug 2026 20:50:22 +0800 (CST)
From: oushixiong1025@163.com
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	u.kleine-koenig@baylibre.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 3/5] fbdev: savage: Convert to managed PCI and ioremap API
Date: Thu, 13 Aug 2026 20:50:13 +0800
Message-Id: <20260813125015.1097301-3-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813125015.1097301-1-oushixiong1025@163.com>
References: <20260813125015.1097301-1-oushixiong1025@163.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgB3lO2JvX1qxfeJMA--.22540S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF45Jr1kurWUCr18ArWfAFb_yoW5tr1xpF
	Wkta1ayrWrJ3yUuwnrCF47CF15Krs2k3yrGry8K3WIqFn8Aa4kXrs7JFyjva9xJrZFk3Zx
	X34Fq348Ja4xZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jO_-PUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4Q6Mm2p9vY43JwAA3M

From: Shixiong Ou <oushixiong@kylinos.cn>

Fix missing pci_disable_device() in probe and remove.

Use pcim_enable_device(), pcim_request_all_regions(),
devm_ioremap() and devm_ioremap_wc() to replace manual resource
management. Remove all pci_release_regions() and iounmap() calls.
Merge failed_init label into failed_enable.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/savage/savagefb_driver.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index 7789196d2eb5..56ff3c50cd29 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -1728,7 +1728,7 @@ static int savage_map_mmio(struct fb_info *info)
 
 	par->mmio.len = SAVAGE_NEWMMIO_REGSIZE;
 
-	par->mmio.vbase = ioremap(par->mmio.pbase, par->mmio.len);
+	par->mmio.vbase = devm_ioremap(&par->pcidev->dev, par->mmio.pbase, par->mmio.len);
 	if (!par->mmio.vbase) {
 		printk("savagefb: unable to map memory mapped IO\n");
 		return -ENOMEM;
@@ -1755,7 +1755,6 @@ static void savage_unmap_mmio(struct fb_info *info)
 	savage_disable_mmio(par);
 
 	if (par->mmio.vbase) {
-		iounmap(par->mmio.vbase);
 		par->mmio.vbase = NULL;
 	}
 }
@@ -1774,7 +1773,7 @@ static int savage_map_video(struct fb_info *info, int video_len)
 
 	par->video.pbase = pci_resource_start(par->pcidev, resource);
 	par->video.len   = video_len;
-	par->video.vbase = ioremap_wc(par->video.pbase, par->video.len);
+	par->video.vbase = devm_ioremap_wc(&par->pcidev->dev, par->video.pbase, par->video.len);
 
 	if (!par->video.vbase) {
 		printk("savagefb: unable to map screen memory\n");
@@ -1802,7 +1801,6 @@ static void savage_unmap_video(struct fb_info *info)
 
 	if (par->video.vbase) {
 		arch_phys_wc_del(par->video.wc_cookie);
-		iounmap(par->video.vbase);
 		par->video.vbase = NULL;
 		info->screen_base = NULL;
 	}
@@ -2188,11 +2186,12 @@ static int savagefb_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 	par = info->par;
 	mutex_init(&par->open_lock);
-	err = pci_enable_device(dev);
+	err = pcim_enable_device(dev);
 	if (err)
 		goto failed_enable;
 
-	if ((err = pci_request_regions(dev, "savagefb"))) {
+	err = pcim_request_all_regions(dev, "savagefb");
+	if (err) {
 		printk(KERN_ERR "cannot request PCI regions\n");
 		goto failed_enable;
 	}
@@ -2200,7 +2199,7 @@ static int savagefb_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	err = -ENOMEM;
 
 	if ((err = savage_init_fb_info(info, dev, id)))
-		goto failed_init;
+		goto failed_enable;
 
 	err = savage_map_mmio(info);
 	if (err)
@@ -2331,8 +2330,6 @@ static int savagefb_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	savage_unmap_mmio(info);
  failed_mmio:
 	kfree(info->pixmap.addr);
- failed_init:
-	pci_release_regions(dev);
  failed_enable:
 	framebuffer_release(info);
 
@@ -2355,7 +2352,6 @@ static void savagefb_remove(struct pci_dev *dev)
 		savage_unmap_video(info);
 		savage_unmap_mmio(info);
 		kfree(info->pixmap.addr);
-		pci_release_regions(dev);
 		framebuffer_release(info);
 	}
 }
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


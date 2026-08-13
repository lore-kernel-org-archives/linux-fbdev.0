Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F646F4AE;
	Thu, 13 Aug 2026 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625470; cv=none; b=hyrhDkTx/8WZV55I5ZezIjyyVOExGVWhYlS+cfjmAEZ7es049qZpisIzYdEXoTzfSdUbrr33tN375fw2Q8uUQ6EQ5M60sLibzXLr2U3P7QCDUWScF3TWLf9lnGWmPVwVb9UBPGfYRVoP9zMOhNt+HVSOol+swfnQp4XZqPQDjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625470; c=relaxed/simple;
	bh=nlepqJ1e5zfB3g+coEDIy6XX6gtJugit6D77Qk2AXzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z1179y51Iapq11RMcKXGmp0WHKz6oeB3Jwwye5R5y3Jf9yog3OZZeWpR6Zdq1qWu1aPtOI2ZfivkN4NcwgDJGpsg0QPm+BRKf6LSNnlgDnZA5M9b8LEYcq6R8ibaESg63nZE4HmGtLB4xLWtNXhHM/LwQCPWGD75ufh3CkeEx4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L0AfYe9e; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L0AfYe9e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tw
	U2UmKc0VqNuKR+XXFp2odsiikhh3amQi3ufiG3shw=; b=L0AfYe9e6jJSNqpbok
	yrqz5+M+jHw3nJ/fF1Rk5XHzfnbiA42R0cFlCzJaypWoXAck487CkT13Sa2Sp0I9
	jpnXQzsTZq2RUk82kT0bcftFi6Bp6Vwwk2LD9p7j2bZBxLLBjKe9XF5iKKqYdeOO
	fwowJuKYuKMEaZPFSWltajJFo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3lO2JvX1qxfeJMA--.22540S2;
	Thu, 13 Aug 2026 20:50:18 +0800 (CST)
From: oushixiong1025@163.com
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	u.kleine-koenig@baylibre.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 1/5] fbdev: aty128fb: Convert to managed PCI and ioremap API
Date: Thu, 13 Aug 2026 20:50:11 +0800
Message-Id: <20260813125015.1097301-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgB3lO2JvX1qxfeJMA--.22540S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWryDZryftw45Cry5ZrW7XFb_yoWrAw1Dpr
	1fGFW3Gr4rGFnFgF4DuF15Z3Z8ZrWIv345CrW2y3sagFsIy3s2qrZ7tFyjvF9xJ3ykK3W3
	Zw45t3WxZFWUGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZyCAUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-QqLmmp9vYoWbwAA3-

From: Shixiong Ou <oushixiong@kylinos.cn>

Fix missing pci_disable_device() in probe and remove.

Use pcim_enable_device(), pcim_request_region(), devm_ioremap()
and devm_ioremap_wc() to replace manual resource management.
Remove all release_mem_region() and iounmap() calls.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/aty/aty128fb.c | 40 +++++++++---------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index bcb10e66221c..b76bfe014f41 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -2009,31 +2009,30 @@ static int aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return err;
 
 	/* Enable device in PCI config */
-	if ((err = pci_enable_device(pdev))) {
+	err = pcim_enable_device(pdev);
+	if (err) {
 		printk(KERN_ERR "aty128fb: Cannot enable PCI device: %d\n",
 				err);
 		return -ENODEV;
 	}
 
 	fb_addr = pci_resource_start(pdev, 0);
-	if (!request_mem_region(fb_addr, pci_resource_len(pdev, 0),
-				"aty128fb FB")) {
+	if (!pcim_request_region(pdev, 0, "aty128fb FB")) {
 		printk(KERN_ERR "aty128fb: cannot reserve frame "
 				"buffer memory\n");
 		return -ENODEV;
 	}
 
 	reg_addr = pci_resource_start(pdev, 2);
-	if (!request_mem_region(reg_addr, pci_resource_len(pdev, 2),
-				"aty128fb MMIO")) {
+	if (!pcim_request_region(pdev, 2, "aty128fb MMIO")) {
 		printk(KERN_ERR "aty128fb: cannot reserve MMIO region\n");
-		goto err_free_fb;
+		goto err_free_info;
 	}
 
 	/* We have the resources. Now virtualize them */
 	info = framebuffer_alloc(sizeof(struct aty128fb_par), &pdev->dev);
 	if (!info)
-		goto err_free_mmio;
+		goto err_free_info;
 
 	par = info->par;
 
@@ -2041,7 +2040,8 @@ static int aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Virtualize mmio region */
 	info->fix.mmio_start = reg_addr;
-	par->regbase = pci_ioremap_bar(pdev, 2);
+	par->regbase = devm_ioremap(&pdev->dev, pci_resource_start(pdev, 2),
+				    pci_resource_len(pdev, 2));
 	if (!par->regbase)
 		goto err_free_info;
 
@@ -2050,9 +2050,9 @@ static int aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	par->vram_size = aty_ld_le32(CNFG_MEMSIZE) & 0x03FFFFFF;
 
 	/* Virtualize the framebuffer */
-	info->screen_base = ioremap_wc(fb_addr, par->vram_size);
+	info->screen_base = devm_ioremap_wc(&pdev->dev, fb_addr, par->vram_size);
 	if (!info->screen_base)
-		goto err_unmap_out;
+		goto err_free_info;
 
 	/* Set up info->fix */
 	info->fix = aty128fb_fix;
@@ -2063,7 +2063,7 @@ static int aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* If we can't test scratch registers, something is seriously wrong */
 	if (!register_test(par)) {
 		printk(KERN_ERR "aty128fb: Can't write to video register!\n");
-		goto err_out;
+		goto err_free_info;
 	}
 
 #ifndef __sparc__
@@ -2085,25 +2085,15 @@ static int aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_drvdata(pdev, info);
 
 	if (!aty128_init(pdev, ent))
-		goto err_out;
+		goto err_free_info;
 
 	if (mtrr)
 		par->wc_cookie = arch_phys_wc_add(info->fix.smem_start,
 						  par->vram_size);
 	return 0;
 
-err_out:
-	iounmap(info->screen_base);
-err_unmap_out:
-	iounmap(par->regbase);
 err_free_info:
 	framebuffer_release(info);
-err_free_mmio:
-	release_mem_region(pci_resource_start(pdev, 2),
-			pci_resource_len(pdev, 2));
-err_free_fb:
-	release_mem_region(pci_resource_start(pdev, 0),
-			pci_resource_len(pdev, 0));
 	return -ENODEV;
 }
 
@@ -2124,13 +2114,7 @@ static void aty128_remove(struct pci_dev *pdev)
 	unregister_framebuffer(info);
 
 	arch_phys_wc_del(par->wc_cookie);
-	iounmap(par->regbase);
-	iounmap(info->screen_base);
 
-	release_mem_region(pci_resource_start(pdev, 0),
-			   pci_resource_len(pdev, 0));
-	release_mem_region(pci_resource_start(pdev, 2),
-			   pci_resource_len(pdev, 2));
 	framebuffer_release(info);
 }
 #endif /* CONFIG_PCI */
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


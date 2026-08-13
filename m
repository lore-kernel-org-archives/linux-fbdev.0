Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29DA3E172F;
	Thu, 13 Aug 2026 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625475; cv=none; b=ErTjpXb776DNytMzE5yfqRftbAxnYT0UDQWReAqUYPPvlRNOuZ6EDnOAUydx9Mi2IqIHJ7JI3AnmiM651WICMETJdkshOG9YA2YDza4JebMimHFCd7WuQ4r5IyZvBANTQmMQAukK+XYLbKfJByuHcFOL64UPbUSd78ozOdkoafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625475; c=relaxed/simple;
	bh=pwOG9mdRK79Bg8yBJmpkL38yDwiyLGV564tH+3lYDHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NVU5yAqVfvalXRN3N7inH52CwOXkVuzD4cPi2jflbvS2O5SGZ0rFaCBLjadAL7FKwYxDJTY7moLv83pDB+3EU9vd/CVx+jDYrdNyuVPNyYqtUJxDsgOD2S+tqqtnbgI5yG7oTkbhqP6i4juHV/Zr3kZUlvf5qrwPGCUKl1qrlQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VKmSsGYD; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VKmSsGYD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oK
	w70w/LOsp/h1z6Fef4O8j0xSbzMzILJqyCgk0tvCQ=; b=VKmSsGYD0tzfZze2kP
	91JdLGx5MzY1u5toIjA2GgalZcc0wRq3uby/qRihHrHuMCr+4kw+WDJ6cNmUd+pe
	JLay6BMJl07AdXaIoRcGUe+thZudxhlLpHjdpNsHzTRCwZWr+zbSf6apdap63zmT
	rJxpSuEsdA3i0SmBApLSUxoHE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3lO2JvX1qxfeJMA--.22540S3;
	Thu, 13 Aug 2026 20:50:21 +0800 (CST)
From: oushixiong1025@163.com
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	u.kleine-koenig@baylibre.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 2/5] fbdev: nvidia: Convert to managed PCI and ioremap API
Date: Thu, 13 Aug 2026 20:50:12 +0800
Message-Id: <20260813125015.1097301-2-oushixiong1025@163.com>
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
X-CM-TRANSID:PygvCgB3lO2JvX1qxfeJMA--.22540S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4DZw15Kry3ur1UWFy7trb_yoWrJFy8pF
	sxKa1ftrWfKF95uw1kCF4UZFs8X3yIv3y3Cr4UK3Z3trsIy3s2vF4IqFyav39rArZrJF1a
	qw1jqw1UZa1IqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOb18UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4Q2Mm2p9vY03EgAA35

From: Shixiong Ou <oushixiong@kylinos.cn>

Fix missing pci_disable_device() in probe and remove.

Use pcim_enable_device(), pcim_request_all_regions(),
devm_ioremap() and devm_ioremap_wc() to replace manual resource
management. Remove all pci_release_regions() and iounmap() calls.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/nvidia/nvidia.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index 7d20c4087aeb..4ef7a5ba43cc 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1292,7 +1292,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	NVTRACE_ENTER();
 	assert(pd != NULL);
 
-	if (pci_enable_device(pd)) {
+	if (pcim_enable_device(pd)) {
 		printk(KERN_ERR PFX "cannot enable PCI device\n");
 		return -ENODEV;
 	}
@@ -1305,7 +1305,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	nvidiafb_fix.mmio_start = pci_resource_start(pd, 0);
 	nvidiafb_fix.mmio_len = pci_resource_len(pd, 0);
 
-	REGS = ioremap(nvidiafb_fix.mmio_start, nvidiafb_fix.mmio_len);
+	REGS = devm_ioremap(&pd->dev, nvidiafb_fix.mmio_start, nvidiafb_fix.mmio_len);
 	if (!REGS) {
 		printk(KERN_ERR PFX "cannot ioremap MMIO base\n");
 		return -ENODEV;
@@ -1333,7 +1333,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	if (info->pixmap.addr == NULL)
 		goto err_out_kfree;
 
-	if (pci_request_regions(pd, "nvidiafb")) {
+	if (pcim_request_all_regions(pd, "nvidiafb")) {
 		printk(KERN_ERR PFX "cannot request PCI regions\n");
 		goto err_out_enable;
 	}
@@ -1358,7 +1358,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	sprintf(nvidiafb_fix.id, "NV%x", (pd->device & 0x0ff0) >> 4);
 
 	if (NVCommonSetup(info))
-		goto err_out_free_base0;
+		goto err_out_enable;
 
 	par->FbAddress = nvidiafb_fix.smem_start;
 	par->FbMapSize = par->RamAmountKBytes * 1024;
@@ -1378,8 +1378,8 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	par->ScratchBufferStart = par->FbUsableSize - par->ScratchBufferSize;
 	par->CursorStart = par->FbUsableSize + (32 * 1024);
 
-	info->screen_base = ioremap_wc(nvidiafb_fix.smem_start,
-				       par->FbMapSize);
+	info->screen_base = devm_ioremap_wc(&pd->dev, nvidiafb_fix.smem_start,
+					    par->FbMapSize);
 	info->screen_size = par->FbUsableSize;
 	nvidiafb_fix.smem_len = par->RamAmountKBytes * 1024;
 
@@ -1423,19 +1423,15 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	return 0;
 
 err_out_iounmap_fb:
-	iounmap(info->screen_base);
 	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
 	nvidia_delete_i2c_busses(par);
-err_out_free_base0:
-	pci_release_regions(pd);
 err_out_enable:
 	kfree(info->pixmap.addr);
 err_out_kfree:
 	framebuffer_release(info);
 err_out:
-	iounmap(REGS);
 	return -ENODEV;
 }
 
@@ -1450,11 +1446,8 @@ static void nvidiafb_remove(struct pci_dev *pd)
 	unregister_framebuffer(info);
 
 	arch_phys_wc_del(par->wc_cookie);
-	iounmap(info->screen_base);
 	fb_destroy_modedb(info->monspecs.modedb);
 	nvidia_delete_i2c_busses(par);
-	iounmap(par->REGS);
-	pci_release_regions(pd);
 	kfree(info->pixmap.addr);
 	framebuffer_release(info);
 	NVTRACE_LEAVE();
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


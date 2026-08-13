Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C8447AF67;
	Thu, 13 Aug 2026 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625475; cv=none; b=nbZ/yS7PCBg1wJE0Zu97pAyUQW9HibgWiKLZaUwsz9gAUgGYaoCBD2C/LwiGFakbtrr4E/IOhVslzC2EvwrGcCdsTmbEA3a5uUPIZnMNIv6bltDbDwzaPJljHUnSQVTKZeogRLt8e2awI00rFkPG926omT6Su9ES/fSY1lggVd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625475; c=relaxed/simple;
	bh=odGa2UsacVwpDfdT4pQOriKEDLZJ+vB2tGNe5FYg90U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pcASdcaxBRaiNA7BkO8joHEca5ibtwyr3GVPFXasfLh80dOYg0Ax5q+l6P+tuZizIRw1+C74SjMOsXg9XxA3Ldq8Os8K0xNpveEKmXh8Pk5YGGaJn8Csk8kH0Z+SsBHJrKhtcByaGhIKpL3EFNDVdnvvXjQ9NPfs+sPjJR8qWV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aMmgwwdv; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aMmgwwdv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ch
	uGeiwEbh3v21bNTNb7bSglyAc8AmH3h3N7zu1+nXg=; b=aMmgwwdvH9jPEgqv23
	n7CpAMhHbsb2kzONKvcbO4o7gGJ9U8XyhZcF3xZhNMlznDG5Cx1ZMxANp0YhDkJ3
	ERVqYc97Dn+WbZZXwFXoHo2kLqQqaZuyZcqFCG84alAgSJeqXP7DHO9bXSjnpiBA
	v7tBYEjd0S9S2NA0gYMQ85COA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3lO2JvX1qxfeJMA--.22540S6;
	Thu, 13 Aug 2026 20:50:24 +0800 (CST)
From: oushixiong1025@163.com
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	u.kleine-koenig@baylibre.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 5/5] fbdev: atyfb: Convert to managed PCI and ioremap API
Date: Thu, 13 Aug 2026 20:50:15 +0800
Message-Id: <20260813125015.1097301-5-oushixiong1025@163.com>
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
X-CM-TRANSID:PygvCgB3lO2JvX1qxfeJMA--.22540S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry8WF4rGFWUZw1rXFW7XFb_yoW7Jr4UpF
	yfGFsxtr45KF409r1DCrn09a95Aa1ay34rGrW7tw1ftFn8Jw18XrZ5GasF9rZ3J3yktrs0
	9w1kt3WfCw129FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jj9a9UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-RCNnGp9vZAWrQAA39

From: Shixiong Ou <oushixiong@kylinos.cn>

Fix missing pci_disable_device() in probe and remove.

Use pcim_enable_device(), pcim_request_region(), devm_ioremap(),
devm_ioremap_uc() and devm_ioremap_wc() for the PCI path. Convert
aux_start to devm_request_mem_region(). Guard atyfb_remove() to
only unmap/release for non-PCI (Atari) devices. Keep iounmap for
sprite.addr outside the guard since it uses raw ioremap().

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/aty/atyfb_base.c | 47 +++++++++++-----------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 9fc5af09f86c..97cc8b6a9361 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3435,7 +3435,7 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 	raddr = addr + 0x7ff000UL;
 	rrp = &pdev->resource[2];
 	if ((rrp->flags & IORESOURCE_MEM) &&
-	    request_mem_region(rrp->start, resource_size(rrp), "atyfb")) {
+	    devm_request_mem_region(&pdev->dev, rrp->start, resource_size(rrp), "atyfb")) {
 		par->aux_start = rrp->start;
 		par->aux_size = resource_size(rrp);
 		raddr = rrp->start;
@@ -3448,9 +3448,9 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 	 * By using strong UC we force the MTRR to never have an
 	 * effect on the MMIO region on both non-PAT and PAT systems.
 	 */
-	par->ati_regbase = ioremap_uc(info->fix.mmio_start, 0x1000);
+	par->ati_regbase = devm_ioremap_uc(&pdev->dev, info->fix.mmio_start, 0x1000);
 #else
-	par->ati_regbase = ioremap(info->fix.mmio_start, 0x1000);
+	par->ati_regbase = devm_ioremap(&pdev->dev, info->fix.mmio_start, 0x1000);
 #endif
 	if (par->ati_regbase == NULL)
 		return -ENOMEM;
@@ -3490,8 +3490,8 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 
 	aty_fudge_framebuffer_len(info);
 
-	info->screen_base = ioremap_wc(info->fix.smem_start,
-				       info->fix.smem_len);
+	info->screen_base = devm_ioremap_wc(&pdev->dev, info->fix.smem_start,
+					    info->fix.smem_len);
 	if (info->screen_base == NULL) {
 		ret = -ENOMEM;
 		goto atyfb_setup_generic_fail;
@@ -3511,12 +3511,9 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 	return 0;
 
 atyfb_setup_generic_fail:
-	iounmap(par->ati_regbase);
+	/* devm handles cleanup automatically on probe failure */
 	par->ati_regbase = NULL;
-	if (info->screen_base) {
-		iounmap(info->screen_base);
-		info->screen_base = NULL;
-	}
+	info->screen_base = NULL;
 	return ret;
 }
 
@@ -3536,7 +3533,7 @@ static int atyfb_pci_probe(struct pci_dev *pdev,
 		return rc;
 
 	/* Enable device in PCI config */
-	if (pci_enable_device(pdev)) {
+	if (pcim_enable_device(pdev)) {
 		PRINTKE("Cannot enable PCI device\n");
 		return -ENXIO;
 	}
@@ -3552,7 +3549,7 @@ static int atyfb_pci_probe(struct pci_dev *pdev,
 	/* Reserve space */
 	res_start = rp->start;
 	res_size = resource_size(rp);
-	if (!request_mem_region(res_start, res_size, "atyfb"))
+	if (!pcim_request_region(pdev, rp - pdev->resource, "atyfb"))
 		return -EBUSY;
 
 	/* Allocate framebuffer */
@@ -3612,17 +3609,9 @@ static int atyfb_pci_probe(struct pci_dev *pdev,
 err_release_io:
 #ifdef __sparc__
 	kfree(par->mmap_map);
-#else
-	if (par->ati_regbase)
-		iounmap(par->ati_regbase);
-	if (info->screen_base)
-		iounmap(info->screen_base);
 #endif
+	/* devm handles cleanup automatically for non-sparc PCI devices */
 err_release_mem:
-	if (par->aux_start)
-		release_mem_region(par->aux_start, par->aux_size);
-
-	release_mem_region(par->res_start, par->res_size);
 	framebuffer_release(info);
 
 	return rc;
@@ -3733,10 +3722,13 @@ static void atyfb_remove(struct fb_info *info)
 	arch_phys_wc_del(par->wc_cookie);
 
 #ifndef __sparc__
-	if (par->ati_regbase)
-		iounmap(par->ati_regbase);
-	if (info->screen_base)
-		iounmap(info->screen_base);
+	/* For PCI devices, devm handles unmapping automatically */
+	if (par->bus_type != PCI) {
+		if (par->ati_regbase)
+			iounmap(par->ati_regbase);
+		if (info->screen_base)
+			iounmap(info->screen_base);
+	}
 #ifdef __BIG_ENDIAN
 	if (info->sprite.addr)
 		iounmap(info->sprite.addr);
@@ -3745,10 +3737,7 @@ static void atyfb_remove(struct fb_info *info)
 #ifdef __sparc__
 	kfree(par->mmap_map);
 #endif
-	if (par->aux_start)
-		release_mem_region(par->aux_start, par->aux_size);
-
-	if (par->res_start)
+	if (par->res_start && par->bus_type != PCI)
 		release_mem_region(par->res_start, par->res_size);
 
 	framebuffer_release(info);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


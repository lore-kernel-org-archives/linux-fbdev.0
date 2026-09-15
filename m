Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0BF4A2604;
	Tue, 15 Sep 2026 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483553; cv=none; b=r/4ieyI9rYcQXH3S3a2qJXnfWc8I+/Ze7rDhQYPLnA20PeKHVEBJLX7ulEyJ9QrAO8frIPz9Ylg4LlGrBNlUMTCGqq8C/vFi8XAOp6aPPW0n5/GKDJ7BlBu+tOXnNhocszXO6Nsu+HFNtVOH98POTOTRwC5yCtEEWDXuRGrF3Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483553; c=relaxed/simple;
	bh=sryxKvjfZ9SXWJkloWRmv7gAM/1bQTdAxnTAiQXiuLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L21SnQeATQ5k1gRxN2ILsUD6Ue/srCgltCVQnImEIaGkKiv0qkKnaI7PA839BjUu3zSloW+iB93NpKiYl4YmP20MwWXGBPhYZqSQ+wrCTk7oKTRbYPpgeqMZjKxZcf5bCexsf+zRRuidJwUMvwpYHQFcNqeDuV7d3NJWriplI2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn; spf=pass smtp.mailfrom=tju.edu.cn; dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b=OqY9PXnF; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b="OqY9PXnF"
Received: from tju.edu.cn (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [183.242.150.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ddceb521;
	Tue, 15 Sep 2026 22:45:34 +0800 (GMT+08:00)
From: Yibo Tan <lhfff@tju.edu.cn>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Helge Deller <deller@gmx.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] fbdev: atmel_lcdfb: Prevent FIFO work after removal
Date: Tue, 15 Sep 2026 22:45:28 +0800
Message-Id: <20260915144528.3464726-1-lhfff@tju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0a587c6a003a1kunmb39ec71c2df824
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGB1LVhhOTUhIHUoaHx5MQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSU9JVUpOS1VCWVdZFhoPEhUdFFlBWU9LSFVKS0hKTk
	xOVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=OqY9PXnFOEYsBrY58XRsakZ/d8919hvn1n6Ev5om59QW4+FMvm7VfjVtVqBmg6Z8T1jEGbSJQW2DRAk18hgz6sCCmegwOc5ocY+ngoRlDkrmOOHqA1n87PwUajgPcOTGZdFjQrtSnUY16cy407TTEUN9lK57an0zoHN831uMjJg=; c=relaxed/relaxed; s=default; d=tju.edu.cn; v=1;
	bh=R/WqiFUDtj9hW8jTIp2hYqJBQvF/QvuI4kKPkm5/LJo=;
	h=date:mime-version:subject:message-id:from;

The LCD controller IRQ schedules sinfo->task to recover from a FIFO
underflow.  Probe currently requests the IRQ before initializing the
work, so an early interrupt can schedule an uninitialized work item.

The probe error path and remove path cancel the work before freeing the
IRQ.  A FIFO-underflow interrupt can schedule the work again after that
cancellation.  framebuffer_release() may then free sinfo while the work
is still pending.

KASAN reported a use-after-free in atmel_lcdfb_task() when an underflow
interrupt occurred during removal.  With the IRQ freed before the work
was cancelled, the same test completed without a kernel diagnostic.

Initialize the work before requesting the IRQ.  In both cleanup paths,
free the IRQ before cancelling the work so that it cannot be scheduled
again after cancellation.

Fixes: d22579b83735 ("atmel_lcdfb: FIFO underflow management")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
---
 drivers/video/fbdev/atmel_lcdfb.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 53f0156992e6..9a0cc09004b7 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1146,6 +1146,9 @@ static int atmel_lcdfb_probe(struct platform_device *pdev)
 	/* Initialize PWM for contrast or backlight ("off") */
 	init_contrast(sinfo);
 
+	/* Some LCDC recovery operations require process context. */
+	INIT_WORK(&sinfo->task, atmel_lcdfb_task);
+
 	/* interrupt */
 	ret = request_irq(sinfo->irq_base, atmel_lcdfb_interrupt, 0, pdev->name, info);
 	if (ret) {
@@ -1153,10 +1156,6 @@ static int atmel_lcdfb_probe(struct platform_device *pdev)
 		goto unmap_mmio;
 	}
 
-	/* Some operations on the LCDC might sleep and
-	 * require a preemptible task context */
-	INIT_WORK(&sinfo->task, atmel_lcdfb_task);
-
 	ret = atmel_lcdfb_init_fbinfo(sinfo);
 	if (ret < 0) {
 		dev_err(dev, "init fbinfo failed: %d\n", ret);
@@ -1192,8 +1191,8 @@ static int atmel_lcdfb_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, NULL);
 	fb_dealloc_cmap(&info->cmap);
 unregister_irqs:
-	cancel_work_sync(&sinfo->task);
 	free_irq(sinfo->irq_base, info);
+	cancel_work_sync(&sinfo->task);
 unmap_mmio:
 	exit_backlight(sinfo);
 	iounmap(sinfo->mmio);
@@ -1230,6 +1229,7 @@ static void atmel_lcdfb_remove(struct platform_device *pdev)
 		return;
 	sinfo = info->par;
 
+	free_irq(sinfo->irq_base, info);
 	cancel_work_sync(&sinfo->task);
 	exit_backlight(sinfo);
 	atmel_lcdfb_power_control(sinfo, 0);
@@ -1238,7 +1238,6 @@ static void atmel_lcdfb_remove(struct platform_device *pdev)
 	clk_put(sinfo->lcdc_clk);
 	clk_put(sinfo->bus_clk);
 	fb_dealloc_cmap(&info->cmap);
-	free_irq(sinfo->irq_base, info);
 	iounmap(sinfo->mmio);
  	release_mem_region(info->fix.mmio_start, info->fix.mmio_len);
 	if (platform_get_resource(pdev, IORESOURCE_MEM, 1)) {
-- 
2.39.5


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D02ECE9B;
	Sun,  1 Mar 2026 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329673; cv=none; b=fUllzNufJdrUApWCa7a/3gGmnpUAbfnFlnfoBIodaZvVebzimyFPLeq7JK4qKJUFCO8al3P/N11cRPzGdId6x08C4XPCBWFIbbeq2fE9FZ/Od8q7GLZcnevHeBuEVnJLgfcdWujGcEdJPx4bZrvYvMWjcR8jPmYa1Bngw1IJZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329673; c=relaxed/simple;
	bh=M7AjvNGQ6ivPiRbc206heB/jGonoRNCbN3E/EnL2zjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HInkEWesyZBJZbR+ojxemK5aVxj79Ldo6fejFx/6mQ6/kDq7MZU8UIicKiXAbnowyEocQr8jBDiA8Ev0NdfoAzEe+ZLq5k6wP6baQQn5nSXHkX5p1XDyZXMLL4p10BzNlYHbGiJb2UFASUEPC2XcPEIgvcjvUPBfjmpHgrofPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/babn51; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/babn51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1EFC19421;
	Sun,  1 Mar 2026 01:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329673;
	bh=M7AjvNGQ6ivPiRbc206heB/jGonoRNCbN3E/EnL2zjM=;
	h=From:To:Cc:Subject:Date:From;
	b=Z/babn51pwctts/dQwb1PAK2xWkNgMYhuCVIIRfJgFA3k68Xkf5QZSmad/y2cVMOt
	 X/kr3c3T/0oPdxemzobB+MvHgb8PuIATOdjkqU5aTve7KLraIoZ8ksyHkgsbXGmPQk
	 S+486F3Snzb/oFw9TkP1otOJrwm1aRIqadoxHxCOugO5PHp1NXJpKk2tW1op/sJpll
	 WnCTr8jM5gQK5lfIjk+U4qsCGsUZJCwrOlKl1jn+xj4YNNnfKPzqCzOLOesXkS+Xd5
	 PTK+649d+L6xF3shBUwYMboJpCU5AUSMvj7FjpJgXtJyXDh2JJ5CfZ1ZttunyVl2Wl
	 zyqsQVhPaXdMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fourier.thomas@gmail.com
Cc: Helge Deller <deller@gmx.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "fbdev: vt8500lcdfb: fix missing dma_free_coherent()" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:47:51 -0500
Message-ID: <20260301014751.1711844-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 88b3b9924337336a31cefbe99a22ed09401be74a Mon Sep 17 00:00:00 2001
From: Thomas Fourier <fourier.thomas@gmail.com>
Date: Mon, 12 Jan 2026 15:00:27 +0100
Subject: [PATCH] fbdev: vt8500lcdfb: fix missing dma_free_coherent()

fbi->fb.screen_buffer is allocated with dma_alloc_coherent() but is not
freed if the error path is reached.

Fixes: e7b995371fe1 ("video: vt8500: Add devicetree support for vt8500-fb and wm8505-fb")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/vt8500lcdfb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
index b08a6fdc53fd2..85c7a99a7d648 100644
--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -369,7 +369,7 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 	if (fbi->palette_cpu == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate palette buffer\n");
 		ret = -ENOMEM;
-		goto failed_free_io;
+		goto failed_free_mem_virt;
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -432,6 +432,9 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 failed_free_palette:
 	dma_free_coherent(&pdev->dev, fbi->palette_size,
 			  fbi->palette_cpu, fbi->palette_phys);
+failed_free_mem_virt:
+	dma_free_coherent(&pdev->dev, fbi->fb.fix.smem_len,
+			  fbi->fb.screen_buffer, fbi->fb.fix.smem_start);
 failed_free_io:
 	iounmap(fbi->regbase);
 failed_free_res:
-- 
2.51.0





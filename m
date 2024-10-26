Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556341DFD8
	for <linux-fbdev@vger.kernel.org>; Sat, 26 Oct 2024 03:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729915029; cv=none; b=UA6A8rw2LgI4vdaX9QoboYCfQcMw7jMlShGUsWJjfVGSNbM9Gh41f45cScJUnVvM2HU+CJ9I8z6rMKlbGExb8TPMqkxACqaPtg1WqsNrfBy1C2COgIY5g5d9Pn4iZaN+W52OrXEBOQ7Eh4NioypCqX2Z0Cto11zDgd9sI6hiat8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729915029; c=relaxed/simple;
	bh=qUXxUiMPJIWH2qB1pB2cJOcCS51IEKQw1inijSPa0PE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HH9bK70JZtRsP8Yq8iDz+t+opHoPWgGhWGWv6905LCo7FHb4ZFNH/7KAZ5+cxp5hCMeLNSWfNmXMkny895o+veV41tvCGnADaCgDptnIN1aDis3gBhzZlSD0ACpC1NAeJuRlMsa2Fe+eO/c1IdwrjEAdrAdH8OHz+jmigazc7Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xb5Qq0Y9jz1SD8X;
	Sat, 26 Oct 2024 11:55:31 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 501631A0188;
	Sat, 26 Oct 2024 11:56:58 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Oct 2024 11:56:57 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Helge Deller <deller@gmx.de>, <linux-fbdev@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] video: sh7760fb: Fix a possible memory leak in sh7760fb_alloc_mem()
Date: Sat, 26 Oct 2024 11:56:34 +0800
Message-ID: <20241026035634.467-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)

When information such as info->screen_base is not ready, calling
sh7760fb_free_mem() does not release memory correctly. Call
dma_free_coherent() instead.

Fixes: 4a25e41831ee ("video: sh7760fb: SH7760/SH7763 LCDC framebuffer driver")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/video/fbdev/sh7760fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sh7760fb.c b/drivers/video/fbdev/sh7760fb.c
index 3d2a27fefc874a7..130adef2e468697 100644
--- a/drivers/video/fbdev/sh7760fb.c
+++ b/drivers/video/fbdev/sh7760fb.c
@@ -409,12 +409,11 @@ static int sh7760fb_alloc_mem(struct fb_info *info)
 		vram = PAGE_SIZE;
 
 	fbmem = dma_alloc_coherent(info->device, vram, &par->fbdma, GFP_KERNEL);
-
 	if (!fbmem)
 		return -ENOMEM;
 
 	if ((par->fbdma & SH7760FB_DMA_MASK) != SH7760FB_DMA_MASK) {
-		sh7760fb_free_mem(info);
+		dma_free_coherent(info->device, vram, fbmem, par->fbdma);
 		dev_err(info->device, "kernel gave me memory at 0x%08lx, which is"
 			"unusable for the LCDC\n", (unsigned long)par->fbdma);
 		return -ENOMEM;
-- 
2.34.1


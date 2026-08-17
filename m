Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670C937649D;
	Mon, 17 Aug 2026 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948796; cv=none; b=CTxJGbNj0XySh25liHrbfmjfjqk7P5McW6AfA421M8/9Gd0RkgP23aS/IgdZsyDuRUIJW7GGhzC79wi+J1FDkGOBjVpYQtDt3+uiwih+eIMLCcT8Nb9xIeUURddKZ1lposADFLncuqhW9G2X1Cp8pRti72+T8wjeFrR097J2azk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948796; c=relaxed/simple;
	bh=YAXfyoucDFVd+xUrToagwQBlZZxLxO+3+e27LmGBQPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+MRW29rF0cWaCv0oOugs29h6zmuJZEI3lcLLeQ17+iB3GH3T2Gj8bj9kVIMQLVHEsNGggq1Jepc+3WSVzgEWFr0HHEU/Quqa0AJVcHyTzVJPjf85PTy0IDEYzRypHXFgBrH7eAXyqOSAZLBG3DboG6HMNRkNuO6z+yuy+lwxwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6f142afa9a0611f19a56ed5b684f684d-20260817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:692f5d82-b3b0-48f7-aedc-ced83efa3d51,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:04b980b4817a7bef028bdf65ece100b3,BulkI
	D:nil,BulkQuantity:0,SF:102|136|865|898,TC:nil,Content:0|15|50,EDM:-3|-100
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6f142afa9a0611f19a56ed5b684f684d-20260817
X-User: yuebingkun@kylinos.cn
Received: from tushenkeke2-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yuebingkun@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1025158773; Mon, 17 Aug 2026 14:39:44 +0800
From: yuebingkun <yuebingkun@kylinos.cn>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	yuebingkun <yuebingkun@kylinos.cn>
Subject: [PATCH v2] fbdev: platinumfb: add error checking for ioremap calls
Date: Mon, 17 Aug 2026 14:39:42 +0800
Message-ID: <20260817063942.308926-1-yuebingkun@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ioremap() and ioremap_wt() calls in platinumfb_probe() were not
checked for failure. If any of these mappings fail, the driver would
dereference NULL pointers, leading to a kernel panic.

Add proper error checking and use goto-based cleanup to avoid code
duplication across the error paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: yuebingkun <yuebingkun@kylinos.cn>
---
 drivers/video/fbdev/platinumfb.c | 36 ++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
index fa27a3a4f05b..fdffadcc3e73 100644
--- a/drivers/video/fbdev/platinumfb.c
+++ b/drivers/video/fbdev/platinumfb.c
@@ -567,15 +567,30 @@ static int platinumfb_probe(struct platform_device* odev)
 	/* frame buffer - map only 4MB */
 	pinfo->frame_buffer_phys = pinfo->rsrc_fb.start;
 	pinfo->frame_buffer = ioremap_wt(pinfo->rsrc_fb.start, 0x400000);
+	if (!pinfo->frame_buffer) {
+		dev_err(&odev->dev, "failed to ioremap frame buffer\n");
+		rc = -ENOMEM;
+		goto err_release_fb;
+	}
 	pinfo->base_frame_buffer = pinfo->frame_buffer;
 
 	/* registers */
 	pinfo->platinum_regs_phys = pinfo->rsrc_reg.start;
 	pinfo->platinum_regs = ioremap(pinfo->rsrc_reg.start, 0x1000);
+	if (!pinfo->platinum_regs) {
+		dev_err(&odev->dev, "failed to ioremap registers\n");
+		rc = -ENOMEM;
+		goto err_unmap_fb;
+	}
 
 	pinfo->cmap_regs_phys = 0xf301b000;	/* XXX not in prom? */
 	request_mem_region(pinfo->cmap_regs_phys, 0x1000, "platinumfb cmap");
 	pinfo->cmap_regs = ioremap(pinfo->cmap_regs_phys, 0x1000);
+	if (!pinfo->cmap_regs) {
+		dev_err(&odev->dev, "failed to ioremap cmap registers\n");
+		rc = -ENOMEM;
+		goto err_release_cmap;
+	}
 
 	/* Grok total video ram */
 	out_be32(&pinfo->platinum_regs->reg[16].r, (unsigned)pinfo->frame_buffer_phys);
@@ -623,13 +638,22 @@ static int platinumfb_probe(struct platform_device* odev)
 	dev_set_drvdata(&odev->dev, info);
 
 	rc = platinum_init_fb(info);
-	if (rc != 0) {
-		iounmap(pinfo->frame_buffer);
-		iounmap(pinfo->platinum_regs);
-		iounmap(pinfo->cmap_regs);
-		framebuffer_release(info);
-	}
+	if (rc != 0)
+		goto err_unmap_cmap;
+
+	return 0;
 
+err_unmap_cmap:
+	iounmap(pinfo->cmap_regs);
+err_release_cmap:
+	release_mem_region(pinfo->cmap_regs_phys, 0x1000);
+err_unmap_regs:
+	iounmap(pinfo->platinum_regs);
+err_unmap_fb:
+	iounmap(pinfo->frame_buffer);
+err_release_fb:
+	release_mem_region(pinfo->rsrc_fb.start, resource_size(&pinfo->rsrc_fb));
+	framebuffer_release(info);
 	return rc;
 }
 
-- 
2.43.0


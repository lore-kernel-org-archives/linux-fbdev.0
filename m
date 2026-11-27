Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795757607;
	b=pp883NDkpZcTU7Eze84856tJZMdyVELVnfO0Rxgv4IAZWeSDJJvcKHIAjXcRmR3MGe2Y
	 tRHuLY8bchHsG7ci/H+G9it4+ESkxGwa8QsjPbFMdGHSjEzJDWfLr6b/BcpAfrvHXTiF1
	 RJML9s1utpmS55LjDx6TaZuzK6y2SobU589VvmxRBkvVooEIM+t68WsYsyrCxp141gM12
	 k/K7zJDk81urPu7ugN6RNlvrBNl1oRBgA+x8dAbM8sWMmaF4E7Z1j3N2ghYfyP6HmqCrJ
	 0EWk0bNM3DEDE1Ad91lFgDXrJrUpfovTJ4dAvLOBM+vpg1P1UB3zegoPfHrCOJWImfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795757607;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=H9/l8zrbjI1Fi8JYq3QN58ALIk2gWRpzKtBMdgpzqe8=;
	b=0MBqhNsSrOD0HZzKHV7CK9vW+oiuc4FWdRv6bRWTu2wsyBXlvxXFjO0vR6XPlkXXYRkJ
	 57dplfgE9MylHhomkH2jQFeN+ME6yyn5kxnt9okOpKOYFwhKk6WyGSjVONsXTeepLVXuZ
	 Y/UbZHXP/5YbxuNWGwHIBp7qmbZmMShXKTT4Sd44APEIKY/Zm2Imw8gl6/cOrLGQf6qhB
	 2ZWDemFfO/019sYVD8Bb3sXIxZAgVWdylbubS6xZJ8u7/NGKIqrlj7SqYeSioKT5VQJub
	 VnvElTb9eyDDxMVtvDzLMM7pGvwpR+fDr6Vq9hGfiH1ajZqqMBKFjR43QxBVRhT7RQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ZNs+536t;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23829606A31C
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2026 05:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23829606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ZNs+536t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=H9
	/l8zrbjI1Fi8JYq3QN58ALIk2gWRpzKtBMdgpzqe8=; b=ZNs+536tdlkUt0VJ4L
	CpakhHsJnl5bGBN+H1QEWUD9mKWbE6ENFGdu2n5E/VD6HXNKKXxnfDh1XpOtl7dI
	8ldcGiqmoxMe2JcbCGUln8TuG8bfkzSQ4kwdFIW6qlGQ3a2yQ7JsqCRo2D9N1bjE
	e9XBNlYwImNILF9A98W6ZtbBo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wB3Ps7+FQlr8ZpFKQ--.60941S2;
	Fri, 27 Nov 2026 13:32:48 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: deller@gmx.de,
	fberckel@xs4all.nl,
	davem@davemloft.net
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] video: fbdev: Free color map if framebuffer fails to register
Date: Fri, 27 Nov 2026 13:32:42 +0800
Message-Id: <20261127053242.361218-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3Ps7+FQlr8ZpFKQ--.60941S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw13ZrWrZFWUZr48WF4Durg_yoWkZFb_C3
	4Fvry8Xa4UKr1fGr1xAr15Ary2yws7Zrn3uF1vqasxGFy3Wr1rXr48Zrn5X3WUuF18KFsx
	CryqgF4xCw1SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRXYFXUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7gCiEWsJFgA0nAAA3B

gfb_set_fbinfo() allocates color map via fb_alloc_cmap().
If register_framebuffer() fails, the memory should be freed.
Add a goto label and call fb_dealloc_cmap() to do so.

Fixes: 2d378b917988 ("sparc64: Add very basic XVR-1000 framebuffer driver.")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/video/fbdev/sunxvr1000.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sunxvr1000.c b/drivers/video/fbdev/sunxvr1000.c
index a93b06614187..b77e5ad16f1b 100644
--- a/drivers/video/fbdev/sunxvr1000.c
+++ b/drivers/video/fbdev/sunxvr1000.c
@@ -154,18 +154,21 @@ static int gfb_probe(struct platform_device *op)
 	if (err < 0) {
 		printk(KERN_ERR "gfb: Could not register framebuffer %pOF\n",
 		       dp);
-		goto err_unmap_fb;
+		goto err_dealloc_cmap;
 	}
 
 	dev_set_drvdata(&op->dev, info);
 
 	return 0;
 
+err_dealloc_cmap:
+	fb_dealloc_cmap(&gp->info->cmap);
+
 err_unmap_fb:
 	of_iounmap(&op->resource[6], gp->fb_base, gp->fb_size);
 
 err_release_fb:
-        framebuffer_release(info);
+	framebuffer_release(info);
 
 err_out:
 	return err;
-- 
2.25.1


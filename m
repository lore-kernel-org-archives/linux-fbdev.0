Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA7352941
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770186174; cv=none; b=GlvTgdPqsW6kHLhyuRh6RBsRAYjGp1ALlAUo4YTPO57Dp2INRBIHBMe/vd9l1wq8lQhqmdA/tCEz3bJMN91x2d7GRQaMdfhdpi1+WfX86NIxOOqLm0/DDfuXDLN49Or3HMgVM6PhefujbkYJLY+utlT86xUgz8Y7M2zOgk544Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770186174; c=relaxed/simple;
	bh=XNWUFeTs+Kgl3RtBPh3SL54x5bCFit9tdIFTFeTwjl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bv8wEK+tEftyzERgB2PALplOl96oWrPo67M8LFhxyLqC8rQINKJLhTQ3GPwsWGZvfv2Du1qOD4byOk+DpT13SG3b66UX12K1KnJDGZBtI2K6MQxE5v92nyghlcsi2S3l/yirQjgGIqRXdqrhPGWw9DJx5gafE+HvHF9O/w0uuSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjuBpKzI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjuBpKzI"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso2570257a12.3
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Feb 2026 22:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770186173; x=1770790973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y20MhP2lBI6MQPIBm3+UQ19S98gAaN1y57Up4ru7wdI=;
        b=kjuBpKzIrWzWk09zSj32eaxcdbTgCY4w6BXbBg1MCYgsJljrqFEj75KBs80OElCdvC
         luyYRw/z4qu9C3hmzzbTt26K0EQMb+80g2+5cKJ+4R+rWaLXwpjQoPwnHE2+RmHy1Ldq
         5RoWmJI8i3G7KOzvCldvgj9aDYO85U0B8s1N1YBvb6MRpq7gfQ1mG6UKRY71q7YUQjZn
         kaXjt0+OysXPT5RVgx1smoZHZzJ6jaPgEV3Ji9SkBu8SKq65EIC0OYrUfcDGDyAWrhma
         PEYRsciOUdIVmpLq+qtKN4oWcYTyDhLAxEL9CMUuvp8JMLUU4mVk/U/OP5f9X3QYz80w
         UL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770186173; x=1770790973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y20MhP2lBI6MQPIBm3+UQ19S98gAaN1y57Up4ru7wdI=;
        b=NownU6U4U/3OZb2ilZg43NHmtk+6skl/O5wY1zcUilCX/Sh0Noc+0M4ALEiSODMIA4
         i7ycme4urEcW+V/G0gDtnAxSVbZq1OcOOg+tiZr5tSqrNLu6DeXkEifZEozQKKOrAv9w
         0zgohBJXlj3ZqnvRYXIZPJhLPdNHjaNMUCSlHlszoZoaF2F40iK13mVmbOvK4DzfGJWn
         IYfZGtpzyxtmppsvEaLHkZZCDzwpUcB0oyTphWvaKi+8+ndA5z+KAgzVm/1RA4kVSbQf
         PmnNpG/5rLBvXDYn8dlShNQpA/q0Bem0C1lK43ppJKGhFi6X3Hcs1SW8kmywSLI2N9cO
         fwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsLlkVR2BPRPCS1QxgRp0jyVvVzKgWAY8/B6/DVF1EDLREABYktl0TmjItkn2ZEX0/hjKziGg0RGvknA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08BdauBCwOUBvBmGuW2UyvZ5icjSmLN76z8Ar+P8x4bQIdr4Q
	nK7nCxctPF3YYyUI6NZOy5j6A4apCu4vPveZmsYR1hHaidTRaIVEernG+V2GQcsR
X-Gm-Gg: AZuq6aJMm5RzjBnGa2zyAWwUF9M2Gu1Jq8oqzzilgW48LoDmzdM34t59kFfMuPwR56L
	Fy5tx2dYGZkQ6Phkcm/FZxvOP9NdsDY8fttv6Be+B9lsMmQBSGf4okSJDSTIGr6GhMUgFVZ+Osm
	f0GoaHtVGwDJexG0Ma8R24tblAalfnsnNZITcZ1nriShOnu9yUEcv+aJEgvogLANLan33KvC4xS
	/Yl3ET9x/j0NzVf4q5owCZeC+m6bEfT1/l0fo0dc/Whg9yNthJbukPe6hlX5v/3a7/ZFWH4iV1B
	ugO5wCtowRUleQ+HI85CSssMnBBPa7PjB1yHZXKTxCKMHBHIkorH+n2cd00zqrCYq+Uj1yizsHr
	nekK3AsRHoCgqKltck3VDCsOid8yXFGK660QIRcmlgnkZTUQ9FzrXmtsmxAoGvyKm44J0CL4X8z
	09wvY2Xrm4qwYj
X-Received: by 2002:a05:6a21:68e:b0:348:b7a1:431 with SMTP id adf61e73a8af0-393720910f0mr2109274637.10.1770186173475;
        Tue, 03 Feb 2026 22:22:53 -0800 (PST)
Received: from mint.. ([2401:4900:53f5:9794:567c:c0b1:37aa:12a9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c85065f6fsm1046364a12.26.2026.02.03.22.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 22:22:52 -0800 (PST)
From: dhyaan19022009-hue <dhyan19022009@gmail.com>
X-Google-Original-From: dhyaan19022009-hue <dhyaan19022009@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dhyaan19022009-hue <dhyaan19022009@gmail.com>
Subject: [PATCH] staging: sm750fb: rename pvMem to pv_mem
Date: Wed,  4 Feb 2026 11:52:40 +0530
Message-ID: <20260204062240.20293-1-dhyaan19022009@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the CamelCase variable pvMem to the snake_case pv_mem to
comply with the Linux kernel coding style. This fixes multiple
warnings reported by checkpatch.pl.

Signed-off-by: dhyaan19022009-hue <dhyaan19022009@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 18 +++++++++---------
 drivers/staging/sm750fb/sm750.h    |  2 +-
 drivers/staging/sm750fb/sm750_hw.c |  6 +++---
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fecd7457e..9bf3c0a37 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -624,27 +624,27 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->pv_mem;
 		pr_info("use simul primary mode\n");
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_secondary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->pv_mem;
 		break;
 	case sm750_dual_normal:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->pv_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
 			/* not consider of padding stuffs for o_screen,need fix */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->pv_mem + crtc->o_screen;
 		}
 		break;
 	case sm750_dual_swap:
@@ -652,7 +652,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->pv_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
@@ -660,7 +660,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			 * need fix
 			 */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->pv_mem + crtc->o_screen;
 		}
 		break;
 	default:
@@ -771,7 +771,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	crtc->cursor.max_h = 64;
 	crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
-	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
+	crtc->cursor.vstart = sm750_dev->pv_mem + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
 	if (!g_hwcursor)
@@ -1090,7 +1090,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 		sm750_dev->mtrr.vram = arch_phys_wc_add(sm750_dev->vidmem_start,
 							sm750_dev->vidmem_size);
 
-	memset_io(sm750_dev->pvMem, 0, sm750_dev->vidmem_size);
+	memset_io(sm750_dev->pv_mem, 0, sm750_dev->vidmem_size);
 
 	pci_set_drvdata(pdev, sm750_dev);
 
@@ -1122,7 +1122,7 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
 	iounmap(sm750_dev->pvReg);
-	iounmap(sm750_dev->pvMem);
+	iounmap(sm750_dev->pv_mem);
 	kfree(g_settings);
 }
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index fcb7d586e..2dc57bbe7 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -98,7 +98,7 @@ struct sm750_dev {
 	__u32 vidmem_size;
 	__u32 vidreg_size;
 	void __iomem *pvReg;
-	unsigned char __iomem *pvMem;
+	unsigned char __iomem *pv_mem;
 	/* locks*/
 	spinlock_t slock;
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index ce46f240c..de1331c56 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -76,15 +76,15 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 
 	/* reserve the vidmem space of smi adaptor */
-	sm750_dev->pvMem =
+	sm750_dev->pv_mem =
 		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
-	if (!sm750_dev->pvMem) {
+	if (!sm750_dev->pv_mem) {
 		iounmap(sm750_dev->pvReg);
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("video memory vaddr = %p\n", sm750_dev->pvMem);
+	pr_info("video memory vaddr = %p\n", sm750_dev->pv_mem);
 exit:
 	return ret;
 }
-- 
2.43.0


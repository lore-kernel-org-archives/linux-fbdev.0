Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793406868;
	b=x25+67w1DU5UkJNjEwq6SlTrZOtAxoaNiQ4CHN5S/X2DiDFlT+1Nb+HHwOwPdYSQ6Sll
	 M68jFYLFJ74KNx0b7iOyQ1OrUntlOHD2Ej7URBK+fpOftFKPRVsScR9IBFCRc1ji9+vxf
	 mjbPHUVljMrbdkjistbXfPlPN3gQUFAWwyZAMEMiW9IQC7tw5eyIlQMSCpQnMRyAGv/gj
	 LKj/5uAjtcxSCIRx32jLiLGvpS7Pqq5ryYkQJsLLg2w9k1V2oV6ASaMWOWoKlZahs3tSn
	 fUWTGElB+FBnzKMGjHb48gzYuvW7u+cwJz4oEfUj/3Ta2HyIhfOKk03vRdCE81fERyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793406868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lAQsub6pmHls3bP0tt9PGyqlBwOUYsP9EC/vfE7Hwr8=;
	b=4UJnk3xRBBFP/YBpjxUj/tmoFYxU80tKBcwgqP9cmuekS2W0Hu+qjrwr3fBGGvQgXdXl
	 kgguREyqp8h5H7xJN47K/clMA9xIoQKvNpZHsaIAimeUqiBpABsXPjgzPmuD/nZbdvQEE
	 IwoiHRP+Ki3RZ+IyLJzlyFZjPYu2LbfX53r3zGgVQAa0EAEHFCHzfUpkqDuuNEy4GkO/9
	 MPNSFdsIZsTkjo7ULrS8YB7Ay76XbHF4U5ZSG1SICdFePAarSn3mYJ0VfFZRA8wV+GwxO
	 7EVKYZys9a3rOUimCZ5Rs1TIIv2+AwA7HsF8D6cdzQ2RbdltwBYCK/D4iXc940ly4dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YycHXE/k";
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5EB606A31C
	for <linux-fbdev@vger.kernel.org>; Sat, 31 Oct 2026 00:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C5EB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YycHXE/k
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1931ff67a29so521903c88.1
        for <linux-fbdev@vger.kernel.org>; Fri, 30 Oct 2026 17:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793406868; x=1794011668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lAQsub6pmHls3bP0tt9PGyqlBwOUYsP9EC/vfE7Hwr8=;
        b=YycHXE/kQCeONe5u5VShHK5xy0VoYQSfDziX/pTbHa5PCDO71PBexSxxok9WdIuWbC
         Z1SUTlz5OxMIGRP5QzMkCspCLshQfsx5Otk46wluTefz5AXSi1J7GaAKfOdswBERl7I8
         Nb6dUc6cuiwTJfF2Xgz+sKZEUFqDgfus/xGvgWrp95gRe9JLVpRFkDxkup9GUyW7HBBN
         IoohchD3pXqteRT9FIty4btbFJ3nrqFRK31vfBDOKVrvTUjHy5+Jp9DcQ46J9ADYTTJv
         2Eyq17sbd3jlneJRjyrE9UY8hT99UP/LS7yle1E6wbV4zBVqLySU3utj/T5lD7qssP12
         QzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793406868; x=1794011668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lAQsub6pmHls3bP0tt9PGyqlBwOUYsP9EC/vfE7Hwr8=;
        b=TMNG5uoZInuT+LLKrhO2gBwvnu1pMsNhla583vBmL+CgwTJwdgNA0D9Fgr6z0yB+bz
         Ykw8bWZeiizT12WzCYto53OmC28pdmvHZ0FuYIvBcAWNYAINFd2YT0PPzKEzf1MIt1hC
         fMzEKTthYBngeQyrleLypOSbEaJKMvRFRBZauh+RCOPQEjIA70Gbc0plWWeAVUFVteI+
         /U9WLaUV1RLVxXRh9ZJmfjRU1sn9ARLEGH1/Tom+WKNgqh6n8AXV9VAaM/GxYZ49UcCt
         g7eF7/m3lM1AeHnJq6K2SBCZWnMgohFDMj8jaDuT1RXlaN8C5sJ/3PvCs9ddKxYi0TaZ
         6eQw==
X-Gm-Message-State: AFq9FYJGUWZ12fT1xOaxwMpJZitNmr1WF+D7km0fQuDRkvH0TigLYWr7
	RntUgMaVZTsO2KRVab4lcgMLukEu5Yw8pw7xkWm8evAN2Qu/q4wv7TPA
X-Gm-Gg: AYBFou0BG5NE8aSkfHp5Xog0IxPDhBq/3gCLOL606Y7URgeHb0bALjQDk2wwB3wH/Qh
	xq6C+S9i13oFSNBTO2LvggBDDVMdofNdC+aDnEMoeJYOT2ipJHEU5HSsgC1NGlPr8rcwJLVS8fQ
	+87gO6UZYZj5ALoxTg+WV/EeMDMRteB11sfVoHQCD221nFpYhvqfGSHM3m5tfF1jPOVElGqXN/0
	X5q+HnRTXc4Isr09bcbz6FW0Skch3Zl4uFk0PcOnjgDDRr3iDb9s+UEWy/u/kKbMuRYIhNDYPHY
	s8mEyRM5v+vux2g2/2w6E7m2oygkr0N8xludzsJZ5L++jxfDQMTVD13K7WQtKIeVQwdCPVlliXZ
	uC/eyTXqeLe4tshtx15Z+Ehd/wEew2zTHcdVrIFiN7AaYbpqoflOo04ZtBCLymD6TCR1y6kPAjI
	TJJeQ3TtS9IHVCTs0a3NwxPlIiyCZ9V/Kjs5zLzCG+znR0sNtSxK4mWXUdgB8i97L1q57+X99yv
	E0xCDqRhjSKRFdsUfxlEdMPIvsF9+CzugYovFteriwU+s3SmOfPYOE3g3zcPOIXBeIng6ZRmXUo
	IBZ2BECCClb408OgA7mzcajoNhJzv8zPJ2E/G/HYlF8UQM8mUhSGN7FLCJkVgR6wWJP4dkUNOIT
	83m2kj01WLE2JRdhdimC+w0Z9ppohtTpE2UVGmCwunI83Ks6WScfBzrYdUOrdkFShJry58vnd+4
	BYfb81tVrDGF1+Aw==
X-Received: by 2002:a05:693c:639b:20b0:369:f2f4:b227 with SMTP id 5a478bee46e88-36a4238e9e4mr5713485eec.18.1793406867364;
        Fri, 30 Oct 2026 17:34:27 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm11707816eec.3.2026.10.30.17.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 17:34:26 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: pxafb: initialize IRQ completions before requesting IRQ
Date: Sat, 31 Oct 2026 08:34:24 +0800
Message-ID: <20261031003424.1796478-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
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

pxafb_handle_irq() may run before smart-panel and overlay setup.
Completion objects are uninitialized, and completing them can panic.

Move completion setup into a helper called from pxafb_init_fbinfo()
before devm_request_irq(). Drop the later initialization now that every
completion is initialized before the handler can run.

An early interrupt can also leave a completion count without a waiter.
Reset command_done and branch_done immediately before starting their
hardware transactions, so stale counts cannot make later waits succeed
early.

Tested an early interrupt through the real handler on ARM QEMU: the
unpatched path panics in complete(), while the patched path completes
normally with early=0. A stale-credit replay incorrectly returned
flush_ret=0 before this change and now returns -ETIMEDOUT twice.
Normal smart-panel init/flush/timeout/work controls also pass. Main,
no-smart and genuine-overlay ARM builds pass; strict checkpatch passes.
---
 drivers/video/fbdev/pxafb.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 1b2a16590999..84ef5baaf087 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -642,6 +642,7 @@ static void overlay1fb_disable(struct pxafb_layer *ofb)
 
 	lcd_writel(ofb->fbi, LCSR1, LCSR1_BS(1));
 	lcd_writel(ofb->fbi, LCCR5, lccr5 & ~LCSR1_BS(1));
+	reinit_completion(&ofb->branch_done);
 	lcd_writel(ofb->fbi, FBR1, ofb->fbi->fdadr[DMA_OV1] | 0x3);
 
 	if (wait_for_completion_timeout(&ofb->branch_done, 1 * HZ) == 0)
@@ -705,6 +706,7 @@ static void overlay2fb_disable(struct pxafb_layer *ofb)
 
 	lcd_writel(ofb->fbi, LCSR1, LCSR1_BS(2));
 	lcd_writel(ofb->fbi, LCCR5, lccr5 & ~LCSR1_BS(2));
+	reinit_completion(&ofb->branch_done);
 	lcd_writel(ofb->fbi, FBR2, ofb->fbi->fdadr[DMA_OV2_Y]  | 0x3);
 	lcd_writel(ofb->fbi, FBR3, ofb->fbi->fdadr[DMA_OV2_Cb] | 0x3);
 	lcd_writel(ofb->fbi, FBR4, ofb->fbi->fdadr[DMA_OV2_Cr] | 0x3);
@@ -894,7 +896,6 @@ static void init_pxafb_overlay(struct pxafb_info *fbi, struct pxafb_layer *ofb,
 	ofb->ops = &ofb_ops[id];
 	ofb->usage = 0;
 	ofb->fbi = fbi;
-	init_completion(&ofb->branch_done);
 }
 
 static inline int pxafb_overlay_supported(void)
@@ -1170,6 +1171,7 @@ int pxafb_smart_flush(struct fb_info *info)
 	lcd_writel(fbi, FDADR6, fbi->fdadr[6]);
 
 	/* begin sending */
+	reinit_completion(&fbi->command_done);
 	lcd_writel(fbi, LCCR0, fbi->reg_lccr0 | LCCR0_ENB);
 
 	if (wait_for_completion_timeout(&fbi->command_done, HZ/2) == 0) {
@@ -1277,9 +1279,6 @@ static int pxafb_smart_init(struct pxafb_info *fbi)
 	fbi->smart_cmds = (uint16_t *) fbi->dma_buff->cmd_buff;
 	fbi->n_smart_cmds = 0;
 
-	init_completion(&fbi->command_done);
-	init_completion(&fbi->refresh_done);
-
 	if (!fbi->inf->smart_update)
 		return -EINVAL;
 
@@ -1775,6 +1774,23 @@ static void pxafb_decode_mach_info(struct pxafb_info *fbi,
 		fbi->video_mem_size = video_mem_size;
 }
 
+static void pxafb_init_completions(struct pxafb_info *fbi)
+{
+#ifdef CONFIG_FB_PXA_OVERLAY
+	int i;
+#endif
+
+	init_completion(&fbi->disable_done);
+#ifdef CONFIG_FB_PXA_SMARTPANEL
+	init_completion(&fbi->command_done);
+	init_completion(&fbi->refresh_done);
+#endif
+#ifdef CONFIG_FB_PXA_OVERLAY
+	for (i = 0; i < 2; i++)
+		init_completion(&fbi->overlay[i].branch_done);
+#endif
+}
+
 static struct pxafb_info *pxafb_init_fbinfo(struct device *dev,
 					    struct pxafb_mach_info *inf)
 {
@@ -1831,7 +1847,7 @@ static struct pxafb_info *pxafb_init_fbinfo(struct device *dev,
 	init_waitqueue_head(&fbi->ctrlr_wait);
 	INIT_WORK(&fbi->task, pxafb_task);
 	mutex_init(&fbi->ctrlr_lock);
-	init_completion(&fbi->disable_done);
+	pxafb_init_completions(fbi);
 
 	return fbi;
 }
-- 
2.56.0


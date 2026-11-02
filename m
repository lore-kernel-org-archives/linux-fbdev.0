Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606623;
	b=z7vNZaUL/oblj32luH9QUERSPdAVB+DvXhiTrH9xhNjs3AM3mnMHWOXxQumXKcON2Jip
	 Fv+g67296lzTm9/YGBUQMOEhGYo6wJf55zKisycckBs9qZzaqQj1i6Jano39c+hJWuJMu
	 AN/kT+mI4P8P4b3QaXOP5rwpEgB/VYBgEfDPd4CBAmR012Y4/grjXISDkHpzk2MWm4D5E
	 RoICv8rdgYXgvjYK927pibXQtyo8LGQEqDCmPAOQQ2UEdEmC38P6xaS8Wi1OLe74b4WXw
	 mLTdtWZHaImjhMlOVgN0QfFLLKEg5r9p3Prja4EHMwiDoEdMpOMCLDZLoWOIrFg6BIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DJARq++ZNqDTm8Q9TFtOCOzhzKAsHsjDftUFwH6EBSw=;
	b=qyQLIp+K9gN21jWjIoVDPAJJ5DU6n+RyMB4HEl/TGbvXaAFv2hN0IECRK9fSgAJ647wF
	 kgO0h8jYqdwgnvlWTeWwrtrS4OxGqpCN4hY/vtHM9IYh6980izf93WtfsVr6w8y8TSx9K
	 nKTbGQZHhXsVdX0SovcHd5kW3t6J12+Glrqt+Mn4J5ecp4u++uxb6M8TUMPdsm5uqQONK
	 0nVcMkOj7p+fZOESVfxbudYsBb9oUeVy9MuEtZoL81/TDF7PyfxEUa68q38QrIuVXp0o/
	 e7TrGiSuxyBUDf4o65a7Rh6uI3ET25A9L6JnLHIg01D7vWWVP4fND0QxUh8Zp8mhQTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="aXv/Q9bp";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D585606A33A
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Nov 2026 08:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D585606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aXv/Q9bp
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e985106c0cso25488455ad.2
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Nov 2026 00:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793606623; x=1794211423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJARq++ZNqDTm8Q9TFtOCOzhzKAsHsjDftUFwH6EBSw=;
        b=aXv/Q9bpUcq/w2O/zoFJcHzpTc/FOH8vrMSRHhooMnGMDELvKmIYQukvOUgu19v/4T
         +LqNmdMP0KXTWCjM7ORGfb6Nw2QOR9gGbBkhDrTQt8A4RJciHpkwMl4R6waNDlgJ2ZUX
         POsa1AFRE3RqTCbfaqF1x6S+yF8pT2Lsi2S1LIfS8JHAmPTrOmO7vS5wqNxX9wBmw8mW
         p28+DMxaCdniXdHHuxh51SJ8M+IC9ze4YzyEPDlighPJJrqn2o2f5Sv/lXdJEIa+YjHx
         rfiuoTjFm7NkqTeHQ+K1joc98ij80ivEKRacwBFkk24Cg/UsnQxDFhzoWZNOBHAbebGD
         bl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793606623; x=1794211423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DJARq++ZNqDTm8Q9TFtOCOzhzKAsHsjDftUFwH6EBSw=;
        b=BcDnscqqLIWRO3VVqFLu00NyCyQV/Fsgh32oJdJ5ctNohXB4cwhUYm41YHDzZ+sVIh
         45tJxPQlJi27ALn0g+Hl7h6q4n045fulDj5jWli3srcnFGZaP1vnstwsa0XeeYwV1Tlv
         Bq6VBA6O6kZs3tc/8neVanG4NO1UA+DPenuDO6AdBXnNHFdVOs1xN0URPnZByB84ZXe0
         Y6FGUiOEPrpwWUzM2ZIYGMOab0brVen/xDFVTdizgsOvk5W/6+w2oIrE9NqZcv1285hF
         1QnP6eiah31TAXEN4NO81ILzFt9f53KMwwqKUQgmGD4DJsSJxsG6L4OVZYteIAVmF9NB
         okcQ==
X-Gm-Message-State: APuU4Z/ogSmazZI7757XAtxSuB6e0Y67D5nOWz+KAXzppd2QNFh70BrS
	Vpxe3e9x3U4MIvk/MePnIRWFuxW9ub2UxNJEWErEHK6lHzsZ/6y4yDs9VZhn4MR+
X-Gm-Gg: AYBFou2WDc04dsSHNPFf1vnMqiYopCQIE81H/riTuUk6aaCTcH4CP2cfY9g/+ZX3nn3
	i7hbdE+tOHcC5aWieL3ryEUGghU3d+QDvt1qhaKqZ/z1H3dp9pADB7SS29couBPC907gnQf8RW0
	eHTPWmE6HP8650JHITj+iJFIcHug0yQRZONdxunHRGOQayCM4rdh0ZpVijDYgOtTaODfPq898CE
	M+vlXZQqMcrXjtlG+KoJ+Ol6vLPdtdhg62dkwKGV/KDeFFnbdn8og7W6+4oS3xP/NfnhgRHij5e
	aHtZqtc/a9eyslhRFFSODkgNUz1cciFlu/7PKSt+gh645u1dYQblAqBLisqYZSlG31TITVAB3ZW
	U/PNFc+4V9BBAJT0EmOcLEfLxA1tFB0OJcsCLFg/XVCto8blKSnX8DUv9WNJGXU0p5nvWlM5Iq0
	e9ZE9d9994+rlHxB29bbzChvNcG8GUDdT/sWsdQldZhOa1tSNvNxRcfdMWLlU/Iq2+YfGtneItk
	S4Y2is8CN20YwKnlCk6ijiHyFHBM54kaWjBBp0ELFOsYolCdKloHrWJDO35rLSN4NIUVNPOSC1M
	ow/Yl9tw22Pcyghu9xFgwggxHb92utt/G7XX/4b/rJ1Nc0TUAJNiHAi3Jh1pER5LrDOOpBnxomr
	puWfNvulIv2kBMO9uHnmO5vmyUbWBSU2ukaPbAZkGCZvZag7FpoiQ+jeYXZAz7WcwE1FxeLFwOW
	QgXtos4WlgrxE8NuBgSpJW5EnmVTJeXaM6cB4=
X-Received: by 2002:a17:903:1b2c:b0:2ea:a2ea:5f62 with SMTP id d9443c01a7336-2eb364b8c96mr87259915ad.24.1793606622268;
        Mon, 02 Nov 2026 00:03:42 -0800 (PST)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392afa5asm23573655ad.72.2026.11.02.00.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 00:03:41 -0800 (PST)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] fbdev: pxafb: initialize IRQ completions before requesting IRQ
Date: Mon,  2 Nov 2026 16:03:32 +0800
Message-ID: <20261102080332.1466689-4-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102080332.1466689-1-matthias.goergens@gmail.com>
References: <20261102080332.1466689-1-matthias.goergens@gmail.com>
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

pxafb_handle_irq() completes command_done when LCSR has LCSR_CMD_INT
set, and an overlay's branch_done when LCSR1 has its branch status bit
set.  Probe requests the IRQ before it initialises either: command_done
in pxafb_smart_init(), where commit 07df1c4fea14 ("[ARM] pxafb: small
cleanup of the smart panel code") moved it, and branch_done in the
overlay setup, since the overlays were added.  If one of those status
bits is already set when the handler is installed, for example because
the bootloader left a smart panel or an overlay running, complete()
runs on an uninitialised completion.

Initialise all completions in a helper called from pxafb_init_fbinfo(),
before the IRQ is requested, and drop the later initialisation.

With the completions initialised early, such an interrupt instead
leaves a completion count with no waiter, which would let a later wait
return before its transaction has finished.  So reinitialise
command_done and branch_done just before starting the transactions they
wait for.

I have no PXA hardware.  In a test build on ARM QEMU that raises the
LCD interrupt early through the real handler, the unpatched driver
crashes in complete() and the patched one does not.  After an early
command interrupt, a later smart-panel flush returned success at once
without the reinitialisation, and timed out with it, as it should when
no further interrupt arrives.

Sashiko, the AI review bot, pointed out the early interrupt while
reviewing a pxafb cleanup.

Link: https://lore.kernel.org/all/20260722081427.413EF1F000E9@smtp.kernel.org/
Fixes: 07df1c4fea14 ("[ARM] pxafb: small cleanup of the smart panel code")
Fixes: 198fc108ee4c ("[ARM] pxafb: add support for overlay1 and overlay2 as framebuffer devices")
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 drivers/video/fbdev/pxafb.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index b889a17e7304..afdcb14f4b42 100644
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
@@ -1281,9 +1283,6 @@ static int pxafb_smart_init(struct pxafb_info *fbi)
 	fbi->smart_cmds = (uint16_t *) fbi->dma_buff->cmd_buff;
 	fbi->n_smart_cmds = 0;
 
-	init_completion(&fbi->command_done);
-	init_completion(&fbi->refresh_done);
-
 	if (!fbi->inf->smart_update)
 		return -EINVAL;
 
@@ -1779,6 +1778,23 @@ static void pxafb_decode_mach_info(struct pxafb_info *fbi,
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
@@ -1835,7 +1851,7 @@ static struct pxafb_info *pxafb_init_fbinfo(struct device *dev,
 	init_waitqueue_head(&fbi->ctrlr_wait);
 	INIT_WORK(&fbi->task, pxafb_task);
 	mutex_init(&fbi->ctrlr_lock);
-	init_completion(&fbi->disable_done);
+	pxafb_init_completions(fbi);
 
 	return fbi;
 }
-- 
2.56.0


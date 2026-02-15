Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B042DECBA
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771163941; cv=none; b=S0BEj0Pjw07hMcYpt06mv/AmA9/82KHWYhPwF9Fzg5mSF6MKYO1Yy+TB+6Lcv3XE9PgMrdLJzdYKYqPuSETRIMAa9gkBXvFshIKqHRG4y7MfVjUpdGAWrrEmRarvGwyFk5+/L3RqoGKC2LXI5Ou8xTq6Nb2TF0kjwrFiCSyY/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771163941; c=relaxed/simple;
	bh=WDPMJYitsaZOczzGc6r7cwWt+IFe7ij1QjyvVhnA2xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOY6mINpq42QmV++TropZ9PQiFbrWeINMTU8yvEE7W+1WgO3DNqUmbZ5O8cXigb6GqOwZgoNylmxpjVB2SLAKrqwzL6ECqzNa7cUuQcjTtct90ELg5SiBZKgWkohmWPviMptIkHfcdsaHmqMn3LoHmBMwvx3vyIMusxnhtn/kJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hPnkR4pa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hPnkR4pa"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4834826e555so24124045e9.2
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 05:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771163938; x=1771768738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rfGoVyH7QzemOXYwDCpxwn3sKTnq0CRHqTEQ4ExGNE=;
        b=hPnkR4paGnOwY3SlDqYD/rnXzNRhUf0AiPUE1t8qX4E05h2SdlpUXRJaQEsK5KKEkT
         dsmWSnd2TPvX8ADdwjGcnGCiyHxH/J9ZTee/xLIUf0t/lDj0fUkBgT1aY/R2mpx9Q/x0
         f5tXxwa1NhUzoYibXR9Vt2o4j8uJ/4C7nKaBkQ3wKrMHmkMGVSxWtR49AhbSYtiFDrVn
         /pMDLD7je34+4GA8lVcFWDZvV/hk9UAH2AZWpO8nPZB46GU85E7ICiyvwzHVGzadTTMP
         xNmHTsiLHJC3CRVmRxGbY5nnp4W8BcZP6LLLe1m0g5rQ+sFQMr25hVtaovkN+DBuvI5I
         9jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771163938; x=1771768738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7rfGoVyH7QzemOXYwDCpxwn3sKTnq0CRHqTEQ4ExGNE=;
        b=kg8WvgcjRBS1kl21e1P50eFnv5/awRVm4KHdBxOyZ3QZA54yAIOf2MKfnlo5YkVpZV
         LFQqBtIM0yoSzR/FqhUteihmEQwbW6UVoU1rkfILliYmfR6Z9xfP/1ftEgxvDQg6y0Dx
         dRrra01rFGXlb9VSv20brYOyEzGTJ2cRsvQ/amI9ZDOvrWpw1Lfhs6nl3HXsmxusFTML
         4Q/3m2Kn1qBFkxd2pFaQzirxVnJAEl5sg7Wv0haljM3GUEAiczYLh4sCwQsYFosoiu3F
         mEmNixjSF4mbEONJXDxtg0WhY2Mvx7MIIZImW6w1eehx4Wky7UyzSqGrmFwld9SDzMcJ
         rb6g==
X-Forwarded-Encrypted: i=1; AJvYcCXvKZyOFcgO7GGg1F7lyksQXpo0cpyPeIwjNk2fj4D8wUcMRNq0fZFk5OUuuR9Kcmsv1jRBdaEtPVz02g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLbFG9cPHyyksBJ/o+Cd1AT8JvnTU7rMX6NKB3pCBx4drPduKN
	kEwyon9x3QF8SUTrzxJSBdyoA7qUMKihVZr5mZ7aDab/yG4bgdzNWHsOLQwo4aUwfAM=
X-Gm-Gg: AZuq6aLUwtHTjdv3LBxlw5Co78Gw5K2T6Y+EMO6PK6oaQ9LBvJr8RCCLdjgzNiiop2A
	LlxLUJQycTAs48KQTuWbwN8gqfTdsumtTCWB2/mP6+AmMUASEmSkRzgD6NMJ9xZgHoaCP/+WqoH
	1h2InWnnSk2WWGs9DHEF3tbNpe/EOtdl4A4JlNSg74hTvovuGy4DMwEdWvzBs26C314MaKDcKoZ
	gYo9jcMjZA9rKi1qfhUc+ZomsgEqJ+KZv1uUk1K0YWvggwO6PZQnxss7v84QAeBVmaip5V2daEe
	leAPmOzLs3CooeXI5LQ1UpYPGI7gGGzFRz7XfbXLdNa8nmz0WwvLcansi5SIDujBWCnSgqKvHTG
	P/Qn2LalTAlRLpBgaclSD3jrXFDuGP0Pqh4bqjkOc6vd/p1S5D2CsBxMigi6BSKGxKj+tG1UUOi
	nrwospbxwg4Qo01HK4RR8EvhzClLVkDVvTuKPMqf4=
X-Received: by 2002:a05:600c:8b61:b0:480:1b65:b744 with SMTP id 5b1f17b1804b1-48379bf7907mr78962345e9.28.1771163937888;
        Sun, 15 Feb 2026 05:58:57 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4834d82a4c4sm625296895e9.10.2026.02.15.05.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 05:58:57 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v4 3/7] fbdev: au1100fb: Use proper conversion specifiers in printk formats
Date: Sun, 15 Feb 2026 14:58:30 +0100
Message-ID:  <3e1577c91f4dacb3cc45baf8edeb33a53cfc0c40.1771163316.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771163316.git.u.kleine-koenig@baylibre.com>
References: <cover.1771163316.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=WDPMJYitsaZOczzGc6r7cwWt+IFe7ij1QjyvVhnA2xI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpkdEL8OYewHuCfLGaJt5OK1OFr60mmRCF1WWKQ VJhHTrsg5yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZHRCwAKCRCPgPtYfRL+ TmwdB/oCQHyznbHbbHG+wytDWTFDuT+/+1ODskvIRCGnMus9zw96fpJ65J+m9vHSBw41WBWCGiu ahUvsPyKc2Qhmf9w//YwFJno25zByYBJy+lEg50OhvMsTqGFhR62p3hCNHEDzsuzUh09Xsx8Oxy wf5TkJZ0rWn/Sjia7Crzr+stvGR1NOO9Hm0d8uF6FcYIZybjnqvpV8kNaXnz0tBZg4UuP4i5as+ gqxEHQ1i8asiNRrKTFmf9s3P0Dc79VAW/dDEEAEfMRbhqyrMTEZQW/G4HGfjgK9hJoHsOE0H9Pm zU5e33oc8UZF9ln4kVT6revmaDywiCtajEOoqBJMA4iLfXoG
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

%zu is the dedicated type for size_t. %d only works on 32bit
architectures where size_t is typedef'd to be unsigned int. (And then
the signedness doesn't fit, but `gcc -Wformat` doesn't stumble over this.
Also the size of dma_addr_t is architecture dependant and it should be
printkd using %pad (and the value passed by reference).

This prepares allowing this driver to be compiled on non-mips platforms.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/au1100fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index b1da51683de7..e43687ac74a1 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -439,7 +439,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	fbdev->regs = (struct au1100fb_regs*)KSEG1ADDR(fbdev->info.fix.mmio_start);
 
 	print_dbg("Register memory map at %p", fbdev->regs);
-	print_dbg("phys=0x%08x, size=%d", fbdev->regs_phys, fbdev->regs_len);
+	print_dbg("phys=0x%08x, size=%zu", fbdev->regs_phys, fbdev->regs_len);
 
 	c = clk_get(NULL, "lcd_intclk");
 	if (!IS_ERR(c)) {
@@ -456,7 +456,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 					    PAGE_ALIGN(fbdev->fb_len),
 					    &fbdev->fb_phys, GFP_KERNEL);
 	if (!fbdev->fb_mem) {
-		print_err("fail to allocate framebuffer (size: %dK))",
+		print_err("fail to allocate framebuffer (size: %zuK))",
 			  fbdev->fb_len / 1024);
 		return -ENOMEM;
 	}
@@ -465,7 +465,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	fbdev->info.fix.smem_len = fbdev->fb_len;
 
 	print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
-	print_dbg("phys=0x%08x, size=%dK", fbdev->fb_phys, fbdev->fb_len / 1024);
+	print_dbg("phys=0x%pad, size=%zuK", &fbdev->fb_phys, fbdev->fb_len / 1024);
 
 	/* load the panel info into the var struct */
 	fbdev->info.var = (struct fb_var_screeninfo) {
-- 
2.47.3


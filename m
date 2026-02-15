Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55E25A64C
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198430; cv=none; b=UnOO/tDtAudgcCNJlXKZY87bmgz2LN+ZWs0C4Iy08f3Ev5OS5kGape83/T3aQzRo/QjvHbfXH+o5H6Pp4riinmLu0x+MkDWw8P/vMIYG2VisOOXbR++1iK15gHs6nTZrioXMbtCGMQN7d3tm0jKU4auJ10e7makFlae9UyEMzF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198430; c=relaxed/simple;
	bh=C+TkgfpREa8zIVzwPsqZ+/CMmjGONBaTrnA3gNijQlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEns3r86GAJkGjrk5t0dgNLGuXS88+i7exHD09B4zGp1YCCQOFqm9V9djEnRZl4cjpCQtjn3d2vbj99sUlD/yCL9ftzOqt1g+jKOwbg8EeZtDA6RsGx2nVQMpTAWgniZM97YCilJlIMDqe6DGQdYiIFTjX2eGb7Qk96v3ktggq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ubBJol5G; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ubBJol5G"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483703e4b08so19819415e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 15:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771198427; x=1771803227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riZ6PWdFfyeNlDheq9J/VZWbSjXQ8eOOU0u+w/mWLKY=;
        b=ubBJol5GLhVaaUALMW7HmBk5QD0ZsTMzuXJlk2iXGh0DAnQ7wMdi87VbDrclgn/cPF
         RkOwaUCdc6yEVZs6aaFzTajQ/Ef042NYhbIgZByv9k/Nfej1ogoq0ZFR8pASBjGVs6hU
         O7dOUeOdbCPEtJzNteRTPLO8QnOdXvjiMOoB0rjFkwX9+GEgLg629l4t0evlujBwSkGZ
         JT7EXksUsseYW5H4x1em+8zqsAVCPlX9qqvTg5PGe2C5ct34V/Cv9OaetRta+xfXqDYY
         3oRC4R3tBUahk9oNVqj/57oeMTRJp13kW7nbpC3T+xYB+ynQj+/h8Uo1RZbgzLSSSiic
         5Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771198427; x=1771803227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=riZ6PWdFfyeNlDheq9J/VZWbSjXQ8eOOU0u+w/mWLKY=;
        b=EmJRpY1y2ZoTDazSW/xabaki1D+OwfagEv+92xjWUcKERFbK3U67Nnh9N4ZJrS1iKY
         Q8uOnqHOBlwb9TYPA3VXN3HHn/NFOezQ1j30nMpCDXgpulbhqTGCbsCW6RRh8UnFPTpe
         xJU3EBncM4obEnjJ+tFZ0f1l654Z+lP85bn/WPBoAp0K5OqFkEYVNjmEC9EnaAG/h5nR
         VE8+wAm6erZ+IYquUZXcg9VEA5Mok/0r5rpXDMd5GTZXuDo2T5lnqhmrrNCWFN78WUX3
         bYLxRrJ+c97WIDiZJd4oTN+UjnWQ2nxj0jogB8WvfrPqhM6bzY2eGtkx14LGgIKhe2+V
         7MiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeatedxMg1aLy4c/GTWNPLmcIiuwEvux9pbyvjA326KgmF893kIMioxLs5KkndpaiSR99oJKPbuvMcuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJdZxaPN8pdu6heJ5U5Gc92RZTdBOTVdMeM+rqIH0VphBUs+V9
	4BceinEhWnyhBVPaJo1pwauwxTiqb4cTQ+A5n5lp1ib1CptbuoxXduVz/aboIlDY1T4=
X-Gm-Gg: AZuq6aJ1nQPuPYNe8YTAV/rxiYLWm3LtLGivcVCJlR/RoHp9Rb86njfrtW8WTnzB9cN
	jqWe6Vkke4EAb3IpDrRk+EUwWWfLSoe6Eu1r/M5zLqs1UGGiL3gJi4Iqg/aV8OWUYUztkfaEd5d
	P5ofrUEPMAruBitcLcFIeChc5LpN5n0fvgNdNMBWCWLWkN0upcEcmzIc7saBInhQjVyiaiOdGEm
	/jVUgjoil1+0inO3FjjGpEU4zBdLTMR6al+dq0CJ+h9cQFoInhrWIpAVuDID0DUnS09ETFBw3VQ
	4QfsJHpvsjvD4vpCYsvObNFSyrfXoyqTKoTw/LdbIGXPT6xJXho81w8Gh4yFNFynMhbX1hYuJD3
	/+dYevf9nL51YESnWPkB55Wg/6zrecOA0k9tQk3dhVpPMjpQ9rPhcoms5D7r45qdkz/GBgjliTT
	C03aBtP6AnlXbWfUiZxAavkt0GmOtn
X-Received: by 2002:a05:600c:8b32:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-48378d7250emr126740185e9.8.1771198427340;
        Sun, 15 Feb 2026 15:33:47 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43796ad112bsm22934376f8f.36.2026.02.15.15.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 15:33:47 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 3/7] fbdev: au1100fb: Use proper conversion specifiers in printk formats
Date: Mon, 16 Feb 2026 00:33:19 +0100
Message-ID: <67e84da83038879b933c3c40a3715c2ca82a4813.1771198101.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771198101.git.u.kleine-koenig@baylibre.com>
References: <cover.1771198101.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=C+TkgfpREa8zIVzwPsqZ+/CMmjGONBaTrnA3gNijQlo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpklfEdt8klR1hZb6Sfbm5eRG4XF5wQH2rt73y2 XmGiszbXzeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZJXxAAKCRCPgPtYfRL+ TqQFCACcqZCdYcACZnKLN5Af2fitxAn5w9sPoYdRoIUuln7Qx55503VKvU5tCcQoeejdWT2ccR5 89msNoXlP8uUh9/B/+1Pa5orfqRDdC7aA6u0BA8RowS72J3xrGUSbZWa1EArGfxR+5l7GQVWfdx boWk1NhDNVTGUNXX8taTGpm7k8DTSS2HTuTM2oeKzAGn3zxWfEMP9q4ALSZT7dWR9Oox0q+vY2m f/f/bXYI0UarJsZNKf8gmVuKO/vXFhkjy9kjbNIrUKs0UcfSjgXwwW+PL9RN4s/8eCJrrfY7ktm DqmeQ8rwnXcgwEIi9E6OYzT0W62r5SGpXdSsfjZJBslcWaBS
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

%zu is the dedicated type for size_t. %d only works on 32bit
architectures where size_t is typedef'd to be unsigned int. (And then
the signedness doesn't fit, but `gcc -Wformat` doesn't stumble over this.
Also the size of dma_addr_t is architecture dependent and it should be
printkd using %pad (and the value passed by reference).

This prepares allowing this driver to be compiled on non-mips platforms.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/au1100fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 1abaa8e81315..398375793f57 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -440,7 +440,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	fbdev->regs = (struct au1100fb_regs*)KSEG1ADDR(fbdev->info.fix.mmio_start);
 
 	print_dbg("Register memory map at %p", fbdev->regs);
-	print_dbg("phys=0x%08x, size=%d", fbdev->regs_phys, fbdev->regs_len);
+	print_dbg("phys=0x%08x, size=%zu", fbdev->regs_phys, fbdev->regs_len);
 
 	c = clk_get(NULL, "lcd_intclk");
 	if (!IS_ERR(c)) {
@@ -457,7 +457,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 					    PAGE_ALIGN(fbdev->fb_len),
 					    &fbdev->fb_phys, GFP_KERNEL);
 	if (!fbdev->fb_mem) {
-		print_err("fail to allocate framebuffer (size: %dK))",
+		print_err("fail to allocate framebuffer (size: %zuK))",
 			  fbdev->fb_len / 1024);
 		return -ENOMEM;
 	}
@@ -466,7 +466,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	fbdev->info.fix.smem_len = fbdev->fb_len;
 
 	print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
-	print_dbg("phys=0x%08x, size=%dK", fbdev->fb_phys, fbdev->fb_len / 1024);
+	print_dbg("phys=0x%pad, size=%zuK", &fbdev->fb_phys, fbdev->fb_len / 1024);
 
 	/* load the panel info into the var struct */
 	fbdev->info.var = (struct fb_var_screeninfo) {
-- 
2.47.3


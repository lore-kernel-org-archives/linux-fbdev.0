Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D232B40A94A
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500373; cv=none; b=pgy7odEEeBHePeRLGtR/gNFe19hMlJXwBqVxEztakUJoU6HpwJesMFjwE1Gcq9f/sT0XxY/2WogkgllMlz6H8N+myGKZfjAxvY56IruLeh05mmTD3URcFpXZjsGzzpopvZFNQIkMtKgy6UMfEGMrtHLNPx6Haow5g4M/4e2PAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500373; c=relaxed/simple;
	bh=ffGwx378rSebpgRqlD2a87sBNQEwXVCXpUJaIpASTHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrRz8XArv2lmJc+sRE2W1n3mkgROKJzzdHbHDEKPAlJhRik3bPgAG9xNzS/Sxa2sEvGOTVpIz1NYA9IeEz4SJTcknYDwPKbjb70yt5M1RjUTtix+tiVyDiuLEbRbju71p+ipEVwhAN30BWt8Fy7qUe5MJilSCNdwd74nqkNK34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=v37reCcu; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="v37reCcu"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso793010a91.1
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 05:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785500370; x=1786105170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h1Ta837wxPAUZQOdiOlroOxLsJQaIrBUrobqEoKBc/U=;
        b=v37reCcurO3QGKWoNFQky3UyD0Ur3qG/TLcUr1tL5X+pUsQcXuw4+b6a0I3yB4SjP2
         KtZAG/u5XFPgIcBLV9Am1xc1W/H2Ahp2JX/F8/9UqI1NkW0hWnBuUl5izvxuSKBj1z/y
         HVHMq40o+fr2dphqHbAfmSa1XDyK28BU67NXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785500370; x=1786105170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h1Ta837wxPAUZQOdiOlroOxLsJQaIrBUrobqEoKBc/U=;
        b=tDo9w4s1tf2UWsqVAVe+9cvln38wBSJUEBGVDCWN2Zr4NgLGG7bhpBTFWhJQqwjcND
         2+GnXdT1tahHFfDzp6G71xGFD8tfyHmJHDzLdYH1x6d2Pu4dWKcFTg/cBobuqvnwAGu9
         mB08Qcr6kzXpRuYk9etEdNRABa0zJBBM5XBU6NENc9fAsoQWaJC6kgVvHN5AurmTTgp3
         PzBWcKdIthcwSF3iZJ7x2Ribj/cJ34F+zTAm930TcAyOfsFqjFEYqpu7qHMOENqvGIHs
         UUdNhNNPMk9CFGGSU3ytalqEDRVYUgGQSH2vcmByoKMgpaVgD3vieXlZYCIHzmEeRcx/
         zFSQ==
X-Gm-Message-State: AOJu0YwxeBU3X53pL14ibaEnQAqOdqBicyAkE05cH9wfnh01E+saBpMn
	9SfQoqAboytZc7yaRQ2Dh2Uv0EtpDrVHaJBGtAw5YqzgaXtmpcDhe7pCjz/WhMwWiho=
X-Gm-Gg: AR+sD10cP5YVNSyH9ZOAyQaSJtz+pWIPYv+kbkTrWtkJa+YaOzBBAdm8yhMrdv+6m1T
	bmVDwq46ZlxpfdBeZMiFuZ2m2++DFE8pfxxFvzy3zpDFTB4xg/Uq48LLo/yiAjitZWmRFcCywkG
	ntuQIjR83+BfxJEcGQvDv7wTmVR7m6ivPUyKTOg1OUUtQ+v+8z+ICPCzaEKbqECMaslT6iwiNM4
	f7VqKeW8qS6BghMw08K3oxhTlcslapIblmXV3DnvyUuKxZ4Nv9xqRqUb4V0p33hP7C9Od/hrj8X
	fvmZZKtFqM1QAv5lpzuKxVBOi59iSBPuOhfPa2dwZZitVRuUNp6m9PT3117Qp/gzd0ZogVhmDoL
	WlAFefA1Rd2jNpy6tIMIti52DNQva0jQNRc3Or44u7k2MxiF2HHFKbKhW/avOzRuENJyK7jegHH
	Kc4GOpM6ilRubL8/kPrB2MqjvMJCS4gFabx+bMjyImIZVlX5h14Uo=
X-Received: by 2002:a17:90b:1e41:b0:381:50ab:1594 with SMTP id 98e67ed59e1d1-38fb13ecd0bmr1608483a91.27.1785500369713;
        Fri, 31 Jul 2026 05:19:29 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:77cc:841c:1fc1:22d4])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-38fb2b8c5c5sm321981a91.4.2026.07.31.05.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:19:28 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 3/5] fbdev: tdfxfb: Manually boot unbooted cards
Date: Fri, 31 Jul 2026 21:19:12 +0900
Message-ID: <20260731121915.3362232-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731121915.3362232-1-daniel@0x0f.com>
References: <20260731121915.3362232-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the card is detected as being unbooted it isn't too difficult
to use the config table in its BIOS to fire it up so do it.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 40 +++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 465c46edf6e7..4d92ab5b5430 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -67,6 +67,7 @@
 #include <linux/aperture.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
@@ -418,9 +419,13 @@ static bool tdfxfb_get_bios_cfg(struct pci_dev *pdev,
  * Try to work out if the card was booted or not, just checks if
  * one of the dram config registers matches what is in the config
  * table if there is one.
+ *
+ * If we have a BIOS config table attempt to manually boot the
+ * card if needed.
  */
 static int tdfxfb_hw_init(struct fb_info *info, struct pci_dev *pdev)
 {
+	u32 mempll, gfxpll, draminit0, draminit1, miscinit1, dram_mode;
 	struct tdfx_par *par = info->par;
 	struct tdfx_bios_cfg cfg;
 	bool have_cfg = tdfxfb_get_bios_cfg(pdev, &cfg);
@@ -436,10 +441,39 @@ static int tdfxfb_hw_init(struct fb_info *info, struct pci_dev *pdev)
 	if (tdfx_inl(par, DRAMINIT0) == le32_to_cpu(cfg.draminit0))
 		return 0;
 
-	dev_err(&pdev->dev,
-		"Card hasn't booted and is unusable\n");
+	dev_info(&pdev->dev,
+		 "Manually booting card using config table\n");
+
+	mempll = le32_to_cpu(cfg.pllctrl1);
+	gfxpll = le32_to_cpu(cfg.pllctrl2);
+	draminit0 = le32_to_cpu(cfg.draminit0);
+	draminit1 = le32_to_cpu(cfg.draminit1);
+	miscinit1 = le32_to_cpu(cfg.miscinit1);
+	dram_mode = le32_to_cpu(cfg.sgrammode);
+	tdfx_outl(par, PCIINIT0, le32_to_cpu(cfg.pciinit0));
+	tdfx_outl(par, AGPINIT, le32_to_cpu(cfg.agpinit0));
+
+	/* memory clock, and the graphics clock if the card wants one */
+	tdfx_outl(par, PLLCTRL1, mempll);
+	if (gfxpll)
+		tdfx_outl(par, PLLCTRL2, gfxpll);
+	/* flush posted writes */
+	tdfx_inl(par, PLLCTRL1);
+	/* PLL lock */
+	udelay(100);
+
+	tdfx_outl(par, MISCINIT1, miscinit1);
+	tdfx_outl(par, DRAMINIT0, draminit0);
+	tdfx_outl(par, DRAMINIT1, draminit1);
+
+	/* SDRAM/SGRAM wake up: load the mode register */
+	tdfx_outl(par, DRAMDATA, dram_mode);
+	tdfx_outl(par, DRAMCOMMAND, 0x10d);
+
+	tdfx_outl(par, LFBMEMORYCONFIG, 0x00001fff);
+	tdfx_outl(par, MISCINIT0, le32_to_cpu(cfg.miscinit0));
 
-	return -ENODEV;
+	return 0;
 }
 
 static void do_write_regs(struct fb_info *info, struct banshee_reg *reg)
-- 
2.53.0


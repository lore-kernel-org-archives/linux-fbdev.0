Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7C283FE6
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Jul 2026 04:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784177195; cv=none; b=fmi/QXlFCCBa2jnytil+eTgOEfnRVffPxEx95dKwfPl41JCjWsaYzRl2nNj1UWnP00Gll5jvUz8rxJDGgTD+Hanj3pnRRJUeXpNW6ku3xkmWYxy4EDMrqXja0RfflxZUlK2hMZnPuVRxGthU7izWtajBggRk08e8efMBBuf091U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784177195; c=relaxed/simple;
	bh=jLsncUXgsxf2LHonIcXGrctbpjoU4r/DWZEFpHjfutg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VhIXWT6h8dL0IWgAON0zYr4Se+NLKObZ6Z8F6HXL6FAIvURrxRFMigprJsgMtUOSfLLdZoo15OUyjeJmh/9ImR3qSgCi4c6Z3HHo5MSV+XiLrNT44A7OOXWVqJDfp9/3URqf6yfTi1Aqw0Lsk7g8bj86IJbpCLdqrPJmdi0j0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgA9lj3x; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgA9lj3x"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2cc8ed77bbcso33310495ad.0
        for <linux-fbdev@vger.kernel.org>; Wed, 15 Jul 2026 21:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784177192; x=1784781992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=enEY90CGFOJDQcplxBar2hJV6yl0T0mtmkQgs1NewkI=;
        b=RgA9lj3xKgJzkPZPSji9PAxw2oC+aCzAYFt2AYTV0doYyQ/aXZHdPPpMZXgDotYCjC
         zM0AvcCLOT7ztvjGos4k8QqhgXMK6avSZcriS26brHedCRGdcdoXddZUbnN73Mnb3+8L
         bRsaMkcq7hvhVwo4KOITB+9/veePzOA35JIOPZDmWgchjc+NumuVYR4FdofOic6K8wO1
         sPNTSfTwSzkghMLFOelFQjENJUCKn+0BUmYYTtb0ZIro4nDwpy0IhgxMqWjsvPReluAL
         bvdL0gU9EDX2r+Uu612PhFH8N6+Ukh3hzR9VhrA2+2lWwLN5X84+gz2O/b3CTj/5ps2T
         Hm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784177192; x=1784781992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=enEY90CGFOJDQcplxBar2hJV6yl0T0mtmkQgs1NewkI=;
        b=dhXNdQdWz4Epl4HEyvzpfBM9E44kjJ2YXTA4pCSvnvhGIStSuvdYv75u7Sa3NPFWTw
         Y7aKcll8RWg3uRbbm1qeHWkrIWxdsKtj+Em8g7R0zhW5XnptQITTLzghhHNn3Wkyp/9a
         8MQ4MPSFiOwlAD4ws5iJXRyOlB8MsD2egIwwNlv+nbAkYQRrOxFr+HEsL3PgFnjIIqy7
         Q6Ugu2bYsoRZLSEjd4lEZrekwd5TNhHV2RjNSkCjO1k/Wv/uoxwwnnpUqxlvSCyO/JFV
         Ic03gPRLIcieGSK1kY6CKpIuv3jlhmvRZW9m8XBjO9ZnNXpyNAexqxx60xkGIVqzmQVt
         A7fw==
X-Forwarded-Encrypted: i=1; AHgh+RrGwl+AlkhHC6zUkDSAHm6s/u6P51tJQ+AUqnV92+9IM0QiEufHwNUOOp0I5rjdYV/ca/R24fweDvtw/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUhKQZlhTiySLrl3N633B+AGvKdXdfAp5gHROVs2ZotvVL9XVY
	asjhkF+KdwWsc6JZaZ02s7V+lDdwfuURYf+hQRBcQ9+uyVAz5xyxfctp
X-Gm-Gg: AfdE7clCoRJMcJ4X2NuxtqabGPcSmGaF1cfF/UlkYCQa6QRWdT840Tj21MTT+gLrau7
	aFbjGzsVIS0k7oQRcvC0vscSMAy/+d6PTY/nhB8DHmd+M14qzrnf9/LaeV8s42PL/Vgus0xGEkP
	2BfTssJALhm8eUaMt8H3vwydS7jZKjckac1WfLe9KXNoOd1mnKUnYjvYAPUFFcjaSsgTsuwlDr4
	ykmvUd4Hpj7nxSfqRsAtsyDFRnaKYSz4ZigJRo7kCzhCLqQ7KTIZTeLE7xAPf66EadsYEVRMoaH
	cz+T+142tvSmm4QZs0ENDB/85P704pRXeLfP+k57qbIuUmspWLXHK3hnt7Z79N87ollrw+rzL3C
	5Lony6w0KFeWj5kE5G0llRIALvk3YPO1kLvfJ0wkLyriDHFUPxxPnrzpRxWUiPVRVqrqRWrvLSH
	n/bn7mSrjXlW2H16LH5/Z7M4BU40P/bWyw2w==
X-Received: by 2002:a05:6a20:eec2:20b0:3c3:75ff:95b6 with SMTP id adf61e73a8af0-3c375ff9bc9mr2981268637.31.1784177192013;
        Wed, 15 Jul 2026 21:46:32 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e538368sm10282930eec.12.2026.07.15.21.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 21:46:31 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Carpenter <error27@gmail.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] staging: sm750fb: remove unused set_all_eng_off field
Date: Thu, 16 Jul 2026 04:46:13 +0000
Message-ID: <20260716044613.2659-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The set_all_eng_off field is only initialized to 0 and is never set by
any caller.

Remove the unused field together with the dead cleanup path guarded by
it.

No functional change intended.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 27 ---------------------------
 drivers/staging/sm750fb/ddk750_chip.h |  7 -------
 drivers/staging/sm750fb/sm750.c       |  1 -
 3 files changed, 35 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 0bb56bbec43f..aa78d0bc1d87 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -263,33 +263,6 @@ int ddk750_init_hw(struct initchip_param *p_init_param)
 		poke32(MISC_CTRL, reg);
 	}
 
-	if (p_init_param->set_all_eng_off == 1) {
-		sm750_enable_2d_engine(0);
-
-		/* Disable Overlay, if a former application left it on */
-		reg = peek32(VIDEO_DISPLAY_CTRL);
-		reg &= ~DISPLAY_CTRL_PLANE;
-		poke32(VIDEO_DISPLAY_CTRL, reg);
-
-		/* Disable video alpha, if a former application left it on */
-		reg = peek32(VIDEO_ALPHA_DISPLAY_CTRL);
-		reg &= ~DISPLAY_CTRL_PLANE;
-		poke32(VIDEO_ALPHA_DISPLAY_CTRL, reg);
-
-		/* Disable alpha plane, if a former application left it on */
-		reg = peek32(ALPHA_DISPLAY_CTRL);
-		reg &= ~DISPLAY_CTRL_PLANE;
-		poke32(ALPHA_DISPLAY_CTRL, reg);
-
-		/* Disable DMA Channel, if a former application left it on */
-		reg = peek32(DMA_ABORT_INTERRUPT);
-		reg |= DMA_ABORT_INTERRUPT_ABORT_1;
-		poke32(DMA_ABORT_INTERRUPT, reg);
-
-		/* Disable DMA Power, if a former application left it on */
-		sm750_enable_dma(0);
-	}
-
 	/* We can add more initialization as needed. */
 
 	return 0;
diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index ee2e9d90f7dd..2a13debc179f 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -76,13 +76,6 @@ struct initchip_param {
 	 */
 	unsigned short master_clock;
 
-	/*
-	 * 0 = leave all engine state untouched.
-	 * 1 = make sure they are off: 2D, Overlay,
-	 * video alpha, alpha, hardware cursors
-	 */
-	unsigned short set_all_eng_off;
-
 	/*
 	 * 0 = Do not reset the memory controller
 	 * 1 = Reset the memory controller
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index a2f244878f85..039e2033f84e 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -837,7 +837,6 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	sm750_dev->init_parm.mem_clock = 0;
 	sm750_dev->init_parm.master_clock = 0;
 	sm750_dev->init_parm.power_mode = 0;
-	sm750_dev->init_parm.set_all_eng_off = 0;
 	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
-- 
2.43.0


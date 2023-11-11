Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4021B12B7D
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="j9/uP+Xd"
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE733C05
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:42 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9e5dd91b0acso267640266b.1
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699361; x=1700304161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuBW6agG70lIoCkGnVCWEFfcl6uwNB9B1+pa2Yxc8Go=;
        b=j9/uP+Xdw1Pq1sOD1h6jzT5RhRDbh7QbdYHMsw0DFpoZJwoJziQuHef1h0jrjFE5O1
         WjTyTx93aPwRDuSOGHMq/qIRSEQUQOSX0FT8FN7o3TEEwNMqp+hVKAuUdAMbRJL2g5LJ
         qWjxsbHnyCLi610M+A9iCZdBac+AZ/WG/hXQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699361; x=1700304161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuBW6agG70lIoCkGnVCWEFfcl6uwNB9B1+pa2Yxc8Go=;
        b=b53ZC+OoSbzF8DKp6rmX4nhzacVP43euTVi+K+X5MdHK3jWkpZcimXBLFUVLRviZeH
         MMRneWic4dyHzUxdhxOT2t58jrbNqs7iTVDah7N1BsfG28m+Vhhcl1Szro+Cg8CvtOQ7
         IvLcQfOz/4BLUXs0NWoKYGeQgxlbvvW+Z6dUAbydPRuvlxrVKvMXg3+bPc2UccXxq5tV
         6S0vyNsjuwUHy69HIWcAkqmUOwK0QAshJNJM6fRucuFwz8iNNX90WOOzDnyScMSr/Adf
         r3FAhxNhiHz0cViJ0RY/vvg0kNarFSgWWJrRl5kG/e92gsvWzXRy+AI01QdejbQq4+3Z
         J8fQ==
X-Gm-Message-State: AOJu0YyHHiVk7fiRKWvypg+bLQztKisUhG2ODL8YEslHPbxtxNGPqFTv
	NbOFMGc1SCGrJrv7J+4qLBsLSg==
X-Google-Smtp-Source: AGHT+IFbVhFnBfDEfeThETUmx79l/FqCUdUKdBP1kZUSVO8UVeOwurpqW+LCgtJFLlAn08avd0DyXw==
X-Received: by 2002:a17:906:3c9:b0:9e6:59d5:7a86 with SMTP id c9-20020a17090603c900b009e659d57a86mr915376eja.57.1699699361285;
        Sat, 11 Nov 2023 02:42:41 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:41 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Helge Deller <deller@gmx.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 04/10] fbdev: imxfb: replace some magic numbers with constants
Date: Sat, 11 Nov 2023 11:41:53 +0100
Message-ID: <20231111104225.136512-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
References: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch gets rid of magic numbers replacing them with appropriate
macros.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index b7ef43a7930a..485e57fa9389 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -89,6 +89,7 @@ struct imx_fb_videomode {
 #define PCR_BPIX_12	4
 #define PCR_BPIX_16	5
 #define PCR_BPIX_18	6
+#define PCR_PCD_MASK	GENMASK(5, 0)
 
 #define LCDC_HCR	0x1C
 #define HCR_H_WIDTH_MASK	GENMASK(31, 26)
@@ -414,8 +415,8 @@ static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	pcr = (unsigned int)tmp;
 
-	if (--pcr > 0x3F) {
-		pcr = 0x3F;
+	if (--pcr > PCR_PCD_MASK) {
+		pcr = PCR_PCD_MASK;
 		printk(KERN_WARNING "Must limit pixel clock to %luHz\n",
 				lcd_clk / pcr);
 	}
@@ -444,7 +445,7 @@ static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	}
 
 	/* add sync polarities */
-	pcr |= imxfb_mode->pcr & ~(0x3f | (7 << 25));
+	pcr |= imxfb_mode->pcr & ~(PCR_PCD_MASK | PCR_BPIX_MASK);
 
 	fbi->pcr = pcr;
 	/*
-- 
2.42.0


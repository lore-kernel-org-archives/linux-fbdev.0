Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76B12B92
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UNBvDhYA"
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC064228
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:48 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-9e1fb7faa9dso458253366b.2
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699367; x=1700304167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXZvMG+ePha/xCPPyQSZcW7mIHQVo6pfDhdFQ8Ys4tc=;
        b=UNBvDhYAIRvg6gLaB/0hwwz+OB45vtUOomtc0ASMSf/2BNtOy+ib2yl+sBpspCqFrm
         adlfglJ/YKksfbBEOmmqC9u6aqHUp2Z12RNs5IQ5s34jFhoEXEyBwIvNprrc8IE0JSvg
         IGGYWW9UB1N334JsuA0OcMXucQcGfw+drl+Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699367; x=1700304167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXZvMG+ePha/xCPPyQSZcW7mIHQVo6pfDhdFQ8Ys4tc=;
        b=YBxaQHbml8soXXTBQkxNOpmjz0n72fnuNd5s2EKJvFF4s2bOxXP8/6hRxA9eCTU9GS
         YmgxzyidwTS2KbFh3ypfLiuAQQ7LVqdm9TkaMqWiqzJK4jilAB6J2JtqXPfd6vZEnVqf
         UKur6OUFG2oTBqS87VnEKakfrP0IZod+CwiY5eJ31ZPWopqWUSXDQdvUtnY4WjTn2ORg
         TgnIQ1Eb1x+WpcsR+nB8z6molYbUk7nGyHE4LHo9Xb48LECq6faL323Wh4o8GmRbhaoE
         bdKAcB5rvTwe84/1gizMs5tK//UIZJtEKS2Pe+w3d8PBUijKonLL0tU6DwYPKJEigp3p
         +Lkw==
X-Gm-Message-State: AOJu0Yx/Q1XGUvZR2Tq8GH3rV0CeZQMZ8byRt8bqWnWELJgmTGQ0oJuM
	9I0jYf52Id7bDQXNB91DfqkjEQ==
X-Google-Smtp-Source: AGHT+IGJZcFy9OdyadzV+Qr9dejIzMtNTDEhCcEQriAhe7EtSGvFTDpXzYmEJXyYAtgH1pYC278gVQ==
X-Received: by 2002:a17:906:fa9b:b0:9dd:6664:1a3a with SMTP id lt27-20020a170906fa9b00b009dd66641a3amr1013488ejb.51.1699699366905;
        Sat, 11 Nov 2023 02:42:46 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:46 -0800 (PST)
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
Subject: [PATCH 08/10] fbdev: imxfb: Fix style warnings relating to printk()
Date: Sat, 11 Nov 2023 11:41:57 +0100
Message-ID: <20231111104225.136512-9-dario.binacchi@amarulasolutions.com>
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

Resolve the following warning reported by checkpatch:

WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...

This made it necessary to move the 'fbi->pdev = pdev' setting to the
beginning of the driver's probing.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index ad293dc44dbb..a0172ff75c46 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -414,8 +414,8 @@ static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	if (--pcr > PCR_PCD_MASK) {
 		pcr = PCR_PCD_MASK;
-		printk(KERN_WARNING "Must limit pixel clock to %luHz\n",
-				lcd_clk / pcr);
+		dev_warn(&fbi->pdev->dev, "Must limit pixel clock to %luHz\n",
+			 lcd_clk / pcr);
 	}
 
 	switch (var->bits_per_pixel) {
@@ -628,28 +628,28 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 
 #if DEBUG_VAR
 	if (var->xres < 16        || var->xres > 1024)
-		printk(KERN_ERR "%s: invalid xres %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid xres %d\n",
 			info->fix.id, var->xres);
 	if (var->hsync_len < 1    || var->hsync_len > 64)
-		printk(KERN_ERR "%s: invalid hsync_len %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid hsync_len %d\n",
 			info->fix.id, var->hsync_len);
 	if (var->left_margin < left_margin_low  || var->left_margin > 255)
-		printk(KERN_ERR "%s: invalid left_margin %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid left_margin %d\n",
 			info->fix.id, var->left_margin);
 	if (var->right_margin < 1 || var->right_margin > 255)
-		printk(KERN_ERR "%s: invalid right_margin %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid right_margin %d\n",
 			info->fix.id, var->right_margin);
 	if (var->yres < 1 || var->yres > ymax_mask)
-		printk(KERN_ERR "%s: invalid yres %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid yres %d\n",
 			info->fix.id, var->yres);
 	if (var->vsync_len > 100)
-		printk(KERN_ERR "%s: invalid vsync_len %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid vsync_len %d\n",
 			info->fix.id, var->vsync_len);
 	if (var->upper_margin > 63)
-		printk(KERN_ERR "%s: invalid upper_margin %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid upper_margin %d\n",
 			info->fix.id, var->upper_margin);
 	if (var->lower_margin > 255)
-		printk(KERN_ERR "%s: invalid lower_margin %d\n",
+		dev_err(&fbi->pdev->dev, "%s: invalid lower_margin %d\n",
 			info->fix.id, var->lower_margin);
 #endif
 
@@ -701,6 +701,7 @@ static int imxfb_init_fbinfo(struct platform_device *pdev)
 
 	memset(fbi, 0, sizeof(struct imxfb_info));
 
+	fbi->pdev = pdev;
 	fbi->devtype = pdev->id_entry->driver_data;
 
 	strscpy(info->fix.id, IMX_NAME, sizeof(info->fix.id));
@@ -1044,7 +1045,6 @@ static int imxfb_probe(struct platform_device *pdev)
 	lcd->props.max_contrast = 0xff;
 
 	imxfb_enable_controller(fbi);
-	fbi->pdev = pdev;
 
 	return 0;
 
-- 
2.42.0


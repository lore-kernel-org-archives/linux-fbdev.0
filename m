Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133712B78
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ONatCP+N"
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172993C05
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:39 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-9e62ab773f1so215570866b.0
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699357; x=1700304157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eutcu8nha5gIvSO1Nw/orY10THf/Z0yjX5SxOR1EIyg=;
        b=ONatCP+NCjimx7glVaUqlVQ1ccgIpvANjCL1+dniTAcpHf0/dDPx1lvfu8g8QnQfus
         PglkSM7SxDlHi3rMtUarf7m0UJBvQ2lL3yJ6Hjr5Zzbp6pn6Qkm7eT1LCK+YiIm0IspF
         owGlYdVDDr+VxNWkxLBIPVFmpsgOCZ6WaYypw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699357; x=1700304157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eutcu8nha5gIvSO1Nw/orY10THf/Z0yjX5SxOR1EIyg=;
        b=A2QZFjbM/pDPNwv9yewTEHfBZ1stpUI3dU8dSmZ3sQK4aUzMILEFOco2AkIL7TTW1X
         uSo8wm2hOV59aufDtWIq5rtcpHEHsMUxoeeKeyMeJ+fRElJ5tmQ3PgG5AqYBjH9z+urc
         ZWvKkFex9bZZcJVicoejo8OZEG6G0zZQ3vvrSfUS5E+Y32vZqvCWkOoEexS8yvsS+9dv
         kmt+SMLV0tpO/+ZKa7PXNKEOM9C9RO6UdcDHazatvm9iPTFknmKwSLcdFGgzSYzwoF2R
         D/dt6bvE1k7SKaBP9AJxEZZmN+Uere0CP89DZeEQbDrnh7+kF2AgupCSkXH7HMpMczAe
         Mvxw==
X-Gm-Message-State: AOJu0YyCZOq4wKHyLfJdjIwHIQwUsvWjYKZ5/pCWSPzvxtwdOHV0/0m9
	ifyHjFEfEfT88EjuCyxu5wl7ww==
X-Google-Smtp-Source: AGHT+IFaeH1R8CrvRx8lpT+f3/8b10gmDt0Mv/InNxCSXdSMqZkc1Dynsl2CrxZY/kuNg5o1BYLkuA==
X-Received: by 2002:a17:906:4742:b0:9bf:4915:22ca with SMTP id j2-20020a170906474200b009bf491522camr1072967ejs.45.1699699357215;
        Sat, 11 Nov 2023 02:42:37 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:36 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Martin Kaiser <martin@kaiser.cx>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 01/10] fbdev: imxfb: fix left margin setting
Date: Sat, 11 Nov 2023 11:41:50 +0100
Message-ID: <20231111104225.136512-2-dario.binacchi@amarulasolutions.com>
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

The previous setting did not take into account the CSTN mode.
For the H_WAIT_2 bitfield (bits 0-7) of the LCDC Horizontal Configuration
Register (LCDCR), the IMX25RM manual states that:

In TFT mode, it specifies the number of SCLK periods between the end of
HSYNC and the beginning of OE signal, and the total delay time equals
(H_WAIT_2 + 3) of SCLK periods.
In CSTN mode, it specifies the number of SCLK periods between the end of
HSYNC and the first display data in each line, and the total delay time
equals (H_WAIT_2 + 2) of SCLK periods.

The patch handles both cases.

Fixes: 4e47382fbca9 ("fbdev: imxfb: warn about invalid left/right margin")
Fixes: 7e8549bcee00 ("imxfb: Fix margin settings")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 84201c9608d3..7042a43b81d8 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -42,6 +42,7 @@
 #include <video/videomode.h>
 
 #define PCR_TFT		(1 << 31)
+#define PCR_COLOR	(1 << 30)
 #define PCR_BPIX_8	(3 << 25)
 #define PCR_BPIX_12	(4 << 25)
 #define PCR_BPIX_16	(5 << 25)
@@ -150,6 +151,12 @@ enum imxfb_type {
 	IMX21_FB,
 };
 
+enum imxfb_panel_type {
+	PANEL_TYPE_MONOCHROME,
+	PANEL_TYPE_CSTN,
+	PANEL_TYPE_TFT,
+};
+
 struct imxfb_info {
 	struct platform_device  *pdev;
 	void __iomem		*regs;
@@ -157,6 +164,7 @@ struct imxfb_info {
 	struct clk		*clk_ahb;
 	struct clk		*clk_per;
 	enum imxfb_type		devtype;
+	enum imxfb_panel_type	panel_type;
 	bool			enabled;
 
 	/*
@@ -444,6 +452,13 @@ static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	if (!is_imx1_fb(fbi) && imxfb_mode->aus_mode)
 		fbi->lauscr = LAUSCR_AUS_MODE;
 
+	if (imxfb_mode->pcr & PCR_TFT)
+		fbi->panel_type = PANEL_TYPE_TFT;
+	else if (imxfb_mode->pcr & PCR_COLOR)
+		fbi->panel_type = PANEL_TYPE_CSTN;
+	else
+		fbi->panel_type = PANEL_TYPE_MONOCHROME;
+
 	/*
 	 * Copy the RGB parameters for this display
 	 * from the machine specific parameters.
@@ -596,6 +611,7 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 {
 	struct imxfb_info *fbi = info->par;
 	u32 ymax_mask = is_imx1_fb(fbi) ? YMAX_MASK_IMX1 : YMAX_MASK_IMX21;
+	u8 left_margin_low;
 
 	pr_debug("var: xres=%d hslen=%d lm=%d rm=%d\n",
 		var->xres, var->hsync_len,
@@ -604,6 +620,13 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 		var->yres, var->vsync_len,
 		var->upper_margin, var->lower_margin);
 
+	if (fbi->panel_type == PANEL_TYPE_TFT)
+		left_margin_low = 3;
+	else if (fbi->panel_type == PANEL_TYPE_CSTN)
+		left_margin_low = 2;
+	else
+		left_margin_low = 0;
+
 #if DEBUG_VAR
 	if (var->xres < 16        || var->xres > 1024)
 		printk(KERN_ERR "%s: invalid xres %d\n",
@@ -611,7 +634,7 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 	if (var->hsync_len < 1    || var->hsync_len > 64)
 		printk(KERN_ERR "%s: invalid hsync_len %d\n",
 			info->fix.id, var->hsync_len);
-	if (var->left_margin < 3  || var->left_margin > 255)
+	if (var->left_margin < left_margin_low  || var->left_margin > 255)
 		printk(KERN_ERR "%s: invalid left_margin %d\n",
 			info->fix.id, var->left_margin);
 	if (var->right_margin < 1 || var->right_margin > 255)
@@ -637,7 +660,7 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 
 	writel(HCR_H_WIDTH(var->hsync_len - 1) |
 		HCR_H_WAIT_1(var->right_margin - 1) |
-		HCR_H_WAIT_2(var->left_margin - 3),
+		HCR_H_WAIT_2(var->left_margin - left_margin_low),
 		fbi->regs + LCDC_HCR);
 
 	writel(VCR_V_WIDTH(var->vsync_len) |
-- 
2.42.0


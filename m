Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2112B61
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iUVTib7I"
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EAF9F
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:41 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9e62b14c9eeso215491466b.2
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699358; x=1700304158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv+Nw99h5TQ+ZdPAOUHCJ7Is/AuyKPzv38qwm03SYTY=;
        b=iUVTib7IJ4nhaswszUcXNqeDYfL9gea5rmO66MPg09zFniiYdl8zeNd7NL/UI0WXr3
         kLBahdPopN5Tgd9pCNTkFE0JUd4OpJhp8WN0DGjLxLu26Q66OgCXa9a+4CUbZhXBu+nG
         2Frn8VH7h/uX9zsEua2SXecMfxyNoAku+QdO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699358; x=1700304158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cv+Nw99h5TQ+ZdPAOUHCJ7Is/AuyKPzv38qwm03SYTY=;
        b=jPGSYSElYs6BxrRDp+3w1BTz5hqedf+/YEYny8+2HZWPffPGj3LTW4GqkRL5XU/Mte
         XAIFlzhF1apL0s2ya/B5M+vFm9jBgZhPE4hbK+n/QcP9MnP+I0ZUbCMzk2iq6Rg6D3HG
         NMn+6SHLY40EtB8JO2/NzBQuM2XCgnxs3/wnWvNcyzZiyX3vWvengCse1sIGPe3Js4F5
         AXCSniH1N8+GPKNv3GfUscavff72seXeBMLZrGLFQ2PBkaF8QAtKoYQp5OL2k+41tGrm
         Ob8Zivp+gT2uiPI5TmGXdU2sP3RM7kNB5NLJ9y2K9Jhc4H8jH22rYbmyIswuDlU2Bax5
         ruNA==
X-Gm-Message-State: AOJu0YwVdlNRZJYLIQjGXvc7g7uE2VWTUsR2mFzAC2GpVMc379blOh0m
	zosdRJpxlhug43cHrsSbgP9yPQ==
X-Google-Smtp-Source: AGHT+IGV/oLH/5lcH7sOkoekG3D+ekNeJmSBIhCHEhoX0aYsTwH02HKUCdbRojD3+VixFTGso1kIJg==
X-Received: by 2002:a17:906:fc0a:b0:9e0:5d5c:aa81 with SMTP id ov10-20020a170906fc0a00b009e05d5caa81mr1063698ejb.27.1699699358600;
        Sat, 11 Nov 2023 02:42:38 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:38 -0800 (PST)
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
Subject: [PATCH 02/10] fbdev: imxfb: move PCR bitfields near their offset
Date: Sat, 11 Nov 2023 11:41:51 +0100
Message-ID: <20231111104225.136512-3-dario.binacchi@amarulasolutions.com>
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

The patch moves the bitfields of the PCR register near the macro that
defines its offset, just like for all the other registers.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 7042a43b81d8..6af5f09d9c85 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -41,13 +41,6 @@
 #include <video/of_videomode.h>
 #include <video/videomode.h>
 
-#define PCR_TFT		(1 << 31)
-#define PCR_COLOR	(1 << 30)
-#define PCR_BPIX_8	(3 << 25)
-#define PCR_BPIX_12	(4 << 25)
-#define PCR_BPIX_16	(5 << 25)
-#define PCR_BPIX_18	(6 << 25)
-
 struct imx_fb_videomode {
 	struct fb_videomode mode;
 	u32 pcr;
@@ -88,6 +81,12 @@ struct imx_fb_videomode {
 #define LCDC_LCHCC	0x14
 
 #define LCDC_PCR	0x18
+#define PCR_TFT		(1 << 31)
+#define PCR_COLOR	(1 << 30)
+#define PCR_BPIX_8	(3 << 25)
+#define PCR_BPIX_12	(4 << 25)
+#define PCR_BPIX_16	(5 << 25)
+#define PCR_BPIX_18	(6 << 25)
 
 #define LCDC_HCR	0x1C
 #define HCR_H_WIDTH(x)	(((x) & 0x3f) << 26)
-- 
2.42.0


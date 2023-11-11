Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C954312B74
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DJl/s2fu"
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56C644B6
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:45 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9becde9ea7bso812716866b.0
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699364; x=1700304164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKRsMdTRp52wX/RfOne0bAjVlYqKCb2FkmXxuvgSsdI=;
        b=DJl/s2fuQIIcozKl54nfpJuDneZJxL4Lrr891YmgCslA9lVF/SYCZuK9pailC1wRRN
         lWc5XmA2AXfltpSjbNB+UWIwer9WItEtSxZH6uOP1/jQ77Bl2hhTjoNTA4xWfxOxsOaH
         WVBDYizY2Z52is4+NnEpgxNxTlF9WfSXCVWCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699364; x=1700304164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKRsMdTRp52wX/RfOne0bAjVlYqKCb2FkmXxuvgSsdI=;
        b=qqKhjWb5qQ0x2TMyhBbZG9ruE4vuMxgZIID/XDa5V6REz2rUu9XrPhZxsEWqM8uqt5
         pg7kTEuBLzAollwUpjAYTDxPNkEhxr9W2JMJBqLbJ1CmbBFEqAt7xBoe2BKIA//9Dwn1
         7Pro3ME7S+BXehSkgvpvLnSAauFhtQ+tedhE5CUPPNJwyFuQRvUVPfK/HjzYmKRtFTFE
         RcHwGPz1i3lvzq5Osn7x827o+cByvxQiorjNxawHLGRhZRzJ6jigQCUqFh31BoqCpRdf
         sz65k6Pu4m7YOFBd6qBA0Wb2RzT8/C2z1OvoRbJ3mHDGD6eZdoAGbN+CfFCbQw6vojQE
         ol8Q==
X-Gm-Message-State: AOJu0YyxQchcir/gZ6xHmpydYWkBdQVeOoVDLERiS/XWQfLHnJ1rmfVt
	yGAcPw95nhFGOVgmeDaOrrwAzg==
X-Google-Smtp-Source: AGHT+IEJbLdVs0JW+jcGlc8xPQxdZhfaKGnEyX/Ga6OBU0qyC2zAkwbXYZvVAliT6vWUL6mEDi9zyw==
X-Received: by 2002:a17:906:4e4d:b0:9ba:8ed:ea58 with SMTP id g13-20020a1709064e4d00b009ba08edea58mr1653246ejw.30.1699699364258;
        Sat, 11 Nov 2023 02:42:44 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:43 -0800 (PST)
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
Subject: [PATCH 06/10] fbdev: imxfb: drop ftrace-like logging
Date: Sat, 11 Nov 2023 11:41:55 +0100
Message-ID: <20231111104225.136512-7-dario.binacchi@amarulasolutions.com>
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

WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index de1434069530..83497f6998f1 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -694,8 +694,6 @@ static int imxfb_init_fbinfo(struct platform_device *pdev)
 	struct imxfb_info *fbi = info->par;
 	struct device_node *np;
 
-	pr_debug("%s\n",__func__);
-
 	info->pseudo_palette = devm_kmalloc_array(&pdev->dev, 16,
 						  sizeof(u32), GFP_KERNEL);
 	if (!info->pseudo_palette)
-- 
2.42.0


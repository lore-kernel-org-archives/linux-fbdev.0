Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ADB125A7
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bqRVzsok"
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E9344B8
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:50 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso444814866b.0
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699369; x=1700304169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57XfclRA1DPTjEGTeta8gbvZTvGhPeSww56J1vwZoGA=;
        b=bqRVzsokysWOjTYqiiyzz63kLTJ12L/yQx9u0AoEXyg3teldFilGzA6jx9bjpv9PCd
         8LHXBX6yxFrCkOVfFOU4DIIT/aM1is3JoeApWBvzi8KYjpdsfavhvdc4gI9WWsM4Aqcm
         yoTOvWWWGCaiJmHWLZ/gZBA+60j2PYWk/w/bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699369; x=1700304169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57XfclRA1DPTjEGTeta8gbvZTvGhPeSww56J1vwZoGA=;
        b=gAT+W8jNYDd8vpw6LfJK+vuUeTfxXXIZ1P9PjvRaibYrOvODkMwiEdsMK7VcQZp2VD
         PGQmz/SOsPHrJuKV17XoTgrDfRKQUbYwfDIZ6jLfTXPlO43Ax9zFhBIjczBJQGK1zmgz
         C5x/m2MB/MHF76ZEpwkB7Wq09gz3uqI5dS0YgQQV9tOZ1bdm+sKScoH2thNKpQpI1JTL
         bEAMj6fr4BxJVy4iOXPAwUjexy2WOSdRm2zMFqMrv5O8KCIN1HESRtvfIW14DN/3dutM
         9mXRcHCWnCFbVnrzb5TRsizaJpwJicRteSbOqLpXuiCEZSqmfiv4WRfVb89GlbO7Rsgp
         QNlA==
X-Gm-Message-State: AOJu0YzxGmgQMtoaqvRpbbTWU81af8SoXy/nz+6CvgoVrnBhOUuOMrLT
	4GUJwO1nrh4rJc1SwYw4uDbTpA==
X-Google-Smtp-Source: AGHT+IF51sz/9Eym2oiwu4zOU3bpJ1pg92NvUM3b8/mDpd88MUL1wczf210dAwnnzyMpQ5H7XMHxcg==
X-Received: by 2002:a17:906:361a:b0:9dd:bd42:4ec2 with SMTP id q26-20020a170906361a00b009ddbd424ec2mr908050ejb.10.1699699369457;
        Sat, 11 Nov 2023 02:42:49 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:49 -0800 (PST)
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
Subject: [PATCH 10/10] fbdev: imxfb: add '*/' on a separate line in block comment
Date: Sat, 11 Nov 2023 11:41:59 +0100
Message-ID: <20231111104225.136512-11-dario.binacchi@amarulasolutions.com>
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

Linux kernel coding style uses '*/' on a separate line at the end of
multi line comments.

Fix block comments by moving '*/' at the end of block comments on a
separate line as reported by checkpatch:

WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/video/fbdev/imxfb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 8d6943f0bfca..a4dbc72f93c3 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -946,8 +946,10 @@ static int imxfb_probe(struct platform_device *pdev)
 	if (ret)
 		goto failed_init;
 
-	/* Calculate maximum bytes used per pixel. In most cases this should
-	 * be the same as m->bpp/8 */
+	/*
+	 * Calculate maximum bytes used per pixel. In most cases this should
+	 * be the same as m->bpp/8
+	 */
 	m = &fbi->mode[0];
 	bytes_per_pixel = (m->bpp + 7) / 8;
 	for (i = 0; i < fbi->num_modes; i++, m++)
-- 
2.42.0


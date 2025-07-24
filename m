Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F151DE2BF;
	Thu, 24 Jul 2025 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753327541; cv=none; b=paRFXpXKP+kYFsM7/jc6abxFikAyFLIzfBSSQIgmSuQTIJkKgy5bCr23ZUWZRSIrKn2N+o/8rEDzSK1sWczdqx5pe2HeLnfmsrxq/9aIyZ8E34ZlPo82LDXaEtBrzNlQa7XXE5d9xWPmL08pyK8tBCRPPJjhqD36IT2qcMcheNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753327541; c=relaxed/simple;
	bh=efbE91mXDP2/1Bi3Ip6H72JhYzu0xOb9xHFk5TOQ2ro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EmkTG0DXwgEPXfX5N3GdkagOssdJHNIHujJt8LOUqrLylW52NaOi0hVJSCBB6UQ9BnuqksvqqQFAIR53l/7uX6ITkqupYZqjE/GcfNyaeB5l9AJlE8XTyoD0V2LVyfO6/G1qDrDo/Ddu6HcXmYvH/gT7/8PQHRDfe0bbBuJMU2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gsgd+1Hy; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gsgd+1Hy"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e3401cb5d7so1873685a.3;
        Wed, 23 Jul 2025 20:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753327538; x=1753932338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6wVDs/1wpqhDY4HcSZTV4ZWp0eLuVHcvYN7ua0ivt9Y=;
        b=Gsgd+1Hy84qjiah/F8nWiBtmqpiSK9dW/mY4txKEwtYkAObszbysipCA1MjEYE/x2k
         fkRlLiovcZv+yEQKBCAuHHA9V4yWGGTTyvl3+sQIisObMLjIdedWMlA4gzOh4F+4smGH
         r33FWuZWSZP/P6tXe+sW+5XpbjIV86LSSkM4m9MXEzZ/3iWNzBuFdaHe/4La19ei0Aog
         NF36z/I2jTYHpBLCZXNgP0ioXqr0g1aGRcLTgLK8O4Z1+ylM7pIGnsTxoYMUv4qri2FM
         741cxVbrX5O9Psdlcye9X4EB3RrFUXB/12drH6whaVhlk6W2afy8A2QvrtV0xHz4m771
         gDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753327538; x=1753932338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wVDs/1wpqhDY4HcSZTV4ZWp0eLuVHcvYN7ua0ivt9Y=;
        b=BMfXgEXVWigP0CXtqu2Mb7EcEQUn7fs8hsFK5ZJ7xckdxCezzsIYhzSb47EgvADJBR
         44u5OQ4ZOP11ryXciZesjVsSGZOsdXZFQ5bJqVkHP9rWe1Ux7B770DY9vHHDR1WOM/6F
         OJ7+tHHrtuCYfnZaRSQ3Cxdhiq4Ngrm7vTOVCSaOLNJ9Oq+6/wUIpxXFWtw27yFIlV6C
         4fMMVilTZjG3Sh2PhdmzJoo7utxDhdFE7q1dyZFipbsdSUklTUh+dUhdiHF6VF+kvaaq
         Ac3aiO35ZU5cGpAcucwa8uWEpHrQSoNgrAi+M4pM9aU5KDqb6TkvsT4ML9mE3FV/5AI7
         baQw==
X-Forwarded-Encrypted: i=1; AJvYcCUHz3OTkNpUl7t6uH/uZ+YHfnaPFqNo7g4fzIW8781S66+GZ+2S/z9K3QPY+grdA05NKcn4LAOw57LE3w==@vger.kernel.org, AJvYcCVXNRjhaGTLu5SRXzwrVBP3ieIuoALo8imL9ZzSwomYTmGFwehLpT2qws+K9YnKdIYxbpHLjLTfFlEIbppG@vger.kernel.org
X-Gm-Message-State: AOJu0YwYnNrLzlbcwC2XlSe3w4h6qGXB1ItJxQjguTe32vGVfkVj64Ck
	DTjiGZKxZCpzXt5Kxt3kHVLlb3vD1nrF49vvtAOu66r0CddtugxK0to=
X-Gm-Gg: ASbGncuP3qwUo+fW4N8/tYf+CaC6mQFYeGdfr1FMMP/PhsZNNGLo9wbqIvR8afy9NoW
	snhSmiIdjLMP5oVPuONvlbYdkD1B439ECdo2/3VUvcdvMJWfpl3/xDK18JrdbcZUoHWe0ZR7Qrq
	7kQfnPK5e0BXR8JrsN+290imaIGX5f6puyBLf6sdAvFtfvy8DNU5U7Tjh8TtRTAvzjQ3P3t9ii1
	g90Iql1kpSHrPhuMMIezi2ov1dwOaj0W1gE/sj1EA2nGJH8eRSf2PI7ieAGQV4g/A/1X0lWYXE5
	y+wtO+FY3N0JnXjok/e7Ec+lRKEDK7ruxfqYkPxm8GfNSo4fC0eIt0X024cXmKHlrVFu4djIFHV
	luGZ+SeNgRr8+5ODowc0=
X-Google-Smtp-Source: AGHT+IHGnu+YAjFvpNlXoLdms3urmPpO5CFALkcBe0mKnj1jUfEF3394xo2fVnScG0OOVxyFL1h9pw==
X-Received: by 2002:a05:620a:4687:b0:7e3:328f:61fa with SMTP id af79cd13be357-7e62a1410a7mr262258185a.5.1753327537421;
        Wed, 23 Jul 2025 20:25:37 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e632d4d48fsm54145685a.2.2025.07.23.20.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 20:25:37 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: s.hauer@pengutronix.de,
	deller@gmx.de
Cc: kernel@pengutronix.de,
	shawnguo@kernel.org,
	festevam@gmail.com,
	msp@baylibre.com,
	plagnioj@jcrosoft.com,
	linux-fbdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] fbdev: Check fb_add_videomode to prevent null-ptr-deref
Date: Wed, 23 Jul 2025 22:25:34 -0500
Message-Id: <20250724032534.1638187-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fb_add_videomode() can fail with -ENOMEM when its internal kmalloc()
cannot allocate a struct fb_modelist.
If that happens, the modelist stays empty but the driver continues to
register.
Add a check for its return value to prevent poteintial null-ptr-deref,
which is similar to the commit 17186f1f90d3
("fbdev: Fix do_register_framebuffer to prevent null-ptr-deref in fb_videomode_to_var").

Fixes: 1b6c79361ba5 ("video: imxfb: Add DT support")
Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/video/fbdev/imxfb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index f30da32cdaed..a077bf346bdf 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -996,8 +996,13 @@ static int imxfb_probe(struct platform_device *pdev)
 	info->fix.smem_start = fbi->map_dma;
 
 	INIT_LIST_HEAD(&info->modelist);
-	for (i = 0; i < fbi->num_modes; i++)
-		fb_add_videomode(&fbi->mode[i].mode, &info->modelist);
+	for (i = 0; i < fbi->num_modes; i++) {
+		ret = fb_add_videomode(&fbi->mode[i].mode, &info->modelist);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to add videomode\n");
+			goto failed_cmap;
+		}
+	}
 
 	/*
 	 * This makes sure that our colour bitfield
-- 
2.34.1


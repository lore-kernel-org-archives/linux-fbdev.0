Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D1397930
	for <linux-fbdev@vger.kernel.org>; Fri, 14 Aug 2026 03:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677478; cv=none; b=nw+dMmwY31sOotzwkIuqz/3ObgTjy7JeWy1Ez82oG3XngohRj5iTHzzPC7Pz8b4cNmLW1zFUSQSEPGZrWMUUZCos8IO8vKtqvGAGOKKj7vIOS2/pnQmHLuA/HpsbFMO695YPbgHa1RNZU5SPRB36YG5XR144F4AlQixkdMJVyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677478; c=relaxed/simple;
	bh=X9Ul7nctoGDdKiisl4+6Ep78QtF+NaTDx9TTZkjI0+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Mi6tJOUe+L5pFBPYeLIVl0Ny+aeYJQWtw/+e6gyi2VqWbFu6CP4yhfF1SAmJIuKXanneCcuyx59tKdfpUNUo20eTOXLdpImZyAJN3BYrySXKgHKkMeNmbxpDvblKERTLdpPPj5ZdS4z9xKf9luJOgEOtM9M3y6TkL8WZmC8dPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtwdKUAh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtwdKUAh"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cfff5f88dbso9088605ad.3
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Aug 2026 20:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786677476; x=1787282276; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PivGI0hud4xlknUygM2f/RdQ1bzliuSDoxqWeIZ/XNo=;
        b=YtwdKUAhjgfXM/AxM0ilOOw2DG/1WitDeWNxRelRDsBx0shoY4uDl6Ur81mRIF/B1/
         HABuifMwJRp09KnPMirhKZWFdnNFj+vJe0tXOJdb9ndHYtKH7dUiQXwKXsMdntPpoq3A
         SfJFhHIShg7eC9GGkGgYzaW4TRSz3C7y0eJrt7fA0gDCAmHP+8IE312Dhi7yi28H7l2J
         UVuaII9Qa25EjHPN4hY1vfRBpxjcZp5N+ESY0lzuQ+4vAqCoUZL+tlpODk23E1+ZrXRn
         i7bckyYUMWsvr8uze1z+Hcbgp5TnRnN9TcX+x1GzzsI857ER4/52WmdeeJwHDDtL++4r
         fbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786677476; x=1787282276;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PivGI0hud4xlknUygM2f/RdQ1bzliuSDoxqWeIZ/XNo=;
        b=PZSRqLMwzPkUGWglY1pVFjzPBYz7yacZxbZ+vbXcAXUaRQEC2RNTU8wd0ODqY75K+Y
         bxNrQfys0BLTz/87tYtMeGAtGqxMUWsug70dMksY6/gfPonc0l6ARhNi6y4BjtTAAzvG
         mg//JEiLcGpdF8CKiQUel5D1Eis4PwVCZnI9QntbZFXdwL27+6hUr4BHzgCeRZQWluxR
         UTm+l4ERBa7JkZ91W2kKJ1/0h0j9j5/MOXqriT5ARY+COO5cW4TgVSjBHa8xrokvrDHD
         wC5uTIx3Fv4xdp3LfyJLpwsfUKlc6Kd5f0D/qacFLO1hImBrLvLnH4get8OcI/ycZJte
         SnTg==
X-Forwarded-Encrypted: i=1; AHgh+Rqy84yJTA5yCJoiuHLsc+/KQNY89vYC1WqMGnybBXygRXEVDxPjCQVmAaZoFakSH67RLRqBlk0Cj5Io8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrpIWpYYnloENriGUKKI7Qv0CWSyjfbbgdfuqqFAr6I74HMwnS
	F8imjRQ0mTtzIo5yTk3X75s4B+NKEr6W9X0wxPnT4raTRB4qYYvuwvfIcAaqoQ==
X-Gm-Gg: AR+sD1367HSuKnJLcoiHe9cn5pCHfCziMDrGITzyNUI5qjszBtQMAf0gljo3GFXx0dp
	jv3phiyYDLYzDI70y6DqX64iCyaNfHYxdd8P0B8ENSqgef6B+SeLKMwAWrwP3Ebyv0+EksVf1m5
	UzZrg6rkmDA5vtf5iJsf/8iyCtkOZGBBRj6ClWm0AJSdHe0AeJ6khg5uKn02BX5vsiYfGjmTFa0
	YImHQd9bycZGQYlZLArYipOEUYeJubEEQCNq2kC5j1/MMb8ZoHtkCXvdVxjgoYz3jOkLSCbYNeO
	eJUrJ4lUMMDWD8Lsef/hGQCM69O3mI9FDiFqlfqiwJt2RTWOJahNtmXTU8/c4DBjxb3Icu6TJsY
	QmLhQK3SqmhCesxFICcOVbMM0Fbw7R0WpR2axMkAHkU4RjFn54nnJJg39rA9+zgdHjAID1GhphU
	D78CgqpzUhPXkJb0WE+jC9WwXMpANkzDLvFrWr5tzV36xeeEyYbeDxchjp0LsvJdJsLBaonMkVW
	f2ZCVQBvts/r5TJfzLk5jpsZTctgoY0uxi9tIfxAdZXx7Iu8h7VQA==
X-Received: by 2002:a05:6a20:b40b:b0:3bf:9aa9:b2a4 with SMTP id adf61e73a8af0-3cc71d71cdcmr2832307637.20.1786677476084;
        Thu, 13 Aug 2026 20:17:56 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-170-159-fibre.sparkbb.co.nz. [222.152.170.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec0223e52sm13771917eec.24.2026.08.13.20.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 20:17:55 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id 493F3360489; Fri, 14 Aug 2026 15:17:52 +1200 (NZST)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org,
	geert@linux-m68k.org
Cc: schmitzmic@gmail.com,
	Miro Kropacek <miro.kropacek@gmail.com>,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 2/5] fbdev: Give atafb proper parent
Date: Fri, 14 Aug 2026 15:17:42 +1200
Message-Id: <20260814031745.17140-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260814031745.17140-1-schmitzmic@gmail.com>
References: <20260814031745.17140-1-schmitzmic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

From: Miro Kropacek <miro.kropacek@gmail.com>

The atafb fb device registers no parent, causing a missing symlink
(/sys/class/graphics/fb0/device). Xorg fbdevhw driver looks for that
symlink when scanning for devices, so add a parent node for atafb.

Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Cc: <linux-fbdev@vger.kernel.org>
Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
---
 drivers/video/fbdev/atafb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index b8ed1c537293..3d540803dc2b 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -3101,6 +3101,11 @@ static int __init atafb_probe(struct platform_device *pdev)
 #endif /* ATAFB_EXT */
 
 //	strcpy(fb_info.mode->name, "Atari Builtin ");
+	/* Parent the fb device properly: without this fb0 registers as a
+	 * virtual sysfs device with no /sys/class/graphics/fb0/device link,
+	 * which makes Xorg's fbdevhw reject it ("No devices detected").
+	 */
+	fb_info.device = &pdev->dev;
 	fb_info.fbops = &atafb_ops;
 	// try to set default (detected; requested) var
 	do_fb_set_var(&atafb_predefined[default_par - 1], 1);
-- 
2.17.1


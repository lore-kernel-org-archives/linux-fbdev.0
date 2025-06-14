Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6FB2E11DB;
	Sat, 14 Jun 2025 05:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749878794; cv=none; b=rzua/o9V5m8Iv8N7rFnC4sh4AYbjpY16S8nvAsHAelbj0LEGdgniI9mqdQHv8PHiDfYu1B0/jO8OjRydTcVR1CLx2FvRZjDt5IT8cNZXeOcwUs6JX9odNEtM98TaiQatIYYjPu7/DFIWcGvdF87NmbHaJDu3huPT9cGxGI2Y/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749878794; c=relaxed/simple;
	bh=JT9+IQXNoYchOxtRfSzACcwEA7yfDhQ1suXoi9NPnug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Azbmnf3ljRDoCAZtqUhWTcjZQz0dL/HvtOmxmROi8BJvKImJIybx+6KXYpAFpmvyWOKajABsm2jASGPtq8wLaYou7jw5LriPmD62q/SAsvHZxMbbRTJFkc9CcOLBNZXzSL0t9rh3vMWBb0gyysCz372t9Y1hv0FGaxnCeZTO2Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wpo81hfZ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wpo81hfZ"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e3980757bso23044877b3.1;
        Fri, 13 Jun 2025 22:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749878792; x=1750483592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ//krHGMnPWZB5Q33bWy4al2+1hIHKEXPMnm5ssurI=;
        b=Wpo81hfZ/OvWq0l2EM+WxtBxW6bF16n8TtLIffKe08/hcYHD2w1D76PQdU8I4mlYaT
         eEyFyAhKD4b+FZCqolzAcwDRIC9IidVc06yrTSvNcPBChynWyj/1yZdRHDAG6QSSjTkt
         g2PrtzYRAQI+kvLtT8tU9CDvZFcquPPTFHyBLuBml+otv6/spsonxoouSO+ON0IxQG97
         E48zMKub6d0xt3uZ+lUt3xm8uKT/yGCZyWeRmb9BWv8mlCtmWLMjiZvFCYa01A7+ixBj
         SbdZiRymjrJ9A8lBDCkijVJjBwEhlVwnjmQjcInHM2cDkfnHp7cIcAeZkxVBvsyjPaAx
         4Y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749878792; x=1750483592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJ//krHGMnPWZB5Q33bWy4al2+1hIHKEXPMnm5ssurI=;
        b=vDtL/gkr9KJLfipNPGd4LL8A4Xxq2roRLVYzkBDJGvv5mp6Q0jGfBKMmBI9nJfTzJN
         AdF9Aasuk8+RqfHmmDQ4H/PDxqGkeYn/Ov3u4LtOeZr6DF/gU6CwyOPAU5qgC495la/U
         +iWnVqWgx9nX5XBF/7SwrAcqiIwtzx1g/kYRvlP0dO2jZTHLTBaRuAVntt0oTV1Nzh5V
         DtizMQDmmenlJcA73I3Arb0qUvjd+D6xQQexaSzNGfrTC+yWN4gfPxe5JVTqHvRvVIMI
         yPhGWzFF129phlp5971Loa/jolX7qikpknHtxpn2LyoLv9MJ+Wb6NAgak/SJ/uCgXaA/
         ZnWw==
X-Forwarded-Encrypted: i=1; AJvYcCU1wE3+5p3fI2eWpydtys5voIo7uIux30xN+4Dpo6b8Y7fbn/WKjwgaEgA1JcqECPHtuRCsuC+ORnfmqQ==@vger.kernel.org, AJvYcCVzyCUNSOTkyEr4VCf81RmFPnFj3aDgpFXBiQdhvdw6b+pGcKSZLOW7MMCrekiH/iuBwOC9jek4hLeVVOYB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0w0yo/oYJ/GSgX9T3cCgD8bPARwZO5wYMlYRkGvFcDwJgsEcL
	CRuW8nUzyOx71fybE6+b8SrWVZhWyi9wVoGAPqxgmib25pZwobYVokz8
X-Gm-Gg: ASbGnctN8bhmhC82R7Lp3Egqcc244yRK+2RzclwdpdhrHAXDYE/y9UlzNTTC80Q3Zna
	fHUp9CqnpamYQydaSzB6OY+0Y2d/Vh51SBxalHWBpysSFhu8Nw8H8SxS4pzOe6FwOq8rkMQj2B/
	94UDk5+IKGP0LsA2zH4/5crS+ENsdWmKdTXysNtIReiHyAW9EuhnmHXXKUSgu9UWqvFakzjMLER
	qCuOb+aH7tVi5ary3/pdQOP2lfUPNlRYg1PaZBWUGuF4e9dq94FFyXefr3cp8SdPwXC952rKN++
	sgnIjtkkZIlQJKonuISxz9wXbh3AEWQo2Kzhs4tcRQ0bVofkayOyGUF92mel9I7+qQOSskLYygN
	m
X-Google-Smtp-Source: AGHT+IECiqewpok8U4+1eKYPDaZZt/oK9V8Chhj+9rUS82dtw6OQW6ZhSPid6O0SRD7zxoR3WsVfdQ==
X-Received: by 2002:a05:690c:7443:b0:70e:7e33:fbd6 with SMTP id 00721157ae682-71174962c9dmr34072197b3.17.1749878791713;
        Fri, 13 Jun 2025 22:26:31 -0700 (PDT)
Received: from trojai4.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-711527973d0sm9017927b3.58.2025.06.13.22.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 22:26:31 -0700 (PDT)
From: Alex Guo <alexguo1023@gmail.com>
To: deller@gmx.de
Cc: alexguo1023@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: i810 Fix potential divide by zero
Date: Sat, 14 Jun 2025 01:26:29 -0400
Message-Id: <20250614052629.3549586-1-alexguo1023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable var->pixclock can be set by user. In case it equals to
zero, divide by zero would occur in i810fb_fill_var_timings and
i810_get_watermark.
We cannot find the default valid value of pixclock for driver
i810, so we fix this by returning directly if 'pixclock' is
zero.

Similar commit: commit 16844e58704 ("video: fbdev: tridentfb:
Error out if 'pixclock' equals zero")

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
 drivers/video/fbdev/i810/i810_dvt.c | 2 ++
 drivers/video/fbdev/i810/i810_gtf.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/i810/i810_dvt.c b/drivers/video/fbdev/i810/i810_dvt.c
index 2082b5c92e8f..1db4a63a2631 100644
--- a/drivers/video/fbdev/i810/i810_dvt.c
+++ b/drivers/video/fbdev/i810/i810_dvt.c
@@ -251,6 +251,8 @@ void i810fb_fill_var_timings(struct fb_var_screeninfo *var)
 	xres = var->xres;
 	yres = var->yres;
 	
+	if (!var->pixclock)
+		return;
 	pixclock = 1000000000 / var->pixclock;
 	mode = i810fb_find_best_mode(xres, yres, pixclock);
 	
diff --git a/drivers/video/fbdev/i810/i810_gtf.c b/drivers/video/fbdev/i810/i810_gtf.c
index 9743d51e7f8c..ae001b256ace 100644
--- a/drivers/video/fbdev/i810/i810_gtf.c
+++ b/drivers/video/fbdev/i810/i810_gtf.c
@@ -259,6 +259,8 @@ u32 i810_get_watermark(const struct fb_var_screeninfo *var,
 		}
 	}
 
+	if (!var->pixclock)
+		return -EINVAL;
 	pixclock = 1000000/var->pixclock;
 	min = ~0;
 	for (i = 0; i < size; i++) {
-- 
2.34.1


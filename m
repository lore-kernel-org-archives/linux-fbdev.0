Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E0F313270
	for <linux-fbdev@vger.kernel.org>; Fri, 26 Dec 2025 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766750682; cv=none; b=AvIjk43GhCXR8fxBcRwRfUU/LZDmK5kkcu8OCxICg+Zah6s4Bb5N8wPFKpvfHOgTriPrBZMbhXYtxzZsb+cmQs+oowqyyxXfkuIP3JBfUMxfp3KCCC8elWOYGxyRX1fYJFOSoGoNKxvJFkKZmROAq2bGpj7pdEr3yadD8IkSMRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766750682; c=relaxed/simple;
	bh=5WWw3Ai3nUNL+KGovcJwkDFtqP99aWr0F86Mzj5u/cA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZB9elU6xKVkhhp/PZLOfCvLpmv0k8kzit5mBsJ7t3bxj5w3TKW64/2renxZYb82cJodMLJvAoEH6nlr8zGE1IC/v+rTFlwOnkIT1Zj7YmVTgdPFF24FAZRqmtuR8wCUkpDLlXcR20A0AsLKXj/ebLpgYZG5LQYfzNS3w3GmcDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVFJQiD9; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVFJQiD9"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c32700f38so1147416a91.2
        for <linux-fbdev@vger.kernel.org>; Fri, 26 Dec 2025 04:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766750680; x=1767355480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jzOikjZCAZIVSqRjJRRgnV5+w+5j2FvIdULvG9czO64=;
        b=GVFJQiD9btkYr1UWzH8XW1PecfjRd/bhjQr+T0p4DC6UgcG6An3tjN+ma5oDMNjgZN
         ag+pf6ueQJLn+U2u5Lh07sWWVKf6AjdXmyqCZG/cS1SLOFFvc3UymM5JLLHd/nSTq/a5
         jxMsPSLQeLvpBS5+qKgitY7m/+0o714K+x3Rmoh2NcIi1wnMAK9mRr1YbkWUYTojOlsq
         dYtraY55aDMFCZSUoyUsn0f5m5j+Ql4eJEMgrGMKy8NwbbzJC98iiocDxGAGlqP6oWLn
         yr2kQEEeQDnYv34U9YOKo0and1s8TjTqHaOkXNgsp6OG+OqgkfmEAChYnf+5R2t1a7xL
         H5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766750680; x=1767355480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzOikjZCAZIVSqRjJRRgnV5+w+5j2FvIdULvG9czO64=;
        b=phZP7De38bqhukPxD4R7uuKv/8c6GKUZMpEiLSO3JfffGXZWDgbzstSNhqYB9nOMpH
         QTc1/jW+8aTyoOxhHEObYbUVilmp9EhTEM8HwJ/owEcP+/3JMsevXGAfQCqDQSyOkW/f
         nwTMsS0MX5eX+Zfe+Rky6TVEqAaL7MkhPhIMH1zlVwc1pMIyioAVaxiDI7EAsWRMMCMl
         bJkVCh1bU4Hvo05/sDHn/Oeb6PRdxddc8P6AwmCEou17WIhY4ifPSpQPa9+n0i35qZXB
         HqVXHYdl+6y1d4ebORA2Dx4PCxtF/GNZF1NUqHPGIdiDDXFx4KwK/9nZNJQrhOf56YAr
         hDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQrAAh/XO0iERY2cUT3cIiZFRsw/bgc7cCLkEtD7aJGAXIo9jGDjFZCtGXb2DHELkqmhe90d2Wlp+Ezw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKjsIq8DpDBlySUaQX++qm15lejU0tfxivEPLN7K1E6jgBgyWQ
	+Yt3AZMuoMaYwPlXD4N5u1zTGsRIAwx6OuNnCHiITLOlt2c0Wj5Rt908
X-Gm-Gg: AY/fxX656yCKpKq7TLrZhVPMn0gEZON5/MfNxjQUSpLuyyNFspQQRO4TfiV05NODF3d
	R5c9KyXkiecugp+2dASHVmzbMPRqPFZD2pb+MLuVs5Fqsw9Kj/NUMxQGRjuQY08tvOzrCiWLs0S
	vxszqI0ZhH8f35jRldzkxz7/7cU9IIW6k91elFsHB+zAqGSXThLd2QdiN3HPu1akK4jJF/aOTK8
	RCOweV5SZabVnfilyJ6ickkH3EiKSCZ2+emklLplC5n9KtaktLKncS/ZR3EZu038ZHJ/Lfd02Qz
	CEt7unQVsb+N/e2YfHexTKGdtzSmsGa0ft14u6jKq57jSXASn1qyvVtGgyFEcd0bSPdOmXloFrc
	w17qw+O/1t1++2Qq56KKgo3Js51lYAg3Ya0HhkMfp0uGO+eV+CDRxVWASbz7MUglT28VNZJm06A
	uiSpFaX9E8yrFkYJMBaif+rnzEY8j/vr1V4HV3rPghFghkP5rB
X-Google-Smtp-Source: AGHT+IGHbrz3Pi/17OtuTBKj/RvZlBgKGNkstEwcas0tluFEbj85RUQ4XNy2YcB56+6MmI/E1pvQ4w==
X-Received: by 2002:a17:90b:4d8e:b0:343:e480:49f1 with SMTP id 98e67ed59e1d1-34e921c4431mr15253293a91.5.1766750679676;
        Fri, 26 Dec 2025 04:04:39 -0800 (PST)
Received: from zlabs-hw-ts-ws2.csez.zohocorpin.com ([122.15.156.136])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79a17fb2sm18821244a12.12.2025.12.26.04.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 04:04:38 -0800 (PST)
From: MottiKumar <mottikumarbabu@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mottikumarbabu@gmail.com
Subject: [PATCH] staging: sm750fb: fix const array warning
Date: Fri, 26 Dec 2025 17:34:17 +0530
Message-ID: <20251226120417.2599020-1-mottikumarbabu@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a missing const to g_fbmode to fix a checkpatch warning:
"static const char * array should probably be static const char * const"

Signed-off-by: MottiKumar <mottikumarbabu@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index d100b9e1d3d5..7afb58561a0c 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
-- 
2.43.0


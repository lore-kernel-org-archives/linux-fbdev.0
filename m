Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A8B328629
	for <linux-fbdev@vger.kernel.org>; Tue, 18 Nov 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459839; cv=none; b=eFkYLx2F68ux713c1RqPxM0UPPJP1ybeb3Ek734t11zwCwtfhPNqlfqrSi1D4FzKnLI2GwdvTZr5ZHThXCy4gYLtnk8WDcfjKN4GOSfHsxFkHi7hIb+7KRf6a+SG0sabB+c4DcN9AbJm7bq9ro88ArDqQSZ1vGk422x64wx2fmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459839; c=relaxed/simple;
	bh=xDkQEi+B8s+5NfWPQ4nrEVjh33lmY4E/4VzVq8xl4tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQFQzsBupucSItksEZH3fZ8+a5iTD3LipcLSi6o3Jvkb0QAu/477Lr2FTSpRxaM43m4m5SR9gS0PYPEH5LAH2++tEpXZC3cZbv4BWPhKKTtWWfjvf/IkBqydivh15FyPyO72OSDGDBQ8oY21waOrJ6RlpCEI4UfRCurhrWFpnu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tghy5clf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tghy5clf"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2958db8ae4fso49001235ad.2
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Nov 2025 01:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763459836; x=1764064636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6tZ5VzBoVYTTO+te69K4vXT1SJ3st9Rw22BJ6+xFwY=;
        b=Tghy5clfxb/JPDW9WDsrhWxUQbjlF5ov/lfGNDMMClLEpzFbt8FISAc0aZ6qIPRdEU
         zXSxOI3Lge9I0F6yWU55ffdQsGf3wQVPkAZjBIKRRGceuTmX+IwWjeeWw1bbl46dxGPV
         Hu55QJg1FH0YrJvjCpG+MY/QTXEoXKnAzOZHt+aRbTN3l9CMQsAaFhydXGCXRTj5AljX
         4R4rHGeKkAdPaPiYTLYf8HwGjbKjtGCgKSDYnpfu43uvk6uCwCFpiG6u8N9fpW0v7hUJ
         n8mO5vUFSqSWcbUK8cW4pYcFodRCoPFxtlCizCIBSujMXFfq9ia7DUTceVMqu8//HXvi
         RTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763459836; x=1764064636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6tZ5VzBoVYTTO+te69K4vXT1SJ3st9Rw22BJ6+xFwY=;
        b=R7FdRmcVBxEMwJejojH9o5uyUORm+auCHKXERNIui8/1BoD5igihOpY5n5h4/Ct4bW
         ExzMgNFe2CWLrcBMW5S3DEG9rBnHr96+RslYAMaPiYxLOmueKhVCQnW5OZ5De8EtCUd1
         NJG/tZ8Wh6CGdXoxaK6hDPlp7e69Wxcxrcqiq8ejlzJFX6blPQzUU1qWpvFT0yrF7EoP
         bLLGw6GucqDdfz2XqGEzOYMT1yJS0o7y3Ci2Jrcp+8K7acnEEQEQTOMfj8kDzHv/IGAv
         jDU9gI21mR6PmDEC/Vd1YvgeettIL4126cJZCSF/XFDK/AvRE54cHBYXEBgAZB/LQToy
         mgqw==
X-Forwarded-Encrypted: i=1; AJvYcCUDQHC3PpxwcRLiuNGaSU/nkVwUBH0QQLGgQKR8CUhC4y5AzURcRVBIOxRU2Xa/JzT17I8TrwbQZ+dXjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWygaWsYYTnCtly9Ka2QNfMB5+nGnu+1cSxtqaED/SaZZAI7Ym
	muyXdY+gUWrgyTGwslzJ9DCAEfdojgObOqmUwAN+bfAo4cGHAcxkp6jK
X-Gm-Gg: ASbGncvhNxso678n2cUgqYXykE2HURbwf1fgpcy54am+iUn2QE6WEdM73X/chez2BU8
	P6U/mTgqPnIXM7Ljr8ouq4jUY63D56cE1Z6xYvotdbmcUxfOim51IfuwyvVYBvB+Dl3jwt/WtE/
	o+oW8LUnuHwxUDc+onISRRLLSR5RTWMcmsAH8UFrZ4ZX1wQciJ5WEyWj5yje8BqGx+9xontPVXF
	1w84ionqi+Id3CfNFB3GdJhoyplnkm07xc76UT8mQscLQJyIRv1R4dbz2R7AhqeGbomedBLVGlr
	YA13qqH26iIGn5f6vgwX6tNGar+1yuw9S3vg2rsrsp2S6l2eO3hHv/Hoto6jS03bbUhX4c461Sj
	qAsY2x/xEBC7Gtdn+fZrL7TpimuX86jahBjbVx/WKxKQHuVU8Aypi+61MnKWeY7/pcQ07gWuJ
X-Google-Smtp-Source: AGHT+IHMmjMJMqz3ygPywtDFWliHJnZbTS7XL1ZWr8wjn2DCGXdd4NPyybAvK2X81ZXZ3yNMXbed1g==
X-Received: by 2002:a17:903:198b:b0:295:82b4:216a with SMTP id d9443c01a7336-2986a76a1d4mr172192395ad.55.1763459836197;
        Tue, 18 Nov 2025 01:57:16 -0800 (PST)
Received: from hsukr3.. ([2405:201:d019:4042:80a6:7dd7:b597:d951])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccafesm168572415ad.97.2025.11.18.01.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 01:57:15 -0800 (PST)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Sukrut Heroorkar <hsukrut3@gmail.com>,
	linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
	dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: shuah@kernel.org,
	david.hunter.linux@gmail.com
Subject: [PATCH] fbdev: q40fb: request memory region
Date: Tue, 18 Nov 2025 15:26:55 +0530
Message-ID: <20251118095700.393474-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The q40fb driver uses a fixed physical address but never reserves
the corresponding I/O region. Reserve the range  as suggested in
Documentation/gpu/todo.rst ("Request memory regions in all fbdev drivers").

No functional change beyond claming the resource. This change is compile
tested only.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 drivers/video/fbdev/q40fb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/q40fb.c b/drivers/video/fbdev/q40fb.c
index 1ff8fa176124..935260326c6f 100644
--- a/drivers/video/fbdev/q40fb.c
+++ b/drivers/video/fbdev/q40fb.c
@@ -101,6 +101,12 @@ static int q40fb_probe(struct platform_device *dev)
 	info->par = NULL;
 	info->screen_base = (char *) q40fb_fix.smem_start;
 
+	if (!request_mem_region(q40fb_fix.smem_start, q40fb_fix.smem_len,
+				"q40fb")) {
+		dev_err(&dev->dev, "cannot reserve video memory at 0x%lx\n",
+			q40fb_fix.smem_start);
+	}
+
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		framebuffer_release(info);
 		return -ENOMEM;
@@ -144,6 +150,7 @@ static int __init q40fb_init(void)
 		if (ret)
 			platform_driver_unregister(&q40fb_driver);
 	}
+
 	return ret;
 }
 
-- 
2.43.0


Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266BA33A9FF
	for <linux-fbdev@vger.kernel.org>; Mon, 20 Apr 2026 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692706; cv=none; b=hUlRa2HmsI7FY9omqvxMGLGyxDXTBop7H3PmphGpoZdEh7HrBDtUDo/JKFy9wACcNotp86wh8ZCF8t2EQPn9yVq8TNSA3djAxz2fWIWtvhUSv5ZkoFkrTMKVfqtLrUfDaZAcM4irAKFNxsoQzUILOhIL/9luYacezJmfaE4iJZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692706; c=relaxed/simple;
	bh=B5cTKTS/yU/85uj1vFP0zTWjuldQ3kvKaYOwcV/usyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjR57UCv5SFBqZ246Dg7jfWtg0RCUsSMbWWjB0HfD9qVOSu0qaSLiXPzPaNa8IIcNSZcjEWstowx1B+eRrj7z/KwVrGly187Iq7XV97mPeLSF3/8meOlNoVQCPgtIHBJF7VWfkv0/SKtpByng6YXMcuYWbmPZMpVPHkkLF8DpFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgQHyONs; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgQHyONs"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43fe608cb92so2041796f8f.2
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Apr 2026 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776692703; x=1777297503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqCHN1cCEt3ASeaIcQIdHw02mQbDZZaQMdp0xTMA86A=;
        b=rgQHyONs5QGSyJS43NE7EYjLZC2Wc5d+eJm4BCyOC0ROf3A2fsEFPCFkKcpC/RM74Z
         GTckzfOrOfSWP+RZQnsLWfXOi48UyCN3o7lZ067B82aLsYs4ggloxw2QZuz7EqBZFvrp
         cZspeNI44ioos/f0XACj+3ATLDYcnXFU9ySJnS7FL3Z+pXV1v2MNihsxacWnC4NpFW45
         9uTLHR1iWCSQPs6NtVq3GFqWlF8BvcfrpGOvRFEbMl755sdOjkrjy3dBzPEem6nOg5EI
         /c6Hwc3RI1t06tWtouZR3oXRIr44XSdFao64PYMZqHXaxan6Sufd3fv1EIuclwvEwdjT
         ZJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692703; x=1777297503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RqCHN1cCEt3ASeaIcQIdHw02mQbDZZaQMdp0xTMA86A=;
        b=ZP+1Rwgce8g7g/2WKnZq7MFUiGIOYfYFOKvsoV8nJw9E+2YqfZMNtzN/kbSnC2etkd
         vOTdCx+fzzMEd5dtv802NqTs93EuJZHnbjtXFQpYTyeTtzJ2hfbKmZYZI8+zxTFR1//M
         wYbd8zyWzg6wH3HsJI7lCu6gSpxuf4CoE2h8weAjPiUrbuhYiPSoMqLsIrJxm3TbznIj
         hivfpF0WkAvoBBk/mMAU3SdBz3WzR5RbdAjW0VqsSqegzZnXAZr7tPbxymAbiU8mO8li
         zeMY/QZTjxzVM3XYAZUEZ8WdGOsUPZtYnclj9CPiTP8BZm3HWlvsf5Mf5TrUypitnAPW
         U8jg==
X-Forwarded-Encrypted: i=1; AFNElJ/AA4DPOw1s2Ak8kaGRhgM85MDzjJRsOdQ5OkKietY6Hc7qEDZ+9NurvIP93czddPghsNhC8gvW7z+z5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIGezb/5YgTcpHnJULPRp//wrJ01OqBRcRbNkoyrHWL1IhcxfM
	f0Dhky0Gn29BtrfJfW0A/XtttCnSBN8lvMYftMwMr4+G8qPmVBHXer+y
X-Gm-Gg: AeBDieuebQAb3hNeP1HFFDp+JfHnnGmDruRZzvBQ8qI6gQMg1/5wRveP5Ebp9Wjw2Fr
	tQHkK1awQ9iH5Sic/fhwZgP9cSSObbD2FT0ut7Ws/sx7hPkw9/L81LXIMThdXObW0thijpYJAV7
	558cZXrNYICqP6tlqV+FUOFD43BJKKMhBLH4Cva7ws6IAOIkRgKwzO+2o0iIy89VKWoSWcdTtLC
	Q0rDLMQysuyZpSt3ZHNfMYnyHdFleq9M1PKMPbZBwia6MrCZV+k7qgpN8Xq+1ICI2zvU2LYTp0j
	uM5NdXJ2v2Qq5xjZUczSb+MsyyfqcPvfOMowC0Z9+jzpSuCQbc++PWk5OBRQ0p2fS5M8ozKnieL
	fYsLY71oTaguiCyjBqk4AN4YzjsyqaCQH1UzLqJ84ZTO/CsrVkzSjkCZcCyW1k20sBXOgPNSSzV
	l97KSWK4ggatyjkbdTKHKzVCQILCvAqHLZDUBt3PsLsarZu9SMWjA=
X-Received: by 2002:a05:6000:1889:b0:43d:6244:f8b with SMTP id ffacd0b85a97d-43fe3dc3824mr21219986f8f.13.1776692703207;
        Mon, 20 Apr 2026 06:45:03 -0700 (PDT)
Received: from anthony ([2a06:c701:499d:3e00:12ff:e0ff:fea5:3d2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm29302178f8f.13.2026.04.20.06.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:45:02 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: deller@gmx.de
Cc: thomas.zimmermann@suse.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 3/3] fbdev: goldfishfb: Request memory region
Date: Mon, 20 Apr 2026 16:44:24 +0300
Message-ID: <20260420134424.77494-4-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420134424.77494-1-amit.barzilai22@gmail.com>
References: <20260420134424.77494-1-amit.barzilai22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_ioremap_resource() instead of plain ioremap(). The helper
requests the memory region before mapping it, which registers the range
in /proc/iomem and prevents another driver from mapping the same
registers. As it is device-managed, remove the corresponding iounmap()
calls from the error unwind path and the remove function.

Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/video/fbdev/goldfishfb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index ffe33a36b944..14a7cb0a7a1c 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -194,9 +194,9 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 		ret = -ENODEV;
 		goto err_no_io_base;
 	}
-	fb->reg_base = ioremap(r->start, PAGE_SIZE);
-	if (fb->reg_base == NULL) {
-		ret = -ENOMEM;
+	fb->reg_base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(fb->reg_base)) {
+		ret = PTR_ERR(fb->reg_base);
 		goto err_no_io_base;
 	}
 
@@ -273,7 +273,6 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 				fb->fb.fix.smem_start);
 err_alloc_screen_base_failed:
 err_no_irq:
-	iounmap(fb->reg_base);
 err_no_io_base:
 	kfree(fb);
 err_fb_alloc_failed:
@@ -291,7 +290,6 @@ static void goldfish_fb_remove(struct platform_device *pdev)
 
 	dma_free_coherent(&pdev->dev, framesize, (void *)fb->fb.screen_base,
 						fb->fb.fix.smem_start);
-	iounmap(fb->reg_base);
 	kfree(fb);
 }
 
-- 
2.53.0


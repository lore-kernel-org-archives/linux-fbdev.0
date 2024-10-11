Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970381D0DE1
	for <linux-fbdev@vger.kernel.org>; Fri, 11 Oct 2024 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675757; cv=none; b=Te3nc/DCVgdaz7P90J+Oapu/5X+Au32iFPOhtM+uzHYRxi8doV4OEfksBsYUZJPRAIU52lk9a577LMQFt3vWQQrGicNRwAJK7NIbEyrdeSTpEVjM2mqOXedQFDkfk0JRUG+1fE4XfQVsnPTrhuAgTi0aX6EjLvXZKpK5C4HCiVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675757; c=relaxed/simple;
	bh=B7kyYckFT/0DJHm3tDLiNH9WM3QNDHo1rocCSnEz2WI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tAmL1R4Bev62o5mXwm5JSFIPXSJOnqfMs4QaCKrnyT8rYZy+DDfMJ8f5shYRsO9J00LUvxQLgokErej0af7q2ysNz1rOMK6RwrU4vtSgOlL7SjVCkCHg3xFTl9GZ8/39lvFvHXm0z71UzO6JaXdEfuIRQjDvTqGYCTVjDb0fPdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dxXQKG8H; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxXQKG8H"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431195c3538so14796835e9.3
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Oct 2024 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728675754; x=1729280554; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9H6rXUaUQHjyd2VSgKGDs+alotbQnC2p5Cn69HNYv04=;
        b=dxXQKG8HU1bwH2NhuFz0fSNyTBshOiaztF4OgaX2/Q00YcMPR1PzeWdw/JS8p9FXhH
         d0YgEDWluhg6g5YzuKRbyEW+eD4aAyy66GAllToPKCU1CKgJ8eiYjeavghxRXjZGYsM3
         xPJVsAzUQAW3RT+HRZh3tUCTor9VZ++Y5w77Jw07DMJNjimB1TkZ+DzvXNQNOwJMkbAC
         3npLKYuQgPU41l9HO2s3/Fe+Q+EzKTOAjtl/NRLRgzBHCDjsLABCnEq/WOIFEDGWkFqp
         A9FL+A4Vm18YYaSHazL6/su5MovelE7fWctiFGdAk1K7G+rQYmGX4vJW1I1E2k/EkcrP
         /MAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675754; x=1729280554;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9H6rXUaUQHjyd2VSgKGDs+alotbQnC2p5Cn69HNYv04=;
        b=Gj0neyZCqXIotjxEFcuMJxraj19/i/ogmAKcUwTwc+oHhgkbHXrxe3wMq/054UoTnR
         cXrEEuVuU9cM/8sjsGaaHTxgEkKjjbjbhMefl0tShMUR4kS89zdS7qnpcSW1jWky3xXO
         AQERff520SNa62Z0mp6pdykdlClN5U98pyCCkbPSfsslTglzBRegNEBEfey5b1QffVqS
         a8xx5qBJfyNEbmN/0hmvqlaOMhDhqLKdbvygVqB1XjYt96cvAaXTS2fUz7nljW6AsLwt
         /J8AU0y8hv3YvX7rQALRrdYfX/8wXcna+CNC/PvtN8Tcrzi9ClVBax2NYS4JbaIvTx10
         97qA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Vcb/75DynIBDh+swFbopXgUX3IY4BytD/KM3i8BJ9FUH8kKFzjkegnhnKmikTLQj0g+fE2sfwt3MXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwZQnjsi3DEHkU93E5O7J1KCDIY11Jc+giQESxScmbQA4ltLfI
	tk7aJ3RPOh63oYaVxixxF5m1qdOYyZUfJznrUp8Qwa7TSZTOLtiWk2TJMWpEEPw=
X-Google-Smtp-Source: AGHT+IFPVVvRgJhwZiV6j4xkCfdUzrR6DGnGMYo8fZws+use+5kUvfYFQjYHJ8OsNnHP8FEbLNe+OA==
X-Received: by 2002:a5d:4d4a:0:b0:37d:4527:ba1c with SMTP id ffacd0b85a97d-37d5531a0a2mr2327244f8f.49.1728675753903;
        Fri, 11 Oct 2024 12:42:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fa79sm4686059f8f.72.2024.10.11.12.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:42:33 -0700 (PDT)
Date: Fri, 11 Oct 2024 22:42:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Helge Deller <deller@gmx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sekhar Nori <nsekhar@ti.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] fbdev/da8xx-fb: unlock on error paths in suspend/resume
Message-ID: <37842441-e372-40e9-b0f5-cf69defc2db5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Add a missing console_unlock() in the suspend and resume functions on
the error paths.

Fixes: 611097d5daea ("fbdev: da8xx: add support for a regulator")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/video/fbdev/da8xx-fb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index fad1e13c6332..66ff8456b231 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1610,8 +1610,10 @@ static int fb_suspend(struct device *dev)
 	console_lock();
 	if (par->lcd_supply) {
 		ret = regulator_disable(par->lcd_supply);
-		if (ret)
+		if (ret) {
+			console_unlock();
 			return ret;
+		}
 	}
 
 	fb_set_suspend(info, 1);
@@ -1636,8 +1638,10 @@ static int fb_resume(struct device *dev)
 
 		if (par->lcd_supply) {
 			ret = regulator_enable(par->lcd_supply);
-			if (ret)
+			if (ret) {
+				console_unlock();
 				return ret;
+			}
 		}
 	}
 
-- 
2.45.2


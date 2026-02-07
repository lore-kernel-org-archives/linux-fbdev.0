Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862D2701C4
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Feb 2026 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770484378; cv=none; b=mCLb1FFvED1nvF+VIlkji7kX4lvTVaI/l1jaSuYOipsBUgwA7t0gs8YcUjcnLnSIwipYURe3RWDvmRyPuQmhTwSduS87PCc1jTTAJN7GAcCs78RoJFEzFmlGty6YRfUStXAdsgcm/Xqgb9HTGEcNDsZ8kPpfWV2YAX6ivxx6PXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770484378; c=relaxed/simple;
	bh=PRKEEDXGhUgRfpyYcSE3CgEOIerXkC5W3JA9O+m7CdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qdl5+8X4PxplzzXLBICbaJcZjA+KWlYZTQM8LmvkHTqbeZY6acLI1XrqwZUtmq7++pT4ajt6+qwaw5pbAe2H8yZ7QHkgy15zqd/wlZMVgfb2UhhWkaMBYuyz/fPjvqL+qf9xcpVvkjYUaewXHYKQunD+CTwO3HwhhRDFg2Dx7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JXVU0FFh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JXVU0FFh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so19331675e9.2
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Feb 2026 09:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770484376; x=1771089176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBNswDVCvxM40B6CIwygotXLGe434Ipwm5Sz6WlbTOc=;
        b=JXVU0FFhHM6HZtTp2Uc5X6VsTK++j5FHhcvkNEWCssP4c5TCfXyH4AWiAhY5H0zP17
         d4i21976d4FX6QbBC2C+pe+ghs1krbKqBvV8VL35C69poY+AzX08wb2SRjSj+v4l3BS1
         NaZPLNwBfK4sTWFVd42o7ks3opvwpssEGpkjBBBEqVYylqj6CmqBTLoHkzMPi2LoWfZ6
         O/TEYMWBGFFG7LlYgiYjAxhN20cB+euzmak4CQoqzx4iu664RCcsQNOohaTLNlCNM4y6
         +pMer4M2mvrbWHBdxlJLj3QRModHDI10EaweEO7n4Z4XcBYf1s10/zFu6fpyhSssfZJI
         sGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770484376; x=1771089176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nBNswDVCvxM40B6CIwygotXLGe434Ipwm5Sz6WlbTOc=;
        b=sBB8GWjv+A9VB9Xs7apXhhPzrfPL9SWaSPp67na4h8qpyx1fsZUDrVilZ3mCxvq27J
         MGFI5TV2eqc5I7XN6VTLTNaZ1PqMdvmuuqfBwBOh6Nq+CdKDkYKeq80Wl4yOEaJZx80M
         yGc1zUBznhbIACHG6DsYAbao9RnFJNVER6i2CWOL+4GUQDosTJ/GT02e2uW/8meOxS6m
         RAdJo9XPA/wqUgIf6aH3VOrEG6hD+KvNVeCdKdHthZmD2rIoJdAp5+LKqHYqdxemkmFu
         ERdPYO+fLe5reow2fo7CPIzpmiklLoFWb/6Y6at48qBnt4o8cQ0hm4/YPNHnXnqJb3ol
         t05w==
X-Forwarded-Encrypted: i=1; AJvYcCWcloU19DlexIQPDUxYtp62gUxg5MsYH0Pq9UpTLSX0prQ75j0TQ52e35V1ikoo9D36ozkUB1pvqRgA2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqozI9x4Ma46K4UQt40sov1OtEwlh11mnBrdSBTtjt6H8bGAZX
	Pyr/96CRdsdUAPNcFZ0Bi3+4oUd8xAEqjH74bdIXBrt+n0ENxC8UY8nfaSzoWaWnivc=
X-Gm-Gg: AZuq6aJO5e++/6B64B2Yo2ARGtCcdx/ct80eFS4DHae6VgQhhHMs4dLbKUqZBigOdnK
	/KdZ0iCl9dJfFeeLMOHjtcm1AXT5d1XLDkbe15Nss/45kgVmGN/AqrpmgqKG11yTadH2SErnoCv
	KxXz5xt4QfzybdI8KrU6PcmahJLYecrD1bupjVahdwOa+Ko/UuRr0mAQjqf34MsWacJRIe/iOpB
	xfvqvq7FoPZ1+biGcCenW9MmcgJrOaKAUBl5FhpvVmEZhuCFxL6TttIrfowdydaWD8yrM/3Z1Ms
	ClYanvcd3087i2KlZAndxY6OxgBTUWqExlXcqkfO8kLmqtmMsyX2n9WquWZQugwymYc8GTqQw1i
	uk0/aLOg3431crNOKeKIckBsE9joGuMrhkNYtNu93w2wH1ABM6GL+rQX7afHsA0K43LOlsmiGk3
	EnyIQCBp1NUr+QqAj8
X-Received: by 2002:a05:600c:4590:b0:479:2a3c:f31a with SMTP id 5b1f17b1804b1-483201dc4afmr84421225e9.1.1770484376542;
        Sat, 07 Feb 2026 09:12:56 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-436296b2ed9sm14431652f8f.5.2026.02.07.09.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 09:12:56 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/4] fbdev: au1100fb: Use %zu to printk a value of type size_t
Date: Sat,  7 Feb 2026 18:12:36 +0100
Message-ID:  <444f0cd1a39cc665a9e2d76454138c3e71c7747f.1770483674.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770483674.git.u.kleine-koenig@baylibre.com>
References: <cover.1770483674.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=PRKEEDXGhUgRfpyYcSE3CgEOIerXkC5W3JA9O+m7CdI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBph3KKcBNNlLuyF2eU4Ccfaudr5J9crWtOZK1PN HWEfAJlSNqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYdyigAKCRCPgPtYfRL+ ToB/B/0fa+zXGHEdcQtdjS6hefpe4i2HuWor/LdzHcN5SvxDPpkkafdLg/Nn1ZLvflE2WZGDH9+ P+L4qa5JejM9bl7hUMM0RqNHn2q1VUAkwoEV8BEelKh29X1+gzD5dius1pzNzdYpEGftBrtmQN3 2Q3V8hXt7hAlDIUsHyzgImmQDFYpnkK3jDZEAYYbLb4XuSrJ9zRbc7/dn2s8f6xYJMzB5IxUAVw BRT4TSmBs7jsq7c679S1FR1ZJb7xZkIIpQJ2+THh2OiFURZg1AiLsIyeVHL7fFgXp3wdh2QQnUv alKfy1xlA7blicp3dwziHpAUCXJp+2Bv5QV7rzkAVB8tzkKI
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

%zu is the dedicated type for size_t. %d only works on 32bit
architectures where size_t is typedef'd to be unsigned int. (And then
the signedness doesn't fit, but `gcc -Wformat` doesn't stumble over this.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/au1100fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index beba8befaec9..a0e1aceaf9a6 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -456,7 +456,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 					    PAGE_ALIGN(fbdev->fb_len),
 					    &fbdev->fb_phys, GFP_KERNEL);
 	if (!fbdev->fb_mem) {
-		print_err("fail to allocate framebuffer (size: %dK))",
+		print_err("fail to allocate framebuffer (size: %zuK))",
 			  fbdev->fb_len / 1024);
 		return -ENOMEM;
 	}
-- 
2.47.3


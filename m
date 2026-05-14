Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7933CAE65
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747105; cv=none; b=Vepv08pUpZ7GXhDg9twSjLGdOdhGsCQxISrvQOKpcWI0vm7goSMFi4do/54lqLzIxRuyh6Gzjfg1l3gycagBPx4N3Ji1vfiZttdzOlQZAVrx/jYhHoeUyjIpx8SeS3eJHuYOe8vyDrnafaaeWrC9GEcoErzQAOZdq4n9FT9CIug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747105; c=relaxed/simple;
	bh=8Z8K1cxzOFKrVJqTydIBAVWPHk0uegI4AOwudkIAUMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sjWG4LgErlHaxVUZuGaR8KDgjdhT7zQCRLfLmGDBPIto0U0wSB27gR78GWVvo+bbiUTzfsHVMrkCeWcxtYx6ZLdotAhFjETx8czUhVLDkBlFKdf206fhhQBTbvqYhxkCQ/yN5fOA16PtF8d3p3wVCKG6HcBqM7//y+GCnw2OcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=CVsKybsX; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="CVsKybsX"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c80291e6237so5544925a12.0
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747102; x=1779351902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7d38f+IaIo+LqPs0VUxtKb87zLxGu6BC7Fyaado5mzo=;
        b=CVsKybsXWDXuCTZclc+ut8IMXNhmqIGPBFYrMQkaLFXdFfmujFt98fCinanHM64J8H
         53iFU/aBY0VpBu+TjsfeF/QtiAe2+CLoM9fdvsu/HKrO7vp2LOIpFbnAJCbc+DqB4asj
         tsWkdQpJZ7UYDiAaaZQA3OPxUDYWTXdZbmTqePGte5tfr6+srYAvPnlDWClkl8V2qbcN
         8DMHRldVeI9/e04AAEBGFmMt0M7Lgg25kJXnsCbhvy/zVxFIH4Ad4KAEaaCD2oWtmxPF
         1T6gIfm6HKDFci2DeiwsgdShtfrC9k4IdIcs1jE+7U3vLAV1TA/9pDwFft5fRLDlhfPZ
         615Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747102; x=1779351902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7d38f+IaIo+LqPs0VUxtKb87zLxGu6BC7Fyaado5mzo=;
        b=g4VpNeYotMUrSVNXkycyIZcZY3fKoe79gxUA/7xFvBatpsYDgjAX6XOKqTPY+1rcQc
         ljqr/9CosgQjhcYakMJ7PEXt1WgbyL8iOcoRjYcrlnJJAnipeuMejftGotN8UhXYeuts
         2Lqhs4UR3h3WkI654CGKC24AkcHKwBlT96GvVPOJMnamRgQYFPa/B//XjK7l/8uJ9JtM
         5gV2AwbqdJeVZmOI3rBG2dMnBp++oa6au4n1lyW2w/Qk/oA+gNoASm9jVuwGMxCvNEQi
         kzPdlAVC1U7Uzu7hZb4xlF+SgZMuGkMZj0V4fQ1TVQ7sOLd5knhifkMU3k2hVSJi5fjq
         m7JQ==
X-Gm-Message-State: AOJu0YyeyGC7ZU/fcfryp+A4c7KYQJ+gomX9pGBzDxoxS9WhGw0/GDwp
	hdXfdivZdJYJQsN66VojNL7S88HdXEnqJlCoV9UxKJOcLErnulHG8/WRDsOoeT/42mo=
X-Gm-Gg: Acq92OHxFUvFDWRBS33gbC+B/YfJP2TS0YUpnI/FOL9a+lYZuTHp1frkiGUy5Yy+fHc
	oMT8MoELW5j9lt816MEhxsVvzfx+4/yUgvW+vM+04TYbGlxzKBrJmiPvUr49WFztiQCAIyorQGb
	jM+nHbSljtA1KKwjkN3DBJkLK0FqEfGy9BD4h0ZjuURZ8d7zW4KmBj4XVgLJCMPx+wxet3+MACQ
	KYloOKSTAVLrGhMEQoVgufZy7HJHFKpRJI/tM02thyqyCBbGxJG6UVNPI50fEOjyHqfeg71wyU7
	Op7PCbm8vjiOlVQ8g8x+LVvlFjr1vyvGlkVANjsk0Cje92e6i56vCJRtLrT7wiJWBQi/qRpUWC2
	abxKTk7eo7BphW20yZjnUXRExtKSf1sxq1boTIvKbzOWuGiaxgTpzPGufMJMhBlCn7jrL3rUGQc
	WIVKw9c0L3jRZAKV9T3TbHf9g7Dkq3o2fwK23lgUzXRKC4pxTSOgoBauAr6lkmDdm/uWSuBYNHj
	ymwGZeivpQtLmAKBSV80Lm0ezy1H757D1bC3NTWa8KSqTYdizr1u/A=
X-Received: by 2002:a05:6a20:7495:b0:38b:d9b5:5de2 with SMTP id adf61e73a8af0-3af83e4433bmr7439055637.50.1778747102141;
        Thu, 14 May 2026 01:25:02 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:01 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:31 +0530
Subject: [PATCH 02/14] fbdev: broadsheetfb: fix potential memory leak in
 broadsheetfb_probe()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-2-b3a2474fa720@cse.iitm.ac.in>
References: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
In-Reply-To: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Siewior <bigeasy@linutronix.de>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, 
 Ondrej Zary <linux@rainbow-software.org>, 
 Antonino Daplas <adaplas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, 
 Krzysztof Helt <krzysztof.h1@wp.pl>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Michal Januszewski <spock@gentoo.org>, Heiko Schocher <hs@denx.de>, 
 Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0

The memory allocated for pagerefs in fb_deferred_io_init() is not freed
on the error path. Fix it by calling fb_deferred_io_cleanup().

Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/broadsheetfb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index c8ba098a8c42..582f1ee4c9b6 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -1072,12 +1072,14 @@ static int broadsheetfb_probe(struct platform_device *dev)
 	info->flags = FBINFO_VIRTFB;
 
 	info->fbdefio = &broadsheetfb_defio;
-	fb_deferred_io_init(info);
+	retval = fb_deferred_io_init(info);
+	if (retval)
+		goto err_vfree;
 
 	retval = fb_alloc_cmap(&info->cmap, 16, 0);
 	if (retval < 0) {
 		dev_err(&dev->dev, "Failed to allocate colormap\n");
-		goto err_vfree;
+		goto err_fbdefio;
 	}
 
 	/* set cmap */
@@ -1121,6 +1123,8 @@ static int broadsheetfb_probe(struct platform_device *dev)
 	board->cleanup(par);
 err_cmap:
 	fb_dealloc_cmap(&info->cmap);
+err_fbdefio:
+	fb_deferred_io_cleanup(info);
 err_vfree:
 	vfree(videomemory);
 err_fb_rel:

-- 
2.43.0


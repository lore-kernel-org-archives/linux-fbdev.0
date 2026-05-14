Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6603D75AB
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747127; cv=none; b=Usz0SsNmaV8yUXEC1NjyusCPIG5BWfikUI+UAybaZ5XB/iB1BZ7prXZy4N78YaIPmn6IJaJOke0cDO3oHYClFjWKmFSjuR3qA+e/8cYlC8tiBzPJJiqU3C9RgoGcQFYopNDVSV0yFY3DSttkCE1MPslBoXa0F8aqFTJ+iYK1IWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747127; c=relaxed/simple;
	bh=7dxxrzbqdG+D1liscZGC4J7GXbPSfqu94rWrjh7Aoes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FKHonjundBd/qnr7r6jUQ4mrxhnKnbgch1EcBckOgwksR51W/POeWTsD+wZZOsjAzlsvhE+JQw/cyJtce/RQwCOBf+JUKswItHC97/PfIpyZQxEHf9Q2SwjRoONkLY3BdFDYGZwgwvOhAR+jvsN4epBEFGFwXlCdy+GEekYieTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=Om9xZZjh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="Om9xZZjh"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36900945df5so1021729a91.0
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747125; x=1779351925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cj4tsYfpJn1h72OjlKL8YrS/bESA9WMb/nnrThUnbQ0=;
        b=Om9xZZjh2bxdxmVNCiYljIo6TEXd0J4seAO8DMoA8QqiHAAoS5TJmjXsFgeTQSAKTV
         YY0Fbnwc6Adxo5JCmEUU23QUdl27ML8rnMntB5Tr2n4iiuc1czbhLqiLGE8i1csg7oGK
         c/dzGAOP4uEGt9eW/rJggM17RmUPWqPwEqCEyMCru0ZnazRwJInWSLBebCuSdLFuTTSd
         a9A6EL5rDoDWL9gPS+AzElv/NnFkkOnnicS3jApYybmvX4XNDxgCpNM6uWnQq0+Ddb4b
         ukXf9upoU8AYTKIa+L09XXOAUoPgypiklhfMJ+1P5vdYZ7g21byhK0vLuumwEyHKn5Oz
         /Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747125; x=1779351925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cj4tsYfpJn1h72OjlKL8YrS/bESA9WMb/nnrThUnbQ0=;
        b=LSu1rCaoXP2QUnsOM0GBs00f5+EjJ65pgSU05phitArlJLC17YRRjDiJnC3Qlt53lG
         WWwaVqE9eGKo2GPunVQy0SrxjCI2trG6wnmmk5xKFXqtwqUebejz3MbVAnz0bJxs+AaL
         D5pOEkcS5LQRCHq4I9DMGHa10VXbKns7JJcYGBi8r2kZAg3rpnhv6DU1LTd9EraLxknj
         VOqEeXJ3qUbvGmVOlsnGIOKY0BdN/6XR7/TzN0kk9WKwsZLC2p8e0Vn7teFbD7uVcQsw
         2pOyvGAh709L5Ys6cxj+vRN3WJnVtLkZiIvV3u44HMD4Z09IMREXAaLO+yIxJOFdeIMF
         Eukw==
X-Gm-Message-State: AOJu0YwUBwSy+u5ecbyXp4zrKjPUPaquvtOdnT7SZqBwLe7wXhSVRqv6
	ssfKMS7POS2c7yTTTbmQP8tOrdE8OB14erA0fhNNrWPaKNmJ4/uGDf4e2TI7AwO065g=
X-Gm-Gg: Acq92OHLafgZoWMJZlJ3db4pb3QqemUzPDDi5BAwXqJyJlOur6hFL7oDfIIj25HGVY6
	AvRv/v/gJxzfvg/wcQZLmk+lCIipKtPdnGfRfV+CfVnBFYtb/mpJGDjDu3ZxLJMnvIh69Y6H83v
	TgB9YF3aIREvNOgnRn3Wn4dsBPt4gTTZoG3Vo46jucemmINBCnLxNkT+ozlT86yhhpcjwPwCbQt
	hQVHLhD1R2iZtVQDtLd+V5yg6T79E3FPbDN6xkPiQwMMROW52w9O+eBK87IZL/R1CbKP79+IUD6
	oCjr7oJOj35xJJeULpZWkTz4yu9CS6MG6o6YROCgsk/wJ0qmIBOjovMM9kZd/kAEpQ+oY/Q3Lw6
	FPofbe5EH/cmdwAwfx5+kFX+YobobSNuqSjqol44kxfZ4oqOgo/wIBOFj4sc3OoMOxMKXMpPDVe
	BOzw52/aZKSvdmDG/2qfNcfzWkSzMvWKCEOqWelwycPe3tYPZb0RtzjhSKcxwK1bgult203DnZL
	NfUveCNwNvMaEdZNvEPzqNSMDrwTD+kTY0Gn7OgX7CJ
X-Received: by 2002:a17:90b:2e4f:b0:368:30bf:e51a with SMTP id 98e67ed59e1d1-368f782f1c3mr6794705a91.12.1778747125031;
        Thu, 14 May 2026 01:25:25 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:24 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:34 +0530
Subject: [PATCH 05/14] fbdev: carminefb: fix potential memory leak in
 alloc_carmine_fb()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-5-b3a2474fa720@cse.iitm.ac.in>
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

The memory allocated for modelist in fb_videomode_to_modelist() is not
freed in the subsequent error path.
Fix that by calling fb_destroy_modelist()

Fixes: 2ece5f43b041 ("fbdev: add the carmine FB driver")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/carminefb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/carminefb.c b/drivers/video/fbdev/carminefb.c
index 5f13f1cc79d3..fca50b7961eb 100644
--- a/drivers/video/fbdev/carminefb.c
+++ b/drivers/video/fbdev/carminefb.c
@@ -589,6 +589,7 @@ static int alloc_carmine_fb(void __iomem *regs, void __iomem *smem_base,
 	return 0;
 
 err_dealloc_cmap:
+	fb_destroy_modelist(&info->modelist);
 	fb_dealloc_cmap(&info->cmap);
 err_free_fb:
 	framebuffer_release(info);

-- 
2.43.0


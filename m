Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED83D905C
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747167; cv=none; b=FXMKGQVX9GNgbssma85oRc//nEFIAqDmSrt9yxLt8Zh6Y5I+K5J7dOtEbGP4mKs1WV5CdNxDQ+uHMbyLXXjfh2NYbZ3Bk081fBcgVHUxx/sGh4s1h9r1DVg3rMQuzfrvjkai08qUcbOfDHRBwQYIJJaHH03YzhmG7tSCl+uXces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747167; c=relaxed/simple;
	bh=aaNOXqVJslECMUlTkP9KNemoHAJsvHiIdYYefjAnxgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MwPRiXa6w5WSYy9UOYZWzDFBkMDA5jroNXlt5FJoMeFTxvx5ws3Z6AbwcmGR9l0PVkx7xaICuLATHhZjFSNA5xGzTt0PbGzfVr1rb0ODv0w9iFOXVEyWvnKd8Ho4cG8+wItQQ5M6aDI95nXIypJSczk2GKZTbVQS3two4DkRDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=oYtY3QWB; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="oYtY3QWB"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c8025aecc40so3837691a12.0
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747164; x=1779351964; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4r44B3WqzqqOS4+0yZVm7MlIZp2ZYEB2HNnv71bMuBw=;
        b=oYtY3QWBvWnNQfJ9iYtDy34uwIjcmPjJydL+pdKMozvPw8EXoaF0jhg0qxPlVx6Ht2
         9CgxPXKyzTXRfr0maeLaORztubY+XdQcOmw9vaW7grigWVWmUxTYebElnZxj+/7WiHGY
         moIgj/RLJwJMtexdStRWBCK3mmVkVroZqq9IBTklTZ+GpVodRn6zfosNmy40OQnF97pc
         r7gRdLlLAQXnsUl8ntiVPThYIcWFVtO0/YjJgn5pUo7LTqhiG6yQRs2AJFp0rRHZPQbq
         mzbs92fueIkPtwhF8ZeT9Yf0X0P5POzzkIXszBGmuLsds19ck/oAFKGw/XGq0Hwhnfwa
         tlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747164; x=1779351964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4r44B3WqzqqOS4+0yZVm7MlIZp2ZYEB2HNnv71bMuBw=;
        b=LEybgKPlLIJO1d5fpVcghwuX89JRARI+xwcoiYSUnddjyy6nqhZ/d2/1NH4Gq7zbmK
         kbrwTX7rlvNVZGtTb/L1xtAzFT9q74t22Pb7tFvVAmVnw3X/pNFVHvGukt2WPeBt0rnB
         TLdjEC6fT8SSKshsXiI5xYYzsfBc+7YTh6Zt2/MgDn9Tl5K7KB9EUsv6BCTnaVkuYfBn
         jLNYvBwZcAMbf6F75W+AEoASyZ3oP/vhaXRGS1tm4wqi6XhK7wXR2nrPLxMzlWvhEazz
         +S5esjm/T25m9Kkrg6WYWpdRV/l8d/DzIA+ya/zIA9VEpU+a3J0R8oeD5zilQQvRKnjv
         PgYA==
X-Gm-Message-State: AOJu0YyCIB9G9l6bKSIycs9jrWUIUY/b9rDRwX5z755NT0zKypOPMLN2
	lIwrFReD4NVQDk/XTt2nz288LY4Zg62r94M6qVIJAoIvJVH9Brkboh59ljG4rN+Kxfc=
X-Gm-Gg: Acq92OGXrPVAOXN4BeSvkLwdh1kA3HMAHO/L68upA6OiRVQRt/Ffp+MUNQMlJhp769v
	R/pwQrBCJ0Qpjub/aIkT2kuL5oFIuwulxY3RlAn51eTk4nys1vkbLuFL0h7bGenbeWkyO+pDUQk
	DYgCUCktMy8xSdG6AYRc0QcctbK1WW+GR3BF05B6HFGNcyVamxAmwT/voxvsBIXinnPHyG22Yiq
	4+9ojPe6i+/HWEvTsmjgwrFLl6prDtJaPMrv8inbCDFRZXHvicv5ZCw4EktthsZxvAHX9TWLzK5
	2O55PZv9EL9yYivu/0afQcO682Z6+HpQAG2WkMfSC64K93c1VKBbbju7YVKn4dw2OxtZyuNG5rb
	GIIKsMtL9+TuZjAhBE4dWny9qTmD3r+iSrjx6awOYTyBWSZyWeYLB8SujxayChTw/R/CAGhRkHu
	RklLQYWMxZ+CQP2qRxu8lvWfRKEgjo+TlSAvsbr2Hp6OhRXGn3xI8JdQanrNL1tmtp5aXFJ8evq
	WFwSXTFQeri36Z8OwRN+b7Ecx9LOrqRX/E3oDgxdOYY
X-Received: by 2002:a05:6a20:ba07:b0:39f:c93e:c7f7 with SMTP id adf61e73a8af0-3b0bacce1e9mr2039565637.0.1778747164402;
        Thu, 14 May 2026 01:26:04 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:26:03 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:39 +0530
Subject: [PATCH 10/14] fbdev: tridentfb: fix potential memory leak in
 trident_pci_probe()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-10-b3a2474fa720@cse.iitm.ac.in>
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

In trident_pci_probe(), the memory allocated for modelist using
fb_videomode_to_modelist() is not freed in subsequent error paths.
Fix that by calling fb_destroy_modelist().

Fixes: 6a5e3bd0c8bc ("tridentfb: Add DDC support")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/tridentfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
index a8fdbae83a80..9f055ba776c8 100644
--- a/drivers/video/fbdev/tridentfb.c
+++ b/drivers/video/fbdev/tridentfb.c
@@ -1706,6 +1706,7 @@ static int trident_pci_probe(struct pci_dev *dev,
 	return 0;
 
 out_unmap2:
+	fb_destroy_modelist(&info->modelist);
 	if (default_par->ddc_registered)
 		i2c_del_adapter(&default_par->ddc_adapter);
 	kfree(info->pixmap.addr);

-- 
2.43.0


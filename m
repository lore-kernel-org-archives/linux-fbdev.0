Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761BF2E888C
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Dec 2025 05:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767072548; cv=none; b=tDzOSU7dE+ptAx+U+y8oTybljTeTYuGzWsLGlZoYVYCSK7dVscGLXGWOsW1usZp246fcKPWIbXHvkVyyBJJ+HjIEyCbt9AjuR5fhgQ+gDCocMGcIA0/z3dVUPNznWZhEtTJ0YGokk/hDRiUnlFY998859m/xl+cAU9Ia0uQfzXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767072548; c=relaxed/simple;
	bh=86Kzw/hKU0nrIm8xZ8jpwyS+2DiCcDwmWTX+qvqHhFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oF594eU/OKQpXaImBHZBbza+KomIdqH9KZ4i0230YMO+/iwMuhBQQlayY92VIdcZbxyatVr12IndEORM8w4v+ooTGn++YsleJIe4hEYbDAjhN+MsG0tTvjmjl7Acd5AaG/UiENMX/jF2xWqN3SBDOl18wmyxBeNPQFyvLC7xnrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJzkLHf0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJzkLHf0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0d0788adaso86682855ad.3
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Dec 2025 21:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767072545; x=1767677345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKkdwzvSXz/T9pEqrvQ0VdQLUSbrQRl3ctUuH0zUyRA=;
        b=HJzkLHf06dwAcn9J4Ab7958kyg5hAF0iIVEkXaoxbcEv0m0K6stJusjo1zc/w1K/lt
         Tr/19rFS1zNs5R/rJe9uvFxujaOYHYdCLdILTCxqDoWykR1n3pCR+JXzl4n2SobSgt0p
         zX1MyEOUWaAIBj3iRZa+7BSqoVrXNOqYHXN67UCA/3lMP2KJH2GfhQdPGrD/qJKRe4+/
         BkMRIIldwFvgqZRXwS1kXyXPSuJIZHNotrQ+5vT0g6Zy9PNqQbak/Fl5kAc+F+9B+W+9
         XOHU+uTLi6r52e1Zk+bQxL2BJNVFCU30egBOY5T7qW5S9RL3lL+fvpuSJPhvdDog2XWv
         f43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767072545; x=1767677345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fKkdwzvSXz/T9pEqrvQ0VdQLUSbrQRl3ctUuH0zUyRA=;
        b=MUX85qbyYKwHJAlOuZU4QSVnDHo0X8xpCJXJAffy64Q+Ygs/25l3LQnyCXOcskYsP/
         QhIa0xAi+eJUcFevczXM5L1+2Cnw7HGOJMV5/31kmmeRp8F+uK2UATFnoS7+mgVeQcUc
         lpbX0g0Wyd5C/d573yA0yOreii9lzd2HXU+zSUL4dwTdY3YCakkBcpti7f/lrGe5Uify
         3qR2fQzH1yBPRPul/2H8S99UmZSxCm7GRrmxJGiL1SFZrazOzgtoBwQwDuMXUAk80Gho
         i681jI+giCyvKVmv6yMpEJe0UGnRJVVSaaEBTGhFAva9VLvCNRvpPj9mzXXehXJcEmSZ
         UaJQ==
X-Gm-Message-State: AOJu0YzgRM5MgfQfysN+BOk4nx5ABYwwiljY8K+ZoeFC0aV94ZV+rtNi
	7MEOwPQ1RIhmMX26A7q0xT4mbnezPJ9kFPYmu3zTzjbGNYBq4rqIDrZf7yhZQY7k
X-Gm-Gg: AY/fxX5mAH3BfF/xFD/iriy3h3MsKCbGqNIoI+am1I3xvNBt7rrSPWLOCLY2v+lnlRD
	HKOiccBNIZ4Yw4IcG9I3uQmwJspW258M9862P9ONr0xLGfbkWWBzy3MBcdHLqQh1XfBr6Go4ffD
	K3/Wxv7iSiDPw3rr8rJfsfcqnSfiDqDwNPI0M38t9RVBLQKACm7ANRId5WngRbyuL5Agj1CE1qy
	lzKriuD5Aqk9K3LmSF5HEsrHtwB4TMp8URuhmzpK1DH+TUujlZHI8yZVNNWt3yyvr7EQfqrLYbP
	mM974yem/Z+fTmR1jLkyRDF/wfSuo5nwmvw98qZjL+jWHZeIz1LsgKooX3f3tZyhksxAzodcuLv
	dp7IIuxNVE19b44xxC41V8IO1U/KSwqS+drhY0PbJ4kF1FaL+cKrPnaSW3PLZz8dKAJQrZD1InW
	tK53Z3udxCE3WnqR1qEJKEDyPEGMSI6lPNVIKTHaLCJ/v/TtpeBe46
X-Google-Smtp-Source: AGHT+IEF20IOQ3ACEEG5Q9roz15yiegJkgEV49gziCCB4yVsuyx2zyUl9Tnp5LPbFSW7p23DGv+NWQ==
X-Received: by 2002:a17:902:d2c4:b0:2a0:d662:7285 with SMTP id d9443c01a7336-2a2f1f789ffmr344796915ad.0.1767072545159;
        Mon, 29 Dec 2025 21:29:05 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:f7a0:c2f:d915:faf0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c8286esm289290375ad.33.2025.12.29.21.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 21:29:04 -0800 (PST)
From: Chintan Patel <chintanlike@gmail.com>
To: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	tzimmermann@suse.de,
	andy@kernel.org,
	deller@gmx.de,
	gregkh@linuxfoundation.org,
	Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH v3 1/4] fb: Add dev_of_fbinfo() helper for optional sysfs support
Date: Mon, 29 Dec 2025 21:28:19 -0800
Message-ID: <20251230052827.4676-2-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230052827.4676-1-chintanlike@gmail.com>
References: <20251230052827.4676-1-chintanlike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dev_of_fbinfo() to return the framebuffer struct device when
CONFIG_FB_DEVICE is enabled, or NULL otherwise.

This allows fbdev drivers to use sysfs interfaces via runtime checks
instead of CONFIG_FB_DEVICE ifdefs, keeping the code clean while
remaining fully buildable.

Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
 include/linux/fb.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 05cc251035da..dad3fb61a06a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -628,6 +628,15 @@ static inline void unlock_fb_info(struct fb_info *info)
 	mutex_unlock(&info->lock);
 }
 
+static inline struct device *dev_of_fbinfo(const struct fb_info *info)
+{
+#ifdef CONFIG_FB_DEVICE
+	return info->dev;
+#else
+	return NULL;
+#endif
+}
+
 static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
 					   u8 *src, u32 s_pitch, u32 height)
 {
-- 
2.43.0


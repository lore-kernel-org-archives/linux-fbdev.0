Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426E36404D
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Jul 2026 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938000; cv=none; b=GNDJUwpd5XmcTFTIepSlPBN3RdhmCULYLqKfmZBVsJ/XS/zIKmXKeiPDYpgmxRmqfayAXJxnrzNVRo/qItLUXOrg/f3rRkaoQcls16eq7p8Zlu7AbZ+Qb9waoeJqJT68MbMVm7MhVgmN6rHrIXFFa7aPFpvwU17C7QPqYd/9Ob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938000; c=relaxed/simple;
	bh=DbIl8eyUDTcDG004poG9cmmxee7SHYKNKOEke/947Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNzqCA20SJVQzrc1QuKEowMpAJrbmNsj4Igo3xVVon1ZJF330sYbswAI1YaGn55fUGg4SANc4o4O+I6pgv8dsPymRTkQl+H+Hsnx/4IzGLdnta97tBxhVz3YxqPvAbMdzR4x/Hb6y+FiTYJsSYERjhTEeHs1f5jsiI9vE/e1vwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URLUURKQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URLUURKQ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47362928f65so2905670f8f.2
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Jul 2026 03:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783937998; x=1784542798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N9jAAyHAI2D1PucdtnorXSHGwmyQhG7HWP4Mt9DkiF0=;
        b=URLUURKQxH6/IDBw/Edk+PoecvMkAIGZJ/wj+3mtyMzZoDs09AgZiIkiTyxv3tyOJN
         QitwnPn5klRiXbmjekmiCuuaE7XQIB41pg9yP690iLO5GasgxFp7XCytwAMSLTo6fuFX
         ImxG0AmhmrDfcGmNi68XIhcH8M+lwXEEwVGVWkbeODZ3ZANIU0QkM0ewCTMvWayrY0E9
         hcBzQg1VjeuPIZoHpRu9OgNQ+OuOo6XV1E7HR9DsIHItOrkC3zN063SxlqrOlpft+Yw4
         jUFvEASPhbsTrlVFmn/OXUA7tPY0tFKMhf8BPYhhSMMyRaxemTsXXldwotl8JZ7QvLs3
         Duyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783937998; x=1784542798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N9jAAyHAI2D1PucdtnorXSHGwmyQhG7HWP4Mt9DkiF0=;
        b=h2rP9Hx2ng5PWnTMi4NnJ/7VH9IBLnsDYCgp0meE6A1tJz2vaRJnFwjRJQ57w/KlXT
         G5VTFiLeqL7xPaljQc1uFScMysh35gKaGNoBTBq3lQcjeJQHDjtbbhS+m5E/Z6o7W9Xg
         Yfwt+oAgFxSfeYI8U+2elG7UiGaLFNh7afAZ/WPGGCkUxdqPc/eYXC2zWZjtqr05Z3H1
         z8z9WgWB+tSupEcWnu46/zuPxUevNxKT4X64eTCoGD9vMoU18hxwgL1VnPlmyh7m/Njj
         S0w3xtIxxAYpkHKYDuRzQX/hYcNubYyX2jyoWGIvS1zqjWqykk9uR7KjxZV3mOFe7YKM
         ZMFA==
X-Forwarded-Encrypted: i=1; AHgh+RpBHYuAUYrmvSg3ML+JX+fO692m5++87qsBrQgU2IfIqWPEyvxrFMwfW5W8e7yCgvxmPSB7SBRLoupR4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw32xUhXkpdHy+RlbGAajXugUT2FD+QMySZbJdLN2BL9MtpZfJ
	KIEcdXs+Vb3P05h7BsSP1Yhxyqu4a7RCxEo0urVSzuvsCFyYsJhvxLY=
X-Gm-Gg: AfdE7cm0mpBPuEY9MRVHbD9GtQqdXTTzoTql+R4PM2NbSDdvkUZh0ur3MWG0lfqUF8d
	kztOe/O+kgGtx9ImXhW82Y7vkTj6LmZBdwwqANDDR01BfUcjlyyPYQk8AF3lcqlyHgxvXAB4k9a
	P5lNai8rGWroxuHwTIcz5M6HZ9Llnc4bjCPOLxpXsDORO16dvOcJ8lzrFQoMblsQe6vOFO4B2/h
	k7RaJ3q1y9sdwXEX+kiEaO/bEnOgJhRRmKMNOPczAfLX3LDsG86pxbGSyehi0mp7isItlsZqwzq
	sJivJrExZ001rEYKKRmlFKwRGGpMnyOwFVKTWNMCTzQFpOwASjujm1d5hb8DTvuUdbltDFvEOPi
	39lR6GaZNFrjMaVMf2PWF7RPZaS49c3ZqmlzflNG7KP22LFOJMc0XddVRns3U5qZAkiTdI2iSPf
	Ft8h/uYOTjdJ/DQ4QCYHAOwQKvLW8+2yYXnLJc6AVAM1wLMRhJfkQIa7tKWWuj06pf9vRQwQ==
X-Received: by 2002:a05:6000:22c7:b0:472:8343:7f5e with SMTP id ffacd0b85a97d-47f2dc8ce54mr9184872f8f.5.1783937997743;
        Mon, 13 Jul 2026 03:19:57 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:ceac:ba6c:1653:e93a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47aa0f213e8sm83332478f8f.34.2026.07.13.03.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 03:19:57 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Helge Deller <deller@gmx.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] fbdev: pvr2fb: correct user pointer annotation and sentinel initializer
Date: Mon, 13 Jul 2026 12:16:38 +0200
Message-ID: <20260713101638.600333-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __user annotation to buf, as it is passed as a user pointer in
pin_user_pages_fast(). Use an empty initializer for the sentinel
board-table entry to avoid initializing a function pointer with an
integer literal.

Fixes: 5f566c0ac51c ("fbdev: pvr2fb: Fix leftover reference to ONCHIP_NR_DMA_CHANNELS")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607131247.fpQ6eTc7-lkp@intel.com/
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
Not sure, if we do such changes, but as I received a test robot email, I
leave it up to you all :) (I also compiled and tested the change)

 drivers/video/fbdev/pvr2fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 9428716e2dc4..a6e7abca7a06 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -639,7 +639,7 @@ static irqreturn_t __maybe_unused pvr2fb_interrupt(int irq, void *dev_id)
 }
 
 #ifdef CONFIG_PVR2_DMA
-static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
+static ssize_t pvr2fb_write(struct fb_info *info, const char __user *buf,
 			    size_t count, loff_t *ppos)
 {
 	unsigned long dst, start, end, len;
@@ -1077,7 +1077,7 @@ static struct pvr2_board {
 #ifdef CONFIG_PCI
 	{ pvr2fb_pci_init, pvr2fb_pci_exit, "PCI PVR2" },
 #endif
-	{ 0, },
+	{ },
 };
 
 static int __init pvr2fb_init(void)
-- 
2.43.0


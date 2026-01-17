Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8F72727FC
	for <linux-fbdev@vger.kernel.org>; Sat, 17 Jan 2026 04:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624266; cv=none; b=aHVIXkueIyCmpzF0OmMk6FFCagfVuUR4Qytb7vLsx2i6CUUyIwpt0Jt/8djpE8q/AleOP7IcAp6C1mtSdy6PHDaWFLQYzgoU5/4JDsjkD1VdAv/1+RFSm/sChuoDRtibL9dBIKOAbw+/ro9D0ZT4de2JRX2ELAaipGr81rW3loQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624266; c=relaxed/simple;
	bh=uE69x94dEWXAgSGtMUCZSUPtE0Tydj3bf2EuX68TmvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B31KvzeCJdLOsrqtBYywpl4VycsIgT5lLBa9bWuUR63RRWLnOftkZOG24vaM7877QYNkpQiDtdGQPuJW1pYYAbWsLXo7K/SbI73pbvER5/E2UQkfH0QpTDr+JS5uCrBMRaHwWFP54akxGFvaMK/+Fm3JCN2AaE+iqAwok7c6l6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDYIrEK7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDYIrEK7"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b75e366866so847482b3a.2
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Jan 2026 20:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768624264; x=1769229064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w/Q0mSJAiu6YE8Oa45NpmmddauxEQc9oB3CUI6p98s=;
        b=gDYIrEK7kw+pFIwGnWPm+9ITFl3jqdvGAWJkX36W5hgrmi7p04T/wsi5vKhD5rDMwW
         e7Tq71jDIfKfm1JB/K11VkZa3XIgwjjJFgGU/6R7J1KllSlDm0GRO34zn3GVDsu0chXz
         iFH/IIeyCWQ9RZw2YKoZifP2+vt+wtfevk6RWufq/RbAc8vF8U/bLrb5pmcO5hpzbJ0y
         i9ZUubziXYpzeZBHun6+BtVfaD2txCo8wdbNa1jPNJrWA0i7lPAr4DMjbNtr1+cpbVn+
         PyJ8A5q9dhtWvs5kN5fOYDE2oY767SiD0FIQWDEHwDK3g+tZrnHahoX/mEg8VcRtcpj6
         fYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768624264; x=1769229064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2w/Q0mSJAiu6YE8Oa45NpmmddauxEQc9oB3CUI6p98s=;
        b=CL72O5MeEkVOfwfwuSrPJNd+moBN4e91OOMSGG/l+ulewMfMtBwGtxYoZ+OWEWiw/n
         JS1HWL5xrmJ7PtD1mn6w02Wfvlx4ZskBhi0HkRn707I72PLzPV4nuNQ3+FTpJ8+TUY1M
         2hyKjYeqp8Ct8vN/awd/dxTzTctkeyuZeS2Jz2d5OYWbMwuvWg2EHltkER1T1hzlRnzg
         BwwyAoeFNQ9T7BgBTiSe3LxGp2VYnFTBCewWG/+u8mQcHo7bmPZUU0glZyCTuSL4PZSM
         Y4/EUsCqhnuPGFiWin70Tkx7h7XKCQGcrj4RoWqRB4VnvOTRfPY68ayJvNRwrLqkc9+a
         cEaw==
X-Gm-Message-State: AOJu0YxcnjLO1VhtObZ6oH0GJ94kh4GKPc4ulBJud9SNAKa87rjrImfD
	g2PVxXEmznW4pNz4W7WE/YXzAQP/TxFE9bVmq09so+AgPD08M4FPnXboJ9P1ew==
X-Gm-Gg: AY/fxX5r0TdSlVY4PuYEOha3hXMsIap94VvsTJQPl9l7LiD5B5Ym2UPMSwBszc3C/bA
	RAXleT9muIV16kUX9cSUkV1y+LxvwCxx97JbgY5twC9atTVA/HPR9wxa+Nkc8Ugmd3aWGe/+rm1
	LjaZpXqSaCMfkzO7sivG4ibToi4wlX+GPBH3Lpd+SFlk88zuQ5XaDRoHtP9uxYep/m+hAdx09DC
	e5aGAivMg1hFlh/fyAN+cqLsFvsjed7Qgp8/AP/2y9TB7ohPH5lkRb38oi3i7W6uKXkKo+NvghH
	jtawmDHZEYiamTVAWKMsR3KZ0uyo01jOLTXHI8DXjIjZ84bH16f+dDyhOPsGbG2hH4h4iEIuuEs
	sLva3IT5okIbosKGcMo73e5I1YBP2LvVbOfb1IFbn1tuYM7FC8vAQZmXUEOLEUbGgvUmZAx9pj8
	jF2xxvVWfnhsHg7/dnhORmVxtBdZAS167RIJEPZLXl1ZJFs+4GiCqKIA==
X-Received: by 2002:a05:6a00:2989:b0:81e:af19:34b8 with SMTP id d2e1a72fcca58-81fa01e487dmr4740579b3a.43.1768624263888;
        Fri, 16 Jan 2026 20:31:03 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:26af:b454:d793:29de])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa108b23asm3370159b3a.3.2026.01.16.20.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 20:31:03 -0800 (PST)
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
Subject: [PATCH v7 2/2] staging: fbtft: Make framebuffer registration message debug-only
Date: Fri, 16 Jan 2026 20:29:31 -0800
Message-ID: <20260117042931.6088-2-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260117042931.6088-1-chintanlike@gmail.com>
References: <20260117042931.6088-1-chintanlike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The framebuffer registration message is informational only and not
useful during normal operation. Convert it to debug-level logging to
keep the driver quiet when working correctly.

Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 1b3b62950205..f427c0914907 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -792,11 +792,11 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 	if (spi)
 		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
 			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
-	fb_info(fb_info,
-		"%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
-		fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
-		fb_info->fix.smem_len >> 10, text1,
-		HZ / fb_info->fbdefio->delay, text2);
+	fb_dbg(fb_info,
+	       "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
+	       fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
+	       fb_info->fix.smem_len >> 10, text1,
+	       HZ / fb_info->fbdefio->delay, text2);
 
 	/* Turn on backlight if available */
 	if (fb_info->bl_dev) {
-- 
2.43.0


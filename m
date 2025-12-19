Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BDA2D323D
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Dec 2025 05:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766123031; cv=none; b=tUaeyOSQWrcdZ7i2N83H7uDAp/2Q/zUs5+HDSPQooGHyhpxe/9Cm836KV753pul3bGdbPOanYHNOIzMwtJZE6P1EmmoxvcnsqREJIN7rAL3crEKoAWmNBvigITmNitITLThBrhSdCOSFXcB6bIMUU3vBu0mTdeKoF9a8XY9dqvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766123031; c=relaxed/simple;
	bh=wTBNcJt2rI9S3EuSYIzTN+CG+sDnu9ds+FK4O8Ikt9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCxGUEXii9DG5BvlzWUMBESIFD1HyyonrHtmLlaAq40TxesapStNht8e+k8lHAIYusID+JZgEvN4JEmUtnTDVpcrsD0I+yoc1TYZ3+kjut6ZMSIHmcTiTgroKy8XDzveAfok27MxdRYduarTHpkVbQNFICczOxKa302mYNqbizw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqUXsznZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqUXsznZ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0a33d0585so13296975ad.1
        for <linux-fbdev@vger.kernel.org>; Thu, 18 Dec 2025 21:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766123029; x=1766727829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyhsaHMpowAoVL5AwJvNjQeVURBtbaVBE0KV9gHYSKY=;
        b=BqUXsznZ8P4OyXHuXngaPVscRGGIN/svI91ndgycwFbrr3iCcwu5Wn2+sFPD7AOqlk
         kXcxIW8kg1HeXADbKto+/VAnpIErudnnYXfZh7TopzCAI5uMtMeuVGs63CsH5aW7X3eb
         koehOKM4CqKu/7rRtLf4ezvx1k9ZZ6ovrvkKZI1mi1TA9/X7Vi6hFSn7Ttbcnlvtdrvq
         lIC7ugaXETfdBVwpsloxNv7ijcTtBBODJ34LxSmk2bGuUiO6KQa82Q5/ulYCx15DeqNv
         HyodnIMuUS5nHuaVni4opLEi8xaHtL5oc7ZJFMs5w20s0VtXyd+r2eGzucpOSXneXhEH
         /K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766123029; x=1766727829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GyhsaHMpowAoVL5AwJvNjQeVURBtbaVBE0KV9gHYSKY=;
        b=gS4JbIarqmfNX8Bu6D9ggaNpH9I6X/F5UimXtp7mCqldFrzz7+NQVpAz4brE/LoFeT
         y48UK0SEbDYLAAT71C+be4rroOWjw+XIUE8w2kB6nvPvBQKawGfuScqTMCinz7o+Ris8
         fExd6yLhELkP0xatF2Llf44FB/OXoN7RJqq6YrGw9MnSeR+zL7WuAUU4yUgtM9nM+s6/
         uFsxRWv0JSGDJzBGDE/KGU+4u97JOlz1igxkvNoTpbUJJkNGf3HbwEXJPDVk7zmi27MV
         DHjHsRW4y6c8xh81FV+peG+GgFUoe0tLGhBLgkiINdeKof/fiwmJ/kceYX5wd3TZy6lm
         Kjkw==
X-Gm-Message-State: AOJu0YzCZriQd+RYnRuJJVRnqIFvyqgvvQTuYkvvelizj/4Rhw5xehbs
	zMvfNAh6fP1rhRwI8dlBFphEZm/K63qIzCbcyLoUUnn9C7UnpRyh0UmuCk8kApj6
X-Gm-Gg: AY/fxX5CMSi1fVlFPLjAe2kRuFZL0mSqS2iz8qYqKgJpUnR2heXytG2PW9B3M3GGUNU
	WQkvu1EXlG56qO4erSFGVOwK2QksehFhk/E5a1lJpvHUaUKn64nTHUqhQYzrqXQnYWl0ghUdNRB
	u8pkf1XsG9q2ZnvgMHWASLNSuxI5lV40T03ZaAvEl2OfZjZLMsgPTw/zjB57+Qz8dQ1nK5SuwBS
	uPdS/YRZB0FvMEM7X2ibHGj86PALeMmb9fBsytLMc+TnBw23vOdJzW/HfmL4Y3r6wUCFPlAETGx
	Q/KdpwcxeUjT9E3hl1feGcngg17Fvd9WWdusUOtuWQ9PIFxPJcMUDWKDotQBBwxjxc7zd+pke/m
	+kIAutKNSsNRnxi4b+ypSt/6eWUwy6n0zZgURrXm6lFWj3oiyfY8HJtTUunG6SzLU4yB+q0WChG
	XI/C1KvtnZ4AualA3Nz28mpEADHDO4mJfseWbpy4W+3dU=
X-Google-Smtp-Source: AGHT+IHXEchSi8iM+Y5+MS3Ww91XngpXuQu21mxZ8hWmVfsLgeWot8cDnyt6+QWma8zqSPX6kmHH4g==
X-Received: by 2002:a17:902:f68f:b0:29f:1fad:8e56 with SMTP id d9443c01a7336-2a2f22049acmr15569505ad.6.1766123029021;
        Thu, 18 Dec 2025 21:43:49 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:5160:2cad:cf88:afa5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3da7dabsm9878955ad.25.2025.12.18.21.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 21:43:48 -0800 (PST)
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
Subject: [PATCH v2 4/4] fbdev: sh_mobile_lcdc: Make FB_DEVICE dependency optional
Date: Thu, 18 Dec 2025 21:43:19 -0800
Message-ID: <20251219054320.447281-5-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219054320.447281-1-chintanlike@gmail.com>
References: <20251219054320.447281-1-chintanlike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sh_mobile_lcdc driver exposes overlay configuration via sysfs, but the
core driver does not require CONFIG_FB_DEVICE.

Make sysfs support optional by defining overlay_sysfs_groups as NULL when
FB_DEVICE is disabled. The driver always sets .dev_groups, and the kernel
naturally skips NULL attribute groups while the code remains buildable
and type-checked.

v2:
- Replace CONFIG_FB_DEVICE ifdefs with NULL overlay_sysfs_groups
- Always populate .dev_groups

Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index dd950e4ab5ce..704c17ad241e 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1350,7 +1350,16 @@ static struct attribute *overlay_sysfs_attrs[] = {
 	&dev_attr_overlay_rop3.attr,
 	NULL,
 };
+
+#ifdef CONFIG_FB_DEVICE
 ATTRIBUTE_GROUPS(overlay_sysfs);
+#else
+/*
+ * When CONFIG_FB_DEVICE is disabled, define overlay_sysfs_groups as NULL.
+ * The compiler will optimize out the sysfs code paths when dev_groups is NULL.
+ */
+static const struct attribute_group *overlay_sysfs_groups[] = { NULL };
+#endif
 
 static const struct fb_fix_screeninfo sh_mobile_lcdc_overlay_fix  = {
 	.id =		"SH Mobile LCDC",
-- 
2.43.0


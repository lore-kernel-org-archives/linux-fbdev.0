Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857872E88BD
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Dec 2025 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767072552; cv=none; b=P/jZ1prZI/5xNEWw6oW+MFz7+A0ntd4UXwEYZaH999UdPHAy3ASuV3imQE4x8dtdkFId70aB2tQTGycPwhZGQNDvGdsl/3ciAyHuDNgfbxDFIsAb8MDdOoKYM57WtgoIa38It/m2AJpIuXBux/kkqYstOABcqsail/xQPxxeEkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767072552; c=relaxed/simple;
	bh=GAGjpPhjgIvIUqlyfKlbs+tqnrLy69m1dh/HDqos+sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQm48zZWtfAJbc6DepH5iFLAf+fG8TznYG+RrTf+Mxa1sVWXVw6Owgi9Mp94vRHkaHT6Mqw6XehwIr5DrvcVaBvnBaw/LsbWZgZAFVwQa2PE1h8gl8UClJ8canTiPu3XtmM8z3jtY3qunobbFL8emh8TZwKCbGA0SG0LT9mWirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+Lno6PO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+Lno6PO"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so85995245ad.3
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Dec 2025 21:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767072549; x=1767677349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJqOs0RXEJY8E2s1bb5OeUsv+WqHfc5EFgK5KbB75l4=;
        b=H+Lno6POnxup92vGJ1f7ihfIfbwleJVor6tXER17rp/zQBaa0niWobKLm5AbfdzeR/
         1LFNoT44dIFX6+X+48yM9SvwxfIhQ5uDHGd1aPQTALn0LxlKaT6G9XcL9Ib661xNUxh9
         MEKivs33TvK/o/XVoU6qIeN6WNA5/Q5ibLmKKXG8W3dYzvgahRTmiLoFsZuTRzWak/1E
         8ddAiXOPjqKc07lcqS7we5idlVmNHjULmlY4ELJ8mgPHI5hoQLOZ4v2kbTEBZXML4C2b
         qjwa9cedy+B2EtA4/z0dvZqkG4woKTpUna8tDuOfsehAMaVRjq9MEE1AJ1DfEagYeITw
         0XrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767072549; x=1767677349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LJqOs0RXEJY8E2s1bb5OeUsv+WqHfc5EFgK5KbB75l4=;
        b=Cry3Gu44egHSpU9PFnfdzkUsi5vLvMfMVBcgbEg8yk78QlluRIgabfm5PeoFKWW880
         p3eu23lnIDDj2ZV25Nd3YXnG3vlcnNCPYDD2OEfARqYiAE0A6VRkMlU2B1znlzakpUR3
         A3Fp2z4DPlV5esP+O1K6VlcHu4GCANXtabiOcechzPU555GCo7kJsP2uVzPqhlTuAqgL
         geSABMptpgS01NGybz/Xv9fFfFEAQZaLebJY+0RNlQarl1kO32ABTpe79gmL5fThH/S+
         mpmKvpG1w6yJ29/wTVpUV2bdn4pGsF8x53cqPKOmksREBVrCqfRZJrdEk9tOY1YoG9r9
         b1cA==
X-Gm-Message-State: AOJu0YyvqBvNaH26SiQG/CTCuTol/4h/qwu0PBiJjYqb0fTSGIx+xWp3
	lO6oCeTxbqLUVz52zWW0FtFCD/8jfLnuSrNiFfpdqnYIVhs1MokTvdny/e0Gl0tO
X-Gm-Gg: AY/fxX6XrEKm4ubXYwF3fa7xDN3oTOxqm2PTqGwzev21XkE3a81NgSMp104NSe6TNz4
	/rThDKc0XbSNk5GrCCkOvEvfFN8uSsyQmSJRXxHUt1IQHyaoYPnTAEk2ADRO10ynic2SvNjX3Aj
	r3ADp/L98AWHfNN+Cy0li/LrjIUvS0xKiAnoH3jb8W6/C8RPPPLQIS2NSVkQYW3Cm8cjsasEBfH
	g2pz5irPNkbieGfjY0erVJxi7Uxxin9qB5V16GoZ3gOBu9tSHevQepnuQraxDFtrTjiiz943au/
	NJCZ2/lv+VFszNjEDVfu7nQ/WTi3IPq+7DQd+SPixSnM5AbJ0s6/nm0WKzqLFaw3cKPqwArvZ61
	ROZSiyDjdEAQs9Yl1yeaxNM7nzcc/94QmNB0muMp6mR/1VR7OsrIhhfavpVKITOW8krCzMa8F20
	4hVEtSUZmJ6LKaIebZaL3qaw9dZNo7GAM7oA7aC7i0jpL0VF++s9el
X-Google-Smtp-Source: AGHT+IHpNTh/+mtzP6KtG3m//yZa/VBoJcww6MwkW4PNCEdqrAaxVfXefkHC54eoavSEs+b2060qpw==
X-Received: by 2002:a17:902:cf08:b0:2a2:ecb6:55ac with SMTP id d9443c01a7336-2a2f220cbf6mr374425555ad.7.1767072549441;
        Mon, 29 Dec 2025 21:29:09 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:f7a0:c2f:d915:faf0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c8286esm289290375ad.33.2025.12.29.21.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 21:29:09 -0800 (PST)
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
Subject: [PATCH v3 4/4] fbdev: sh_mobile_lcdc: Make FB_DEVICE dependency optional
Date: Mon, 29 Dec 2025 21:28:22 -0800
Message-ID: <20251230052827.4676-5-chintanlike@gmail.com>
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

The sh_mobile_lcdc driver exposes overlay configuration via sysfs, but the
core driver does not require CONFIG_FB_DEVICE.

Make sysfs support optional by defining overlay_sysfs_groups conditionally
using PTR_IF(). The driver always sets .dev_groups, and the kernel
naturally skips NULL attribute groups while the code remains buildable
and type-checked.

Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index dd950e4ab5ce..cb7ed1ff9165 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1350,7 +1350,17 @@ static struct attribute *overlay_sysfs_attrs[] = {
 	&dev_attr_overlay_rop3.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(overlay_sysfs);
+
+#ifdef CONFIG_FB_DEVICE
+static const struct attribute_group overlay_sysfs_group = {
+	.attrs = overlay_sysfs_attrs,
+};
+#endif
+
+static const struct attribute_group *overlay_sysfs_groups[] = {
+	PTR_IF(IS_ENABLED(CONFIG_FB_DEVICE), &overlay_sysfs_group),
+	NULL,
+};
 
 static const struct fb_fix_screeninfo sh_mobile_lcdc_overlay_fix  = {
 	.id =		"SH Mobile LCDC",
-- 
2.43.0


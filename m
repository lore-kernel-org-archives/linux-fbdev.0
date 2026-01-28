Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363473093DF
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605519; cv=none; b=bUmbyOA/fxnIAs2pATK20qcW11I5+g+riNhkdzzqs11KBt52nUP5kQ49W74Nj4i6QQOF4uVP4JX9xXD6yuW41SzrusCssWIIVjIKnS1T89QBTtj+kVez8s2SPHUlJOxnAruWit9qjxSPwaoelcG2ZJyM+BBvBZTw59WMOtm+yyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605519; c=relaxed/simple;
	bh=rsHKKUqIFIU+jzfxFZDz7U4jp7ISiWCLS5lmLXmOoGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fh56b+IPOuqB8w/15k+bfELbjk6u+s7UO/Ea88b4bObe6iZ5LtsbBWwyPJ5nON/Xk3S2Q02Bu7McV6FcMOI9I3F248hJAf86l7PgPcDFTCPDnG7MDXl0HR6dsOq217IGP82JpGP0ajF9I+HfjhumD7V9vbVmUDGyHZCeeIzw+hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehpLolAg; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehpLolAg"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8230c839409so5549622b3a.3
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 05:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769605517; x=1770210317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=60aBumMe56xZXRD8vE8OZN2hvZkCH80+CQWsk/u8eek=;
        b=ehpLolAggx/M4wmFSzs4/9rGdT2LcGVc9D6fThl0F3luWmYK31CB1VecMAg9ueF+4a
         Pqpeub79nFUGSuFfz4hljb3L4rPDdBeLPC/x5KiZioYgjxUanSeOnmPxfYudhyw8DbfR
         ce1wcskTY5u946m1Lf+nkD6pB2/oolSBpfbH02z+G7HfWukHaCmnMi8yWejuUFXvn4Gt
         0HKzA7+b4ivCdsXdwX7UNAHPuWEomvmFtZfnE8ZFNdoSMxY/HT0twwMYObNtcnJDRXuR
         E/cVukgknLvNCGr2pzqWowWX0bPv9UmKq5jYmZw27ag0saJOyRQIeSzOHjlTRozMngyl
         UtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769605517; x=1770210317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60aBumMe56xZXRD8vE8OZN2hvZkCH80+CQWsk/u8eek=;
        b=YjFt6e0Y8Kv6u9fWFqHgwtepBERJJqxZGwftc6iLZy6l3ld9G/UFB/j7pVl6PduWge
         9DhllfKhSeVRolMHTC8Y4pjPL+8oZV2NtEj/yzKb9ohWDEA6veyuRDOQQ+LjFhO18AxE
         gigvclAn9DfA8sQkvokcQEVfavbc006yky4+bo2xknuhHIMfmDEk8LPMDM2Z9j4nyG/e
         ja2f1MVB7gyI3wAtXhj6aWyldrrMKyLpIgpIBKZ8TnPtN4yL/XjmuQmqoJForelMxQ86
         I3H9xTvi2ORAVALSFb+VLU3LfzltAcdIRmX2/mmQmxEBWRSp9EIHsbLPJbNG/zSeqqNj
         Ibng==
X-Forwarded-Encrypted: i=1; AJvYcCUN3nPDzcIWKZXnLw/JeeMrhl6BrLGlLBxEuB5toh7mrO9tERD+SkdmVMEoRgY1X6QUS9oOVvjE8gAGLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl84sQjWvgv8f0/Hy4hqL0/ca9dKC8vVWrxw7NYAjIAa1ROWvj
	O3/26zNWm3h8hEtnbrRR2xD5s/MaMGxcO2Cbsaow4yy9ldwjJT8yddpv
X-Gm-Gg: AZuq6aIUEnn1LgLym1KsyD9GbI6S/ZTwYRIVNxNK120BN/hx+/ZLF7lhquCDOfUxdHm
	9AjFc/6/6QGAYEWyEd3GSclfekQJTLUjr44CPxE/PZ/kl/XfY4+23m6RbbuMJTabyPmWDbQU863
	IO/kFzmqP4u/QZpulAf3ZKuvyrR6xJvLMMlGQvwI3mTkazJqZ4PWR+SyKH/pmdAyMQyHM+wnrUv
	BJNguDEt1tiWCEobsI2U/69GRa9gVAXx5gdJ/84DoxNrBz4xbxkujBLynjP+Z59sW1SlkBtWdFB
	HQKJkxwfEIdrc8aZZoyP0RVPmMnL8IefcvwhstFQ4j7lq2Zkuy0NBLo8zsEQ+SsuXB0L9gWVKRE
	dIWqMDnCPMY2wrWCXrzXV0TKWa/xRazSui0DFNU23MuaLsL8fDQZ3eqeh37LCcvmp7xtF1AGHnq
	/3gOuC+K1vtu1qbTbpTJG03va3Sw==
X-Received: by 2002:a05:6a00:9506:b0:81f:ac80:499a with SMTP id d2e1a72fcca58-82369199b5amr4580614b3a.20.1769605517452;
        Wed, 28 Jan 2026 05:05:17 -0800 (PST)
Received: from localhost.localdomain ([58.231.102.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c50fccsm2569978b3a.60.2026.01.28.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 05:05:17 -0800 (PST)
From: ChanSoo Shin <csshin9928@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	ChanSoo Shin <csshin9928@gmail.com>
Subject: [PATCH] fbtft: Improve damage_range to mark only changed rows
Date: Wed, 28 Jan 2026 22:05:03 +0900
Message-ID: <20260128130503.868466-1-csshin9928@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of marking the entire display as dirty, calculate
start_row and end_row based on off/len and mark only those rows.
This improves performance for partial framebuffer updates.

Signed-off-by: ChanSoo Shin <csshin9928@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 8a5ccc8ae0a1..0fbdfdaaa94d 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -415,8 +415,11 @@ static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t len)
 {
 	struct fbtft_par *par = info->par;
 
-	/* TODO: only mark changed area update all for now */
-	par->fbtftops.mkdirty(info, -1, 0);
+	__u32 width = info->var.xres;
+	__u32 start_row = off / width;
+	__u32 end_row = (off + len - 1) / width;
+
+	par->fbtftops.mkdirty(info, start_row, end_row);
 }
 
 static void fbtft_ops_damage_area(struct fb_info *info, u32 x, u32 y, u32 width, u32 height)
-- 
2.52.0


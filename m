Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E56342519
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592146; cv=none; b=ZvSqTuL71eH6sgxdPhufay87IwX0lhF5fvnTblRfk/DnlY63Bkvi0IAn+18sUSMrFa7CaST8E5IT6uIaXZ2Pnnk9Z0CIUU1hKVZllu21UksjZpYC3aqWyHYu1dDjH0p8gXbwxMRaEUUhFDP+C3O3tMelw4UyqlK3U62rWX8j3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592146; c=relaxed/simple;
	bh=J4xPd1IfrfMwRUhA35VU8gwe3m4oudk3ftkWf8tejlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXo5YSF9Lc67hbB17i3vOUn7OVdAoV7SKIOU+brIQPEry1xO8oJuZ/ZjyQO1v5eOZ1P3fxbz28ABIwuI5Whba41xFh0cFSEty+EErur2F9vsnBg4HX/9F/P4Tr7hthhLcqee7EmQnWrNvcB6kRs3ZVnRqHtXE27GDjEs9qFqMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dI0/K6Rp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI0/K6Rp"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-823081bb15fso3715749b3a.3
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 01:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769592143; x=1770196943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/20MeRTWa/ulLtC3Qbnsogn/fAwzsjqDT77al9NCJDw=;
        b=dI0/K6RpByOAV1e56krtt8Sk6EuAq6ppgtCIG6myrlow7Xykqr4bg3BmHdooHS2mMv
         ErkznYdcz0y30zVNRB8KOTkhctPCz5KRWWMF+FExU++jlSNt2mb43tEmtsbQ6AKzNCnN
         jDPyBWZVNaO4Mkm2pgLiAkTRDRQUx2040VgePn3p2SgTIXwyyffNrfxkAIYgH5PAu1Dg
         7YtzVv/oNuQaSooqX2Q6edE26Y+7ZliCsYXppqRMcK4ymtlgkOAFBU7W1Mf3Cz+AxmeS
         bXDrwXP1AvFEQcnbdryROnIkvecF1izGh5vGvdNgiqifjJS1xy+/bsBxar8XWlUDlULN
         QNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769592143; x=1770196943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/20MeRTWa/ulLtC3Qbnsogn/fAwzsjqDT77al9NCJDw=;
        b=Xwf/LyrlDgHAuOz6gg+qUYOZbdHbqCX8dq5o9J2bNyifNlBKnO+lnHPhY1m9UJWmOF
         il2LmZYAv9FgyZtCQsj5+eBQcnz+goTD5c9HQwFXjG9kOssWMRGCOUm1ITfrvtPMwnzL
         PbhgXzz/TjJ0EPWfgQ7//C5VXCYIoSYOLZzzitwKmOZ0JQQMYL2RBR+roiBPED5yJQCJ
         uYvEdr0MOUxgGy6txX24Y7zVCAeCxqpcIK315s7EbY5ZMmXSQs558D3wi6xAaYZ6XorO
         wACfyWIacYCwPjd9Az5wNHo/xJed0e45dsKPt/HBZXyZu+QcpI87Gg1AhN9vU3ywJhrs
         mPyw==
X-Forwarded-Encrypted: i=1; AJvYcCWfoPd/FxSZ8uvNa6BTZOKIezp0abDMQGSO362nhGWDwwUpAOHp5O14ozAh4+vc6Uzq8nDWu2bosqA/oA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yydkb/sA8GSYlBCWR7prI/nBhAHB3jUezgY4TJntwhxS5zuapnR
	IFL7yHPbXrIHarG7egzcQvpa7/eA15aVvSdwGtt7/m2iPIqXd/e/H6zC
X-Gm-Gg: AZuq6aIZzhyk2g/65aOdjayPJ4PSijfoL4wFEtGzUQL/vgtP5Nm28YGHRNWhMTKfEgU
	UBIBMRzoiyEUeJEVG4ROObln5Bqejo2vnaKUdgsWHpCbqx+lewnPvgG4Fa6jqXvLcaB/5/PuoPO
	dGAHPIO7TKPd6aZ7by+wmlsLZn8BK9RtH20cVMFEub0uoGplHOigOPIAar5o3oAav2eVhcBVLWP
	nbelwUjUvYlPMYd1qQNhWGsIawMkOUKZxtitVU3E1J8OK2DL5eMV+8WxCVE3MzY2sFMqo0PiPzP
	EBFehiX2nj5imoJ2fmU8jdWcV3O2n65svpWVxAKfz8XkexlNv7x88x39XTAt7ysk9s0jA4SMWEw
	B1sGmUy1ZCqFa4qkERlKY1x4w+R4B+YPoWaMAhl9+0VQzJa+6YkGKU22/G6Wu9NlsPvK2lfabaU
	hPz8nMUrKrvobdGxkGJ1E1OsRz0g==
X-Received: by 2002:a05:6a21:6b0d:b0:364:13ab:d4c5 with SMTP id adf61e73a8af0-38ec629f950mr4457135637.26.1769592143279;
        Wed, 28 Jan 2026 01:22:23 -0800 (PST)
Received: from localhost.localdomain ([58.231.102.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642b0b4c07sm1758138a12.36.2026.01.28.01.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:22:22 -0800 (PST)
From: Waffle0823 <csshin9928@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Waffle0823 <csshin9928@gmail.com>
Subject: [PATCH] fbtft: Improve damage_range to mark only changed rows
Date: Wed, 28 Jan 2026 18:22:10 +0900
Message-ID: <20260128092210.864021-1-csshin9928@gmail.com>
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

Signed-off-by: Waffle0823 <csshin9928@gmail.com>
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


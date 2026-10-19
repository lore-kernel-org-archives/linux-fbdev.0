Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C24AA024
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403032; cv=none; b=vCQ91IsqdM1deVI9HVU5opId23QdYw4e/Wk8n744k3sidilkgYDUyE4sB7vLiVRbtjwrhS3tE1t9SQ+MpZfy4rkAeLR2cwr1loa7EKEV4lJ84Uh6LiZCmLHaPei2s6vxO5U8pMkjSGKIL49wIkrq1hqMh/fAXKJyOc2ZIh/dC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403032; c=relaxed/simple;
	bh=xFgk0mJKcQyQYp2XJYOl2hd1I9aMMN7ZqbRdpp25/zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWTnCH3pNnhfCjQoBbBWbY6fNAzyc73yFE1lv7SdXJXxObve146YsjNqK42XbJwWnwlzrvlNIo77E02weyE7dZhpOkbkSJMzD163ISK+4GVL/FkaX1K8pALcEQskD0xtUWEbN+C8Uz2XtIkJdb+6kalV10zb1Hxfdej/2inyTUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmZ0YXgU; arc=none smtp.client-ip=74.125.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmZ0YXgU"
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-35dc2af1f2fso1214475eec.0
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792403029; x=1793007829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IHd99zSc7XuTxtPtex7CCdBAnhkgrWqdaJDnZa0vj8o=;
        b=SmZ0YXgUwhZhzMzKAQZz9Kh6o9jAq9ZuKLDDd7AjCDODMQGR2V5l4Ma6ILlIOFTPtN
         3uoDf1guZqmSL/IQM1Ft5dmU6gbeTdKLkXGzrgqgvJo0UsoplnN1Vj2Sv3iq7OgELdS7
         p+q4dy7xuac9UDhSeM/bqsKVEx8JMmafB2B6hjk3J1gnmVhw5KwkNb376+roi4T0Qyso
         opvXrTsNMxHiA55HSQzqhNeRO8LKCsopOPJix972kjMOMKWHPK/AbolhAP45eZrg8pQe
         uf8n2G/2rNGZY9AteoVv5SxRNZdxB48HlwRhSgCepsL5oWOgqMIVmCltSGjxUBDJqaVN
         NgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792403029; x=1793007829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IHd99zSc7XuTxtPtex7CCdBAnhkgrWqdaJDnZa0vj8o=;
        b=M1fE0/Z2B2beQabo9VsZIcas4im0dx/Fpt/7s6LHBrM+m5AEGFwYaB0faeKvMfA0CF
         YNrPr8hpQPrQDta1+yASsBpEAxkNZ1SmbJ04mxBi9+Alp1gT3QyEor87YVT8uUjjA5VV
         Ob/AeHarjqxINKwF8niueiTNM4NGY3azv64x5AWc+ohMxF8L5Sq7uIrguyYI4nmW1u1k
         6v/iNQM1evQDnHaMRz9Qm8U0N/MfpugQZ3RC/321/pm4WSWFwj3xlJStJ+vj6pkUUKS1
         kJnMRX+nyc/ro/3/PMk5ZfepMHc7bd73IrQgOMvynfuOiMzehjwjRohQfnZfunJr+tlU
         oryw==
X-Forwarded-Encrypted: i=1; AKwUvByyu1YAZ31i5C2CTWFgkFIUpaunfo9M5xylb7jwcnumpEOrB1ADnONba67hMI7KkoxYJtI+CaCXVukFbw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLZPtXmvRZyEstyeUygYcwzLI8gxpFDfZJo/gFDBNwx37vyHbEp
	gQNV55cog3Dn2WmFGoraYgeytZli1a5Do3c+P/wZKJlW7YM/txagZENu
X-Gm-Gg: AYBFou118BVRkyS8dkFMr/kDpR3Y+BB7SmIPdrd66BVENmhYTxC01+Gm5UnFsMcX2p+
	7HUn46H0H8njmgCnkAXZS16s+KG090+gQPaoAaeyUwr9c/jEjgNNZiuVlZjlbzawWWHProGRPv6
	s+88N6AOhMOlGgz7p0A3yY7ehgIZI3IDNSZ4n2w5vQXxKRyXfsyyvlAF3zuzIt/GKbKkkgLZ6AB
	oEDC6FAD1XGOl3D4yrUI7MivId79n9kDX3NRKI/LIZwcwdvkcZ9X8ZucRVT+4GSt8ZknIvLWLCY
	T7fKZjiqAup5pFiba0a5xJy7hTbwbhUy01siM614NxiaO4iPS+wyjo0iwZjCNQlh1/m5R6lgrTk
	tIE4KsFjyH6GXdI+gK2S+4GovyY87ZtXoXb0J8i+3FS3q7do1Kp5Dj5/8QuOPlWE43/fcvWKiLH
	LdJ0o1GVUX4eTnljtgQR1JGhXq/sVQJ+Qxm4+Ika/dWza2c1ZZ0vnnUtr0sD4cEVr/FP91X4123
	vZSqVv705VTpjp49YrscOinybxoxQ9QjWTN
X-Received: by 2002:a05:7300:ea0b:b0:35d:8c39:b31f with SMTP id 5a478bee46e88-361a2a3e8f4mr10129688eec.35.1792403029024;
        Mon, 19 Oct 2026 02:43:49 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607bc950f9sm34370074eec.0.2026.10.19.02.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:43:48 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	Yao Yiqi <yyaqia@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/3] fbcon: Include font geometry in the rotated font cache
Date: Mon, 19 Oct 2026 17:43:29 +0800
Message-ID: <20261019094331.1128871-2-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019094331.1128871-1-yyaqia@gmail.com>
References: <20261019094331.1128871-1-yyaqia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() caches a rotated copy of the console font and
skips the rebuild when the fontdata pointer and the rotation match.
Raw font data carries no geometry, though: width, height and
charcount live in vc->vc_font. fbcon_set_font() deduplicates uploads
by byte equality, so the same bytes re-uploaded with different
dimensions keep the fontdata pointer while the geometry changes, and
the early-out skips the rebuild.

The rotated cell size depends on the geometry (rotation swaps width
and height), so the stale buffer is indexed with the new cell size.
Re-uploading a 4x16 font as 16x8 on a CW-rotated console, for
example, doubles the rotated cell size and reads past the end of the
old buffer.

Record the geometry the buffer was built from and compare it in the
early-out. The pointer-only key used to be backed by an explicit
width check in the deduplication, which commit 1e3c49aa03fb
("lib/fonts: Compare font data for equality with font_data_is_equal()")
dropped.

Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
 drivers/video/fbdev/core/fbcon.h        | 9 ++++++---
 drivers/video/fbdev/core/fbcon_rotate.c | 9 ++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 407d207b14f1..bfbd70f8b1cd 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -89,10 +89,13 @@ struct fbcon_par {
 	char  *cursor_data;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
 	struct {
-		font_data_t *fontdata;  /* source font */
-		u8 *buf;                /* rotated glyphs */
+		font_data_t *fontdata;       /* source font */
+		u8 *buf;                     /* rotated glyphs */
 		size_t bufsize;
-		int buf_rotate;         /* rotation of buf */
+		int buf_rotate;              /* rotation of buf */
+		unsigned int buf_width;      /* geometry of source font */
+		unsigned int buf_height;
+		unsigned int buf_charcount;
 	} rotated;
 #endif
 	u8    *cursor_src;
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 6cdbc96eeca6..660a3fa81bae 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -21,11 +21,18 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	unsigned char *buf;
 	int ret;
 
-	if (par->p->fontdata == par->rotated.fontdata && par->rotate == par->rotated.buf_rotate)
+	if (par->p->fontdata == par->rotated.fontdata &&
+	    par->rotate == par->rotated.buf_rotate &&
+	    vc->vc_font.width == par->rotated.buf_width &&
+	    vc->vc_font.height == par->rotated.buf_height &&
+	    vc->vc_font.charcount == par->rotated.buf_charcount)
 		return 0;
 
 	par->rotated.fontdata = par->p->fontdata;
 	par->rotated.buf_rotate = par->rotate;
+	par->rotated.buf_width = vc->vc_font.width;
+	par->rotated.buf_height = vc->vc_font.height;
+	par->rotated.buf_charcount = vc->vc_font.charcount;
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
-- 
2.56.0


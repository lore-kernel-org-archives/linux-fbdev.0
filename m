Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA3940BCBB
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400544; cv=none; b=bTkwgmYegCJWm1BsOZbvT/6eS2HbGqbOdOIRylrXjplSWxZgim8iWFE6pK6qHcrfQhpsxSDWTU6LjMUEZN19UX7xmq3FJ5WbGRSU9vtH56ItBRNVLszjw5QB61SL11vZwHvREmg5XvrqUacwMd9+Dl6xrsPwW4GR3ZCWHbn4b4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400544; c=relaxed/simple;
	bh=xFgk0mJKcQyQYp2XJYOl2hd1I9aMMN7ZqbRdpp25/zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VP2RitCDNFx5l1CnyTlqq0Q8a31+1PiCqqd2CiZo+eVjS67gJ5HPQxWZUEmI7NehbW/QAXXV9uWTfd1az3ZIQq/2umAyd/7USjtSIcKKTnXbrDDjJwwUC6vh7BWua0NKOonhQ3WzhxmaM+yEXRi2pH0oxDgfpaOni+9N7RvlNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhjOpC3D; arc=none smtp.client-ip=74.125.229.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhjOpC3D"
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-1433e7b05b0so456236c88.1
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792400542; x=1793005342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IHd99zSc7XuTxtPtex7CCdBAnhkgrWqdaJDnZa0vj8o=;
        b=bhjOpC3DZcZWt1M2rCWyUyJSSJ2FB3JvhYW7k6uUWca2z4wJHyG4MnTPUMUxwgepRz
         l7VZVgvdiIeTJhBq2kzpsEfm1/wOc0xGfvn9DqS36NkZJkL712CqI0S60E6cnMOl8fbc
         lzeyL9Ir2uTBMRrlL3J1fEEQl9z+UXzgW8nzQL3eTK69BXhgv73djqQvJPFQ4tOiCH3f
         OTFwLEXynvLz5jnEHSp/LJsrgbKwgstms2IegCPuccCh5AZmuZzqAyFanl6siKLl/Gbd
         4lp+v2WvlW/H8shbypHocM4WNxLXilQ6YFgnMLAGnXX8tVXMBtAlTO88LppJGgPzRZ0b
         rtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792400542; x=1793005342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IHd99zSc7XuTxtPtex7CCdBAnhkgrWqdaJDnZa0vj8o=;
        b=ZbbcL9BCo4te1WDwAD0wMviUoiJAYQD+ycQCpJh0ZRQJbuiN4sqiNQoFPp1qJ4E77X
         EMJyH1MDYI7eL30beaYBo5yHaYOayT+nQ/Bh0Ny5MrGmbAdNgUJ4wC54a7mqB5LLdO54
         aIjhiH+Ua5HzOX5gyvUQFg35sJvOSs1r7MAsnjYoImciZBMtR6ZZxu12eXvYJi5t+Nf6
         0UNoAQDxfOFcyRna/RkiEI5onHnXZqfKydto2kU+dWbGvnHZv9Ci1YxKoEyI2dF4ZVDN
         LW7Osq+fPScluJQb/+VqMvC7SJr6b6BDAUKjxubb3ralm0zwopxFlK7HpOMoxvKEZWgo
         YG3A==
X-Forwarded-Encrypted: i=1; AKwUvBzV9zxwApRBhTadBBYkD0JKprlqH07cHH6g7t4dCW/zwgUhwjZjff20HRiVFA+V/pFxfV3/F7oi2b6JHQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYL0NwqjaT74oIz0U2dAEPdMuaosF1za40DLUUHUU9Qq4eF/f2gN
	ZZR0XK+9EOUUngU679qfr6LSNRdOD+nw23A2HA021pVPLVU2buf4KGAB
X-Gm-Gg: AYBFou3tGW08oG3IhRVOVqUaSP1we/sL8ubNLk7NxwtbW4VT/VdZ6U/eS13wHtZoZrb
	NHtx3G8SzqSJSqczmmyP1062T9w3dIyeBHPo52q49TI82YWK0GqujZdTvtOPtUb7YR+PekA5hmv
	2YLbVgD3Bu8fL4gfQKXt/HKzxTqCJXqF8YVjTKbjE+Wd76c0ixA70h1/an9DmQZINXYsuYtVnVx
	RsesUhbZXrvzRqaLHdurwCFxmy/jInWNPenGVZj7l2GNGo10tvoIZn1Li0XXQGeEDEcuIojvhCc
	tZ64YpKeLw+wYNAf0uQmvn5kiZaJyyzL463edhnPDNdD/PVUp+LeF89h8zN8KHsQwzhvmZpdDcV
	On1u3XOrWUI8xTuheLvvd7ky3ziItPKnxdU8nYEzLDzw1ppK352Ia7oblHZvlvKHQv5fu5/SidP
	LtG/xIkjwgqqjKuZ0Ht/0DLaTz+SnmuQ/a/fxGZFOLqIJONV+eKUfptdeqDyFzpZDXR/KOAJzHl
	1cHNqlWz+s1FYOfCuBs5upmRjsypRtXOYo=
X-Received: by 2002:a05:701b:2601:b0:151:f0c5:7a09 with SMTP id a92af1059eb24-18513b99fd0mr12384383c88.43.1792400541807;
        Mon, 19 Oct 2026 02:02:21 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm27085064c88.17.2026.10.19.02.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:02:20 -0700 (PDT)
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
Subject: [PATCH v4 1/3] fbcon: Include font geometry in the rotated font cache
Date: Mon, 19 Oct 2026 17:02:04 +0800
Message-ID: <20261019090206.1094958-2-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019090206.1094958-1-yyaqia@gmail.com>
References: <20261019090206.1094958-1-yyaqia@gmail.com>
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


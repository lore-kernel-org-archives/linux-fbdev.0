Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A01381E8B
	for <linux-fbdev@vger.kernel.org>; Fri, 16 Oct 2026 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135860; cv=none; b=JYHNpLyf+g78CL9HnXIo2TL5/NCIp1fugjB8Zp7zPac3B8EhvnG/dgOFq6NWkAW5AFtfJdULkXkJ4Al0//2iweFULus0KWzxY35dGeo8ZoRk1YzsTXM+JenrvpnFc38w6xavizgRdqqJtn9t5FC/Z1lO93JvG8nmzeZe/A0/SCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135860; c=relaxed/simple;
	bh=QWhK+UeEzM2oEDWzEmpI/fGm08uGiHZDRKWGDSbcnBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0j6VRmQvTrxfAJpzKO38aIXSoVQuP/HFI3dTkMuIhp4zW8wv7d2M0eN6rpFvNKGnh3l/ogZZENrLuuG9Gud7vbklOLAZ0iwJfL5z0Jd+AiWj0cpqKMgSsMwJGp3ujGQMAv3HP5iRwqrYAiIJBYpF00u5usCiHm0hTbHb1JlOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2I73NMI; arc=none smtp.client-ip=74.125.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2I73NMI"
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso3016679eec.0
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Oct 2026 00:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792135858; x=1792740658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K9RBwK9DMLq2lboW1315UiNuKOkVh7UxaSWlYUZP2q4=;
        b=W2I73NMIzinF6wM6cDFP6lrhp0WRWskiF0+gJoT+kyNpOYr7g7pbTtOxBvfahcYxMA
         G+TW8fdvOrhFLxjLqOOUtvzAZAL/KC0XRnplF7Ice9ELn3lINhommX4gX1Zf70FqFb6G
         XRZbEEdCP30eObj4lElQdlgdqfY5N+lky3tWLG9H7CKqgtETsCKwspy/R6rP5uodIwyM
         lCnb65SP9hem2OBAgPl295QH3LB3VDGwBbNOM+NnH8HQHIKSvyFnIOr2IZKXyKkgwd0o
         gIVauLVZF04wSXmwux+2b/yhpF0raLZd6lOiuI8g28jt8jbqKXh6oqDeKFOX2jhTGgcp
         mAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792135858; x=1792740658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K9RBwK9DMLq2lboW1315UiNuKOkVh7UxaSWlYUZP2q4=;
        b=W22YcZdUqqh8BOHKaBI6HeOajMGakEH11A53l1TdfW4XC7AZ/nBaPTGLESh/q0bJPD
         kX6yYD6L5vsm6U/uIAVZn4PJOJJWkg26FZ9un7j1X6snt7iJGEts1iEbfOC2es1whFhZ
         1/mkgkT2VZKCf5PS6fE3i8DXLSsByPXzKCeXTAwBPbPlVyrDRCiQwN5724wRnHG04oe+
         EoPeqwe87aut79ywsk3q5rKP66OYwuw8CfDz98TEFlEuCg4/bnU9cNPYr8zQpLe5iuSB
         GKfTJkpdUbGtL2sE7BSW/UKTnp51JenmLWStIgsAQpUMOAfyg2lBmGf/9EYKhOQ3wE9G
         GArQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhsWY/VO2+yEt8fFwTrjp19Dfuk5VzoCU3FKHlNRDfp/AQB15QzKC3ftVJVm1B7HhcqmEyThtGiLP9aw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL3WMXT5pLwbI0H2icHVjD01Pq4EGvflhEaOQxJ4JrfWQDq2Yer
	mp2veFD90bQobzGo3n6rU4q+ilgkGO8FJXFwupTbfJdMpoRtnIAMYeUW
X-Gm-Gg: AYBFou0nPNT4mKR2z0Njj4w0C281bo45L1+hEd8Kejikt/3yG/qq3rfswcQnhmD3Aol
	53kMDncH0TJf6GcELMcD3PHL1NCJG1jeHIcCdq0CXGQlc6K7w6ejMJLQX1pPPvISKdjSBVPW10j
	v3OvTFoFRxOJd4FSZ0GePiuQYtt63bqbhZ5+wO5GY+o/oH7FugkOMkHh27U9HO4+M8sE3RBFkRS
	mKZLYu62N3Dll5XhT4/rQ6PfPrSBP+q6ukkYu0bo5CkGnznYJGS0SFUmb4wyv+GTxP+hcvZcHqu
	DVYnuIlkt0Xa9hvvB1B2/NZYwXINF3MLxX13gKsNGzD4UgUGlrqeAz494vN3OAq05va/h/fBgex
	IDF23EPmvkJMqy8BE7Tr0ImXNvNJ9lGpdcv1Bxn0mrIKSbjMIG99eD4DJ/+RcBfDFrJZriygD0h
	qsJG6YgaenIle4sUYQm4iB3FGnKs7gGlL8R6pQjRtyc0eF7wXPGwOkrIAKGpS+z6IDhGaVSy9t6
	zFIU3QhkXY2zH+9Z6k9kZ+X+rEkmHUji6Y=
X-Received: by 2002:a05:7022:5f04:b0:17d:961d:7db0 with SMTP id a92af1059eb24-17d961d7e11mr8510456c88.28.1792135857744;
        Fri, 16 Oct 2026 00:30:57 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f58c2sm5367021c88.11.2026.10.16.00.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 00:30:54 -0700 (PDT)
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
Subject: [PATCH v3 1/3] fbcon: Include font geometry in the rotated font cache
Date: Fri, 16 Oct 2026 15:30:21 +0800
Message-ID: <20261016073023.490430-2-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016073023.490430-1-yyaqia@gmail.com>
References: <20261016073023.490430-1-yyaqia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() caches a rotated copy of the console font in
par->rotated.buf and skips the rebuild when the cache appears to be
up to date. The cache is keyed on the source font's data pointer and
the rotation alone, on the assumption that an unchanged fontdata
pointer implies an unchanged font.

That assumption does not hold. Raw font data (font_data_t) stores no
glyph geometry; width, height and charcount are tracked separately in
vc->vc_font. When a font is uploaded, fbcon_set_font() deduplicates
it against the fonts of all consoles with font_data_is_equal(), which
compares only the byte count, the checksum and the raw bytes. Two
uploads of the same data that declare different dimensions therefore
end up sharing one font_data_t, and a console can install a new
geometry while its fontdata pointer stays the same.

The early-out in fbcon_rotate_font() then skips the rebuild, and the
rotated blitting routines index the stale buffer with cell sizes
computed from the new geometry:

	src = par->rotated.buf + (scr_readw(s) & charmask) * cellsize;

Rotation swaps a glyph's width and height, so the size of the rotated
cell depends on pitch rounding and differs between geometries. A 4x16
font whose 4096 bytes are re-uploaded as 16x8 on a CW-rotated console,
for example, grows the rotated cell size from 8 to 16 bytes, and the
largest character then reads past the end of the 2048-byte buffer that
was built for the 4x16 geometry.

The key has never included the geometry. Its exposure was limited,
but not eliminated, while the deduplication in fbcon_set_font() also
compared the consoles' font widths and total byte counts: with the
charcount restricted to 256 or 512, differing uploads could then only
trade height against charcount (such as 4x18x256 against 4x9x512),
and even those can change the rotated cell size. Commit 1e3c49aa03fb
("lib/fonts: Compare font data for equality with font_data_is_equal()")
dropped the width comparison, so identical bytes now share font data
across arbitrary dimensions.

Record the geometry that the buffer was built from and compare it in
the early-out, so a geometry change always triggers a rebuild.

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


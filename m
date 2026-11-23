Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442764;
	b=plj4Akn/kDA2NcQUHEdauOulJjBRSckgjZNho2tmKngXrYYUkVfux6HFqgPldyc2rOyj
	 n2fH7WIt2hB8MEbIpvXJaUjFo93LckO9mzXjCxUQVyQ8GhjCINAF/s/epER5cWOX6MHEa
	 NIeaTUwafSCl5VcLmxmlcT07vXDJYJ9nj0Dxlk4WOB1ySS9Xf+BdZoQ77xQth0/12qAEP
	 +omX87XPz6FW6h0+7RR2H7iTNRc0fQ0NCw4i/8qc7Zk2TGH6nWwOGZGsOGpw006TaO4E4
	 u+U5yAxERiSmoZNpENm0PzQu6iS9NiYOLVQsrmZ07KSvekXzkk8ElX5EUI1lQIbvmfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442764;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=akifXYVY/5AXDWKkCXFIRC9bawAVd4VrBG0rlaR+urA=;
	b=edZHLNJdvtwU+XJuU/eh2DgbwktBtqlBoLZ+mAOS49CEQe28qqodqQHWc7r+KJ21of4v
	 9yZPQ4Tari+IUi9QpTDwn0WKqqv8UyJLKzsmIHPyQcOznQFmqlCcgQ4/yNHlNNkNM2Xmk
	 j95qhQ3hN/8jbmSUQ+Pts2gybXpV9eGkt88Zk6uGgOyDcr/OrQsK9VboOcW/JzUjdkUlr
	 z9aqucHuyGqxBSxPLh5dLjBz1BjUDSOs/cEToZtxSvzDWdR108lO0i86cYqufjt3W42j/
	 x1PikD9cR13SlV3/RaAYfzzcdHHH1k0uQwLULh36ZM7AaqvjdcWry2V/y7VpxNL1hKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Sat7IODW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZGkQsKWk;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Sat7IODW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZGkQsKWk;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45558606A321
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Nov 2026 14:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45558606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Sat7IODW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZGkQsKWk;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Sat7IODW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZGkQsKWk
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 227C11F452;
	Mon, 23 Nov 2026 14:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795442760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akifXYVY/5AXDWKkCXFIRC9bawAVd4VrBG0rlaR+urA=;
	b=Sat7IODWbuK74kFpWfabqYz3jJxm4hnxfPzBSup60i9R0+XAssDQEt8Yg4qAFbHX+Lq4kk
	VraQ4nFJTV/7picEGq7uU7YYV8QEckmFQh5/FRAureozDV1IaAJvGs21WTGUwaCLUelC+n
	5BLjLAfuYZAQELShjy2QpW1AqTOwuT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795442760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akifXYVY/5AXDWKkCXFIRC9bawAVd4VrBG0rlaR+urA=;
	b=ZGkQsKWklvSWr072u9cTWnD67uGrttwS/pQa8OMZOZXkI2ETBIM0WiYLXkQ7hX4bznu6f+
	rfAfEw6QHEwXMoAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795442760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akifXYVY/5AXDWKkCXFIRC9bawAVd4VrBG0rlaR+urA=;
	b=Sat7IODWbuK74kFpWfabqYz3jJxm4hnxfPzBSup60i9R0+XAssDQEt8Yg4qAFbHX+Lq4kk
	VraQ4nFJTV/7picEGq7uU7YYV8QEckmFQh5/FRAureozDV1IaAJvGs21WTGUwaCLUelC+n
	5BLjLAfuYZAQELShjy2QpW1AqTOwuT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795442760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akifXYVY/5AXDWKkCXFIRC9bawAVd4VrBG0rlaR+urA=;
	b=ZGkQsKWklvSWr072u9cTWnD67uGrttwS/pQa8OMZOZXkI2ETBIM0WiYLXkQ7hX4bznu6f+
	rfAfEw6QHEwXMoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C973B1352B;
	Mon, 23 Nov 2026 14:05:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oQeBOkZIBGvqQwAAD6G6ig:T4
	(envelope-from <tzimmermann@suse.de>); Mon, 23 Nov 2026 14:05:59 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 3/6] lib/fonts, fbcon: Use font_data_t for rotated fonts
Date: Mon, 23 Nov 2026 15:03:36 +0100
Message-ID: <20261123140554.1129792-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123140554.1129792-1-tzimmermann@suse.de>
References: <20261123140554.1129792-1-tzimmermann@suse.de>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-16.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -16.30

Return rotated font data as font_data_t instead of unsigned char*.
Release the data with font_data_put() in fbcon.

It is still possible to use preallocated font buffers for the rotated
font data. The font data tracks the buffer size and reference count to
do so; font_data_rotate() invokes __font_data_alloc() to allocate a
new font-data buffer if necessary.

Returning rotated font data as font_data_t further allows for using
regular font-data helpers on it. Fbcon now manages buffer life time
with the font data's reference counting. Removes the plain kfree().

v3:
- replace remaining instances of kfree() with font_data_put()
- fix documentation of font_data_rotate
v2:
- fix typo in commit description

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon.c        | 12 +++++---
 drivers/video/fbdev/core/fbcon.h        |  3 +-
 drivers/video/fbdev/core/fbcon_rotate.c | 19 ++++++------
 include/linux/font.h                    |  5 ++--
 lib/fonts/font_rotate.c                 | 39 ++++++++++---------------
 5 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 7720dfc80c16..5ccfc772dc7c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -770,7 +770,8 @@ static void fbcon_release(struct fb_info *info)
 		kfree(par->cursor_data);
 		kfree(par->cursor_src);
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
-		kfree(par->rotated.buf);
+		if (par->rotated.buf)
+			font_data_put(par->rotated.buf);
 #endif
 		kfree(info->fbcon_par);
 		info->fbcon_par = NULL;
@@ -2470,8 +2471,10 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	}
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
-	if (rotated_saved)
-		kfree(saved_rotated.buf);
+	if (rotated_saved) {
+		if (saved_rotated.buf)
+			font_data_put(saved_rotated.buf);
+	}
 #endif
 	if (old_fontdata)
 		font_data_put(old_fontdata);
@@ -2485,7 +2488,8 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	 * state.
 	 */
 	if (rotated_saved) {
-		kfree(par->rotated.buf);
+		if (par->rotated.buf)
+			font_data_put(par->rotated.buf);
 		par->rotated = saved_rotated;
 	}
 #endif
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 289a3d18f917..28111c706e34 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -75,8 +75,7 @@ struct fbcon_bitops {
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
 struct fbcon_rotated {
 	font_data_t *fontdata;       /* source font */
-	unsigned char *buf;          /* rotated glyphs */
-	size_t bufsize;
+	font_data_t *buf;            /* rotated font */
 	int buf_rotate;              /* rotation of buf */
 	unsigned int buf_width;      /* geometry of source font */
 	unsigned int buf_height;
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 7afd63dcee7b..3fe6ac3c6d6c 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -18,7 +18,7 @@
 int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 {
 	struct fbcon_par *par = info->fbcon_par;
-	unsigned char *buf;
+	font_data_t *buf;
 	int ret;
 
 	if (par->p->fontdata == par->rotated.fontdata &&
@@ -40,21 +40,22 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 
 	buf = font_data_rotate(par->rotated.fontdata, vc->vc_font.width,
 			       vc->vc_font.height, vc->vc_font.charcount,
-			       par->rotated.buf_rotate, par->rotated.buf,
-			       &par->rotated.bufsize);
+			       par->rotated.buf_rotate, par->rotated.buf);
 	if (IS_ERR(buf)) {
 		ret = PTR_ERR(buf);
-		goto err_kfree;
+		goto err_font_data_put;
 	}
 
+	if (par->rotated.buf)
+		font_data_put(par->rotated.buf);
 	par->rotated.buf = buf;
 
 	return 0;
 
-err_kfree:
-	kfree(par->rotated.buf);
-	par->rotated.buf = NULL; /* clear here to avoid output */
-	par->rotated.bufsize = 0;
-
+err_font_data_put:
+	if (par->rotated.buf) {
+		font_data_put(par->rotated.buf);
+		par->rotated.buf = NULL; /* clear here to avoid output */
+	}
 	return ret;
 }
diff --git a/include/linux/font.h b/include/linux/font.h
index be1a26ff8ae9..2d7e2ca3db0f 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -120,9 +120,8 @@ void font_glyph_rotate_180(const unsigned char *glyph, unsigned int width, unsig
 			   unsigned char *out);
 void font_glyph_rotate_270(const unsigned char *glyph, unsigned int width, unsigned int height,
 			   unsigned char *out);
-unsigned char *font_data_rotate(font_data_t *fd, unsigned int width, unsigned int height,
-				unsigned int charcount, unsigned int steps,
-				unsigned char *buf, size_t *bufsize);
+font_data_t *font_data_rotate(font_data_t *fd, unsigned int width, unsigned int height,
+			      unsigned int charcount, unsigned int steps, font_data_t *buf);
 
 /*
  * Font description
diff --git a/lib/fonts/font_rotate.c b/lib/fonts/font_rotate.c
index 275406008823..ee9605b9b55c 100644
--- a/lib/fonts/font_rotate.c
+++ b/lib/fonts/font_rotate.c
@@ -181,29 +181,23 @@ EXPORT_SYMBOL_GPL(font_glyph_rotate_270);
  * @height: The number of scanlines in the glyph
  * @charcount: The number of glyphs in the font
  * @steps: Number of rotation steps of 90°
- * @buf: Preallocated output buffer; can be NULL
- * @bufsize: The size of @buf in bytes; can be NULL
+ * @buf: Preallocated font data; can be NULL
  *
  * The parameters @width and @height refer to the visible number of pixels
  * and scanlines in a single glyph. The number of glyphs is given in @charcount.
  * Rotation happens in steps of 90°. The @steps parameter can have any value,
  * but only 0 to 3 produce distinct results. With 4 or higher, a full rotation
  * has been performed. You can pass any value for @steps and the helper will
- * perform the appropriate rotation. Note that the returned buffer is not
- * compatible with font_data_t. It only contains glyph data in the same format
- * as returned by font_data_buf(). Callers are responsible to free the returned
- * buffer with kfree(). Font rotation typically happens when displays get
- * re-oriented. To avoid unnecessary re-allocation of the memory buffer, the
- * caller can pass in an earlier result buffer in @buf for reuse. The old and
- * new buffer sizes are given and retrieved by the caller in @bufsize. The
- * allocation semantics are compatible with krealloc().
+ * perform the appropriate rotation. Font rotation typically happens when
+ * displays get re-oriented. To avoid unnecessary re-allocation of the memory
+ * buffer, the caller can pass in an earlier result in @buf for reuse. The
+ * returned font data should be released with font_data_put().
  *
  * Returns:
- * A buffer with rotated glyphs on success, or an error pointer otherwise
+ * Font data with rotated glyphs on success, or an error pointer otherwise
  */
-unsigned char *font_data_rotate(font_data_t *fd, unsigned int width, unsigned int height,
-				unsigned int charcount, unsigned int steps,
-				unsigned char *buf, size_t *bufsize)
+font_data_t *font_data_rotate(font_data_t *fd, unsigned int width, unsigned int height,
+			      unsigned int charcount, unsigned int steps, font_data_t *buf)
 {
 	const unsigned char *src = font_data_buf(fd);
 	unsigned int s_cellsize = font_glyph_size(width, height);
@@ -227,19 +221,16 @@ unsigned char *font_data_rotate(font_data_t *fd, unsigned int width, unsigned in
 	if (check_mul_overflow(charcount, d_cellsize, &size))
 		return ERR_PTR(-EINVAL);
 
-	if (!buf || !bufsize || size > *bufsize) {
-		dst = kmalloc_array(charcount, d_cellsize, GFP_KERNEL);
-		if (!dst)
-			return ERR_PTR(-ENOMEM);
-
-		kfree(buf);
-		buf = dst;
-		if (bufsize)
-			*bufsize = size;
+	if (!buf || size > font_data_size(buf)) {
+		buf = __font_data_alloc(size, GFP_KERNEL);
+		if (IS_ERR(buf))
+			return buf;
 	} else {
-		dst = buf;
+		font_data_get(buf);
 	}
 
+	dst = __font_data_wrbuf(buf);
+
 	switch (steps) {
 	case 0:
 		memcpy(dst, src, size);
-- 
2.56.1


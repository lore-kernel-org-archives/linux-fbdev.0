Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ADA36DA0E
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Mar 2026 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460807; cv=none; b=S0rDY7qEcbJj3vStraLYqhZbFi0+ClmI17WwwUPkyj0jdL9Axb+0lx/HAT1Z4QuS369dq44ZRubKd/5H0BZ0TsyqQWcOsRib1PdizDx0ks88WjvroB8IPgSy0VuFdlO8Zgqz+UrdmiTyFPJrq03F6Zey5bchp8S2n1QOHsmTEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460807; c=relaxed/simple;
	bh=6f4wTQvuX6ho6vASxCxBAGkuWuxz2okciPAf9Cfe2CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQ37BXHcKfxyupecMbStdyuqR3p0rWYOw4J2ncqrKQGJTyn6h8Ew7f3dZSEdOOf9OOXQepNFNzeLHGN2QJHBQDTIht4U/1d9QLBqde1ZhwtVI+iXdQ63yQeZHs3sdFH07oBD0TDxknYtRBaOn7j0jUpsNLTwbkFTau+yF5Lt/c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DeNyMevc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4zGqFLhq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DeNyMevc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4zGqFLhq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DeNyMevc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4zGqFLhq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DeNyMevc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4zGqFLhq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8F6A3F80D;
	Mon,  2 Mar 2026 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwTX7JM5NLj8OZx32vcI/KOQ9vYoguMCLxH2rYrB2a4=;
	b=DeNyMevcfFN1U7idy4O1FoAsICbVQJPSa1zoAW0BLm7X6Gzb0kvu+m122cCWAOQMEX/BpO
	T1L/Z6iBuF4+kMSDSVpDR0UY4BuGBcUeYmu22x1zMq+fLLYzOd/hYNqVw/cD3qfnXO8K3d
	8w3nLWUoo1bpDqPb2B5w4e7BYDNwkkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwTX7JM5NLj8OZx32vcI/KOQ9vYoguMCLxH2rYrB2a4=;
	b=4zGqFLhqRd+dyhfwQSXnzJZPsCcFlE+4jLJkW8cvF4vJANwnC9LvlFP/a6p/dzh3PIwMoC
	XJj2YiZFepAYaPCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DeNyMevc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4zGqFLhq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwTX7JM5NLj8OZx32vcI/KOQ9vYoguMCLxH2rYrB2a4=;
	b=DeNyMevcfFN1U7idy4O1FoAsICbVQJPSa1zoAW0BLm7X6Gzb0kvu+m122cCWAOQMEX/BpO
	T1L/Z6iBuF4+kMSDSVpDR0UY4BuGBcUeYmu22x1zMq+fLLYzOd/hYNqVw/cD3qfnXO8K3d
	8w3nLWUoo1bpDqPb2B5w4e7BYDNwkkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwTX7JM5NLj8OZx32vcI/KOQ9vYoguMCLxH2rYrB2a4=;
	b=4zGqFLhqRd+dyhfwQSXnzJZPsCcFlE+4jLJkW8cvF4vJANwnC9LvlFP/a6p/dzh3PIwMoC
	XJj2YiZFepAYaPCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85BE43EA6C;
	Mon,  2 Mar 2026 14:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6KF5H+6apWleKQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Mar 2026 14:13:02 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 11/13] lib/fonts: Create font_data_t from struct console_font with font_data_import()
Date: Mon,  2 Mar 2026 15:08:45 +0100
Message-ID: <20260302141255.518657-12-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302141255.518657-1-tzimmermann@suse.de>
References: <20260302141255.518657-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_RATELIMIT(0.00)[to_ip_from(RLf7er7x8tqp4b41gsueb7z9k6)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Queue-Id: B8F6A3F80D
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Add font_data_import() and update consoles to use it.

The implementation of font_data_import() is based on code from fbcon,
which supports overflow checks and crc32 checksums. Fbcon uses the crc32
checksum.

Newport_con now implements the same overflow checks as fbcon. As before,
this console does not support checksums, which are optional. Newport_con
can now also handle input font data with a vertical pitch other than 32
bytes. (The vertical pitch is the offset between two glyphs in the font
data.)

As an internal change, remove the const qualifier from the data field
if struct font_data. This allows font_data_import() to write the data
without type casting. For all users of the font data via font_data_t,
the stored data is still read only.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/newport_con.c | 22 ++--------
 drivers/video/fbdev/core/fbcon.c    | 38 ++----------------
 include/linux/font.h                |  6 ++-
 lib/fonts/fonts.c                   | 62 +++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 53 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 1bc3cb1ea116..ecbbe2e4e2a6 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -501,31 +501,17 @@ static int newport_set_font(int unit, const struct console_font *op,
 {
 	int w = op->width;
 	int h = op->height;
-	int size = h * op->charcount;
 	int i;
 	font_data_t *new_data;
-	unsigned char *data = op->data, *p;
 
 	/* ladis: when I grow up, there will be a day... and more sizes will
 	 * be supported ;-) */
-	if ((w != 8) || (h != 16) || (vpitch != 32)
-	    || (op->charcount != 256 && op->charcount != 512))
+	if (w != 8 || h != 16 || (op->charcount != 256 && op->charcount != 512))
 		return -EINVAL;
 
-	if (!(new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size,
-	     GFP_USER))) return -ENOMEM;
-
-	new_data += FONT_EXTRA_WORDS * sizeof(int);
-	FNTSIZE(new_data) = size;
-	REFCOUNT(new_data) = 1;	/* usage counter */
-	FNTSUM(new_data) = 0;
-
-	p = (unsigned char *)font_data_buf(new_data);
-	for (i = 0; i < op->charcount; i++) {
-		memcpy(p, data, h);
-		data += 32;
-		p += h;
-	}
+	new_data = font_data_import(op, vpitch, NULL);
+	if (IS_ERR(new_data))
+		return PTR_ERR(new_data);
 
 	/* check if font is already used by other console */
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 00255ac92e42..53677c09a0ec 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2039,8 +2039,6 @@ static void updatescrollmode(struct fbcon_display *p,
 	updatescrollmode_accel(p, info, vc);
 }
 
-#define PITCH(w) (((w) + 7) >> 3)
-
 static int fbcon_resize(struct vc_data *vc, unsigned int width,
 			unsigned int height, bool from_user)
 {
@@ -2424,7 +2422,6 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
 	p->fontdata = data;
 	vc->vc_font.data = font_data_buf(p->fontdata);
-
 	old_width = vc->vc_font.width;
 	old_height = vc->vc_font.height;
 	old_charcount = vc->vc_font.charcount;
@@ -2482,11 +2479,8 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	unsigned charcount = font->charcount;
 	int w = font->width;
 	int h = font->height;
-	int size, alloc_size;
-	int i, csum, ret;
+	int i, ret;
 	font_data_t *new_data;
-	const u8 *data = font->data;
-	int pitch = PITCH(font->width);
 
 	/* Is there a reason why fbconsole couldn't handle any charcount >256?
 	 * If not this check should be changed to charcount < 256 */
@@ -2510,34 +2504,10 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	if (fbcon_invalid_charcount(info, charcount))
 		return -EINVAL;
 
-	/* Check for integer overflow in font size calculation */
-	if (check_mul_overflow(h, pitch, &size) ||
-	    check_mul_overflow(size, charcount, &size))
-		return -EINVAL;
-
-	/* Check for overflow in allocation size calculation */
-	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &alloc_size))
-		return -EINVAL;
-
-	new_data = kmalloc(alloc_size, GFP_USER);
-
-	if (!new_data)
-		return -ENOMEM;
-
-	memset((u8 *)new_data, 0, FONT_EXTRA_WORDS * sizeof(int));
-
-	new_data += FONT_EXTRA_WORDS * sizeof(int);
-	FNTSIZE(new_data) = size;
-	REFCOUNT(new_data) = 1;	/* usage counter */
-	for (i=0; i< charcount; i++) {
-		memcpy((u8 *)new_data + i * h * pitch, data + i * vpitch * pitch, h * pitch);
-	}
-
-	/* Since linux has a nice crc32 function use it for counting font
-	 * checksums. */
-	csum = crc32(0, new_data, size);
+	new_data = font_data_import(font, vpitch, crc32);
+	if (IS_ERR(new_data))
+		return PTR_ERR(new_data);
 
-	FNTSUM(new_data) = csum;
 	/* Check if the same font is on some other console already */
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (fb_display[i].fontdata &&
diff --git a/include/linux/font.h b/include/linux/font.h
index a8610201afb7..d3b8ca240152 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -13,6 +13,8 @@
 
 #include <linux/types.h>
 
+struct console_font;
+
 /*
  * font_data_t and helpers
  */
@@ -54,6 +56,8 @@ static inline const unsigned char *font_data_buf(font_data_t *fd)
 	return (const unsigned char *)fd;
 }
 
+font_data_t *font_data_import(const struct console_font *font, unsigned int vpitch,
+			      u32 (*calc_csum)(u32, const void *, size_t));
 void font_data_get(font_data_t *fd);
 bool font_data_put(font_data_t *fd);
 unsigned int font_data_size(font_data_t *fd);
@@ -124,7 +128,7 @@ extern const struct font_desc *get_default_font(int xres, int yres,
 
 struct font_data {
 	unsigned int extra[FONT_EXTRA_WORDS];
-	const unsigned char data[];
+	unsigned char data[];
 } __packed;
 
 #endif /* _VIDEO_FONT_H */
diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index 1da0acdebf53..9b5355f6d2dc 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -14,7 +14,9 @@
 
 #include <linux/container_of.h>
 #include <linux/font.h>
+#include <linux/kd.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -24,6 +26,8 @@
 #include <asm/setup.h>
 #endif
 
+#define console_font_pitch(font) DIV_ROUND_UP((font)->width, 8)
+
 /*
  * Helpers for font_data_t
  */
@@ -46,6 +50,64 @@ static void font_data_free(font_data_t *fd)
 	kfree(to_font_data_struct(fd));
 }
 
+/**
+ * font_data_import - Allocates and initializes font data from user space
+ * @font: A font from user space
+ * @vpitch: The size of a single glyph in @font in bytes
+ * @calc_csum: An optional helper to calculate a chechsum
+ *
+ * Font data from user space must be translated to the kernel's format. The
+ * font's glyph geometry and data is provided in @font. The parameter @vpitch
+ * gives the number of bytes per glyph, including trailing bytes.
+ *
+ * The parameter @calc_sum is optional. Fbcon passes crc32() to calculate the
+ * font data's checksum.
+ *
+ * Returns:
+ * Newly initialized font data on success, or a pointer-encoded errno value otherwise.
+ */
+font_data_t *font_data_import(const struct console_font *font, unsigned int vpitch,
+			      u32 (*calc_csum)(u32, const void *, size_t))
+{
+	unsigned int pitch = console_font_pitch(font);
+	unsigned int h = font->height;
+	unsigned int charcount = font->charcount;
+	const unsigned char *data = font->data;
+	u32 csum = 0;
+	struct font_data *font_data;
+	int size, alloc_size;
+	unsigned int i;
+	font_data_t *fd;
+
+	/* Check for integer overflow in font-size calculation */
+	if (check_mul_overflow(h, pitch, &size) ||
+	    check_mul_overflow(size, charcount, &size))
+		return ERR_PTR(-EINVAL);
+
+	/* Check for overflow in allocation size calculation */
+	if (check_add_overflow(sizeof(*font_data), size, &alloc_size))
+		return ERR_PTR(-EINVAL);
+
+	font_data = kmalloc(alloc_size, GFP_USER);
+	if (!font_data)
+		return ERR_PTR(-ENOMEM);
+	memset(font_data->extra, 0, sizeof(font_data->extra));
+
+	for (i = 0; i < charcount; ++i)
+		memcpy(font_data->data + i * h * pitch, data + i * vpitch * pitch, h * pitch);
+
+	if (calc_csum)
+		csum = calc_csum(0, font_data->data, size);
+
+	fd = font_data->data;
+	REFCOUNT(fd) = 1; /* start with reference acquired */
+	FNTSIZE(fd) = size;
+	FNTSUM(fd) = csum;
+
+	return fd;
+}
+EXPORT_SYMBOL_GPL(font_data_import);
+
 /**
  * font_data_get - Acquires a reference on font data
  * @fd: Font data
-- 
2.53.0


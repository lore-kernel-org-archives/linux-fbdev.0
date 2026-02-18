Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E53D328B5C
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Feb 2026 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403986; cv=none; b=HtFj5gRU9J51qMFxzia18faLNIMWFgD4kcXGf2kbJ9NCRmchIfIx7rpngztaUz+5Yd0XuCLY3LsG19VRcs0etfa5II66V8jt2fxR9vENNTN8orMkdqI0klDPK3z/YSHTybISE4U5Kx+wvvPrG6DOVKTTOynPthLbcmd6HAmYess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403986; c=relaxed/simple;
	bh=VJQaSz8i4rTkDRwtyJGQsYScEQl7YVMVsiqvwe/3Sdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUm369tAehXlbE7OPno0K7Qv7+78OBs4+jpyKzSHy42ZAoQv2yr0T8vJsgpR+k99PsYSJEt0GgHD4eNoIIpZX77SpL6VRRtdtgSWRcdZjlXkJ+RkSTjW0DYNiJeH8JWUs88pV0ioudL0vYfsTQvaerkuAhlyViac2e6uKM8QjMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hhPkqLJO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pXhZwpnS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hhPkqLJO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pXhZwpnS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hhPkqLJO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pXhZwpnS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hhPkqLJO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pXhZwpnS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CE713E705;
	Wed, 18 Feb 2026 08:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrjM6e79Cdgss09ujR62hHqpHlTZihmDPKizIeRd1ZM=;
	b=hhPkqLJOKIKU72F8D4i4KeQGLRx5y4twTsbJMKLEoy3U+k8fY96z8kcSUezLmLFPFDr0/9
	cJ6A05tADMIjxrAadU9iBVo3fl8/86+8S4rHzwN38L5toCgwrfozPIVcCq8Pnh4Dgko8UY
	rmnSjuYdFxOPYeIkFRP7XymSz5oIpmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrjM6e79Cdgss09ujR62hHqpHlTZihmDPKizIeRd1ZM=;
	b=pXhZwpnSOammOZaE16OzoEskCqroWfX/P9VBlJu4AbXw4n5NqulUdAe6QnagMsMNKtZFLF
	w4GRlm7J5Q49a9CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hhPkqLJO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pXhZwpnS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrjM6e79Cdgss09ujR62hHqpHlTZihmDPKizIeRd1ZM=;
	b=hhPkqLJOKIKU72F8D4i4KeQGLRx5y4twTsbJMKLEoy3U+k8fY96z8kcSUezLmLFPFDr0/9
	cJ6A05tADMIjxrAadU9iBVo3fl8/86+8S4rHzwN38L5toCgwrfozPIVcCq8Pnh4Dgko8UY
	rmnSjuYdFxOPYeIkFRP7XymSz5oIpmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrjM6e79Cdgss09ujR62hHqpHlTZihmDPKizIeRd1ZM=;
	b=pXhZwpnSOammOZaE16OzoEskCqroWfX/P9VBlJu4AbXw4n5NqulUdAe6QnagMsMNKtZFLF
	w4GRlm7J5Q49a9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1D953EA66;
	Wed, 18 Feb 2026 08:39:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EEuwNal6lWn8LwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 18 Feb 2026 08:39:05 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 10/13] lib/fonts: Manage font-data lifetime with font_data_get/_put()
Date: Wed, 18 Feb 2026 09:16:01 +0100
Message-ID: <20260218083855.10743-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260218083855.10743-1-tzimmermann@suse.de>
References: <20260218083855.10743-1-tzimmermann@suse.de>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLf7er7x8tqp4b41gsueb7z9k6)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 2CE713E705
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Add font_data_get() and font_data_put(). Update consoles to use them
over REFCOUNT() and plain kfree().

Newly allocated font data starts with a reference count of 1. Loading
the font puts the previously loaded font. If the reference count reaches
zero, font_data_put() frees the font data.

The kernel stores internal font data in a read-only section. Invoking
font_data_get() and font_data_put() tests this internally and returns
success without further operation. From the caller's perspective,
getting and putting works the same for all font data.

Fbcon used the userfont flag distinguish between internal fonts and
fonts loaded by user space. Only the latter where refcounted. With the
new helper's automatic handling of internal font data, remove the
userfont flag from fbcon.

Newport_con uses a default font, FONT_DATA, until user space loads
custom font data. Remove all special cases for FONT_DATA, as the get
and put calls' read-only handlign also covers this case.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/newport_con.c | 26 ++++-------
 drivers/video/fbdev/core/fbcon.c    | 65 +++++++++++++--------------
 drivers/video/fbdev/core/fbcon.h    |  1 -
 include/linux/font.h                |  2 +
 lib/fonts/fonts.c                   | 70 +++++++++++++++++++++++++++++
 5 files changed, 111 insertions(+), 53 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 02bf4df05016..8870555cf837 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -517,7 +517,7 @@ static int newport_set_font(int unit, const struct console_font *op,
 
 	new_data += FONT_EXTRA_WORDS * sizeof(int);
 	FNTSIZE(new_data) = size;
-	REFCOUNT(new_data) = 0;	/* usage counter */
+	REFCOUNT(new_data) = 1;	/* usage counter */
 	FNTSUM(new_data) = 0;
 
 	p = (unsigned char *)font_data_buf(new_data);
@@ -529,23 +529,18 @@ static int newport_set_font(int unit, const struct console_font *op,
 
 	/* check if font is already used by other console */
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
-		if (font_data[i] != FONT_DATA
-		    && font_data_is_equal(font_data[i], new_data)) {
-			kfree(new_data - FONT_EXTRA_WORDS * sizeof(int));
+		if (font_data_is_equal(font_data[i], new_data)) {
+			font_data_put(new_data);
 			/* current font is the same as the new one */
 			if (i == unit)
 				return 0;
 			new_data = font_data[i];
+			font_data_get(new_data);
 			break;
 		}
 	}
-	/* old font is user font */
-	if (font_data[unit] != FONT_DATA) {
-		if (--REFCOUNT(font_data[unit]) == 0)
-			kfree(font_data[unit] -
-			      FONT_EXTRA_WORDS * sizeof(int));
-	}
-	REFCOUNT(new_data)++;
+
+	font_data_put(font_data[unit]);
 	font_data[unit] = new_data;
 
 	return 0;
@@ -553,12 +548,9 @@ static int newport_set_font(int unit, const struct console_font *op,
 
 static int newport_set_def_font(int unit, struct console_font *op)
 {
-	if (font_data[unit] != FONT_DATA) {
-		if (--REFCOUNT(font_data[unit]) == 0)
-			kfree(font_data[unit] -
-			      FONT_EXTRA_WORDS * sizeof(int));
-		font_data[unit] = FONT_DATA;
-	}
+	font_data_put(font_data[unit]);
+	font_data[unit] = FONT_DATA;
+	font_data_get(font_data[unit]);
 
 	return 0;
 }
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 6fbecce606fd..b1123f3911d7 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1023,6 +1023,7 @@ static const char *fbcon_startup(void)
 		vc->vc_font.charcount = font->charcount;
 
 		p->fontdata = font->data;
+		font_data_get(p->fontdata);
 	}
 
 	cols = FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);
@@ -1085,10 +1086,7 @@ static void fbcon_init(struct vc_data *vc, bool init)
 			vc->vc_font.charcount = fvc->vc_font.charcount;
 
 			p->fontdata = t->fontdata;
-			p->userfont = t->userfont;
-
-			if (p->userfont)
-				REFCOUNT(p->fontdata)++;
+			font_data_get(p->fontdata);
 		} else {
 			const struct font_desc *font = NULL;
 
@@ -1103,6 +1101,7 @@ static void fbcon_init(struct vc_data *vc, bool init)
 			vc->vc_font.charcount = font->charcount;
 
 			p->fontdata = font->data;
+			font_data_get(p->fontdata);
 		}
 	}
 
@@ -1193,10 +1192,10 @@ static void fbcon_init(struct vc_data *vc, bool init)
 
 static void fbcon_free_font(struct fbcon_display *p)
 {
-	if (p->userfont && p->fontdata && (--REFCOUNT(p->fontdata) == 0))
-		kfree(p->fontdata - FONT_EXTRA_WORDS * sizeof(int));
-	p->fontdata = NULL;
-	p->userfont = 0;
+	if (p->fontdata) {
+		font_data_put(p->fontdata);
+		p->fontdata = NULL;
+	}
 }
 
 static void set_vc_hi_font(struct vc_data *vc, bool set);
@@ -1419,9 +1418,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 		vc->vc_font.height = (*default_mode)->vc_font.height;
 		vc->vc_font.charcount = (*default_mode)->vc_font.charcount;
 		p->fontdata = t->fontdata;
-		p->userfont = t->userfont;
-		if (p->userfont)
-			REFCOUNT(p->fontdata)++;
+		font_data_get(p->fontdata);
 	}
 
 	var->activate = FB_ACTIVATE_NOW;
@@ -2058,7 +2055,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	struct fb_var_screeninfo var = info->var;
 	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
 
-	if (p->userfont && font_data_size(p->fontdata)) {
+	if (font_data_size(p->fontdata)) {
 		unsigned int size = vc_font_size(&vc->vc_font);
 
 		/*
@@ -2418,21 +2415,20 @@ static void set_vc_hi_font(struct vc_data *vc, bool set)
 }
 
 static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
-			     font_data_t *data, int userfont)
+			     font_data_t *data)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_par *par = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
-	int resize, ret, old_userfont, old_width, old_height, old_charcount;
+	int resize, ret, old_width, old_height, old_charcount;
 	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
 
+	font_data_get(data);
+
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
 	p->fontdata = data;
 	vc->vc_font.data = font_data_buf(p->fontdata);
-	old_userfont = p->userfont;
-	if ((p->userfont = userfont))
-		REFCOUNT(data)++;
 
 	old_width = vc->vc_font.width;
 	old_height = vc->vc_font.height;
@@ -2462,24 +2458,20 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		update_screen(vc);
 	}
 
-	if (old_userfont && (--REFCOUNT(old_fontdata) == 0))
-		kfree(old_fontdata - FONT_EXTRA_WORDS * sizeof(int));
+	if (old_fontdata)
+		font_data_put(old_fontdata);
+
 	return 0;
 
 err_out:
 	p->fontdata = old_fontdata;
 	vc->vc_font.data = old_data;
-
-	if (userfont) {
-		p->userfont = old_userfont;
-		if (--REFCOUNT(data) == 0)
-			kfree(data - FONT_EXTRA_WORDS * sizeof(int));
-	}
-
 	vc->vc_font.width = old_width;
 	vc->vc_font.height = old_height;
 	vc->vc_font.charcount = old_charcount;
 
+	font_data_put(data);
+
 	return ret;
 }
 
@@ -2496,9 +2488,9 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	int w = font->width;
 	int h = font->height;
 	int size, alloc_size;
-	int i, csum;
+	int i, csum, ret;
 	font_data_t *new_data;
-	u8 *data = font->data;
+	const u8 *data = font->data;
 	int pitch = PITCH(font->width);
 
 	/* Is there a reason why fbconsole couldn't handle any charcount >256?
@@ -2541,7 +2533,7 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 
 	new_data += FONT_EXTRA_WORDS * sizeof(int);
 	FNTSIZE(new_data) = size;
-	REFCOUNT(new_data) = 0;	/* usage counter */
+	REFCOUNT(new_data) = 1;	/* usage counter */
 	for (i=0; i< charcount; i++) {
 		memcpy((u8 *)new_data + i * h * pitch, data + i * vpitch * pitch, h * pitch);
 	}
@@ -2553,15 +2545,18 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	FNTSUM(new_data) = csum;
 	/* Check if the same font is on some other console already */
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
-		if (fb_display[i].userfont &&
-		    fb_display[i].fontdata &&
+		if (fb_display[i].fontdata &&
 		    font_data_is_equal(fb_display[i].fontdata, new_data)) {
-			kfree(new_data - FONT_EXTRA_WORDS * sizeof(int));
-			new_data = (u8 *)fb_display[i].fontdata;
+			font_data_get(fb_display[i].fontdata);
+			font_data_put(new_data);
+			new_data = fb_display[i].fontdata;
 			break;
 		}
 	}
-	return fbcon_do_set_font(vc, font->width, font->height, charcount, new_data, 1);
+	ret = fbcon_do_set_font(vc, font->width, font->height, charcount, new_data);
+	font_data_put(new_data);
+
+	return ret;
 }
 
 static int fbcon_set_def_font(struct vc_data *vc, struct console_font *font,
@@ -2578,7 +2573,7 @@ static int fbcon_set_def_font(struct vc_data *vc, struct console_font *font,
 
 	font->width = f->width;
 	font->height = f->height;
-	return fbcon_do_set_font(vc, f->width, f->height, f->charcount, f->data, 0);
+	return fbcon_do_set_font(vc, f->width, f->height, f->charcount, f->data);
 }
 
 static u16 palette_red[16];
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index d26ee7860cf5..1e3c1ef84762 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -27,7 +27,6 @@
 struct fbcon_display {
     /* Filled in by the low-level console driver */
     font_data_t *fontdata;
-    int userfont;                   /* != 0 if fontdata kmalloc()ed */
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
     u_short scrollmode;             /* Scroll Method, use fb_scrollmode() */
 #endif
diff --git a/include/linux/font.h b/include/linux/font.h
index da9869ca2294..d548684e6430 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -54,6 +54,8 @@ static inline const unsigned char *font_data_buf(font_data_t *fd)
 	return (const unsigned char *)fd;
 }
 
+void font_data_get(font_data_t *fd);
+bool font_data_put(font_data_t *fd);
 unsigned int font_data_size(font_data_t *fd);
 bool font_data_is_equal(font_data_t *lhs, font_data_t *rhs);
 
diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index c9f6328d5dda..1da0acdebf53 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -12,8 +12,10 @@
  * for more details.
  */
 
+#include <linux/container_of.h>
 #include <linux/font.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
@@ -26,11 +28,79 @@
  * Helpers for font_data_t
  */
 
+static struct font_data *to_font_data_struct(font_data_t *fd)
+{
+	return container_of(fd, struct font_data, data[0]);
+}
+
 static bool font_data_is_internal(font_data_t *fd)
 {
 	return is_kernel_rodata((unsigned long)fd);
 }
 
+static void font_data_free(font_data_t *fd)
+{
+	if (WARN_ON(font_data_is_internal(fd)))
+		return;
+
+	kfree(to_font_data_struct(fd));
+}
+
+/**
+ * font_data_get - Acquires a reference on font data
+ * @fd: Font data
+ *
+ * Font data from user space is reference counted. The helper
+ * font_data_get() increases the reference counter by one. Invoke
+ * font_data_put() to release the reference.
+ *
+ * Internal font data is located in read-only memory. In this case
+ * the helper returns success without modifying the counter field.
+ * It is still required to call font_data_put() on internal font data.
+ */
+void font_data_get(font_data_t *fd)
+{
+	if (font_data_is_internal(fd))
+		return; /* never ref static data */
+
+	if (WARN_ON(!REFCOUNT(fd)))
+		return; /* should never be 0 */
+	++REFCOUNT(fd);
+}
+EXPORT_SYMBOL_GPL(font_data_get);
+
+/**
+ * font_data_put - Release a reference on font data
+ * @fd: Font data
+ *
+ * Font data from user space is reference counted. The helper
+ * font_data_put() decreases the reference counter by one. If this was
+ * the final reference, it frees the allocated memory.
+ *
+ * Internal font data is located in read-only memory. In this case
+ * the helper returns success without modifying the counter field.
+ *
+ * Returns:
+ * True if this was the final reference, false otherwise.
+ */
+bool font_data_put(font_data_t *fd)
+{
+	unsigned int count;
+
+	if (font_data_is_internal(fd))
+		return true; /* never unref static data */
+
+	if (WARN_ON(!REFCOUNT(fd)))
+		return true; /* should never be 0 */
+
+	count = --REFCOUNT(fd);
+	if (!count)
+		font_data_free(fd);
+
+	return !count;
+}
+EXPORT_SYMBOL_GPL(font_data_put);
+
 /**
  * font_data_size - Return size of the font data in bytes
  * @fd: Font data
-- 
2.52.0


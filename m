Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA993B8D46
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Mar 2026 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065877; cv=none; b=iATJqkzbvoqbctvGi5gRY4N7uMoj93eLT7PCBrAKuVFAjzrUVs4uM1XkDOm/k9dFiHIzpolYrYSbhzSLrq/3DzD9hYGA4TrhtZebmMcelkSYjVXbuZLoeJgcYRf131rOwYM0m5SNyAL4hhuEW7LgiekEFhujZ3jsErHUmyypZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065877; c=relaxed/simple;
	bh=WewjjtXdKQpTembo/e0yO53K4zOxy/gJfLBXdGE2cnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8T0YunLgvUxUrTYCcyuF0lvbTdBJaH9y9vCQP5WyUMTd9xQJ3BaHvDas8hEl0LR2V6YvYYZB1LkA4ypPrZ3hxf4wR7tgILQ/iiuDXMz/C6OPd6HbHe0cZ50kA06XEdQbiM4pBhqhX8Id30UQBnr7GrAiu6hE2qDqVk5zeAXDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ooO3toEs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Puy1AAXl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A0+AzUWT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i95zCBre; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ooO3toEs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Puy1AAXl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A0+AzUWT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i95zCBre"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E6DD55BE46;
	Mon,  9 Mar 2026 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773065852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1BEAZBgrs3tl2TzVltJUpqKLE0TELI4Ye8XVbDaUKU=;
	b=ooO3toEsjHFOuCS3UgWUXP4zAzNFcOjPAMGmWdwHWt/WxkzGwrcVLe2wql9TrwJJP9Cbaz
	GJ9X3O+Qu9fvtneqE0UmQfQNeTLU4dPQzoqXrfM5FM9rgYKbxxWUslHQMHlcq6qstC6TLK
	+MIwDStQydbdbFAW0ll0e0AboBWrwtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773065852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1BEAZBgrs3tl2TzVltJUpqKLE0TELI4Ye8XVbDaUKU=;
	b=Puy1AAXlvhJ+vK2ubgiehAWXe1hrbM7mFmKAAwRVrp40NAKwmLvoQo+6HPmJc5i8NWdjQR
	N/GR98du9aFxd1AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773065851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1BEAZBgrs3tl2TzVltJUpqKLE0TELI4Ye8XVbDaUKU=;
	b=A0+AzUWTKeS+4VckWYuuvHbs16HU5DldQpIkusvS34hF8UusQsxfiKKVFCpgX/FcsqVE/p
	bvDQTn3Sz7sWrym9MGvAEzIVW4jIGyW1tT+8AIHwWVLnhCTQ86G9vuzIT6El3gh++Jgn+W
	Via9EgOKJSd3lZq4N8V1hBFpWT8/438=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773065851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1BEAZBgrs3tl2TzVltJUpqKLE0TELI4Ye8XVbDaUKU=;
	b=i95zCBreoZ9FKrGmKh2KHBNoe1AucAavtlIcJa1rbeOJ3VmYXbl04x3fmv3AB4UzNJKpcH
	9Q7n6rPQczR5aEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC7EA3EF3A;
	Mon,  9 Mar 2026 14:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +MOsKHvWrmldPAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 09 Mar 2026 14:17:31 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 09/13] lib/fonts: Manage font-data lifetime with font_data_get/_put()
Date: Mon,  9 Mar 2026 15:14:51 +0100
Message-ID: <20260309141723.137364-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309141723.137364-1-tzimmermann@suse.de>
References: <20260309141723.137364-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL4936hw7dbgk3hb39jfn1xy19)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO

Add font_data_get() and font_data_put(). Update consoles to use them
over REFCOUNT() and plain kfree().

Newly allocated font data starts with a reference count of 1. Loading
the font puts the previously loaded font. If the reference count reaches
zero, font_data_put() frees the font data.

The kernel stores a refcount of zero for internal font data. Invoking
font_data_get() and font_data_put() tests this internally and returns
success without further operation. From the caller's perspective,
getting and putting works the same for all font data.

Fbcon used the userfont flag distinguish between internal fonts and
fonts loaded by user space. Only the latter where refcounted. With the
new helper's automatic handling of internal font data, remove the
userfont flag from fbcon.

Newport_con uses a default font, FONT_DATA, until user space loads
custom font data. Remove all special cases for FONT_DATA, as the get
and put calls' read-only handling also covers this case.

v3:
- fix module linker error wrt font symbols (Nathan, Arnd)
- fix typos

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/newport_con.c | 23 +++------
 drivers/video/fbdev/core/fbcon.c    | 65 +++++++++++-------------
 drivers/video/fbdev/core/fbcon.h    |  1 -
 include/linux/font.h                |  2 +
 lib/fonts/fonts.c                   | 77 ++++++++++++++++++++++++++++-
 5 files changed, 115 insertions(+), 53 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 1198c6bc2777..43a1a4f41057 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -517,7 +517,7 @@ static int newport_set_font(int unit, const struct console_font *op,
 
 	new_data += FONT_EXTRA_WORDS * sizeof(int);
 	FNTSIZE(new_data) = size;
-	REFCOUNT(new_data) = 0;	/* usage counter */
+	REFCOUNT(new_data) = 1;	/* usage counter */
 	FNTSUM(new_data) = 0;
 
 	p = (unsigned char *)font_data_buf(new_data);
@@ -532,21 +532,17 @@ static int newport_set_font(int unit, const struct console_font *op,
 		if (font_data[i] != FONT_DATA
 		    && font_data_size(font_data[i]) == size
 		    && !memcmp(font_data[i], new_data, size)) {
-			kfree(new_data - FONT_EXTRA_WORDS * sizeof(int));
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
@@ -554,12 +550,9 @@ static int newport_set_font(int unit, const struct console_font *op,
 
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
index fa8f3e4196de..ac59480c98cb 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1023,6 +1023,7 @@ static const char *fbcon_startup(void)
 		vc->vc_font.charcount = font->charcount;
 
 		p->fontdata = font->data;
+		font_data_get(p->fontdata);
 	}
 
 	cols = FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);
@@ -1086,10 +1087,7 @@ static void fbcon_init(struct vc_data *vc, bool init)
 			vc->vc_font.charcount = fvc->vc_font.charcount;
 
 			p->fontdata = t->fontdata;
-			p->userfont = t->userfont;
-
-			if (p->userfont)
-				REFCOUNT(p->fontdata)++;
+			font_data_get(p->fontdata);
 		} else {
 			const struct font_desc *font = NULL;
 
@@ -1104,6 +1102,7 @@ static void fbcon_init(struct vc_data *vc, bool init)
 			vc->vc_font.charcount = font->charcount;
 
 			p->fontdata = font->data;
+			font_data_get(p->fontdata);
 		}
 	}
 
@@ -1194,10 +1193,10 @@ static void fbcon_init(struct vc_data *vc, bool init)
 
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
@@ -1420,9 +1419,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 		vc->vc_font.height = (*default_mode)->vc_font.height;
 		vc->vc_font.charcount = (*default_mode)->vc_font.charcount;
 		p->fontdata = t->fontdata;
-		p->userfont = t->userfont;
-		if (p->userfont)
-			REFCOUNT(p->fontdata)++;
+		font_data_get(p->fontdata);
 	}
 
 	var->activate = FB_ACTIVATE_NOW;
@@ -2053,7 +2050,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	struct fb_var_screeninfo var = info->var;
 	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
 
-	if (p->userfont && font_data_size(p->fontdata)) {
+	if (font_data_size(p->fontdata)) {
 		unsigned int size = vc_font_size(&vc->vc_font);
 
 		/*
@@ -2413,21 +2410,20 @@ static void set_vc_hi_font(struct vc_data *vc, bool set)
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
@@ -2457,24 +2453,20 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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
 
@@ -2491,9 +2483,9 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
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
@@ -2536,7 +2528,7 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 
 	new_data += FONT_EXTRA_WORDS * sizeof(int);
 	FNTSIZE(new_data) = size;
-	REFCOUNT(new_data) = 0;	/* usage counter */
+	REFCOUNT(new_data) = 1;	/* usage counter */
 	for (i=0; i< charcount; i++) {
 		memcpy((u8 *)new_data + i * h * pitch, data + i * vpitch * pitch, h * pitch);
 	}
@@ -2550,18 +2542,21 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		struct vc_data *tmp = vc_cons[i].d;
 
-		if (fb_display[i].userfont &&
-		    fb_display[i].fontdata &&
+		if (fb_display[i].fontdata &&
 		    FNTSUM(fb_display[i].fontdata) == csum &&
 		    font_data_size(fb_display[i].fontdata) == size &&
 		    tmp->vc_font.width == w &&
 		    !memcmp(fb_display[i].fontdata, new_data, size)) {
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
index 5b8557813c5c..dd319d0f0201 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -54,6 +54,8 @@ static inline const unsigned char *font_data_buf(font_data_t *fd)
 	return (const unsigned char *)fd;
 }
 
+void font_data_get(font_data_t *fd);
+bool font_data_put(font_data_t *fd);
 unsigned int font_data_size(font_data_t *fd);
 
 /*
diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index 8c9a6762061c..d25efd8d6c31 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -12,18 +12,91 @@
  * for more details.
  */
 
+#include <linux/container_of.h>
+#include <linux/font.h>
 #include <linux/module.h>
-#include <linux/types.h>
+#include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/types.h>
+
 #if defined(__mc68000__)
 #include <asm/setup.h>
 #endif
-#include <linux/font.h>
 
 /*
  * Helpers for font_data_t
  */
 
+static struct font_data *to_font_data_struct(font_data_t *fd)
+{
+	return container_of(fd, struct font_data, data[0]);
+}
+
+static bool font_data_is_internal(font_data_t *fd)
+{
+	return !REFCOUNT(fd); /* internal fonts have no reference counting */
+}
+
+static void font_data_free(font_data_t *fd)
+{
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
+ * True if the font data's memory buffer has been freed, false otherwise.
+ */
+bool font_data_put(font_data_t *fd)
+{
+	unsigned int count;
+
+	if (font_data_is_internal(fd))
+		return false; /* never unref static data */
+
+	if (WARN_ON(!REFCOUNT(fd)))
+		return false; /* should never be 0 */
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
2.53.0


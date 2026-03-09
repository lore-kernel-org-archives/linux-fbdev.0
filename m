Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49BD211290
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Mar 2026 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065870; cv=none; b=VYUtbTzTnpbUGfFqvPbo/ACfBBVKg0pFqRFNo5bmuYY7sl+Z/QzMMsjf/g0OasDzMiWpNy6FritUIC/l7E+h6/9RDRdbdqlyvCp03D+5BWlroQIPtPIlFCbjSRpbVdUNyfdlZBFGNe0nhPO7xw4VhWSDZ2SukQKtl9C/nYe6ArQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065870; c=relaxed/simple;
	bh=Ec8uqAPCVVEGOu01wxuxlQrqPf6B5dxNLK0WqdqWUd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpRFHY3RBHrxpWX1/EyY3oc+jmU5srkX2HYwucdsGT3FaITzMsWRzx2Bf3qw/NTXWkmeobF69t+a/2gSTWrcgk0IahJd+7CCSw9SPG2pnC/a8VOj3qSMhHKz8GdaaLiTM2XOja1KuXaJV/xiL2NrE6u3hAjLHEw+5cj23aYbxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ugwIkBG/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hYJoTqT1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ugwIkBG/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hYJoTqT1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ugwIkBG/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hYJoTqT1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ugwIkBG/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hYJoTqT1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 635085BE30;
	Mon,  9 Mar 2026 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773065851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GwfyKz1CnzrVU/2lMhApj6XqeXWfO4Wa9M5NaRIfqM=;
	b=ugwIkBG/JsH6Yh7EbBZHiLvr1QAOlmFMf2mlCj7kYDf2UhI9VEZGOlqoZBmVBBYoU9FV4m
	FrTY48XDlsdp6XPSMQaFyObtRqc9ipDmsk7Qdsmv5RueAFobGFL7TbFAe4iqJMulIyjacc
	GeMA3Dt5QPc/F8JT0uQ/wdPmfy19BDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773065851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GwfyKz1CnzrVU/2lMhApj6XqeXWfO4Wa9M5NaRIfqM=;
	b=hYJoTqT1L8tqbQL3VoEh9qkGrRr7g6xpZrCmi0MArUEgiYe6rICdlSQG10zaDWEGxGrvmf
	a/LvDVPj4CVRFsBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773065851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GwfyKz1CnzrVU/2lMhApj6XqeXWfO4Wa9M5NaRIfqM=;
	b=ugwIkBG/JsH6Yh7EbBZHiLvr1QAOlmFMf2mlCj7kYDf2UhI9VEZGOlqoZBmVBBYoU9FV4m
	FrTY48XDlsdp6XPSMQaFyObtRqc9ipDmsk7Qdsmv5RueAFobGFL7TbFAe4iqJMulIyjacc
	GeMA3Dt5QPc/F8JT0uQ/wdPmfy19BDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773065851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GwfyKz1CnzrVU/2lMhApj6XqeXWfO4Wa9M5NaRIfqM=;
	b=hYJoTqT1L8tqbQL3VoEh9qkGrRr7g6xpZrCmi0MArUEgiYe6rICdlSQG10zaDWEGxGrvmf
	a/LvDVPj4CVRFsBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A87B3EF3A;
	Mon,  9 Mar 2026 14:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uGj5CHvWrmldPAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 09 Mar 2026 14:17:31 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 07/13] lib/fonts: Store font data as font_data_t; update consoles
Date: Mon,  9 Mar 2026 15:14:49 +0100
Message-ID: <20260309141723.137364-8-tzimmermann@suse.de>
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

Store font data as pointer to font_data_t instead of unsigned char.
Update consoles.

Pointers to font data refer to the raw data. There is a hidden header
before the data that contains additional state. Document the existing
layout and semantics of font_data_t.

The data field in struct vc_font can be used by any console. Therefore
it still points to plain data without the additional header. Fbcon sets
its value from struct fbcon_display.fontdata. Hence, update the size
test in fbcon_resize() to use struct fbcon_display.fontdata instead of
struct vc_font.data.

v3:
- fix typos (Helge)
v2:
- 'Font lookup' -> 'Font description' in <linux/font.h>

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/newport_con.c | 17 ++++++-----
 drivers/video/fbdev/core/fbcon.c    | 44 ++++++++++++++++-----------
 drivers/video/fbdev/core/fbcon.h    |  3 +-
 include/linux/font.h                | 47 ++++++++++++++++++++++++++++-
 4 files changed, 84 insertions(+), 27 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index e2922caa8685..9b9ed1940404 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -33,9 +33,9 @@
 
 #define NEWPORT_LEN	0x10000
 
-#define FONT_DATA ((unsigned char *)font_vga_8x16.data)
+#define FONT_DATA font_vga_8x16.data
 
-static unsigned char *font_data[MAX_NR_CONSOLES];
+static font_data_t *font_data[MAX_NR_CONSOLES];
 
 static struct newport_regs *npregs;
 static unsigned long newport_addr;
@@ -370,9 +370,9 @@ static void newport_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
 static void newport_putc(struct vc_data *vc, u16 charattr, unsigned int ypos,
 			 unsigned int xpos)
 {
-	unsigned char *p;
+	const unsigned char *p;
 
-	p = &font_data[vc->vc_num][(charattr & 0xff) << 4];
+	p = &font_data_buf(font_data[vc->vc_num])[(charattr & 0xff) << 4];
 	charattr = (charattr >> 8) & 0xff;
 	xpos <<= 3;
 	ypos <<= 4;
@@ -400,7 +400,7 @@ static void newport_putcs(struct vc_data *vc, const u16 *s,
 			  unsigned int count, unsigned int ypos,
 			  unsigned int xpos)
 {
-	unsigned char *p;
+	const unsigned char *p;
 	unsigned int i;
 	u16 charattr;
 
@@ -424,7 +424,7 @@ static void newport_putcs(struct vc_data *vc, const u16 *s,
 				 NPORT_DMODE0_L32);
 
 	for (i = 0; i < count; i++, xpos += 8) {
-		p = &font_data[vc->vc_num][(scr_readw(s++) & 0xff) << 4];
+		p = &font_data_buf(font_data[vc->vc_num])[(scr_readw(s++) & 0xff) << 4];
 
 		newport_wait(npregs);
 
@@ -503,7 +503,8 @@ static int newport_set_font(int unit, const struct console_font *op,
 	int h = op->height;
 	int size = h * op->charcount;
 	int i;
-	unsigned char *new_data, *data = op->data, *p;
+	font_data_t *new_data;
+	unsigned char *data = op->data, *p;
 
 	/* ladis: when I grow up, there will be a day... and more sizes will
 	 * be supported ;-) */
@@ -519,7 +520,7 @@ static int newport_set_font(int unit, const struct console_font *op,
 	REFCOUNT(new_data) = 0;	/* usage counter */
 	FNTSUM(new_data) = 0;
 
-	p = new_data;
+	p = (unsigned char *)font_data_buf(new_data);
 	for (i = 0; i < op->charcount; i++) {
 		memcpy(p, data, h);
 		data += 32;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 103e91c8d874..8d7840b9ebad 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1019,8 +1019,10 @@ static const char *fbcon_startup(void)
 						info->pixmap.blit_y);
 		vc->vc_font.width = font->width;
 		vc->vc_font.height = font->height;
-		vc->vc_font.data = (void *)(p->fontdata = font->data);
+		vc->vc_font.data = font_data_buf(font->data);
 		vc->vc_font.charcount = font->charcount;
+
+		p->fontdata = font->data;
 	}
 
 	cols = FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);
@@ -1078,11 +1080,12 @@ static void fbcon_init(struct vc_data *vc, bool init)
 		if (t->fontdata) {
 			struct vc_data *fvc = vc_cons[fg_console].d;
 
-			vc->vc_font.data = (void *)(p->fontdata =
-						    fvc->vc_font.data);
+			vc->vc_font.data = fvc->vc_font.data;
 			vc->vc_font.width = fvc->vc_font.width;
 			vc->vc_font.height = fvc->vc_font.height;
 			vc->vc_font.charcount = fvc->vc_font.charcount;
+
+			p->fontdata = t->fontdata;
 			p->userfont = t->userfont;
 
 			if (p->userfont)
@@ -1097,8 +1100,10 @@ static void fbcon_init(struct vc_data *vc, bool init)
 							info->pixmap.blit_y);
 			vc->vc_font.width = font->width;
 			vc->vc_font.height = font->height;
-			vc->vc_font.data = (void *)(p->fontdata = font->data);
+			vc->vc_font.data = font_data_buf(font->data);
 			vc->vc_font.charcount = font->charcount;
+
+			p->fontdata = font->data;
 		}
 	}
 
@@ -1409,11 +1414,12 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	svc = *default_mode;
 	t = &fb_display[svc->vc_num];
 
-	if (!vc->vc_font.data) {
-		vc->vc_font.data = (void *)(p->fontdata = t->fontdata);
+	if (!p->fontdata) {
+		vc->vc_font.data = font_data_buf(t->fontdata);
 		vc->vc_font.width = (*default_mode)->vc_font.width;
 		vc->vc_font.height = (*default_mode)->vc_font.height;
 		vc->vc_font.charcount = (*default_mode)->vc_font.charcount;
+		p->fontdata = t->fontdata;
 		p->userfont = t->userfont;
 		if (p->userfont)
 			REFCOUNT(p->fontdata)++;
@@ -2047,7 +2053,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	struct fb_var_screeninfo var = info->var;
 	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
 
-	if (p->userfont && FNTSIZE(vc->vc_font.data)) {
+	if (p->userfont && FNTSIZE(p->fontdata)) {
 		unsigned int size = vc_font_size(&vc->vc_font);
 
 		/*
@@ -2057,7 +2063,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 		 * charcount can change and cannot be used to determine the
 		 * font data allocated size.
 		 */
-		if (!size || size > FNTSIZE(vc->vc_font.data))
+		if (!size || size > FNTSIZE(p->fontdata))
 			return -EINVAL;
 	}
 
@@ -2281,7 +2287,8 @@ static bool fbcon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
 
 static int fbcon_get_font(struct vc_data *vc, struct console_font *font, unsigned int vpitch)
 {
-	const u8 *fontdata = vc->vc_font.data;
+	struct fbcon_display *p = &fb_display[vc->vc_num];
+	font_data_t *fontdata = p->fontdata;
 	u8 *data = font->data;
 	int i, j;
 
@@ -2406,16 +2413,18 @@ static void set_vc_hi_font(struct vc_data *vc, bool set)
 }
 
 static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
-			     const u8 * data, int userfont)
+			     font_data_t *data, int userfont)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_par *par = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize, ret, old_userfont, old_width, old_height, old_charcount;
+	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
-	vc->vc_font.data = (void *)(p->fontdata = data);
+	p->fontdata = data;
+	vc->vc_font.data = font_data_buf(p->fontdata);
 	old_userfont = p->userfont;
 	if ((p->userfont = userfont))
 		REFCOUNT(data)++;
@@ -2448,12 +2457,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		update_screen(vc);
 	}
 
-	if (old_userfont && (--REFCOUNT(old_data) == 0))
-		kfree(old_data - FONT_EXTRA_WORDS * sizeof(int));
+	if (old_userfont && (--REFCOUNT(old_fontdata) == 0))
+		kfree(old_fontdata - FONT_EXTRA_WORDS * sizeof(int));
 	return 0;
 
 err_out:
-	p->fontdata = old_data;
+	p->fontdata = old_fontdata;
 	vc->vc_font.data = old_data;
 
 	if (userfont) {
@@ -2483,7 +2492,8 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	int h = font->height;
 	int size, alloc_size;
 	int i, csum;
-	u8 *new_data, *data = font->data;
+	font_data_t *new_data;
+	u8 *data = font->data;
 	int pitch = PITCH(font->width);
 
 	/* Is there a reason why fbconsole couldn't handle any charcount >256?
@@ -2522,13 +2532,13 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	if (!new_data)
 		return -ENOMEM;
 
-	memset(new_data, 0, FONT_EXTRA_WORDS * sizeof(int));
+	memset((u8 *)new_data, 0, FONT_EXTRA_WORDS * sizeof(int));
 
 	new_data += FONT_EXTRA_WORDS * sizeof(int);
 	FNTSIZE(new_data) = size;
 	REFCOUNT(new_data) = 0;	/* usage counter */
 	for (i=0; i< charcount; i++) {
-		memcpy(new_data + i*h*pitch, data +  i*vpitch*pitch, h*pitch);
+		memcpy((u8 *)new_data + i * h * pitch, data + i * vpitch * pitch, h * pitch);
 	}
 
 	/* Since linux has a nice crc32 function use it for counting font
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 3f4386a40237..d26ee7860cf5 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -11,6 +11,7 @@
 #ifndef _VIDEO_FBCON_H
 #define _VIDEO_FBCON_H
 
+#include <linux/font.h>
 #include <linux/types.h>
 #include <linux/vt_buffer.h>
 #include <linux/vt_kern.h>
@@ -25,7 +26,7 @@
 
 struct fbcon_display {
     /* Filled in by the low-level console driver */
-    const u_char *fontdata;
+    font_data_t *fontdata;
     int userfont;                   /* != 0 if fontdata kmalloc()ed */
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
     u_short scrollmode;             /* Scroll Method, use fb_scrollmode() */
diff --git a/include/linux/font.h b/include/linux/font.h
index d929c5fa32ca..746a0996a018 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -13,12 +13,57 @@
 
 #include <linux/types.h>
 
+/*
+ * font_data_t and helpers
+ */
+
+/**
+ * font_data_t - Raw font data
+ *
+ * Values of type font_data_t store a pointer to raw font data. The format
+ * is monochrome. Each bit sets a pixel of a stored glyph. Font data does
+ * not store geometry information for the individual glyphs. Users of the
+ * font have to store glyph size, pitch and character count separately.
+ *
+ * Font data in font_data_t is not equivalent to raw u8. Each pointer stores
+ * an additional hidden header before the font data. The layout is
+ *
+ * +------+-----------------------------+
+ * | -16  |  CRC32 Checksum (optional)  |
+ * | -12  |  <Unused>                   |
+ * |  -8  |  Number of data bytes       |
+ * |  -4  |  Reference count            |
+ * +------+-----------------------------+
+ * |   0  |  Data buffer                |
+ * |  ... |                             |
+ * +------+-----------------------------+
+ *
+ * Use helpers to access font_data_t. Use font_data_buf() to get the stored data.
+ */
+typedef const unsigned char font_data_t;
+
+/**
+ * font_data_buf() - Returns the font data as raw bytes
+ * @fd: The font data
+ *
+ * Returns:
+ * The raw font data. The provided buffer is read-only.
+ */
+static inline const unsigned char *font_data_buf(font_data_t *fd)
+{
+	return (const unsigned char *)fd;
+}
+
+/*
+ * Font description
+ */
+
 struct font_desc {
     int idx;
     const char *name;
     unsigned int width, height;
     unsigned int charcount;
-    const void *data;
+    font_data_t *data;
     int pref;
 };
 
-- 
2.53.0


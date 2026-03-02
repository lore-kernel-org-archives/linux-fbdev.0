Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CADC3FFAD6
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Mar 2026 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460795; cv=none; b=RiQH93GYM15r0aV62rm/PVe+TkN9z0Q8YVAraBjQPWDjYhVRyv17NXoPY/OQuuzDlOwwu/05Cg3NH6uPsGlUl7QLgytJ98eoEYZ4gFufOC5uw3X3njhBpDGV/9IECTtm5TSAwp8xQ9NMzk6Q3GX2ZtyMBwUnb1fdtYY4ZVbT72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460795; c=relaxed/simple;
	bh=oh/4830j/unBQATW0IBe5LmKnPMjBn50kYCsTr+Bhug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhobWNEO/SjuF42gELFMb1/MOe5PPJFbpxvpnspxupvoNquwhfxtaZy7997b+hZC4qRXLzkYQZaddn/CgWj/Gwe9gLD3OFhUIAY17OzYYQzZsBYj9BEAkDPZLIjh84qQxKHgHs16PjHQTrzx3eQCsU8gZm+6XbYk+R8bCxtxY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FHKrs+b6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e1Yojls1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FHKrs+b6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e1Yojls1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FHKrs+b6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e1Yojls1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FHKrs+b6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e1Yojls1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 088EA3F7FF;
	Mon,  2 Mar 2026 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuOPJLdwL/exynAtq4za/w0ivcdGcqMQCglRysvbQ6M=;
	b=FHKrs+b6bbjduPx9SMmzk9LNgYbwU62mac4Be3Tfu2ULZId8byyYOtd+jAvlz36X81GF/c
	SUaZW/RdvIPTGf8f+igVJDQQTL3j4LjTdHbP4wCuE5zD40RgLKQboNX9FVopDonBpnFO3W
	uE8i0be4jOIiRKcPh26aa2XH88nkbSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuOPJLdwL/exynAtq4za/w0ivcdGcqMQCglRysvbQ6M=;
	b=e1Yojls1FcIm2qP8R7gBfG2I3x1Yem94OyOlAtOrc0S/ZtppwKjmQNRWx0um0j0fR6jRil
	KIgIKb6Rqyf+pIDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FHKrs+b6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e1Yojls1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuOPJLdwL/exynAtq4za/w0ivcdGcqMQCglRysvbQ6M=;
	b=FHKrs+b6bbjduPx9SMmzk9LNgYbwU62mac4Be3Tfu2ULZId8byyYOtd+jAvlz36X81GF/c
	SUaZW/RdvIPTGf8f+igVJDQQTL3j4LjTdHbP4wCuE5zD40RgLKQboNX9FVopDonBpnFO3W
	uE8i0be4jOIiRKcPh26aa2XH88nkbSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuOPJLdwL/exynAtq4za/w0ivcdGcqMQCglRysvbQ6M=;
	b=e1Yojls1FcIm2qP8R7gBfG2I3x1Yem94OyOlAtOrc0S/ZtppwKjmQNRWx0um0j0fR6jRil
	KIgIKb6Rqyf+pIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA1B43EA69;
	Mon,  2 Mar 2026 14:13:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AK8lMO2apWleKQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Mar 2026 14:13:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 08/13] lib/fonts: Read font size with font_data_size()
Date: Mon,  2 Mar 2026 15:08:42 +0100
Message-ID: <20260302141255.518657-9-tzimmermann@suse.de>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_RATELIMIT(0.00)[to_ip_from(RLf7er7x8tqp4b41gsueb7z9k6)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 088EA3F7FF

Add font_data_size() and update consoles to use it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/newport_con.c |  2 +-
 drivers/video/fbdev/core/fbcon.c    | 14 +++++++-------
 include/linux/font.h                |  2 ++
 lib/fonts/fonts.c                   | 21 +++++++++++++++++++++
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 9b9ed1940404..1198c6bc2777 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -530,7 +530,7 @@ static int newport_set_font(int unit, const struct console_font *op,
 	/* check if font is already used by other console */
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (font_data[i] != FONT_DATA
-		    && FNTSIZE(font_data[i]) == size
+		    && font_data_size(font_data[i]) == size
 		    && !memcmp(font_data[i], new_data, size)) {
 			kfree(new_data - FONT_EXTRA_WORDS * sizeof(int));
 			/* current font is the same as the new one */
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 8d7840b9ebad..fa8f3e4196de 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2053,7 +2053,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	struct fb_var_screeninfo var = info->var;
 	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
 
-	if (p->userfont && FNTSIZE(p->fontdata)) {
+	if (p->userfont && font_data_size(p->fontdata)) {
 		unsigned int size = vc_font_size(&vc->vc_font);
 
 		/*
@@ -2063,7 +2063,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 		 * charcount can change and cannot be used to determine the
 		 * font data allocated size.
 		 */
-		if (!size || size > FNTSIZE(p->fontdata))
+		if (!size || size > font_data_size(p->fontdata))
 			return -EINVAL;
 	}
 
@@ -2302,7 +2302,7 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font, unsigne
 
 	if (font->width <= 8) {
 		j = vc->vc_font.height;
-		if (font->charcount * j > FNTSIZE(fontdata))
+		if (font->charcount * j > font_data_size(fontdata))
 			return -EINVAL;
 
 		for (i = 0; i < font->charcount; i++) {
@@ -2313,7 +2313,7 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font, unsigne
 		}
 	} else if (font->width <= 16) {
 		j = vc->vc_font.height * 2;
-		if (font->charcount * j > FNTSIZE(fontdata))
+		if (font->charcount * j > font_data_size(fontdata))
 			return -EINVAL;
 
 		for (i = 0; i < font->charcount; i++) {
@@ -2323,7 +2323,7 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font, unsigne
 			fontdata += j;
 		}
 	} else if (font->width <= 24) {
-		if (font->charcount * (vc->vc_font.height * sizeof(u32)) > FNTSIZE(fontdata))
+		if (font->charcount * (vc->vc_font.height * sizeof(u32)) > font_data_size(fontdata))
 			return -EINVAL;
 
 		for (i = 0; i < font->charcount; i++) {
@@ -2338,7 +2338,7 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font, unsigne
 		}
 	} else {
 		j = vc->vc_font.height * 4;
-		if (font->charcount * j > FNTSIZE(fontdata))
+		if (font->charcount * j > font_data_size(fontdata))
 			return -EINVAL;
 
 		for (i = 0; i < font->charcount; i++) {
@@ -2553,7 +2553,7 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 		if (fb_display[i].userfont &&
 		    fb_display[i].fontdata &&
 		    FNTSUM(fb_display[i].fontdata) == csum &&
-		    FNTSIZE(fb_display[i].fontdata) == size &&
+		    font_data_size(fb_display[i].fontdata) == size &&
 		    tmp->vc_font.width == w &&
 		    !memcmp(fb_display[i].fontdata, new_data, size)) {
 			kfree(new_data - FONT_EXTRA_WORDS * sizeof(int));
diff --git a/include/linux/font.h b/include/linux/font.h
index f19abd112c18..55cc016a9357 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -54,6 +54,8 @@ static inline const unsigned char *font_data_buf(font_data_t *fd)
 	return (const unsigned char *)fd;
 }
 
+unsigned int font_data_size(font_data_t *fd);
+
 /*
  * Font description
  */
diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index a7f118b30171..8c9a6762061c 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -20,6 +20,27 @@
 #endif
 #include <linux/font.h>
 
+/*
+ * Helpers for font_data_t
+ */
+
+/**
+ * font_data_size - Return size of the font data in bytes
+ * @fd: Font data
+ *
+ * Returns:
+ * The number of bytes in the given font data.
+ */
+unsigned int font_data_size(font_data_t *fd)
+{
+	return FNTSIZE(fd);
+}
+EXPORT_SYMBOL_GPL(font_data_size);
+
+/*
+ * Font lookup
+ */
+
 static const struct font_desc *fonts[] = {
 #ifdef CONFIG_FONT_8x8
 	&font_vga_8x8,
-- 
2.53.0


Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487F9324700
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Feb 2026 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403959; cv=none; b=UU+5HaXAG/pqjr9+0nlFlnbXReqINBY9ZhNzEDFS8fWPUdrjl1fgObd3Xrqw5kxsBJkBCokRnmElXR8zqvBJ7/kRe2hG4H/tnZTqxKfQ582iPP8C0Ch3W06RUd3BbrZyQmji06whk/dQQVr5gfFHJFPKnIT8NN1cIbz3Zgw7rL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403959; c=relaxed/simple;
	bh=WE1wpX68LXlxkEpm6KWSIjw7o4VuBy+NDYyGGHGSNDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jhq84Lp2U/ycmf70BbKxYjoa6XbCxw7PNUbIkHIfLjhLqTrzYiz4gHundWHnkzzWYWFw2Wiu1t3dFuqzYL/KAeWtIpufL+bApo8BT99bYpgZ7ZjcMQkrL1ensykNlv9q4Mt30gAuUUFpsxuXlu2P59I5oWTaWkewH+ReyUKDn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XQ4Z4tQV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XXqCKc/r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XQ4Z4tQV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XXqCKc/r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XQ4Z4tQV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XXqCKc/r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XQ4Z4tQV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XXqCKc/r"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A72E95BCD1;
	Wed, 18 Feb 2026 08:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nS/q8UxVLTw4u9oLSBlMg/OWbLCkEyUXBJg1N3jUEzw=;
	b=XQ4Z4tQVvKT6hVAD3iXCYdM/R/qqfJpzfUIz2SMByFB9+lzYNm1xp/MNgyFdIO9duiBEFC
	Pm5n+6kw9fVerGb/JHQnmrGIZFYL/tC3TqaIF8nSg8yv0wf88E8ehz6oRssuW6QcromN5k
	l6txqCOWUk0TD1FLcaCqskL2Tz63klU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nS/q8UxVLTw4u9oLSBlMg/OWbLCkEyUXBJg1N3jUEzw=;
	b=XXqCKc/rwhvFcG7tCFUyer+iLHGOrqD6eTB5ce6vDW4mQLOk0jUifi6JQL6q1mNHcejaWd
	rgo97ejzrixyt/Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nS/q8UxVLTw4u9oLSBlMg/OWbLCkEyUXBJg1N3jUEzw=;
	b=XQ4Z4tQVvKT6hVAD3iXCYdM/R/qqfJpzfUIz2SMByFB9+lzYNm1xp/MNgyFdIO9duiBEFC
	Pm5n+6kw9fVerGb/JHQnmrGIZFYL/tC3TqaIF8nSg8yv0wf88E8ehz6oRssuW6QcromN5k
	l6txqCOWUk0TD1FLcaCqskL2Tz63klU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nS/q8UxVLTw4u9oLSBlMg/OWbLCkEyUXBJg1N3jUEzw=;
	b=XXqCKc/rwhvFcG7tCFUyer+iLHGOrqD6eTB5ce6vDW4mQLOk0jUifi6JQL6q1mNHcejaWd
	rgo97ejzrixyt/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61F503EA66;
	Wed, 18 Feb 2026 08:39:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UK64Fql6lWn8LwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 18 Feb 2026 08:39:05 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 08/13] lib/fonts: Read font size with font_data_size()
Date: Wed, 18 Feb 2026 09:15:59 +0100
Message-ID: <20260218083855.10743-9-tzimmermann@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL4936hw7dbgk3hb39jfn1xy19)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO

Add font_data_size() and update consoles to use it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/newport_con.c |  2 +-
 drivers/video/fbdev/core/fbcon.c    | 14 +++++++-------
 include/linux/font.h                |  2 ++
 lib/fonts/fonts.c                   | 21 +++++++++++++++++++++
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index fcf76f65b06e..eee9695c3eb5 100644
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
index 73f2757155e6..ebb9c5c1b247 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2058,7 +2058,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	struct fb_var_screeninfo var = info->var;
 	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
 
-	if (p->userfont && FNTSIZE(p->fontdata)) {
+	if (p->userfont && font_data_size(p->fontdata)) {
 		unsigned int size = vc_font_size(&vc->vc_font);
 
 		/*
@@ -2068,7 +2068,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 		 * charcount can change and cannot be used to determine the
 		 * font data allocated size.
 		 */
-		if (!size || size > FNTSIZE(p->fontdata))
+		if (!size || size > font_data_size(p->fontdata))
 			return -EINVAL;
 	}
 
@@ -2307,7 +2307,7 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font, unsigne
 
 	if (font->width <= 8) {
 		j = vc->vc_font.height;
-		if (font->charcount * j > FNTSIZE(fontdata))
+		if (font->charcount * j > font_data_size(fontdata))
 			return -EINVAL;
 
 		for (i = 0; i < font->charcount; i++) {
@@ -2318,7 +2318,7 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font, unsigne
 		}
 	} else if (font->width <= 16) {
 		j = vc->vc_font.height * 2;
-		if (font->charcount * j > FNTSIZE(fontdata))
+		if (font->charcount * j > font_data_size(fontdata))
 			return -EINVAL;
 
 		for (i = 0; i < font->charcount; i++) {
@@ -2328,7 +2328,7 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font, unsigne
 			fontdata += j;
 		}
 	} else if (font->width <= 24) {
-		if (font->charcount * (vc->vc_font.height * sizeof(u32)) > FNTSIZE(fontdata))
+		if (font->charcount * (vc->vc_font.height * sizeof(u32)) > font_data_size(fontdata))
 			return -EINVAL;
 
 		for (i = 0; i < font->charcount; i++) {
@@ -2343,7 +2343,7 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font, unsigne
 		}
 	} else {
 		j = vc->vc_font.height * 4;
-		if (font->charcount * j > FNTSIZE(fontdata))
+		if (font->charcount * j > font_data_size(fontdata))
 			return -EINVAL;
 
 		for (i = 0; i < font->charcount; i++) {
@@ -2558,7 +2558,7 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 		if (fb_display[i].userfont &&
 		    fb_display[i].fontdata &&
 		    FNTSUM(fb_display[i].fontdata) == csum &&
-		    FNTSIZE(fb_display[i].fontdata) == size &&
+		    font_data_size(fb_display[i].fontdata) == size &&
 		    tmp->vc_font.width == w &&
 		    !memcmp(fb_display[i].fontdata, new_data, size)) {
 			kfree(new_data - FONT_EXTRA_WORDS * sizeof(int));
diff --git a/include/linux/font.h b/include/linux/font.h
index 4ff8d52e59c3..3afb32b625d3 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -54,6 +54,8 @@ static inline const unsigned char *font_data_buf(font_data_t *fd)
 	return (const unsigned char *)fd;
 }
 
+unsigned int font_data_size(font_data_t *fd);
+
 /*
  * Font lookup
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
2.52.0


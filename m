Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913A2F6911
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Feb 2026 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403992; cv=none; b=sZbjSSVy1f6VyEoPaHLEiA7OqQ9Sq4L3S6k707nuKQyE6bnAJ8HJYqczh0E6N+H6Xz525aCDyLamA9jS2dh6GiTHqEvF12Oc+KXhHeamRKhO6+kCvzZ56yFoBaZsCsH3mEesR+R1zI6yYyr0GO8GDa1QG631Z9321w65L8Bwzr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403992; c=relaxed/simple;
	bh=hGcbzcH1/aaOlxivAnqTV18vAS1xonaHcY0mqljRTUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7e2R6txtuPKlsMzOEoiRVC5Td8NJ40FXQqT8UblOXOQbyRk7ZGWLH/kPonPcuhPavgsPFYFS16W4TRdVXRsmFtJRRwuSeY4nzzUxtO3gnZ4ZNbcBmBxp5Gr2T9EtJmvStldDp0o0YrTn8eMwS6mPZSlLmLhtgAWHd8bAb9k5dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j7/Fuv/i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kFsl2OE6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j7/Fuv/i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kFsl2OE6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j7/Fuv/i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kFsl2OE6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j7/Fuv/i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kFsl2OE6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AFDAE3E701;
	Wed, 18 Feb 2026 08:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yMEMTxlC1oZRfGY8ChNRsGXucnS2R9aO9U9nIXoPhk=;
	b=j7/Fuv/if0cjy5suD0vQ/swSviSVzf+2HWPJJ5CP/3G+P705xk96kMgT/6cskewUZQu5MH
	JcstL2nUCQFTbxatCKTTJ5MfJLmhCQgzTtvPXenNkkANPGO0csxOVxOK5YYr84KAkSh6aQ
	UP5SiG5iR9iVphVNM9UjcH+edOB5GWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yMEMTxlC1oZRfGY8ChNRsGXucnS2R9aO9U9nIXoPhk=;
	b=kFsl2OE6XFFMhzqMKtduCEEUSwEm11BTAlm3T+22eFvylYMb7tdqEpLETDvElm9EQWYgp3
	KDj5jsnLl4ckcUCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="j7/Fuv/i";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kFsl2OE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yMEMTxlC1oZRfGY8ChNRsGXucnS2R9aO9U9nIXoPhk=;
	b=j7/Fuv/if0cjy5suD0vQ/swSviSVzf+2HWPJJ5CP/3G+P705xk96kMgT/6cskewUZQu5MH
	JcstL2nUCQFTbxatCKTTJ5MfJLmhCQgzTtvPXenNkkANPGO0csxOVxOK5YYr84KAkSh6aQ
	UP5SiG5iR9iVphVNM9UjcH+edOB5GWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yMEMTxlC1oZRfGY8ChNRsGXucnS2R9aO9U9nIXoPhk=;
	b=kFsl2OE6XFFMhzqMKtduCEEUSwEm11BTAlm3T+22eFvylYMb7tdqEpLETDvElm9EQWYgp3
	KDj5jsnLl4ckcUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BA673EA66;
	Wed, 18 Feb 2026 08:39:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aJ8WGap6lWn8LwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 18 Feb 2026 08:39:06 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 12/13] lib/fonts: Store font data for user space with font_data_export()
Date: Wed, 18 Feb 2026 09:16:03 +0100
Message-ID: <20260218083855.10743-13-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: AFDAE3E701
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Add font_data_export() and update consoles to use it.

The helper font_data_export() is based on code in fbcon_get_font().
It extends the size of a single glyph to match the requested vpitch,
which us usually 32 bytes for fonts from user space. Internal fonts
have a pitch according to the glyph's height.

The implementation of font_data_export() differs in several ways from
the original code. The original implementation distinguished between
different pitches of the font data. This is not necessary as the pitch
is a parameter in the copying.

There was also special handling for a font pitch of 3 bytes, which got
expanded to 4 bytes (with trailing bits on each scanline). The logic
originated from long before git history exists even in the historical
tree. So it is not clear why this was implemented. It is not what user
space expects. The setfont utitlity loads font with 3-bytes pitches and
expects to read such fonts with a 3-byte pitch. For any font width, the
font pitch is always the width extended to the next multiple of 8. See
[1] for the user-space font-reading code.

With the changes ot handling the font pitches, font_data_export() replaces
the original code's various special cases with a single copying logic.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://github.com/legionus/kbd/blob/v2.9.0/src/libkfont/kdfontop.c#L73 # [1]
---
 drivers/video/fbdev/core/fbcon.c | 57 ++------------------------------
 include/linux/font.h             |  1 +
 lib/fonts/fonts.c                | 40 ++++++++++++++++++++++
 3 files changed, 43 insertions(+), 55 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 30d82290d01f..4d07904f62e9 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2287,68 +2287,15 @@ static bool fbcon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
 
 static int fbcon_get_font(struct vc_data *vc, struct console_font *font, unsigned int vpitch)
 {
-	struct fbcon_display *p = &fb_display[vc->vc_num];
-	font_data_t *fontdata = p->fontdata;
-	u8 *data = font->data;
-	int i, j;
+	const struct fbcon_display *p = &fb_display[vc->vc_num];
 
 	font->width = vc->vc_font.width;
 	font->height = vc->vc_font.height;
 	if (font->height > vpitch)
 		return -ENOSPC;
 	font->charcount = vc->vc_hi_font_mask ? 512 : 256;
-	if (!font->data)
-		return 0;
-
-	if (font->width <= 8) {
-		j = vc->vc_font.height;
-		if (font->charcount * j > font_data_size(fontdata))
-			return -EINVAL;
 
-		for (i = 0; i < font->charcount; i++) {
-			memcpy(data, fontdata, j);
-			memset(data + j, 0, vpitch - j);
-			data += vpitch;
-			fontdata += j;
-		}
-	} else if (font->width <= 16) {
-		j = vc->vc_font.height * 2;
-		if (font->charcount * j > font_data_size(fontdata))
-			return -EINVAL;
-
-		for (i = 0; i < font->charcount; i++) {
-			memcpy(data, fontdata, j);
-			memset(data + j, 0, 2*vpitch - j);
-			data += 2*vpitch;
-			fontdata += j;
-		}
-	} else if (font->width <= 24) {
-		if (font->charcount * (vc->vc_font.height * sizeof(u32)) > font_data_size(fontdata))
-			return -EINVAL;
-
-		for (i = 0; i < font->charcount; i++) {
-			for (j = 0; j < vc->vc_font.height; j++) {
-				*data++ = fontdata[0];
-				*data++ = fontdata[1];
-				*data++ = fontdata[2];
-				fontdata += sizeof(u32);
-			}
-			memset(data, 0, 3 * (vpitch - j));
-			data += 3 * (vpitch - j);
-		}
-	} else {
-		j = vc->vc_font.height * 4;
-		if (font->charcount * j > font_data_size(fontdata))
-			return -EINVAL;
-
-		for (i = 0; i < font->charcount; i++) {
-			memcpy(data, fontdata, j);
-			memset(data + j, 0, 4 * vpitch - j);
-			data += 4 * vpitch;
-			fontdata += j;
-		}
-	}
-	return 0;
+	return font_data_export(p->fontdata, font, vpitch);
 }
 
 /* set/clear vc_hi_font_mask and update vc attrs accordingly */
diff --git a/include/linux/font.h b/include/linux/font.h
index 5a1bf433b275..4ff956a1cd0a 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -62,6 +62,7 @@ void font_data_get(font_data_t *fd);
 bool font_data_put(font_data_t *fd);
 unsigned int font_data_size(font_data_t *fd);
 bool font_data_is_equal(font_data_t *lhs, font_data_t *rhs);
+int font_data_export(font_data_t *fd, struct console_font *font, unsigned int vpitch);
 
 /*
  * Font lookup
diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index 9b5355f6d2dc..1830e6ae9c87 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -202,6 +202,46 @@ bool font_data_is_equal(font_data_t *lhs, font_data_t *rhs)
 }
 EXPORT_SYMBOL_GPL(font_data_is_equal);
 
+/**
+ * font_data_export - Stores font data for user space
+ * @fd: Font data
+ * @font: A font for user space
+ * @vpitch: The size of a single glyph in @font in bytes
+ *
+ * Store the font data given in @fd to the font in @font. Values and
+ * pointers in @font are pre-initialized. This helper mostly checks some
+ * corner cases and translates glyph sizes according to the value given
+ * @vpitch.
+ *
+ * Returns:
+ * 0 on success, or a negative errno code otherwise.
+ */
+int font_data_export(font_data_t *fd, struct console_font *font, unsigned int vpitch)
+{
+	const unsigned char *font_data = font_data_buf(fd);
+	unsigned char *data = font->data;
+	unsigned int pitch = console_font_pitch(font);
+	unsigned int glyphsize, i;
+
+	if (!font->width || !font->height || !font->charcount || !font->data)
+		return 0;
+
+	glyphsize = font->height * pitch;
+
+	if (font->charcount * glyphsize > font_data_size(fd))
+		return -EINVAL;
+
+	for (i = 0; i < font->charcount; i++) {
+		memcpy(data, font_data, glyphsize);
+		memset(data + glyphsize, 0, pitch * vpitch - glyphsize);
+		data += pitch * vpitch;
+		font_data += glyphsize;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(font_data_export);
+
 /*
  * Font lookup
  */
-- 
2.52.0


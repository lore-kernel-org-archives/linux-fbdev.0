Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A23D3307
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Mar 2026 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065857; cv=none; b=mquxMBlprRiexeYVThozbYIrB9WUI8itftpeOOlR1s1NBRozNVMxuQn3TdItfRLGBfEZgz6vkqKeXsViMow8NzcRhmtOujmIVo7jVzdQh3tmG2/mi5b316lrKojW9B+ZjuyW/Q6FQ8cUelBonrdukgUOAk0rZOSRLMBHI2dH5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065857; c=relaxed/simple;
	bh=irufchddwo5YqDSW6oJwIedSRSzEXvSvW1In0pC7uFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4ec/m2d+4pEz8636/kis0Ur5WjTUyE33HaTnSVKSJhzvBTYYE6DDv/yCPQevr9G3V3C+qSLa2Iq2aGO0NZaz/fEaCsd0qz0VL5vboJ7H6WwzR6jil/EZo7oyAxUhyy2GfXHYA7gCDpOckAnhylwYmdl0rPpX7rY8tuuDfY7hKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L6BJzNpw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X8bPw+zT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L6BJzNpw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X8bPw+zT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L6BJzNpw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X8bPw+zT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L6BJzNpw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X8bPw+zT"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9383D5BE12;
	Mon,  9 Mar 2026 14:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773065850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CojlbhE18m4XtJrMFeXMaWQypY+aZWF/H0r2IOFVDiU=;
	b=L6BJzNpwPmoexBDfHbbpkO8Sl6sObsxyx5jDshG6pG6x/36oNllEGnitbaszJwOe6U3Jci
	/jzIYA3DuTOlX6kns+JwzODYlZYEh+Ch3fV8JXgB9r67JQxpbLdBQB5ED4fYT7O2t/ipQF
	Kski2qUz1ViLqvgqYmBnIHiudRcLe1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773065850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CojlbhE18m4XtJrMFeXMaWQypY+aZWF/H0r2IOFVDiU=;
	b=X8bPw+zT3MiHribCG/SDrRyYO0Gl6Fp6ylxC6m9fmQUDDN9ZdeveLAkqTnSikLQ7QDmGXM
	o4Fk6BwTzNntZfDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773065850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CojlbhE18m4XtJrMFeXMaWQypY+aZWF/H0r2IOFVDiU=;
	b=L6BJzNpwPmoexBDfHbbpkO8Sl6sObsxyx5jDshG6pG6x/36oNllEGnitbaszJwOe6U3Jci
	/jzIYA3DuTOlX6kns+JwzODYlZYEh+Ch3fV8JXgB9r67JQxpbLdBQB5ED4fYT7O2t/ipQF
	Kski2qUz1ViLqvgqYmBnIHiudRcLe1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773065850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CojlbhE18m4XtJrMFeXMaWQypY+aZWF/H0r2IOFVDiU=;
	b=X8bPw+zT3MiHribCG/SDrRyYO0Gl6Fp6ylxC6m9fmQUDDN9ZdeveLAkqTnSikLQ7QDmGXM
	o4Fk6BwTzNntZfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 595ED3EF3B;
	Mon,  9 Mar 2026 14:17:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cF2gFHrWrmldPAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 09 Mar 2026 14:17:30 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 04/13] vt: Calculate font-buffer size with vc_font_size()
Date: Mon,  9 Mar 2026 15:14:46 +0100
Message-ID: <20260309141723.137364-5-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

In fbcon, fbcon_resize() computes the size of the font buffer from the
values stored in vc_font. Move these calculations to the dedicated helpers
vc_font_pitch() and vc_font_size().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon.c |  9 ++-------
 include/linux/console_struct.h   | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 247bb90c08d3..103e91c8d874 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2037,7 +2037,6 @@ static void updatescrollmode(struct fbcon_display *p,
 }
 
 #define PITCH(w) (((w) + 7) >> 3)
-#define CALC_FONTSZ(h, p, c) ((h) * (p) * (c)) /* size = height * pitch * charcount */
 
 static int fbcon_resize(struct vc_data *vc, unsigned int width,
 			unsigned int height, bool from_user)
@@ -2049,8 +2048,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
 
 	if (p->userfont && FNTSIZE(vc->vc_font.data)) {
-		int size;
-		int pitch = PITCH(vc->vc_font.width);
+		unsigned int size = vc_font_size(&vc->vc_font);
 
 		/*
 		 * If user font, ensure that a possible change to user font
@@ -2059,10 +2057,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 		 * charcount can change and cannot be used to determine the
 		 * font data allocated size.
 		 */
-		if (pitch <= 0)
-			return -EINVAL;
-		size = CALC_FONTSZ(vc->vc_font.height, pitch, vc->vc_font.charcount);
-		if (size > FNTSIZE(vc->vc_font.data))
+		if (!size || size > FNTSIZE(vc->vc_font.data))
 			return -EINVAL;
 	}
 
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index ea0cdf4278a3..771cba16cb54 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -83,6 +83,34 @@ struct vc_font {
 	const unsigned char *data;
 };
 
+/**
+ * vc_font_pitch - Calculates the number of bytes between two adjacent scanlines
+ * @font: The VC font
+ *
+ * Returns:
+ * The number of bytes between two adjacent scanlines in the font data
+ */
+static inline unsigned int vc_font_pitch(const struct vc_font *font)
+{
+	return DIV_ROUND_UP(font->width, 8);
+}
+
+/**
+ * vc_font_size - Calculates the size of the font data in bytes
+ * @font: The VC font
+ *
+ * vc_font_size() calculates the number of bytes of font data in the
+ * font specified by @font. The function calculates the size from the
+ * font parameters.
+ *
+ * Returns:
+ * The size of the font data in bytes.
+ */
+static inline unsigned int vc_font_size(const struct vc_font *font)
+{
+	return font->height * vc_font_pitch(font) * font->charcount;
+}
+
 /*
  * Example: vc_data of a console that was scrolled 3 lines down.
  *
-- 
2.53.0


Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA82320A1D
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Feb 2026 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403952; cv=none; b=A8X4CiIsl88MIyCqgRDIvBbkUlLLZos4I6TgLegpY8k2O95Efp3FMYlz+gp2fnD+bkYTc3OtQlZxUyfaDDwY/YtV0Drp4K7iL36OOVDnNxRgjGKZ0aGtwHgte7OOnW9BkCQZL/QWCw8dQWFtCc5Urd6owZqCmPjDxW/3/8QK6Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403952; c=relaxed/simple;
	bh=Es//qKrSyYlU6BHtRMvOluv38Q7GY2tlIWcQd5BP6B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCMd34qE2nXNalGlt2JJUlKn9+6/tDQKMK8HnoN3zZTdCZxyE+qrPWbSHdFPnhAi+Dq86XOK/TxP2/5+wano6GwmdDbaMTc5re8h4Y8Fl2HexAxib8zLIw/ajL1JTAEE3lwnIUxpVOthLNH+kz0clGp8TzijXXuW1sZa1ZqgEss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QRfrw483; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=01fkvanA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QRfrw483; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=01fkvanA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QRfrw483";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="01fkvanA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QRfrw483";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="01fkvanA"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B3D15BCC9;
	Wed, 18 Feb 2026 08:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOZEzhfDSpl/+3mnFnqRpcaYFSjgaxuf/m0MT1S4mKY=;
	b=QRfrw483H+tukew4um6mIuyuUuCcSy2/TaoHFpyz45P/F3WZ/EF+lg/FDzawTxb5kwZh6y
	XRhkoodxnZmCwVfd3bGuGz8PvAGDw6+IT84Rc+IHDTVCDpy5MJjI6fZAu75aCnr9LYUGlm
	+Nis5K/t3nMUrcyt+22KNEp01ABVNzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOZEzhfDSpl/+3mnFnqRpcaYFSjgaxuf/m0MT1S4mKY=;
	b=01fkvanAelq8X5W2lNY80lKvuqbodKLdIzQ7psJIgm5s/dG6HgrCITyRjZqymk4kgGB1s+
	V8K8ADSXWY1dRQAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QRfrw483;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=01fkvanA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOZEzhfDSpl/+3mnFnqRpcaYFSjgaxuf/m0MT1S4mKY=;
	b=QRfrw483H+tukew4um6mIuyuUuCcSy2/TaoHFpyz45P/F3WZ/EF+lg/FDzawTxb5kwZh6y
	XRhkoodxnZmCwVfd3bGuGz8PvAGDw6+IT84Rc+IHDTVCDpy5MJjI6fZAu75aCnr9LYUGlm
	+Nis5K/t3nMUrcyt+22KNEp01ABVNzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOZEzhfDSpl/+3mnFnqRpcaYFSjgaxuf/m0MT1S4mKY=;
	b=01fkvanAelq8X5W2lNY80lKvuqbodKLdIzQ7psJIgm5s/dG6HgrCITyRjZqymk4kgGB1s+
	V8K8ADSXWY1dRQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A0E63EA67;
	Wed, 18 Feb 2026 08:39:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ALvLFKh6lWn8LwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 18 Feb 2026 08:39:04 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 04/13] vt: Calculate font-buffer size with vc_font_size()
Date: Wed, 18 Feb 2026 09:15:55 +0100
Message-ID: <20260218083855.10743-5-tzimmermann@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLf7er7x8tqp4b41gsueb7z9k6)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9B3D15BCC9

In fbcon, fbcon_resize() computes the size of the font buffer from the
values stored in vc_font. Move these calculations to the dedicated helpers
vc_font_pitch() and vc_font_size().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon.c |  9 ++-------
 include/linux/console_struct.h   | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 5467b37b1441..96cf890aa0c9 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2042,7 +2042,6 @@ static void updatescrollmode(struct fbcon_display *p,
 }
 
 #define PITCH(w) (((w) + 7) >> 3)
-#define CALC_FONTSZ(h, p, c) ((h) * (p) * (c)) /* size = height * pitch * charcount */
 
 static int fbcon_resize(struct vc_data *vc, unsigned int width,
 			unsigned int height, bool from_user)
@@ -2054,8 +2053,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
 
 	if (p->userfont && FNTSIZE(vc->vc_font.data)) {
-		int size;
-		int pitch = PITCH(vc->vc_font.width);
+		unsigned int size = vc_font_size(&vc->vc_font);
 
 		/*
 		 * If user font, ensure that a possible change to user font
@@ -2064,10 +2062,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
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
index 7fdcae6ed49c..fbb5dd5f6761 100644
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
2.52.0


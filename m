Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8883BE153
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Mar 2026 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065893; cv=none; b=OfZtzM0SkxOV++9/VRjrjZXAxRIjcRiL4t/KOlXE/3C3Trdm9CyRoLpklUbOWpHiRVrI4h0HiR9ys5FBUyQGS1N+8GVykIfG14xUqlavmdJEaMd+Ei58Ph79DP2Ne5Z33/18UHzuAVroW34yWbmAYlH7+CKl0yadsVTOHyqGt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065893; c=relaxed/simple;
	bh=6zNTsXIKejF86BPCVa9YUibZB6aboUaJIe+852zsNLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgGiR8xmcjUBAmShr9jlHUwjs2l+YVXsWvpeB6VNCnI1ZjOt3ySSDJOggIisxwwIlyVQHCWC4btqxUm5UKTrUka+s112/jjoZkECQWbCipTzGcggdhdOuO8JZSVCCdvfNC9QPtQimq7pBfeesjOU+FVJCPK09cZGntbP3oZ9Qzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=koGCXSmG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xqiys0qg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=koGCXSmG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xqiys0qg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="koGCXSmG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xqiys0qg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="koGCXSmG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xqiys0qg"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 331114D246;
	Mon,  9 Mar 2026 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773065852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWzmPpeiXpnE41gcoTXD2KgTeEwpYCVbgY+rouAHnjs=;
	b=koGCXSmGU9uGLrsJ6fKCSXVAvSfkW0kpe42ZgugU2XgUHS4JerP8FXYjGYmCg1m308iEpb
	FXEO/cfuwBHtDZWBZkydRe5L0yuHtqNBB/CS2/gqpXs/jUGyOdb0ygSTRw3kG36zWR6KjQ
	Lgh2Pie6bMS52bm/SSXY4mT6AyDQ+6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773065852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWzmPpeiXpnE41gcoTXD2KgTeEwpYCVbgY+rouAHnjs=;
	b=Xqiys0qgC6VNeeDQ8RhsU+/fcaX8wmzDTRGJV/15+HRbgOJcSasEqcZIly43CoNAkd7GJ9
	7xo5enWZW7tv4ZCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773065852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWzmPpeiXpnE41gcoTXD2KgTeEwpYCVbgY+rouAHnjs=;
	b=koGCXSmGU9uGLrsJ6fKCSXVAvSfkW0kpe42ZgugU2XgUHS4JerP8FXYjGYmCg1m308iEpb
	FXEO/cfuwBHtDZWBZkydRe5L0yuHtqNBB/CS2/gqpXs/jUGyOdb0ygSTRw3kG36zWR6KjQ
	Lgh2Pie6bMS52bm/SSXY4mT6AyDQ+6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773065852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWzmPpeiXpnE41gcoTXD2KgTeEwpYCVbgY+rouAHnjs=;
	b=Xqiys0qgC6VNeeDQ8RhsU+/fcaX8wmzDTRGJV/15+HRbgOJcSasEqcZIly43CoNAkd7GJ9
	7xo5enWZW7tv4ZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECEA63EF3B;
	Mon,  9 Mar 2026 14:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cIVoOHvWrmldPAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 09 Mar 2026 14:17:31 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 10/13] lib/fonts: Compare font data for equality with font_data_is_equal()
Date: Mon,  9 Mar 2026 15:14:52 +0100
Message-ID: <20260309141723.137364-11-tzimmermann@suse.de>
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
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL4936hw7dbgk3hb39jfn1xy19)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Add font_data_is_equal() and update consoles to use it.

Font data is equal if it has the same size and contains the same values
on all bytes. Only fbcon uses a crc32 checksum. If set in both operands
the checksums have to be equal.

The new helper also guarantees to not compare internal fonts against
fonts from user space. Internal fonts cannot be ref-counted, so making
them equal to user-space fonts with the same byte sequence results in
undefined behavior.

The test only compares data buffers. Their interpretation is up each
console. Therefore remove a width test in fbcon_set_font().

v3:
- rebase onto font_data_{get,put}()

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/newport_con.c |  4 +---
 drivers/video/fbdev/core/fbcon.c    |  7 +------
 include/linux/font.h                |  1 +
 lib/fonts/fonts.c                   | 26 ++++++++++++++++++++++++++
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 43a1a4f41057..1bc3cb1ea116 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -529,9 +529,7 @@ static int newport_set_font(int unit, const struct console_font *op,
 
 	/* check if font is already used by other console */
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
-		if (font_data[i] != FONT_DATA
-		    && font_data_size(font_data[i]) == size
-		    && !memcmp(font_data[i], new_data, size)) {
+		if (font_data_is_equal(font_data[i], new_data)) {
 			font_data_put(new_data);
 			/* current font is the same as the new one */
 			if (i == unit)
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index ac59480c98cb..00255ac92e42 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2540,13 +2540,8 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	FNTSUM(new_data) = csum;
 	/* Check if the same font is on some other console already */
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
-		struct vc_data *tmp = vc_cons[i].d;
-
 		if (fb_display[i].fontdata &&
-		    FNTSUM(fb_display[i].fontdata) == csum &&
-		    font_data_size(fb_display[i].fontdata) == size &&
-		    tmp->vc_font.width == w &&
-		    !memcmp(fb_display[i].fontdata, new_data, size)) {
+		    font_data_is_equal(fb_display[i].fontdata, new_data)) {
 			font_data_get(fb_display[i].fontdata);
 			font_data_put(new_data);
 			new_data = fb_display[i].fontdata;
diff --git a/include/linux/font.h b/include/linux/font.h
index dd319d0f0201..58bf3c64cabb 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -57,6 +57,7 @@ static inline const unsigned char *font_data_buf(font_data_t *fd)
 void font_data_get(font_data_t *fd);
 bool font_data_put(font_data_t *fd);
 unsigned int font_data_size(font_data_t *fd);
+bool font_data_is_equal(font_data_t *lhs, font_data_t *rhs);
 
 /*
  * Font description
diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index d25efd8d6c31..3fb76d185647 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -110,6 +110,32 @@ unsigned int font_data_size(font_data_t *fd)
 }
 EXPORT_SYMBOL_GPL(font_data_size);
 
+/**
+ * font_data_is_equal - Compares font data for equality
+ * @lhs: Left-hand side font data
+ * @rhs: Right-hand-size font data
+ *
+ * Font data is equal if is constain the same sequence of values. The
+ * helper also use the checksum, if both arguments contain it. Font data
+ * coming from different origins, internal or from user space, is never
+ * equal. Allowing this would break reference counting.
+ *
+ * Returns:
+ * True if the given font data is equal, false otherwise.
+ */
+bool font_data_is_equal(font_data_t *lhs, font_data_t *rhs)
+{
+	if (font_data_is_internal(lhs) != font_data_is_internal(rhs))
+		return false;
+	if (font_data_size(lhs) != font_data_size(rhs))
+		return false;
+	if (FNTSUM(lhs) && FNTSUM(rhs) && FNTSUM(lhs) != FNTSUM(rhs))
+		return false;
+
+	return !memcmp(lhs, rhs, FNTSIZE(lhs));
+}
+EXPORT_SYMBOL_GPL(font_data_is_equal);
+
 /*
  * Font lookup
  */
-- 
2.53.0


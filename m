Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2673FD14C
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Mar 2026 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460801; cv=none; b=pQ8HF9FaiOzEBh7b56O9FMo6Ybzpv9ZDy0X3dfJ46ofyciaNiEzLLRdIqKVg4u5SPCJ9Vl4zaZcziDhRexv6MzTPjYC2pOM68ZPrLn/qvV1yPwKk1sd3i+Y2lHjwyhYAB7rpwy9qxnLGNT2sh9Y2hogZwK3UfRwDXHlWtStLT2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460801; c=relaxed/simple;
	bh=EGWomaBQrqRuANiJpK2ymkXFD1Wa5bf0qEJk2EYmbY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=judEkMh7HWZb8obq+yBx50XROqL/xycQkiRNJqx93VNEznrJAsjV5WUVxp6jHVBMJXfSaRnBw8K+++F2pybymWe9W0FQ8jsOFVQQ24OXV9dgUJX4BBYMs+5G49NzZF21cOh1FJHrJ9sSHmSNSVZehRQLaLqX/i8x3Vg2HFp1ORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w2mQdbtY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s1IkJmGt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w2mQdbtY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s1IkJmGt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w2mQdbtY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s1IkJmGt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w2mQdbtY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s1IkJmGt"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 442AC3F808;
	Mon,  2 Mar 2026 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9dyZ1v4fg9qIGmkPCG7W/hdjoJTxQ4ir5vYoatE9GM=;
	b=w2mQdbtYzPWsrSORp7qf3oHGfCHtY02rpEOXqKW09v4rq4LSYYKDm68y5j6IxU6w0Tb/D0
	QeoI2Vmt0PL7yJN4oRAQO/OiBVwKcAqaBTQt4Ogd+cPypLW5eMiIqPjMRTBz74YOcA8ihb
	196VecM6/VEcTahGStjOtwMVpZsWQ8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9dyZ1v4fg9qIGmkPCG7W/hdjoJTxQ4ir5vYoatE9GM=;
	b=s1IkJmGt3YmJop2Cr3PTPRA5R4JrpbqqO+RbVXiU+flMUVDdVxfkoVR8dYgmIYkMhG0ddE
	xQ0H4XfaHJr+flAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w2mQdbtY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s1IkJmGt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9dyZ1v4fg9qIGmkPCG7W/hdjoJTxQ4ir5vYoatE9GM=;
	b=w2mQdbtYzPWsrSORp7qf3oHGfCHtY02rpEOXqKW09v4rq4LSYYKDm68y5j6IxU6w0Tb/D0
	QeoI2Vmt0PL7yJN4oRAQO/OiBVwKcAqaBTQt4Ogd+cPypLW5eMiIqPjMRTBz74YOcA8ihb
	196VecM6/VEcTahGStjOtwMVpZsWQ8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9dyZ1v4fg9qIGmkPCG7W/hdjoJTxQ4ir5vYoatE9GM=;
	b=s1IkJmGt3YmJop2Cr3PTPRA5R4JrpbqqO+RbVXiU+flMUVDdVxfkoVR8dYgmIYkMhG0ddE
	xQ0H4XfaHJr+flAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F9253EA6C;
	Mon,  2 Mar 2026 14:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SG+bAu6apWleKQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Mar 2026 14:13:02 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 09/13] lib/fonts: Compare font data for equality with font_data_is_equal()
Date: Mon,  2 Mar 2026 15:08:43 +0100
Message-ID: <20260302141255.518657-10-tzimmermann@suse.de>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
X-Rspamd-Queue-Id: 442AC3F808
X-Spam-Flag: NO
X-Spam-Score: -3.01
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

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/newport_con.c |  3 +--
 drivers/video/fbdev/core/fbcon.c    |  7 +-----
 include/linux/font.h                |  1 +
 lib/fonts/fonts.c                   | 37 +++++++++++++++++++++++++++--
 4 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 1198c6bc2777..4db2b901c709 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -530,8 +530,7 @@ static int newport_set_font(int unit, const struct console_font *op,
 	/* check if font is already used by other console */
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (font_data[i] != FONT_DATA
-		    && font_data_size(font_data[i]) == size
-		    && !memcmp(font_data[i], new_data, size)) {
+		    && font_data_is_equal(font_data[i], new_data)) {
 			kfree(new_data - FONT_EXTRA_WORDS * sizeof(int));
 			/* current font is the same as the new one */
 			if (i == unit)
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index fa8f3e4196de..31e812d87d9e 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2548,14 +2548,9 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	FNTSUM(new_data) = csum;
 	/* Check if the same font is on some other console already */
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
-		struct vc_data *tmp = vc_cons[i].d;
-
 		if (fb_display[i].userfont &&
 		    fb_display[i].fontdata &&
-		    FNTSUM(fb_display[i].fontdata) == csum &&
-		    font_data_size(fb_display[i].fontdata) == size &&
-		    tmp->vc_font.width == w &&
-		    !memcmp(fb_display[i].fontdata, new_data, size)) {
+		    font_data_is_equal(fb_display[i].fontdata, new_data)) {
 			kfree(new_data - FONT_EXTRA_WORDS * sizeof(int));
 			new_data = (u8 *)fb_display[i].fontdata;
 			break;
diff --git a/include/linux/font.h b/include/linux/font.h
index 55cc016a9357..1f5b85601c9b 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -55,6 +55,7 @@ static inline const unsigned char *font_data_buf(font_data_t *fd)
 }
 
 unsigned int font_data_size(font_data_t *fd);
+bool font_data_is_equal(font_data_t *lhs, font_data_t *rhs);
 
 /*
  * Font description
diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index 8c9a6762061c..c9f6328d5dda 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -12,18 +12,25 @@
  * for more details.
  */
 
+#include <linux/font.h>
 #include <linux/module.h>
-#include <linux/types.h>
 #include <linux/string.h>
+#include <linux/types.h>
+
+#include <asm/sections.h>
 #if defined(__mc68000__)
 #include <asm/setup.h>
 #endif
-#include <linux/font.h>
 
 /*
  * Helpers for font_data_t
  */
 
+static bool font_data_is_internal(font_data_t *fd)
+{
+	return is_kernel_rodata((unsigned long)fd);
+}
+
 /**
  * font_data_size - Return size of the font data in bytes
  * @fd: Font data
@@ -37,6 +44,32 @@ unsigned int font_data_size(font_data_t *fd)
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


Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954643FFAA6
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Mar 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460789; cv=none; b=cB1iAXi/iHVOS7YCU6xKcUVVe90rr0xu9xD8qAiSoSagziIIKTgjarTiPSd6QIWq552DQMsbAh2ihvT51ov6VgcRIYXDKHyZX5SlLJ8UUDc98JzEfblJhq4A1rdr0Kql59sI4dwY9xF9CbOkxQgvdismrZ4sgVFAMUorkR/hzzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460789; c=relaxed/simple;
	bh=U5t7FfpI8bDIXdRv4UUiGN9veQB5PuFRipOiFyXYXrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTC7pTuUW1rJ1TdubZZtvXkN7bP8LF1X6uaSpSY56vObNoMuy0pXOchmvN49ZX1lEXSV4R5UHzwEEOIBE2w2xjDeajMCSSSjrp0DEk31DOhxVb4YDxKADrQtx14pcrxpc2EBYjx8dHAStwkdLcc09bB3gjI4lWSjyCrwhNRK6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oa5qRlxH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rkHs28dS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oa5qRlxH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rkHs28dS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oa5qRlxH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rkHs28dS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oa5qRlxH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rkHs28dS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C5785BD76;
	Mon,  2 Mar 2026 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgO/vBjxEvbCUOOxusElmoEUhXTpiDO+udaq2KN88TI=;
	b=oa5qRlxHVdI+XFsogszLlCt9iE/0JRwf+IRGRQjnnPx6oQpCHZwpDMR64DUQ6q1b+kQuYo
	KvdAa/v3qnX8+gafO+4eUKHH4smWUrQRKohQYgAD4W2gKmD4680wI0OYqf9cXLM2TgyqCH
	x46be/WuJJCQvQBahKeZ8z46Qgc/S8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgO/vBjxEvbCUOOxusElmoEUhXTpiDO+udaq2KN88TI=;
	b=rkHs28dStU/jRLUQp3RdCh0YaU3vDJ49ttgk1Hz5/ltmmCe9J1CArABfAMHg1IcpPi02sA
	xy8conT13eIBmxAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oa5qRlxH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rkHs28dS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgO/vBjxEvbCUOOxusElmoEUhXTpiDO+udaq2KN88TI=;
	b=oa5qRlxHVdI+XFsogszLlCt9iE/0JRwf+IRGRQjnnPx6oQpCHZwpDMR64DUQ6q1b+kQuYo
	KvdAa/v3qnX8+gafO+4eUKHH4smWUrQRKohQYgAD4W2gKmD4680wI0OYqf9cXLM2TgyqCH
	x46be/WuJJCQvQBahKeZ8z46Qgc/S8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgO/vBjxEvbCUOOxusElmoEUhXTpiDO+udaq2KN88TI=;
	b=rkHs28dStU/jRLUQp3RdCh0YaU3vDJ49ttgk1Hz5/ltmmCe9J1CArABfAMHg1IcpPi02sA
	xy8conT13eIBmxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FD243EA6C;
	Mon,  2 Mar 2026 14:13:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sD8BCuyapWleKQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Mar 2026 14:13:00 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 01/13] fbdev: Declare src parameter of fb_pad_ helpers as constant
Date: Mon,  2 Mar 2026 15:08:35 +0100
Message-ID: <20260302141255.518657-2-tzimmermann@suse.de>
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6C5785BD76

Fbdev's padding helpers do not modify the source buffer. Declare the
parameter as 'const'.

Fbcon's font-rendering code calls these helpers with the font data.
Declaring src as const will allow for making the font data constant
as well.

While at it, also remove the extern qualifier from the function
declarations in the header file.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbmem.c |  6 +++---
 include/linux/fb.h               | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index cf199038f069..30f2b59c47bf 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -91,14 +91,14 @@ EXPORT_SYMBOL(fb_get_color_depth);
 /*
  * Data padding functions.
  */
-void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u32 height)
+void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, const u8 *src, u32 s_pitch, u32 height)
 {
 	__fb_pad_aligned_buffer(dst, d_pitch, src, s_pitch, height);
 }
 EXPORT_SYMBOL(fb_pad_aligned_buffer);
 
-void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 idx, u32 height,
-				u32 shift_high, u32 shift_low, u32 mod)
+void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, const u8 *src, u32 idx, u32 height,
+			     u32 shift_high, u32 shift_low, u32 mod)
 {
 	u8 mask = (u8) (0xff << shift_high), tmp;
 	int i, j;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 6d4a58084fd5..324b0fd5f617 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -605,9 +605,9 @@ extern int register_framebuffer(struct fb_info *fb_info);
 extern void unregister_framebuffer(struct fb_info *fb_info);
 extern int devm_register_framebuffer(struct device *dev, struct fb_info *fb_info);
 extern char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size);
-extern void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 idx,
-				u32 height, u32 shift_high, u32 shift_low, u32 mod);
-extern void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u32 height);
+void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, const u8 *src, u32 idx, u32 height,
+			     u32 shift_high, u32 shift_low, u32 mod);
+void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, const u8 *src, u32 s_pitch, u32 height);
 extern void fb_set_suspend(struct fb_info *info, int state);
 extern int fb_get_color_depth(struct fb_var_screeninfo *var,
 			      struct fb_fix_screeninfo *fix);
@@ -633,8 +633,8 @@ static inline struct device *dev_of_fbinfo(const struct fb_info *info)
 #endif
 }
 
-static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
-					   u8 *src, u32 s_pitch, u32 height)
+static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, const u8 *src, u32 s_pitch,
+					   u32 height)
 {
 	u32 i, j;
 
-- 
2.53.0


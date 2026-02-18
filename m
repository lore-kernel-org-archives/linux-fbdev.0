Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601832252D
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Feb 2026 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403962; cv=none; b=PSzxyiSll67UiwLJWTSlOBJrRas6YvKp1EGk9vggSy26qEM+myCuQGTsIRiyLE7G9Uo7jve1MfOtrl/LhJteYaOKiTcutWp2UrlJXK8Nu97+FI0aKh1SYqb3dPOvWts++XMRcxZ0F7RGMnnZzh/3MakiZi7LpeukXkzz2F7y2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403962; c=relaxed/simple;
	bh=onqtRKcn4mnPmKQl4LZpN2q8etQWd2vibW2PM7CgK+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6nc6K/6sHU4ZPyk7xa2P9y0KzjV8Fk+EHqvAKrK/4rTDaVZ+e+ozZIXauQ6JQyMtHSGqdLbxKFmPzJP5sgYUpn+uU3IOT05ZdfL6flxnPU8kzlyk7ltpiM5T4ORIe6EOU2OrKNj4UZrXaUz3FCh5EufkOJBHPYvPOkTQ1BQL/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eQ7A0QRM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n47Hhbhd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eQ7A0QRM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n47Hhbhd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eQ7A0QRM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n47Hhbhd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eQ7A0QRM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n47Hhbhd"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D809A3E6F2;
	Wed, 18 Feb 2026 08:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcqdIEuyqZbwAcDIbummLGMBVqW6LxpC7bOENZ3olu0=;
	b=eQ7A0QRMnZAFiliALKu61DLApAE3r/HjP5t4M84hFgWvWtTk737O3THR87TV+bovYoZpGo
	u7UbN3VZAGp9BGUPS9Yu81IZAj+27/POJ622hdtlf35jkSfzg3jVMuXM2Fxx2yNziT7zNB
	4nLVMUduWyM9v8gCP1rDkdhUmw05TXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcqdIEuyqZbwAcDIbummLGMBVqW6LxpC7bOENZ3olu0=;
	b=n47HhbhdIHDHf/HMryBFcl0nh9/EjrWSOPkmRJkcQJZjGYQw9LY9RAl81BSVe9EDme5tpq
	vL1ryynW0S5bvvCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eQ7A0QRM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n47Hhbhd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcqdIEuyqZbwAcDIbummLGMBVqW6LxpC7bOENZ3olu0=;
	b=eQ7A0QRMnZAFiliALKu61DLApAE3r/HjP5t4M84hFgWvWtTk737O3THR87TV+bovYoZpGo
	u7UbN3VZAGp9BGUPS9Yu81IZAj+27/POJ622hdtlf35jkSfzg3jVMuXM2Fxx2yNziT7zNB
	4nLVMUduWyM9v8gCP1rDkdhUmw05TXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcqdIEuyqZbwAcDIbummLGMBVqW6LxpC7bOENZ3olu0=;
	b=n47HhbhdIHDHf/HMryBFcl0nh9/EjrWSOPkmRJkcQJZjGYQw9LY9RAl81BSVe9EDme5tpq
	vL1ryynW0S5bvvCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90B9C3EA66;
	Wed, 18 Feb 2026 08:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SPfuIad6lWn8LwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 18 Feb 2026 08:39:03 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 01/13] fbdev: Declare src parameter of fb_pad_ helpers as constant
Date: Wed, 18 Feb 2026 09:15:52 +0100
Message-ID: <20260218083855.10743-2-tzimmermann@suse.de>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D809A3E6F2

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
index eff757ebbed1..9c78fd32e7b3 100644
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
 	u8 mask = (u8) (0xfff << shift_high), tmp;
 	int i, j;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index b8b6f54f3312..9a8051f258ac 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -606,9 +606,9 @@ extern int register_framebuffer(struct fb_info *fb_info);
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
@@ -625,8 +625,8 @@ static inline void unlock_fb_info(struct fb_info *info)
 	mutex_unlock(&info->lock);
 }
 
-static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
-					   u8 *src, u32 s_pitch, u32 height)
+static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, const u8 *src, u32 s_pitch,
+					   u32 height)
 {
 	u32 i, j;
 
-- 
2.52.0


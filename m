Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EF33A002
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Sep 2025 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422149; cv=none; b=KT+8TW7tHmbNsg/B8a9JeyOXQxTW1hdMY4i5POJMzdPZ7uRuGqW+F5KIeVH3tU47AQtcR5L0ROT8/D46SVlc1Zo3drtcCbITcZW4e66wXEvz7PGrwtMrKvxPsc3jqVcs7dJVuhLD2K7jLETCwZENgtQHz/uGbOvTc6ojZapOA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422149; c=relaxed/simple;
	bh=0sPZ4UDlhK0Uty8ucd3kLYPOpJgfKEOJZABTRt33hfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCQY4ry9sPFIpAs046Df1VPbo9UurNMiAxivbWdsXBOk7bqeyyLMW2brYEd5RuLFZ+4PMlD0bBWE77kymY9tyMKYz2MQ6GBwmpR1hmLuUf3+26P3oPyyKOo/DzZ37diH112aGycWqCChDKljOwwhv3JLdqV3/HDxOnla6OYuUBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YDs9QXfn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h9lQC/Ru; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YDs9QXfn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h9lQC/Ru; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YDs9QXfn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h9lQC/Ru";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YDs9QXfn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h9lQC/Ru"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B371121E16;
	Tue,  9 Sep 2025 12:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757422144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXrTNcIXey7r3a4IZTag05S2jAmGCHxkyv+nq5ZFf6M=;
	b=YDs9QXfneYE2dw+PtqHLKvs2/FNXKJ2iiguMZ0EAtbODZYry3bd0q2zUyNh8itqEXDTVEY
	vqrnffZE4Ng2g6u4SPbZuIuHeSu0nbqRRRhehdUFpHJ5Tnpc/ksKe4lIi7tsmQrtm/qyxl
	HOs/YtwMdn3tHIaClzztM+RyJiyYvLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757422144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXrTNcIXey7r3a4IZTag05S2jAmGCHxkyv+nq5ZFf6M=;
	b=h9lQC/Rugoj6ozHiIuawqV6NJxEQ9gd5YCc6OGqxxn04zTdi9pSJ/PddpZnqGOSZHqyh5U
	CPMqde51n4z+3bDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757422144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXrTNcIXey7r3a4IZTag05S2jAmGCHxkyv+nq5ZFf6M=;
	b=YDs9QXfneYE2dw+PtqHLKvs2/FNXKJ2iiguMZ0EAtbODZYry3bd0q2zUyNh8itqEXDTVEY
	vqrnffZE4Ng2g6u4SPbZuIuHeSu0nbqRRRhehdUFpHJ5Tnpc/ksKe4lIi7tsmQrtm/qyxl
	HOs/YtwMdn3tHIaClzztM+RyJiyYvLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757422144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXrTNcIXey7r3a4IZTag05S2jAmGCHxkyv+nq5ZFf6M=;
	b=h9lQC/Rugoj6ozHiIuawqV6NJxEQ9gd5YCc6OGqxxn04zTdi9pSJ/PddpZnqGOSZHqyh5U
	CPMqde51n4z+3bDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F80113A56;
	Tue,  9 Sep 2025 12:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qFP1HUAiwGilUAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 09 Sep 2025 12:49:04 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sam@ravnborg.org,
	simona@ffwll.ch,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 3/5] fbcon: Set rotate_font callback with related callbacks
Date: Tue,  9 Sep 2025 14:44:43 +0200
Message-ID: <20250909124616.143365-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909124616.143365-1-tzimmermann@suse.de>
References: <20250909124616.143365-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[ravnborg.org,ffwll.ch,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -2.80

The field struct fbcon_par.rotate_font points to fbcon_rotate_font() if
the console is rotated. Set the callback in the same place as the other
callbacks. Prepares for declaring all fbcon callbacks in a dedicated
struct type.

If not rotated, fbcon_set_bitops() still clears the callback to NULL.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/core/fbcon_ccw.c    | 1 +
 drivers/video/fbdev/core/fbcon_cw.c     | 1 +
 drivers/video/fbdev/core/fbcon_rotate.c | 4 +---
 drivers/video/fbdev/core/fbcon_rotate.h | 3 +++
 drivers/video/fbdev/core/fbcon_ud.c     | 1 +
 5 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 2ba8ec4c3e2b..ba744b67a4fd 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -398,4 +398,5 @@ void fbcon_rotate_ccw(struct fbcon_par *par)
 	par->clear_margins = ccw_clear_margins;
 	par->cursor = ccw_cursor;
 	par->update_start = ccw_update_start;
+	par->rotate_font = fbcon_rotate_font;
 }
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index 4bd22d5ee5f4..974bd9d9b770 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -381,4 +381,5 @@ void fbcon_rotate_cw(struct fbcon_par *par)
 	par->clear_margins = cw_clear_margins;
 	par->cursor = cw_cursor;
 	par->update_start = cw_update_start;
+	par->rotate_font = fbcon_rotate_font;
 }
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 380b2746451a..0c7cac71a9c2 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -18,7 +18,7 @@
 #include "fbcon.h"
 #include "fbcon_rotate.h"
 
-static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
+int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 {
 	struct fbcon_par *par = info->fbcon_par;
 	int len, err = 0;
@@ -95,8 +95,6 @@ static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 
 void fbcon_set_rotate(struct fbcon_par *par)
 {
-	par->rotate_font = fbcon_rotate_font;
-
 	switch (par->rotate) {
 	case FB_ROTATE_CW:
 		fbcon_rotate_cw(par);
diff --git a/drivers/video/fbdev/core/fbcon_rotate.h b/drivers/video/fbdev/core/fbcon_rotate.h
index 48305e1a0763..784f3231a958 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.h
+++ b/drivers/video/fbdev/core/fbcon_rotate.h
@@ -90,7 +90,10 @@ static inline void rotate_ccw(const char *in, char *out, u32 width, u32 height)
 	}
 }
 
+int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc);
+
 extern void fbcon_rotate_cw(struct fbcon_par *par);
 extern void fbcon_rotate_ud(struct fbcon_par *par);
 extern void fbcon_rotate_ccw(struct fbcon_par *par);
+
 #endif
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index 14b40e2bf323..1a214a4d538f 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -425,4 +425,5 @@ void fbcon_rotate_ud(struct fbcon_par *par)
 	par->clear_margins = ud_clear_margins;
 	par->cursor = ud_cursor;
 	par->update_start = ud_update_start;
+	par->rotate_font = fbcon_rotate_font;
 }
-- 
2.51.0


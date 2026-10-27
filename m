Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108217;
	b=ILbGgaq3AuOKdFg6tcgBI4k3qrEa3DWWLsRKuChYcB9WNWip61ssKmWcdmVHXuOpjAws
	 Dp9AXgdUtpzcYQaXilml8OUUV1cCghKUjVvhgyGvV0lyR4zkR1Mx6uWBN52+k+Y3D9SuA
	 5PmTWxB+i1p3OZOrk3i3NiGSqtOLYgwSVxlIgcfnePiNWLJ7jg4Q9a23RdUwDE3FdP+nZ
	 T+Pu3HuygAxeUOYeL7DIV/FlQPdcZBtKP/CQjnYP4zg2gbW0Vn3iFY+mCVgEVZeAfI3/3
	 /2ZYjV7T8pCaFFKJpFDhG8YiHePNCXIDR3Ja+D1khfHL9TqdQlSP1JoG5bzzmHr7yNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108217;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Queue-Id:
	 X-Rspamd-Pre-Result:X-Rspamd-Action:X-Rspamd-Server:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score;
	bh=Cvy/F0DMjIvBLD3lHgQbRuv1IOPQRblzzCoUfJM1dWU=;
	b=5jVtmt4F/3Hb+MDaOdePCTaSePdeOSgm/PLi4HDTbKsqoW5PwL6+GQiVUOwTJPlGvI7R
	 fWbR00WUfue9RbPhRVm/88t999oA4qQy+ACoKRskRLPzsj+TSxWjGinfvYRzQLX4Vrfms
	 fTHxay/5pmHEViL5E1efWVLWTHwDXwrcEn+o4nT0/uBtClEuLTZri5tH3P28Ud3IiJbss
	 VZ7tGeA1A0jqiYjxAx8d7erH+RbCWJhFFkO/2EDoRYdHodXhJCOn64Lrzc2eFh6QvJAtn
	 kjhYrmElP8BFT8OQQ1AJDfWJR4IhpKsnHAciC2hJgxhs/uQlPuEiVu8BtmBxKbw3H7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370EC606A326
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 13:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 370EC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B261421E15;
	Tue, 27 Oct 2026 13:36:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64CE013419;
	Tue, 27 Oct 2026 13:36:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wbs7OfSo4GoWVAAAD6G6ig:T6
	(envelope-from <tzimmermann@suse.de>); Tue, 27 Oct 2026 13:36:54 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5/6] fbcon: Look up glyphs using the font interface
Date: Tue, 27 Oct 2026 14:27:20 +0100
Message-ID: <20261027133646.297856-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027133646.297856-1-tzimmermann@suse.de>
References: <20261027133646.297856-1-tzimmermann@suse.de>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: B261421E15
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

Replace the open-coded glyph lookup with font_data_glyph_buf() in
implementations of putcs and cursor bitops. As rotated glyphs are
now stored as font_data_t, the regular lookup function for glyphs
works.

Also replace the open-coded size calculations with font-data helpers.

Note that with screen rotation enabled, width and height swap places
for CW and CCW implementations.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/bitblit.c   | 23 ++++++++++++++---------
 drivers/video/fbdev/core/fbcon_ccw.c | 14 ++++++++------
 drivers/video/fbdev/core/fbcon_cw.c  | 14 ++++++++------
 drivers/video/fbdev/core/fbcon_ud.c  | 23 ++++++++++++++---------
 4 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 65dbdb666ae2..b1c90bc29648 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -75,13 +75,15 @@ static void bit_clear(struct vc_data *vc, struct fb_info *info, int sy,
 
 static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				     const u16 *s, u32 attr, u32 cnt,
-				     u32 d_pitch, u32 s_pitch, u32 cellsize,
+				     u32 d_pitch, u32 s_width, u32 s_vpitch,
 				     struct fb_image *image,
 				     unsigned char *buf, u8 *dst)
 {
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	unsigned int charcnt = vc->vc_font.charcount;
 	u32 idx = vc->vc_font.width >> 3;
+	struct fbcon_par *par = info->fbcon_par;
+	u32 s_pitch = font_glyph_pitch(s_width);
 	const unsigned char *src;
 
 	while (cnt--) {
@@ -89,7 +91,7 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 
 		if (ch >= charcnt)
 			ch = 0;
-		src = vc->vc_font.data + (unsigned int)ch * cellsize;
+		src = font_data_glyph_buf(par->p->fontdata, s_width, s_vpitch, ch);
 
 		if (attr) {
 			update_attr(buf, src, attr, vc);
@@ -112,7 +114,7 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 static inline void bit_putcs_unaligned(struct vc_data *vc,
 				       struct fb_info *info, const u16 *s,
 				       u32 attr, u32 cnt, u32 d_pitch,
-				       u32 s_pitch, u32 cellsize,
+				       u32 s_width, u32 s_vpitch,
 				       struct fb_image *image,
 				       unsigned char *buf, u8 *dst)
 {
@@ -121,6 +123,8 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
 	u32 shift_low = 0, mod = vc->vc_font.width % 8;
 	u32 shift_high = 8;
 	u32 idx = vc->vc_font.width >> 3;
+	struct fbcon_par *par = info->fbcon_par;
+	u32 s_pitch = font_glyph_pitch(s_width);
 	const unsigned char *src;
 
 	while (cnt--) {
@@ -128,7 +132,7 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
 
 		if (ch >= charcnt)
 			ch = 0;
-		src = vc->vc_font.data + (unsigned int)ch * cellsize;
+		src = font_data_glyph_buf(par->p->fontdata, s_width, s_vpitch, ch);
 
 		if (attr) {
 			update_attr(buf, src, attr, vc);
@@ -153,8 +157,9 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 		      int fg, int bg)
 {
 	struct fb_image image;
-	u32 width = DIV_ROUND_UP(vc->vc_font.width, 8);
-	u32 cellsize = width * vc->vc_font.height;
+	u32 width = vc->vc_font.width;
+	u32 vpitch = vc->vc_font.height;
+	u32 cellsize = font_glyph_size(width, vpitch);
 	u32 maxcnt = info->pixmap.size/cellsize;
 	u32 scan_align = info->pixmap.scan_align - 1;
 	u32 buf_align = info->pixmap.buf_align - 1;
@@ -192,10 +197,10 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 
 		if (!mod)
 			bit_putcs_aligned(vc, info, s, attribute, cnt, pitch,
-					  width, cellsize, &image, buf, dst);
+					  width, vpitch, &image, buf, dst);
 		else
 			bit_putcs_unaligned(vc, info, s, attribute, cnt,
-					    pitch, width, cellsize, &image,
+					    pitch, width, vpitch, &image,
 					    buf, dst);
 
 		image.dx += cnt * vc->vc_font.width;
@@ -269,7 +274,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	/* Clamp to font size, same as bit_putcs_aligned() */
 	if (c >= vc->vc_font.charcount)
 		c = 0;
-	src = vc->vc_font.data + (c * cellsize);
+	src = font_data_glyph_buf(par->p->fontdata, width, vpitch, c);
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 589291caed32..9da6c0e41e7a 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -97,7 +97,7 @@ static void ccw_clear(struct vc_data *vc, struct fb_info *info, int sy,
 
 static inline void ccw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				    const u16 *s, u32 attr, u32 cnt,
-				    u32 d_pitch, u32 s_pitch, u32 cellsize,
+				    u32 d_pitch, u32 s_width, u32 s_vpitch,
 				    struct fb_image *image,
 				    unsigned char *buf, u8 *dst)
 {
@@ -107,7 +107,8 @@ static inline void ccw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 	const unsigned char *src;
 
 	while (cnt--) {
-		src = par->rotated.buf + (scr_readw(s--) & charmask) * cellsize;
+		src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch,
+					  scr_readw(s--) & charmask);
 
 		if (attr) {
 			ccw_update_attr(buf, src, attr, vc);
@@ -133,8 +134,9 @@ static void ccw_putcs(struct vc_data *vc, struct fb_info *info,
 {
 	struct fb_image image;
 	struct fbcon_par *par = info->fbcon_par;
-	u32 width = font_glyph_pitch(vc->vc_font.height);
-	u32 cellsize = width * vc->vc_font.width;
+	u32 width = vc->vc_font.height;
+	u32 vpitch = vc->vc_font.width;
+	u32 cellsize = font_glyph_size(width, vpitch);
 	u32 maxcnt = info->pixmap.size/cellsize;
 	u32 scan_align = info->pixmap.scan_align - 1;
 	u32 buf_align = info->pixmap.buf_align - 1;
@@ -176,7 +178,7 @@ static void ccw_putcs(struct vc_data *vc, struct fb_info *info,
 		dst = fb_get_buffer_offset(info, &info->pixmap, size);
 		image.data = dst;
 		ccw_putcs_aligned(vc, info, s, attribute, cnt, pitch,
-				 width, cellsize, &image, buf, dst);
+				 width, vpitch, &image, buf, dst);
 		image.dy += image.height;
 		count -= cnt;
 		s -= cnt;
@@ -243,7 +245,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = par->rotated.buf + ((c & charmask) * cellsize);
+	src = font_data_glyph_buf(par->rotated.buf, width, vpitch, c & charmask);
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index 87e9dd666953..354f40f77bb4 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -82,7 +82,7 @@ static void cw_clear(struct vc_data *vc, struct fb_info *info, int sy,
 
 static inline void cw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				    const u16 *s, u32 attr, u32 cnt,
-				    u32 d_pitch, u32 s_pitch, u32 cellsize,
+				    u32 d_pitch, u32 s_width, u32 s_vpitch,
 				    struct fb_image *image,
 				    unsigned char *buf, u8 *dst)
 {
@@ -92,7 +92,8 @@ static inline void cw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 	const unsigned char *src;
 
 	while (cnt--) {
-		src = par->rotated.buf + (scr_readw(s++) & charmask) * cellsize;
+		src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch,
+					  scr_readw(s++) & charmask);
 
 		if (attr) {
 			cw_update_attr(buf, src, attr, vc);
@@ -118,8 +119,9 @@ static void cw_putcs(struct vc_data *vc, struct fb_info *info,
 {
 	struct fb_image image;
 	struct fbcon_par *par = info->fbcon_par;
-	u32 width = font_glyph_pitch(vc->vc_font.height);
-	u32 cellsize = width * vc->vc_font.width;
+	u32 width = vc->vc_font.height;
+	u32 vpitch = vc->vc_font.width;
+	u32 cellsize = font_glyph_size(width, vpitch);
 	u32 maxcnt = info->pixmap.size/cellsize;
 	u32 scan_align = info->pixmap.scan_align - 1;
 	u32 buf_align = info->pixmap.buf_align - 1;
@@ -159,7 +161,7 @@ static void cw_putcs(struct vc_data *vc, struct fb_info *info,
 		dst = fb_get_buffer_offset(info, &info->pixmap, size);
 		image.data = dst;
 		cw_putcs_aligned(vc, info, s, attribute, cnt, pitch,
-				 width, cellsize, &image, buf, dst);
+				 width, vpitch, &image, buf, dst);
 		image.dy += image.height;
 		count -= cnt;
 		s += cnt;
@@ -226,7 +228,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = par->rotated.buf + ((c & charmask) * (cellsize));
+	src = font_data_glyph_buf(par->rotated.buf, width, vpitch, c & charmask);
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index a610af1023de..01f45eaa2013 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -83,17 +83,19 @@ static void ud_clear(struct vc_data *vc, struct fb_info *info, int sy,
 
 static inline void ud_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				    const u16 *s, u32 attr, u32 cnt,
-				    u32 d_pitch, u32 s_pitch, u32 cellsize,
+				    u32 d_pitch, u32 s_width, u32 s_vpitch,
 				    struct fb_image *image,
 				    unsigned char *buf, u8 *dst)
 {
 	struct fbcon_par *par = info->fbcon_par;
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	u32 idx = vc->vc_font.width >> 3;
+	u32 s_pitch = font_glyph_pitch(s_width);
 	const unsigned char *src;
 
 	while (cnt--) {
-		src = par->rotated.buf + (scr_readw(s--) & charmask) * cellsize;
+		src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch,
+					  scr_readw(s--) & charmask);
 
 		if (attr) {
 			ud_update_attr(buf, src, attr, vc);
@@ -116,7 +118,7 @@ static inline void ud_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 static inline void ud_putcs_unaligned(struct vc_data *vc,
 				      struct fb_info *info, const u16 *s,
 				      u32 attr, u32 cnt, u32 d_pitch,
-				      u32 s_pitch, u32 cellsize,
+				      u32 s_width, u32 s_vpitch,
 				      struct fb_image *image,
 				      unsigned char *buf, u8 *dst)
 {
@@ -125,10 +127,12 @@ static inline void ud_putcs_unaligned(struct vc_data *vc,
 	u32 shift_low = 0, mod = vc->vc_font.width % 8;
 	u32 shift_high = 8;
 	u32 idx = vc->vc_font.width >> 3;
+	u32 s_pitch = font_glyph_pitch(s_width);
 	const unsigned char *src;
 
 	while (cnt--) {
-		src = par->rotated.buf + (scr_readw(s--) & charmask) * cellsize;
+		src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch,
+					  scr_readw(s--) & charmask);
 
 		if (attr) {
 			ud_update_attr(buf, src, attr, vc);
@@ -154,8 +158,9 @@ static void ud_putcs(struct vc_data *vc, struct fb_info *info,
 {
 	struct fb_image image;
 	struct fbcon_par *par = info->fbcon_par;
-	u32 width = font_glyph_pitch(vc->vc_font.width);
-	u32 cellsize = width * vc->vc_font.height;
+	u32 width = vc->vc_font.width;
+	u32 vpitch = vc->vc_font.height;
+	u32 cellsize = font_glyph_size(width, vpitch);
 	u32 maxcnt = info->pixmap.size/cellsize;
 	u32 scan_align = info->pixmap.scan_align - 1;
 	u32 buf_align = info->pixmap.buf_align - 1;
@@ -200,10 +205,10 @@ static void ud_putcs(struct vc_data *vc, struct fb_info *info,
 
 		if (!mod)
 			ud_putcs_aligned(vc, info, s, attribute, cnt, pitch,
-					 width, cellsize, &image, buf, dst);
+					 width, vpitch, &image, buf, dst);
 		else
 			ud_putcs_unaligned(vc, info, s, attribute, cnt, pitch,
-					   width, cellsize, &image,
+					   width, vpitch, &image,
 					   buf, dst);
 
 		image.dx += image.width;
@@ -273,7 +278,7 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = par->rotated.buf + ((c & charmask) * cellsize);
+	src = font_data_glyph_buf(par->rotated.buf, width, vpitch, c & charmask);
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
-- 
2.56.0


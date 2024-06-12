Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A11C17E8E8
	for <linux-fbdev@vger.kernel.org>; Wed, 12 Jun 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200468; cv=none; b=HjuZaNamczvEOG+7dSGOIp5h540m9GtdXUpIU0JRKPoRf7s1bzTutHqDakQbSH0GY2VDOd/3LHFklkukfE8R7ilNBU45x21LN+DM7bydIg+hU4LxkZwhv9LIjFQ8VaSjyFhGhWX8SCrQQQc5/0r4puJekst1KhKx4UMA3mkMWbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200468; c=relaxed/simple;
	bh=bxaBmUQHMQJLyNBPXSw1HR9XBCjR2cyvQd4Uy9kJryI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j/gcj1vNs80AcezPaHmOtFj70FwCfUn3cneoXkDuZrttGKOl36VUs84bxq+KXbfsaSq0sUOAWddZlkAUNj1LcYdNBT4/jYM4w4Z2T04uyNNRTpXKduxjCdCN1vtP1JREstbqhccCtVRtXeGwrmdHAEh7VDQ6X1znLM4cUCVA4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:170b:1b4a:247:a009])
	by xavier.telenet-ops.be with bizsmtp
	id aduH2C0043axqkY01duH1A; Wed, 12 Jun 2024 15:54:18 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sHOPX-008eJl-SV;
	Wed, 12 Jun 2024 15:54:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sHOQb-00EdFk-0V;
	Wed, 12 Jun 2024 15:54:17 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] drm/panic: Rename logo to logo_ascii
Date: Wed, 12 Jun 2024 15:54:09 +0200
Message-Id: <d1077f6b28e4f0b6f052a084e7397000f282e7d6.1718199918.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718199918.git.geert+renesas@glider.be>
References: <cover.1718199918.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variables related to the ASCII logo, to prepare for the advent of
support for graphical logos.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/drm_panic.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 52d8a96b7dedff2c..05b406a7034bb295 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -71,7 +71,7 @@ static struct drm_panic_line panic_msg[] = {
 	PANIC_LINE("Please reboot your computer."),
 };
 
-static const struct drm_panic_line logo[] = {
+static const struct drm_panic_line logo_ascii[] = {
 	PANIC_LINE("     .--.        _"),
 	PANIC_LINE("    |o_o |      | |"),
 	PANIC_LINE("    |:_/ |      | |"),
@@ -417,7 +417,7 @@ static void draw_txt_rectangle(struct drm_scanout_buffer *sb,
 static void draw_panic_static(struct drm_scanout_buffer *sb)
 {
 	size_t msg_lines = ARRAY_SIZE(panic_msg);
-	size_t logo_lines = ARRAY_SIZE(logo);
+	size_t logo_ascii_lines = ARRAY_SIZE(logo_ascii);
 	u32 fg_color = CONFIG_DRM_PANIC_FOREGROUND_COLOR;
 	u32 bg_color = CONFIG_DRM_PANIC_BACKGROUND_COLOR;
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
@@ -430,8 +430,8 @@ static void draw_panic_static(struct drm_scanout_buffer *sb)
 	bg_color = convert_from_xrgb8888(bg_color, sb->format->format);
 
 	r_logo = DRM_RECT_INIT(0, 0,
-			       get_max_line_len(logo, logo_lines) * font->width,
-			       logo_lines * font->height);
+			       get_max_line_len(logo_ascii, logo_ascii_lines) * font->width,
+			       logo_ascii_lines * font->height);
 	r_msg = DRM_RECT_INIT(0, 0,
 			      min(get_max_line_len(panic_msg, msg_lines) * font->width, sb->width),
 			      min(msg_lines * font->height, sb->height));
@@ -445,7 +445,8 @@ static void draw_panic_static(struct drm_scanout_buffer *sb)
 
 	if ((r_msg.x1 >= drm_rect_width(&r_logo) || r_msg.y1 >= drm_rect_height(&r_logo)) &&
 	    drm_rect_width(&r_logo) <= sb->width && drm_rect_height(&r_logo) <= sb->height) {
-		draw_txt_rectangle(sb, font, logo, logo_lines, false, &r_logo, fg_color, bg_color);
+		draw_txt_rectangle(sb, font, logo_ascii, logo_ascii_lines, false, &r_logo,
+				   fg_color, bg_color);
 	}
 	draw_txt_rectangle(sb, font, panic_msg, msg_lines, true, &r_msg, fg_color, bg_color);
 }
-- 
2.34.1


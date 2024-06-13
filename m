Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AAA1534E7
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306299; cv=none; b=bhFFb+71COKV6BBhyMD0lLUqac07LcPQvPeKBjZu6zVUWmZONACzRL87Odr11L626Wc+E4ZXMYvv+n4uqTzzkC67pqhkcqj2Tj1IUFvZV9IRWs20gJpQAiAfbipzaV8cmU3YHvPlBC0usQjPfWLqwrCfxv1FEQ637dqVqbVzVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306299; c=relaxed/simple;
	bh=1gl9Qdl+e+Gxc6KhMzCUTue4x7qBw6QoLAZQjk+A1tE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R9qb8TJ69zEkmmHAj0o4S18SXjs9VNPjQdmuQwv7/lJW+p0bXrZHsNt5IoR0jEee0inUDb0qxJNupaveXX8MDUjyKFymQFBm/nymUn5bGiHbCD5UvTy9MxyM/vVDeXUsv6FMUb0qYw2nAJGcXm02IcM5XgLZGL1g7muY71oF1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:be2a:f066:50f0:dff7])
	by andre.telenet-ops.be with bizsmtp
	id b7J62C00F3w30qz017J6rL; Thu, 13 Jun 2024 21:18:08 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sHpwS-00Ax76-IT;
	Thu, 13 Jun 2024 21:18:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sHpxW-00FL8q-Id;
	Thu, 13 Jun 2024 21:18:06 +0200
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
Subject: [PATCH v2 6/7] drm/panic: Rename logo to logo_ascii
Date: Thu, 13 Jun 2024 21:18:04 +0200
Message-Id: <df77372c16153655c321a290b5a3191ee2dcbc6b.1718305355.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718305355.git.geert+renesas@glider.be>
References: <cover.1718305355.git.geert+renesas@glider.be>
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
v2:
  - Rebased.
---
 drivers/gpu/drm/drm_panic.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 5b0acf8c86e402a8..f7e22b69bb25d3be 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -78,7 +78,7 @@ static struct drm_panic_line panic_msg[] = {
 	PANIC_LINE("Please reboot your computer."),
 };
 
-static const struct drm_panic_line logo[] = {
+static const struct drm_panic_line logo_ascii[] = {
 	PANIC_LINE("     .--.        _"),
 	PANIC_LINE("    |o_o |      | |"),
 	PANIC_LINE("    |:_/ |      | |"),
@@ -447,7 +447,7 @@ static void draw_txt_rectangle(struct drm_scanout_buffer *sb,
 static void draw_panic_static_user(struct drm_scanout_buffer *sb)
 {
 	size_t msg_lines = ARRAY_SIZE(panic_msg);
-	size_t logo_lines = ARRAY_SIZE(logo);
+	size_t logo_ascii_lines = ARRAY_SIZE(logo_ascii);
 	u32 fg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR, sb->format->format);
 	u32 bg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR, sb->format->format);
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
@@ -459,8 +459,8 @@ static void draw_panic_static_user(struct drm_scanout_buffer *sb)
 	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 
 	r_logo = DRM_RECT_INIT(0, 0,
-			       get_max_line_len(logo, logo_lines) * font->width,
-			       logo_lines * font->height);
+			       get_max_line_len(logo_ascii, logo_ascii_lines) * font->width,
+			       logo_ascii_lines * font->height);
 	r_msg = DRM_RECT_INIT(0, 0,
 			      min(get_max_line_len(panic_msg, msg_lines) * font->width, sb->width),
 			      min(msg_lines * font->height, sb->height));
@@ -473,7 +473,8 @@ static void draw_panic_static_user(struct drm_scanout_buffer *sb)
 
 	if ((r_msg.x1 >= drm_rect_width(&r_logo) || r_msg.y1 >= drm_rect_height(&r_logo)) &&
 	    drm_rect_width(&r_logo) <= sb->width && drm_rect_height(&r_logo) <= sb->height) {
-		draw_txt_rectangle(sb, font, logo, logo_lines, false, &r_logo, fg_color);
+		draw_txt_rectangle(sb, font, logo_ascii, logo_ascii_lines, false, &r_logo,
+				   fg_color);
 	}
 	draw_txt_rectangle(sb, font, panic_msg, msg_lines, true, &r_msg, fg_color);
 }
-- 
2.34.1


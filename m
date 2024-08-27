Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874031BFE07;
	Tue, 27 Aug 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772364; cv=none; b=Ut56XV0XOU5zGV/eqMioD40ZO8Kn4ShutRMaHUd9xfUybAY9ViMGBNbxVlhFflGbt4v3bMe8MApD/fJcY7GGAY2WB97q6gR+5Ah05rAjkHaMjvAA3wxjnuosT7Y81e2kqIbN6SrOHkTnGS6W6xRvKvGH0Eo5cEER5EXzkiXk/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772364; c=relaxed/simple;
	bh=yU1HRW3itAcyR9oaVPrkFjRYW6YZAfrAKd8xjgvUGtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgfspnJmdmmIfadxBvB2097OoGChw21wgO78WZvnrj4cKaT9FTv6lVBC5+VZe1q/KOTbaWr5ICvNOr35ih2pQG/2b3YNb8kwnaLTerNbS0j2hOi/GdZDU2uAqAkud5ddqrobF9TMYWj768awmPjkJljQ/L2ycSo9R89YEgM98cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iUY18HRY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iUY18HRY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724772359;
	bh=yU1HRW3itAcyR9oaVPrkFjRYW6YZAfrAKd8xjgvUGtk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iUY18HRYTEem0/qjmhokwz2FVxdlGRX4smmQMntU+vzzcP5p1PhlqfanMz0zdFngm
	 GRCY/Wq6TDzcPI420yStpLPZGadcmeEjWL9DMMbUbQ02Kq2chKgYQpKEkflbnPr6vJ
	 PROZx+XDTdMjaaXH6wa5FrXUhpH7AOR5XTGKsK4Q=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 27 Aug 2024 17:25:14 +0200
Subject: [PATCH 3/5] fbdev: Introduce devm_register_framebuffer()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240827-efifb-sysfs-v1-3-c9cc3e052180@weissschuh.net>
References: <20240827-efifb-sysfs-v1-0-c9cc3e052180@weissschuh.net>
In-Reply-To: <20240827-efifb-sysfs-v1-0-c9cc3e052180@weissschuh.net>
To: Peter Jones <pjones@redhat.com>, Helge Deller <deller@gmx.de>, 
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724772358; l=2207;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yU1HRW3itAcyR9oaVPrkFjRYW6YZAfrAKd8xjgvUGtk=;
 b=bu4ONSTKd3WZjVd+jzRq5fuyqvqHuGJ/m8lrieSml0bQiOp9hlbHZIyqEkp+oq6l/xlFSO579
 jXLouV3SJFODtjYY/3KU23UVYxNlKmhAAU6Sugwp1NnEutR8EKtmroX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Introduce a device-managed variant of register_framebuffer() which
automatically unregisters the framebuffer on device destruction.
This can simplify the error handling and resource management in drivers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/video/fbdev/core/fbmem.c | 24 ++++++++++++++++++++++++
 include/linux/fb.h               |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 4c4ad0a86a50..d17a2daa2483 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -544,6 +544,30 @@ unregister_framebuffer(struct fb_info *fb_info)
 }
 EXPORT_SYMBOL(unregister_framebuffer);
 
+static void devm_unregister_framebuffer(void *data)
+{
+	struct fb_info *info = data;
+
+	unregister_framebuffer(info);
+}
+
+/**
+ *	devm_register_framebuffer - resource-managed frame buffer device registration
+ *	@dev: device the framebuffer belongs to
+ *	@fb_info: frame buffer info structure
+ *
+ *	Registers a frame buffer device @fb_info to device @dev.
+ *
+ *	Returns negative errno on error, or zero for success.
+ *
+ */
+int
+devm_register_framebuffer(struct device *dev, struct fb_info *fb_info)
+{
+	return devm_add_action_or_reset(dev, devm_unregister_framebuffer, fb_info);
+}
+EXPORT_SYMBOL(devm_register_framebuffer);
+
 /**
  *	fb_set_suspend - low level driver signals suspend
  *	@info: framebuffer affected
diff --git a/include/linux/fb.h b/include/linux/fb.h
index db7d97b10964..abf6643ebcaf 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -601,6 +601,7 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 /* fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
 extern void unregister_framebuffer(struct fb_info *fb_info);
+extern int devm_register_framebuffer(struct device *dev, struct fb_info *fb_info);
 extern char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size);
 extern void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 idx,
 				u32 height, u32 shift_high, u32 shift_low, u32 mod);

-- 
2.46.0


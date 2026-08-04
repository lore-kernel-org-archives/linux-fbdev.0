Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46865429CC6
	for <linux-fbdev@vger.kernel.org>; Tue,  4 Aug 2026 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876994; cv=none; b=d4Lmw2tztLXxPGhvWSwhNnSpnF/VYro5dssm6Toi2LVMXKSK6TIKCIz6SCjziSmAZ0QSTZJm4rdr2cCjb5n46QMxbGjsKrj/D028Z6WF8C3rBn462/kgHM32S66CgnGHhQqwJV9QA3oVOq0FDKiADV1yiTDXE31bBUanwZwq/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876994; c=relaxed/simple;
	bh=b6pkm9AbznuP6ASEvkFpmUaiFAyJ0vcaTsusVxEfRjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjzGrybK8CWGalHd3di7X8M0XbIgFNXfpd2QNfpN+es0NM8qvFWh2wGEpL0NhLCHMVPNeM5SGGuoLX0hoeMkT823XtMFRmYLQS5cBfiubsT75wSVZV7oseGCgiSg9faFsx9lBstMhW04y5ClAM1ea0aZ52BP/Y5OR1XY24wsgqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neS7QGSu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neS7QGSu"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so2046205e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Aug 2026 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785876987; x=1786481787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPWyvzGNLa7rHTsTZpFRCraZCWg00Qf6Fr76L45avBk=;
        b=neS7QGSuJmPzeON1P1UrrzYjiKjK5L1nPJPEkNjarlFcPXy5Y5UMdB3HUSliNUXaPa
         u77EN8wR5fhSadZBhWwyk5FjrQzA8+1FBfCiufAu9ooKL4/I+IC6NMnQ94UJ1/pUlYOD
         CVvgJnLpD/QKJvJcRsU+X3NwHxcfylgVxu/EcBtvS54t/s7jQxOMneGru2LY7fyGIt+V
         ejs5jKzaedHd2c6o2Rsi0NzT3/qJ7b5APAvfwtLsp1TEREh9L5kHVCDI6Be76TKnwi99
         +BC1yyqT06gSwG5P6iRbSRZgCLSTOdZgQPlN4bXkiSIQpMuhQMOoRm0fNj4whHFev4Be
         uHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876987; x=1786481787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aPWyvzGNLa7rHTsTZpFRCraZCWg00Qf6Fr76L45avBk=;
        b=qBQVbBKM+fNP5yHksuvhysC86XLvMT/XtLFqTitrtCHpdecoWRkSqmF5S82lKyy6fh
         Nblx7FAu6P0OPwKhaJvQ06OlA2yVEhEApOr7nK9cIYQ/08O3Br7WBkXCcjZHee0wQdAh
         Hr8KtVZ1LeEsvGS94MNzKpKLfA4q5OOzahZxgjYWfrZXcruM9e9d4NWAB5j4KVa6xg/2
         7+1vgnh7Td0l8XDXcd4+qqrZwvw3UvTB1t4F6CeIixGCmpigEiXr66PHIRAOT3TK3BbJ
         BNPahkGSBMyQIdY0UpqcmhwnnAomy/sHLLaTtFHQrs0CM31YPWMrzcH0QQ/uVP7JzAwj
         MKHg==
X-Forwarded-Encrypted: i=1; AHgh+RrZdDPxpp2ON57wtb6bpU37tFwDk3zKD+/MrJcN20HdLSR0Kv36Z+11eng6tnlo2l8M4+Tcb38pIjGOUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMkJxVKUa8uRfgwF4yhGDwuWtK+SKQq95q5EsqmWEk6uABFkfj
	tVei68B93lDOCd5NedSCz0xqlkJyw/S4G77PXKFb8fJ1QtQZY+tNmg6BuLXx3A==
X-Gm-Gg: AR+sD10ATz1BI6wib0X+nD7inBCC351AS24RAWTiaBbAZQHzPIlLDILKt/yeTtn7/Xz
	9Rq9uP2l8x40RNB93sUhTyGsSLXRXyhF9JazOWwKiVxPWsfdITlaiqMU3krA75YRkUyWvJths5+
	mILq4FHRyA9gX+WTpARF64qvocMFSIN1Aqdx24MklWzd8vqwnPZN+GnNZGv2KivEvDTxJ5NXszj
	+o8OzJ395xnadnUj+ndRrSfoX4HpKnDW++aTBTS0+h0yvL4LoY4i/nYs5lMm/18vPvzPY+bvaY7
	7BsCN5ubJVcGnDU7T2qxDbM246o8uF8tBt7xI9Yc8cEaegGJ8RjcTMmDqqPzVMg+4pt2ekKtaOL
	2wzgR7An3t3+7fBaMGp8EFC5LoKpYyr+YsdOkM6H/WAN6XllyPtbpvniTwEUnO5/U5cjj+15r+z
	aQsz8U1Z4+9Cue5Ng2uB3Dg0ewB0U4GQYidfCT3gX6W1ZFh2sSK5O8SkgVsA07uXY8w5354oJ+n
	g8ZZhcoBnj1ypM=
X-Received: by 2002:a05:600c:1f87:b0:495:607e:5ee7 with SMTP id 5b1f17b1804b1-4994e7d8ab9mr9728935e9.17.1785876986562;
        Tue, 04 Aug 2026 13:56:26 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.176.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4bf820sm12070645e9.0.2026.08.04.13.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:56:25 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v2 3/6] fbdev: honour the device tree boot logo placement properties
Date: Wed,  5 Aug 2026 00:56:14 +0200
Message-Id: <20260804225617.264861-4-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260804225617.264861-1-maximpedraza@gmail.com>
References: <20260804225617.264861-1-maximpedraza@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A logo supplied by the device tree describes a specific product, so where
it lands on the panel matters in a way it does not for the built-in Tux.
Honour the optional "logo-position", "logo-offset", "logo-centered" and
"logo-rotation" properties of the "linux,boot-logo-clut224" node.

The rotation is folded into the rotate argument at the entry points, so
fb_prepare_logo() reserves the right amount of space and fb_do_show_logo()
tiles in the same direction the image was rotated in.

Placement is applied after fb_rotate_logo(), since a rotation swaps the
image width and height and centring needs the final dimensions.

fb_prepare_logo() has to grow its reservation to cover wherever the logo
ends up, the way fb_center_logo already does: fbcon only leaves the first
n rows alone, so a logo placed further down is drawn and then immediately
cleared by the console.

"logo-centered" is deliberately close to the existing fb_center_logo, but
it is per device tree rather than per fbcon command line, and it composes
with "logo-offset" so that a logo can be centred and then nudged. That
combination is what panels with a partially visible area need, where the
usable region is not the centre of the mode.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 drivers/video/fbdev/core/fb_logo.c | 174 +++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/drivers/video/fbdev/core/fb_logo.c b/drivers/video/fbdev/core/fb_logo.c
index 0bab8352b..bfc1b72ce 100644
--- a/drivers/video/fbdev/core/fb_logo.c
+++ b/drivers/video/fbdev/core/fb_logo.c
@@ -2,12 +2,178 @@
 
 #include <linux/fb.h>
 #include <linux/linux_logo.h>
+#include <linux/of.h>
 
 #include "fb_internal.h"
 
 bool fb_center_logo __read_mostly;
 int fb_logo_count __read_mostly = -1;
 
+#ifdef CONFIG_LOGO_DT_CLUT224
+
+/*
+ * Placement of a logo supplied by the device tree. The image itself is parsed
+ * by drivers/video/logo/logo.c, here we only care about where it goes.
+ */
+struct fb_logo_dt_placement {
+	bool valid;
+	bool centered;
+	bool has_position;
+	int rotation;		/* FB_ROTATE_*, or -1 when unspecified */
+	u32 x, y;
+	s32 offset_x, offset_y;
+};
+
+static struct fb_logo_dt_placement fb_logo_dt;
+
+static int fb_logo_dt_parse_rotation(const char *rotation)
+{
+	if (!strcmp(rotation, "none"))
+		return FB_ROTATE_UR;
+	if (!strcmp(rotation, "cw"))
+		return FB_ROTATE_CW;
+	if (!strcmp(rotation, "ud"))
+		return FB_ROTATE_UD;
+	if (!strcmp(rotation, "ccw"))
+		return FB_ROTATE_CCW;
+
+	return -EINVAL;
+}
+
+static void fb_logo_dt_read(void)
+{
+	struct fb_logo_dt_placement *p = &fb_logo_dt;
+	static bool read_done;
+	struct device_node *np;
+	const char *rotation;
+	u32 val[2];
+	int rot;
+
+	if (read_done)
+		return;
+
+	read_done = true;
+
+	np = of_find_compatible_node(NULL, NULL, "linux,boot-logo-clut224");
+	if (!np)
+		return;
+
+	if (!of_device_is_available(np))
+		goto out;
+
+	p->valid = true;
+	p->rotation = -1;
+	p->centered = of_property_read_bool(np, "logo-centered");
+
+	if (!of_property_read_u32_array(np, "logo-position", val, 2)) {
+		p->has_position = true;
+		p->x = val[0];
+		p->y = val[1];
+	}
+
+	if (!of_property_read_u32_array(np, "logo-offset", val, 2)) {
+		p->offset_x = (s32)val[0];
+		p->offset_y = (s32)val[1];
+	}
+
+	if (!of_property_read_string(np, "logo-rotation", &rotation)) {
+		rot = fb_logo_dt_parse_rotation(rotation);
+		if (rot < 0)
+			pr_warn("fb: %pOF: unknown logo-rotation \"%s\"\n",
+				np, rotation);
+		else
+			p->rotation = rot;
+	}
+
+out:
+	of_node_put(np);
+}
+
+static int fb_logo_dt_rotation(int rotate)
+{
+	fb_logo_dt_read();
+
+	if (fb_logo_dt.valid && fb_logo_dt.rotation >= 0)
+		return fb_logo_dt.rotation;
+
+	return rotate;
+}
+
+/* Top edge of the logo, in the coordinate space the caller works in */
+static int fb_logo_dt_top(unsigned int yres, unsigned int logo_height)
+{
+	struct fb_logo_dt_placement *p = &fb_logo_dt;
+	int top;
+
+	if (p->centered)
+		top = ((int)yres - (int)logo_height) / 2;
+	else if (p->has_position)
+		top = p->y;
+	else
+		top = 0;
+
+	return max(top + p->offset_y, 0);
+}
+
+static void fb_logo_dt_place(struct fb_info *info, struct fb_image *image)
+{
+	struct fb_logo_dt_placement *p = &fb_logo_dt;
+	int dx;
+
+	fb_logo_dt_read();
+
+	if (!p->valid)
+		return;
+
+	if (p->centered)
+		dx = ((int)info->var.xres - (int)image->width) / 2;
+	else if (p->has_position)
+		dx = p->x;
+	else
+		dx = image->dx;
+
+	image->dx = max(dx + p->offset_x, 0);
+	image->dy = fb_logo_dt_top(info->var.yres, image->height);
+}
+
+/*
+ * fbcon only leaves the first @height rows of the screen alone, so a logo
+ * placed further down would be drawn and then immediately cleared. Grow the
+ * reservation to cover wherever the logo actually ends up, the same way
+ * fb_center_logo does.
+ */
+static int fb_logo_dt_reserve(unsigned int yres, unsigned int logo_height,
+			      int height)
+{
+	fb_logo_dt_read();
+
+	if (!fb_logo_dt.valid)
+		return height;
+
+	return max(height, fb_logo_dt_top(yres, logo_height) +
+			   (int)logo_height);
+}
+
+#else /* !CONFIG_LOGO_DT_CLUT224 */
+
+static inline int fb_logo_dt_rotation(int rotate)
+{
+	return rotate;
+}
+
+static inline void fb_logo_dt_place(struct fb_info *info,
+				    struct fb_image *image)
+{
+}
+
+static inline int fb_logo_dt_reserve(unsigned int yres,
+				     unsigned int logo_height, int height)
+{
+	return height;
+}
+
+#endif /* CONFIG_LOGO_DT_CLUT224 */
+
 static inline unsigned int safe_shift(unsigned int d, int n)
 {
 	return n < 0 ? d >> -n : d << n;
@@ -350,6 +516,9 @@ static int fb_show_logo_line(struct fb_info *info, int rotate,
 			fb_rotate_logo(info, logo_rotate, &image, rotate);
 	}
 
+	/* Done last, image dimensions are only final after the rotation */
+	fb_logo_dt_place(info, &image);
+
 	fb_do_show_logo(info, &image, rotate, n);
 
 	kfree(palette);
@@ -423,6 +592,8 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 
 	memset(&fb_logo, 0, sizeof(struct logo_data));
 
+	rotate = fb_logo_dt_rotation(rotate);
+
 	if (info->flags & FBINFO_MISC_TILEBLITTING ||
 	    info->fbops->owner || !fb_logo_count)
 		return 0;
@@ -483,6 +654,7 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 	height = fb_logo.logo->height;
 	if (fb_center_logo)
 		height += (yres - fb_logo.logo->height) / 2;
+	height = fb_logo_dt_reserve(yres, fb_logo.logo->height, height);
 #ifdef CONFIG_FB_LOGO_EXTRA
 	height = fb_prepare_extra_logos(info, height, yres);
 #endif
@@ -498,6 +670,8 @@ int fb_show_logo(struct fb_info *info, int rotate)
 	if (!fb_logo_count)
 		return 0;
 
+	rotate = fb_logo_dt_rotation(rotate);
+
 	count = fb_logo_count < 0 ? num_online_cpus() : fb_logo_count;
 	y = fb_show_logo_line(info, rotate, fb_logo.logo, 0, count);
 #ifdef CONFIG_FB_LOGO_EXTRA
-- 
2.39.5


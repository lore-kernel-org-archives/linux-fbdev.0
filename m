Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D321514CE
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734260029; cv=none; b=nFNpmTZai3/zPi04908yndD1h65g09qohjYNsTfTAleImYx38p7BBe3cMZd5xxHJ8bfsEGRcKGBUsbBCliQD7aiskcvlzYhxx8n3KM2trroGxKirCX5R+SnzKKHXCBbk0cEsS8epQS6iO0X5gb9qeEH9OZjYrcTSQHY3NzUM+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734260029; c=relaxed/simple;
	bh=B6rfUtml/IU5+gicbUixfbGqsfOS3EevXNf+RGshW+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nun5iDju1uCZXULHf33CU1vYPonDzCEGWRP0ryyYRmqzb4NRCRJykbKtWv1ss0zYzRWdWNjoRIy0OvgReCGfv0cZIrB6HqnMAYucU8/4sBXxVPchYZRED8boIcBzWTJpGZDKtM1fULUTGViLP3r2bUsz7gfxmL9zW1k35+eypq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4YB08d2dzLz4wwdK
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 11:45:21 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by xavier.telenet-ops.be with cmsmtp
	id oylD2D00T4qjdAp01ylDEn; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001Kjs-8e;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nmE-N9;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 14/17] Make variables that are never negative unsigned
Date: Sun, 15 Dec 2024 11:45:05 +0100
Message-Id: <20241215104508.191237-15-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241215104508.191237-1-geert@linux-m68k.org>
References: <20241215104508.191237-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 console.c       | 2 +-
 fb.c            | 2 +-
 pixmap.c        | 6 +++---
 tests/test004.c | 2 +-
 tests/test006.c | 2 +-
 tests/test007.c | 2 +-
 tests/test009.c | 2 +-
 tests/test010.c | 2 +-
 visual.c        | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/console.c b/console.c
index 0ed858e25f52c9d5..adcc78cd1d725f37 100644
--- a/console.c
+++ b/console.c
@@ -118,7 +118,7 @@ static void con_store_char(unsigned char c)
 {
     const unsigned char *src;
     unsigned char *dst;
-    int y;
+    unsigned int y;
 
     if (bitmap_width+con_font->width > bitmap_max_width)
 	con_flush();
diff --git a/fb.c b/fb.c
index ab351d15c82e09d9..4bc6d785e3e9070a 100644
--- a/fb.c
+++ b/fb.c
@@ -533,7 +533,7 @@ void fb_cleanup(void)
 
 static void fb_dump_cmap(void)
 {
-    int i;
+    unsigned int i;
 
     Debug("Colormap start = %d len = %d\n", fb_cmap.start, fb_cmap.len);
     for (i = 0; i < fb_cmap.len; i++)
diff --git a/pixmap.c b/pixmap.c
index 8cd21a62ff5235a8..a7c11909f2d5255d 100644
--- a/pixmap.c
+++ b/pixmap.c
@@ -71,7 +71,7 @@ static void image_bw_to_pixmap(const struct image *image, pixel_t *pixmap)
     pixel_t black, white;
     const unsigned char *src;
     pixel_t *dst;
-    int i, j, k;
+    unsigned int i, j, k;
 
     black = match_color(&clut_mono[0]);
     white = match_color(&clut_mono[1]);
@@ -101,7 +101,7 @@ static void image_lut256_to_pixmap(const struct image *image, pixel_t *pixmap)
     rgba_t color;
     const unsigned char *src;
     pixel_t *dst;
-    int i;
+    unsigned int i;
 
     color.a = 65535;
     if (image->type == IMAGE_GREY256) {
@@ -135,7 +135,7 @@ static void image_rgb888_to_pixmap(const struct image *image, pixel_t *pixmap)
     const unsigned char *src;
     pixel_t *dst;
     rgba_t color;
-    int i;
+    unsigned int i;
 
     src = image->data;
     dst = pixmap;
diff --git a/tests/test004.c b/tests/test004.c
index 9b1e79ef9077219d..308c1ee60899e5a9 100644
--- a/tests/test004.c
+++ b/tests/test004.c
@@ -27,7 +27,7 @@ static enum test_res test004_func(void)
 {
     const struct image *image;
     pixel_t *pixmap;
-    int x, y, width, height, i;
+    unsigned int x, y, width, height, i;
 
     image = &penguin;
     pixmap = create_pixmap(image);
diff --git a/tests/test006.c b/tests/test006.c
index 20ba90963ea10797..c3b6722fafbeaf3c 100644
--- a/tests/test006.c
+++ b/tests/test006.c
@@ -23,7 +23,7 @@
 
 static enum test_res test006_func(void)
 {
-    int i, j;
+    unsigned int i, j;
     pixel_t pixels[2];
     u32 x0, x1, y0, y1;
 
diff --git a/tests/test007.c b/tests/test007.c
index d6e7864c5b36d2bb..8fd1613c8b23cfb2 100644
--- a/tests/test007.c
+++ b/tests/test007.c
@@ -51,7 +51,7 @@ static void increase_level(int *component)
 
 static enum test_res test007_func(void)
 {
-    int i;
+    unsigned int i;
 
     fill_rect(0, 0, fb_var.xres, fb_var.yres, black_pixel);
     for (i = 0; i < red_len; i++)
diff --git a/tests/test009.c b/tests/test009.c
index 4f36950737c811df..a62724ff547c04ea 100644
--- a/tests/test009.c
+++ b/tests/test009.c
@@ -27,7 +27,7 @@ static enum test_res test009_func(void)
 {
     const struct image *image;
     pixel_t *pixmap;
-    int x, y, width, height;
+    unsigned int x, y, width, height;
 
     image = &penguin;
     pixmap = create_pixmap(image);
diff --git a/tests/test010.c b/tests/test010.c
index 6ed97e8e51bfb77e..5b26b773e873eeec 100644
--- a/tests/test010.c
+++ b/tests/test010.c
@@ -24,7 +24,7 @@
 
 static enum test_res test010_func(void)
 {
-    int i, j;
+    unsigned int i, j;
 
     con_init(&FONT);
     con_puts("Hello, world!\n");
diff --git a/visual.c b/visual.c
index e8782950df62178a..c5dbed3095d85e54 100644
--- a/visual.c
+++ b/visual.c
@@ -91,7 +91,7 @@ static u32 reverse32(u32 x)
 pixel_t *create_component_table(u32 size, u32 offset, int msb_right, u32 bpp)
 {
     pixel_t *table, pixel;
-    int i;
+    unsigned int i;
 
     if (!size)
 	return NULL;
-- 
2.34.1


Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F614D29D
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734259524; cv=none; b=sBLL/Tk1IcmEHW7FY3aAWUEB4z2aZns70jV5Bomq6TE4Ozdu6vTldKg/jvNMjNhmC335jSmLT/M/mDu4OAjEbdauKaNBZpf9B7jmQFOpps3XnSocY1e5+K/aTnOw9CoUnzdRwK7FerthP7qSVPNvYUH2C/L9GXLaB2X3KphXM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734259524; c=relaxed/simple;
	bh=FmgQ42YtLyKcr56iqUTHMUlg13/S6R2hBOvTLAu4C08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+Bk7adZiDm+9df8t+6CzjAzei82b0rQ9R5bT0lh5MtFtxnLIPYtYszg0nGLP9PqEXJlVCKNAPWzFQHStmMNJYwv0OgBRg8TzrUBa9TRPWUfaVDlYXljYe1MgkXE0M2GlNs0xBDDWIWvc/9uNyNJuR6IjFVQHr8QkwXTb+atp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by andre.telenet-ops.be with cmsmtp
	id oylD2D00P4qjdAp01ylDUM; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001Kj3-0G;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nlH-EU;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 01/17] Add support for exporting virtual test images
Date: Sun, 15 Dec 2024 11:44:52 +0100
Message-Id: <20241215104508.191237-2-geert@linux-m68k.org>
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

Add support for operating on a virtual buffer in RAM instead of on a
real frame buffer device, and exporting the result as a PPM image.
The size of the virtual buffer is configurable, but for now the format
is fixed to Truecolor 8:8:8:0.

This is useful for e.g. testing drawing algorithms on screen sizes not
supported by your hardware.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 export.c         | 176 +++++++++++++++++++++++++++++++++++++++++++++++
 fb.c             |   9 +++
 include/export.h |  14 ++++
 include/util.h   |   1 +
 main.c           |  33 ++++++---
 tests.c          |   3 +
 util.c           |   6 ++
 7 files changed, 233 insertions(+), 9 deletions(-)
 create mode 100644 export.c
 create mode 100644 include/export.h

diff --git a/export.c b/export.c
new file mode 100644
index 0000000000000000..ddf24518cadceaf3
--- /dev/null
+++ b/export.c
@@ -0,0 +1,176 @@
+
+/*
+ *  Virtual Frame Buffer Export
+ *
+ *  (C) Copyright 2024 Glider bv
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "types.h"
+#include "export.h"
+#include "fb.h"
+#include "util.h"
+
+
+static const char *export_prefix;
+static unsigned int export_xres = DEFAULT_EXPORT_XRES;
+static unsigned int export_yres = DEFAULT_EXPORT_YRES;
+
+static void export_setup(void)
+{
+    const char *param = Opt_Export;
+    char *end;
+
+    /* Prefix */
+    end = strchr(param, ',');
+    if (end)
+	    *end++ = '\0';
+
+    export_prefix = param;
+    Debug("export_prefix = %s\n", export_prefix);
+
+    /* Optional horizontal resolution */
+    param = end;
+    if (!param)
+	    return;
+
+    end = strchr(param, ',');
+    if (end)
+	    *end++ = '\0';
+
+    export_xres = atoi(param);
+    Debug("export_xres = %u\n", export_xres);
+
+    /* Optional vertical resolution */
+    param = end;
+    if (!param)
+	    return;
+
+    end = strchr(param, ',');
+    if (end)
+	    *end++ = '\0';
+
+    export_yres = atoi(param);
+    Debug("export_yres = %u\n", export_yres);
+}
+
+void export_init(void)
+{
+    export_setup();
+
+    fb_var.xres = export_xres;
+    fb_var.yres = export_yres;
+    fb_var.xres_virtual = export_xres;
+    fb_var.yres_virtual = export_yres;
+    fb_var.xoffset = 0;
+    fb_var.yoffset = 0;
+    fb_var.bits_per_pixel = 32;
+    fb_var.grayscale = 0;
+    fb_var.red.offset = 16;
+    fb_var.red.length = 8;
+    fb_var.red.msb_right = 0;
+    fb_var.green.offset = 8;
+    fb_var.green.length = 8;
+    fb_var.green.msb_right = 0;
+    fb_var.blue.offset = 0;
+    fb_var.blue.length = 8;
+    fb_var.blue.msb_right = 0;
+    fb_var.transp.offset = 0;
+    fb_var.transp.length = 0;
+    fb_var.transp.msb_right = 0;
+    fb_var.nonstd = 0;
+    fb_var.activate = 0;
+    fb_var.height = fb_var.xres / 4;
+    fb_var.width = fb_var.yres / 4;
+    fb_var.accel_flags = 0;
+    fb_var.pixclock = 0;
+    fb_var.left_margin = 0;
+    fb_var.right_margin = 0;
+    fb_var.upper_margin = 0;
+    fb_var.lower_margin = 0;
+    fb_var.hsync_len = 0;
+    fb_var.vsync_len = 0;
+    fb_var.sync = 0;
+    fb_var.vmode = FB_VMODE_NONINTERLACED;
+    fb_var.rotate = 0;
+    fb_var.colorspace = 0;
+    fb_var.reserved[0] = 0;
+    fb_var.reserved[1] = 0;
+    fb_var.reserved[2] = 0;
+    fb_var.reserved[3] = 0;
+
+    strcpy(fb_fix.id, "fbtest");
+    fb_fix.smem_start = 0;
+    fb_fix.smem_len = fb_var.xres * fb_var.yres * 4;
+    fb_fix.type = FB_TYPE_PACKED_PIXELS;
+    fb_fix.type_aux = 0;
+    fb_fix.visual = FB_VISUAL_TRUECOLOR;
+    fb_fix.xpanstep = 0;
+    fb_fix.ypanstep = 0;
+    fb_fix.ywrapstep = 0;
+    fb_fix.line_length = fb_var.xres * 4;
+    fb_fix.mmio_start = 0;
+    fb_fix.mmio_len = 0;
+    fb_fix.accel = FB_ACCEL_NONE;
+    fb_fix.capabilities = 0;
+    fb_fix.reserved[0] = 0;
+    fb_fix.reserved[1] = 0;
+
+    fb = malloc(fb_fix.smem_len);
+    if (!fb)
+	Fatal("malloc %u: %s\n", fb_fix.smem_len, strerror(errno));
+}
+
+void export_fb(const char *name)
+{
+    unsigned int x, y;
+    u32 *src, pixel;
+    char *filename;
+    u8 *line, *dst;
+    FILE *stream;
+    int res;
+
+    res = asprintf(&filename, "%s%s.ppm", export_prefix, name);
+    if (res < 0)
+	Fatal("asprintf: %s\n", strerror(errno));
+
+    line = malloc(fb_var.xres * 3);
+    if (!line)
+	Fatal("malloc %u: %s\n", fb_var.xres * 3, strerror(errno));
+
+    Debug("Exporting to %s\n", filename);
+    stream = fopen(filename, "w");
+    if (!stream)
+	Fatal("fopen %s: %s\n", filename, strerror(errno));
+
+    fputs("P6\n", stream);
+    fprintf(stream, "%u %u 255\n", fb_var.xres, fb_var.yres);
+
+    src = (u32 *)fb;
+    for (y = 0; y < fb_var.yres; y++) {
+	dst = line;
+	for (x = 0; x < fb_var.xres; x++) {
+	    pixel = *src++;
+	    *dst++ = (pixel >> fb_var.red.offset) & 0xff;
+	    *dst++ = (pixel >> fb_var.green.offset) & 0xff;
+	    *dst++ = (pixel >> fb_var.blue.offset) & 0xff;
+	}
+	res = fwrite(line, 3, fb_var.xres, stream);
+	if (res < fb_var.xres)
+	    Fatal("fwrite: %s\n", strerror(errno));
+    }
+
+    fclose(stream);
+    free(line);
+    free(filename);
+}
diff --git a/fb.c b/fb.c
index c22bdece6dfeb654..ab351d15c82e09d9 100644
--- a/fb.c
+++ b/fb.c
@@ -20,6 +20,7 @@
 #include <unistd.h>
 
 #include "types.h"
+#include "export.h"
 #include "fb.h"
 #include "util.h"
 #include "colormap.h"
@@ -429,6 +430,11 @@ static void var_fix_validate(void)
 
 void fb_init(void)
 {
+    if (Opt_Export) {
+	export_init();
+	return;
+    }
+
     Debug("fb_init()\n");
     fb_open();
     fb_get_var();
@@ -490,6 +496,9 @@ void fb_init(void)
 
 void fb_cleanup(void)
 {
+    if (Opt_Export)
+	return;
+
     Debug("fb_cleanup()\n");
     if (saved_fb)
 	fb_restore();
diff --git a/include/export.h b/include/export.h
new file mode 100644
index 0000000000000000..e3ef18b7b8e3ec14
--- /dev/null
+++ b/include/export.h
@@ -0,0 +1,14 @@
+
+/*
+ *  (C) Copyright 2024 Glider bv
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#define DEFAULT_EXPORT_XRES	640
+#define DEFAULT_EXPORT_YRES	480
+
+extern void export_init(void);
+extern void export_fb(const char *name);
diff --git a/include/util.h b/include/util.h
index 64d810448d5779e4..5a6b5ab40d383d5a 100644
--- a/include/util.h
+++ b/include/util.h
@@ -103,6 +103,7 @@ extern double benchmark(void (*func)(unsigned long n, void *data), void *data);
      *   Command line options
      */
 
+extern const char *Opt_Export;
 extern const char *Opt_Fbdev;
 extern int Opt_Debug;
 extern int Opt_List;
diff --git a/main.c b/main.c
index a13c80078543c7d1..9887fbd6936ecc1c 100644
--- a/main.c
+++ b/main.c
@@ -16,6 +16,7 @@
 
 #include "types.h"
 #include "util.h"
+#include "export.h"
 #include "fb.h"
 #include "drawops.h"
 #include "visual.h"
@@ -28,6 +29,7 @@
 const char *ProgramName;
 
 const char *Opt_Fbdev = DEFAULT_FBDEV;
+const char *Opt_Export;
 int Opt_Debug = 0;
 int Opt_List = 0;
 int Opt_Quiet = 0;
@@ -42,16 +44,21 @@ static void Usage(void) __attribute__ ((noreturn));
 
 static void Usage(void)
 {
-    printf("%s: [options] [test ...]\n\n"
+    printf("%s: [options] [<test> ...]\n\n"
 	   "Valid options are:\n"
-	   "    -h, --help       Display this usage information\n"
-	   "    -f, --fbdev dev  Specify frame buffer device (default: %s)\n"
-	   "    -d, --debug      Enable debug mode\n"
-	   "    -l, --list       List tests only, don't run them\n"
-	   "    -q, --quiet      Suppress messages\n"
-	   "    -v, --verbose    Enable verbose mode\n"
+	   "    -h, --help         Display this usage information\n"
+	   "    -e, --export <prefix>[,<xres>[,<yres>]]\n"
+	   "                       Do not use a frame buffer device, but operate on a\n"
+	   "                       virtual buffer in RAM, and export the result as a PPM\n"
+	   "                       image in <prefix><test>.ppm (default size: %ux%u)\n"
+	   "    -f, --fbdev <dev>  Specify frame buffer device (default: %s)\n"
+	   "    -d, --debug        Enable debug mode\n"
+	   "    -l, --list         List tests only, don't run them\n"
+	   "    -q, --quiet        Suppress messages\n"
+	   "    -v, --verbose      Enable verbose mode\n"
 	   "\n",
-	   ProgramName, DEFAULT_FBDEV);
+	   ProgramName, DEFAULT_EXPORT_XRES, DEFAULT_EXPORT_YRES,
+	   DEFAULT_FBDEV);
     exit(1);
 }
 
@@ -78,7 +85,15 @@ int main(int argc, char *argv[])
     while (argc > 1 && argv[1][0] == '-') {
 	if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
 	    Usage();
-	else if (!strcmp(argv[1], "-f") || !strcmp(argv[1], "--fbdev")) {
+	else if (!strcmp(argv[1], "-e") || !strcmp(argv[1], "--export")) {
+	    if (argc <= 2)
+		Usage();
+	    else {
+		Opt_Export = argv[2];
+		argv += 2;
+		argc -= 2;
+	    }
+	} else if (!strcmp(argv[1], "-f") || !strcmp(argv[1], "--fbdev")) {
 	    if (argc <= 2)
 		Usage();
 	    else {
diff --git a/tests.c b/tests.c
index 6f6f818ac4ade8b3..c92236f869f41594 100644
--- a/tests.c
+++ b/tests.c
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include "export.h"
 #include "types.h"
 #include "fb.h"
 #include "visual.h"
@@ -81,6 +82,8 @@ static void run_one_test(const struct test *test)
     switch (res) {
 	case TEST_OK:
 	    Message("%s: PASSED\n", test->name);
+	    if (Opt_Export)
+		export_fb(test->name);
 	    break;
 
 	case TEST_FAIL:
diff --git a/util.c b/util.c
index f199ace3501b0362..a946c12091f608f0 100644
--- a/util.c
+++ b/util.c
@@ -125,6 +125,9 @@ void Fatal(const char *fmt, ...)
 
 void wait_for_key(int timeout)
 {
+    if (Opt_Export)
+	    return;
+
     /* FIXME: no keypress handling yet */
     sleep(2);
 }
@@ -138,6 +141,9 @@ void wait_ms(int ms)
 {
     struct timespec req;
 
+    if (Opt_Export)
+	    return;
+
     req.tv_sec = ms/1000;
     req.tv_nsec = (ms % 1000)*1000000;
     nanosleep(&req, NULL);
-- 
2.34.1


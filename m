Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79076580391
	for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194279; cv=none; b=I6lcsYvXzYHiZdXq/FVbl2vz7yXSZ2zmRhyaNOAyIYM0e0h2x427LT22K9b5HmBNhBwrlstBJCx9sEwPgD0EMf4kfJhKJHQthdQZ75mFk3wD1Xpu3+SuOQ9mxI4n2IoDtiOWu0Y9VKxBRnMflQGzFMzAJdYCSziupzPqCFSZR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194279; c=relaxed/simple;
	bh=hcf2y0wvjX9aWK11lKMkQMcHjeBkgkPDVNiobkNIk3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XqNk+aXgfSwyuKMpwbBLFjwsxXCw7cn3vhFVY9p0rx6cS0r4R/6sh6csqQ9Ho/+FvMHt2zTvHklpUGXgDmvATVM98nhFH7TkI64djEo09thXLwQvIHMbZGaECmw4Xm2+sxXgzU45GrWId9g6ISV7rkkA82l0WMESV/eDxG2zSlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ex7OhGz7; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex7OhGz7"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874fso560588f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 13:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194261; x=1790799061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tv2gyMGASSEUQ5phQtVihq/4jYMJzkV2HdzigXP4G4U=;
        b=ex7OhGz7TJFdtHawzTd2p25tvcp5IA3W4sdFiuc+sISadTn+fkSwRNeNNNU49TWT+a
         D1sU3tx3D73UbZPLJSvWRQUv493SIuED82H8+Zd5evoUVGiVbtaWR1S0+C2V31M8fcgf
         FBMmuDNoyBjHFG+r9o54l51Bwwe2BDwCEI1H16O1k8iye6AI0SbWTNiLNWTlFgiS6E72
         4Kodz7rl6HuVseieMPJVmX3Fs/9+KfK5wYGS91lsb+m9DVB5vjvb7Khg90h797HARfNC
         D7TVp8zANUH5cz6XxGrK8Mz+j3/FBpOpJpRmSRxs7xoIMbuYeg29HJYVzcS3kx36fRYk
         bKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194261; x=1790799061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tv2gyMGASSEUQ5phQtVihq/4jYMJzkV2HdzigXP4G4U=;
        b=nO+gAvV3hT5DvTCi9r3b0WTdMj+gswOYd/cRacAsw5+2U4a81vTYivcUZW8YKaMOIT
         KH0lgHK1qRSWR7KnP7QzQaEcITfSJN2NHoHQL7WfFUibfjE/cWkhfQStgZf9ifGAPaIU
         TZyhE0ND1bZK8UAaMjJz4gC8pzeH56Y/C3kQH/Z3zj79deG5WYsH0QvoXUhcQ/jE76bo
         RmiNbUaBmjVYR+tbnlk+eC7qvCt61/stRHExZGrHQtuNTFFcfyRSvO7eI1mN8OK+9bVh
         VmNKPUzlf9Xz2yRGXRVsTK+tSqiyWP1YmcthyboQZ+kIrUcCjkLsezl26g8IznYW869Y
         p+uw==
X-Gm-Message-State: AFuF++njYNpn41OyF9av8KIb7McdqGqrJON8PMcLVinpzYXhg0Zi9FLn
	F9Ag1jhmORRNy3OCufhE2HDghTVAiWwAs8mR0r66fj7qSCeGPKqXRM5D
X-Gm-Gg: AYBFou144Gd4+HIx+HkHtb+KhRKwfJuka+MtOu7xSBYzg7nwuy96rMkpFgyNXvekrRk
	oEbeCpOxR6EqWd7oe23w4XlOvKZNmCqwtlsM19nJNNd/YyA1i6oQjL+BIkhwF7aVpobGhnA3R7W
	U6NsVLzJQj4m7MCzX/eIKBPQ9aEQqQQh6L+1M2EnpWZsgdfJqQXGsyjDOCJIzvCbHZdIwQ58axj
	mHdxbVnrh4hzuUz8LQ9TCMgrSazlcv91leDo/u2uoT4jdB5b+I/NIRd96qSjyABf1e5vd2/l0IW
	9pBhN7knRsKraZR6ARauei3Tnxk8y0nTnYGAZY6EF4s01dj3qVJWaLRE26+eA9iI7VUkUTaZpL1
	Lbf4v0pMJapX1/e+bl2MBlitQA1t2TWNgIcuMEUrudK+WU5NoOBBPdZ+dFelsXMUs0gj7pkwcMt
	lORJ5L9tCCJ4O/L+/2W+6rGzBtGJL+GymK4+8R/4NqzsAMnveTWIvC/18RkC8oyjpudZMj7e/5/
	BuJbx55cEoN1Cl9lmAHJcnFJ1XtHlzVGkI=
X-Received: by 2002:a05:600c:4e53:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-49fe66c8288mr4894915e9.4.1790194261482;
        Wed, 23 Sep 2026 13:11:01 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4c8dsm13559295e9.3.2026.09.23.13.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:11:01 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-fbdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v3 7/7] video: logo: add ppmtodtlogo host tool
Date: Wed, 23 Sep 2026 22:10:35 +0200
Message-Id: <20260923201035.51007-8-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260923201035.51007-1-maximpedraza@gmail.com>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The byte arrays a "boot-logo-clut224" node carries are not meant to
be written by hand. Add a host tool that converts a PPM image into the
node, along the lines of the existing pnmtologo: plain C, no dependencies,
and no quantization of its own -- the image must already use at most 224
distinct colours, and the tool points at ImageMagick when it does not.

Three output flavours:

  ppmtodtlogo logo.ppm                  a complete overlay
  ppmtodtlogo -t dtsi logo.ppm          a bare node, for inclusion
  ppmtodtlogo -t bin -o logo.bin ...    the blob for a reserved memory
                                        region, header included

The devicetree outputs also carry the optional placement properties,
commented out unless requested on the command line, so the generated file
documents what can be tuned without regenerating the image.

The tool is built when CONFIG_LOGO_DT_CLUT224 is enabled but is not used
by the kernel build itself.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 drivers/video/logo/Makefile      |   6 +-
 drivers/video/logo/ppmtodtlogo.c | 416 +++++++++++++++++++++++++++++++
 2 files changed, 421 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/logo/ppmtodtlogo.c

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 937b37d3b6..6dc205d24e 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -10,7 +10,11 @@ obj-$(CONFIG_SPU_BASE)			+= logo_spe_clut224.o
 
 # How to generate logo's
 
-hostprogs := pnmtologo
+hostprogs := pnmtologo ppmtodtlogo
+
+# Not used by the build itself: converts a user's image into the devicetree
+# node or memory blob the "boot-logo-clut224" binding consumes.
+always-$(CONFIG_LOGO_DT_CLUT224) += ppmtodtlogo
 
 # Create commands like "pnmtologo -t mono -n logo_linux_mono -o ..."
 quiet_cmd_logo = LOGO    $@
diff --git a/drivers/video/logo/ppmtodtlogo.c b/drivers/video/logo/ppmtodtlogo.c
new file mode 100644
index 0000000000..7fded9ce9b
--- /dev/null
+++ b/drivers/video/logo/ppmtodtlogo.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Convert a PPM image into a devicetree boot logo node, or into the binary
+ * blob the "boot-logo-clut224" binding reads from a reserved memory
+ * region.
+ *
+ * Like pnmtologo, this tool does not quantize: the image must already use
+ * at most 224 distinct colours. Reduce it first if needed, for instance:
+ *
+ *	magick logo.png -colors 224 logo.ppm
+ *
+ * The node is emitted under /chosen, where the binding expects it: a logo is
+ * configuration handed over by firmware rather than a description of the
+ * hardware.
+ *
+ * The devicetree output stores plain palette indices; the 32 entry offset
+ * the frame buffer layer reserves for the console is applied by the kernel.
+ */
+
+#include <ctype.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#define MAX_CLUT_COLORS	224
+/* Keep in step with LOGO_DT_MAX_PIXELS in drivers/video/logo/logo.c */
+#define MAX_PIXELS	(16U * 1024 * 1024)
+#define BLOB_MAGIC	0x4f474f4cU	/* "LOGO", little endian */
+#define BYTES_PER_LINE	12
+
+static const char *programname;
+static const char *filename;
+static const char *outputname;
+static FILE *out;
+
+enum output_type {
+	OUTPUT_DTS,	/* complete overlay */
+	OUTPUT_DTSI,	/* bare node, for inclusion */
+	OUTPUT_BIN,	/* blob for a reserved memory region */
+};
+
+static enum output_type output_type = OUTPUT_DTS;
+
+/* Placement options, emitted into the node */
+static int opt_centered;
+static char *opt_position;
+static char *opt_offset;
+static const char *opt_rotation;
+
+struct color {
+	unsigned char red;
+	unsigned char green;
+	unsigned char blue;
+};
+
+static unsigned int logo_width;
+static unsigned int logo_height;
+static unsigned char *logo_data;
+static struct color logo_clut[MAX_CLUT_COLORS];
+static unsigned int logo_clutsize;
+
+static void die(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	exit(1);
+}
+
+static void usage(void)
+{
+	die("Usage: %s [options] <filename>\n"
+	    "\n"
+	    "Convert a PPM image into a \"boot-logo-clut224\" node.\n"
+	    "The image must use at most %d distinct colours.\n"
+	    "\n"
+	    "    -o <output>     write to file instead of stdout\n"
+	    "    -t <type>       dts (default), dtsi or bin\n"
+	    "    -c              centre the logo (logo-position = <(-1) (-1)>)\n"
+	    "    -p <x>,<y>      logo-position, -1 on an axis centres it\n"
+	    "    -f <dx>,<dy>    logo-offset\n"
+	    "    -r <rotation>   logo-rotation: cw, ccw, ud or none\n"
+	    "    -h              this help\n",
+	    programname, MAX_CLUT_COLORS);
+}
+
+static unsigned int get_number(FILE *fp)
+{
+	int c;
+	unsigned int val;
+
+	/* Skip leading whitespace */
+	do {
+		c = fgetc(fp);
+		if (c == EOF)
+			die("%s: end of file\n", filename);
+		if (c == '#') {
+			/* Ignore comments 'till end of line */
+			do {
+				c = fgetc(fp);
+				if (c == EOF)
+					die("%s: end of file\n", filename);
+			} while (c != '\n');
+		}
+	} while (isspace(c));
+
+	if (!isdigit(c))
+		die("%s: expected a number\n", filename);
+
+	/* Parse decimal number */
+	val = 0;
+	while (isdigit(c)) {
+		val = 10 * val + c - '0';
+		c = fgetc(fp);
+		if (c == EOF)
+			break;
+	}
+	return val;
+}
+
+static unsigned char get_byte(FILE *fp)
+{
+	int c = fgetc(fp);
+
+	if (c == EOF)
+		die("%s: end of file\n", filename);
+	return c;
+}
+
+static unsigned int find_clut_entry(struct color color)
+{
+	unsigned int i;
+
+	for (i = 0; i < logo_clutsize; i++)
+		if (logo_clut[i].red == color.red &&
+		    logo_clut[i].green == color.green &&
+		    logo_clut[i].blue == color.blue)
+			return i;
+
+	if (logo_clutsize == MAX_CLUT_COLORS)
+		die("%s: more than %d colors, reduce the image first, e.g.\n"
+		    "    magick %s -colors %d out.ppm\n",
+		    filename, MAX_CLUT_COLORS, filename, MAX_CLUT_COLORS);
+
+	logo_clut[logo_clutsize] = color;
+	return logo_clutsize++;
+}
+
+static void read_image(void)
+{
+	unsigned int i, npixels, maxval;
+	int magic, raw;
+	FILE *fp;
+
+	fp = fopen(filename, "rb");
+	if (!fp)
+		die("Cannot open file %s: %s\n", filename, strerror(errno));
+
+	if (fgetc(fp) != 'P')
+		die("%s is not a PPM file\n", filename);
+
+	magic = fgetc(fp);
+	switch (magic) {
+	case '3':
+		raw = 0;
+		break;
+	case '6':
+		raw = 1;
+		break;
+	default:
+		die("%s is not a PPM file (only P3 and P6 are supported)\n",
+		    filename);
+	}
+
+	logo_width = get_number(fp);
+	logo_height = get_number(fp);
+	maxval = get_number(fp);
+	if (maxval != 255)
+		die("%s: maximum color value must be 255\n", filename);
+
+	if (!logo_width || !logo_height)
+		die("%s: zero sized image\n", filename);
+	if ((unsigned long long)logo_width * logo_height > MAX_PIXELS)
+		die("%s: image too large\n", filename);
+
+	npixels = logo_width * logo_height;
+	logo_data = malloc(npixels);
+	if (!logo_data)
+		die("%s\n", strerror(errno));
+
+	for (i = 0; i < npixels; i++) {
+		struct color color;
+
+		if (raw) {
+			color.red = get_byte(fp);
+			color.green = get_byte(fp);
+			color.blue = get_byte(fp);
+		} else {
+			color.red = get_number(fp);
+			color.green = get_number(fp);
+			color.blue = get_number(fp);
+		}
+		logo_data[i] = find_clut_entry(color);
+	}
+
+	fclose(fp);
+}
+
+static void write_bytes(const unsigned char *data, unsigned int len,
+			const char *indent)
+{
+	unsigned int i;
+
+	for (i = 0; i < len; i++) {
+		if (i % BYTES_PER_LINE == 0)
+			fprintf(out, "%s%s", i ? "\n" : "", indent);
+		else
+			fputc(' ', out);
+		fprintf(out, "0x%02x", data[i]);
+	}
+}
+
+static void write_placement(const char *indent)
+{
+	const char *pos = "0 0";
+
+	fprintf(out, "%s/* logo-position gives the top left corner; -1 on an axis\n",
+		indent);
+	fprintf(out, "%s * centres it there. logo-offset is added afterwards. */\n",
+		indent);
+
+	/* -c is a shorthand for centring on both axes; -p wins over it */
+	if (opt_position)
+		pos = opt_position;
+	else if (opt_centered)
+		pos = "(-1) (-1)";
+
+	fprintf(out, "%s%slogo-position = <%s>;\n", indent,
+		opt_position || opt_centered ? "" : "// ", pos);
+	fprintf(out, "%s%slogo-offset = <%s>;\n", indent,
+		opt_offset ? "" : "// ", opt_offset ? opt_offset : "0 0");
+	fprintf(out, "%s%slogo-rotation = \"%s\";\t/* cw, ccw, ud, none */\n",
+		indent, opt_rotation ? "" : "// ",
+		opt_rotation ? opt_rotation : "ccw");
+}
+
+static void write_node(const char *indent)
+{
+	char subindent[16];
+
+	snprintf(subindent, sizeof(subindent), "%s\t\t", indent);
+
+	fprintf(out, "%scompatible = \"boot-logo-clut224\";\n", indent);
+	fprintf(out, "\n");
+	write_placement(indent);
+	fprintf(out, "\n");
+	fprintf(out, "%swidth = <%u>;\n", indent, logo_width);
+	fprintf(out, "%sheight = <%u>;\n", indent, logo_height);
+	fprintf(out, "\n");
+	fprintf(out, "%sclut = /bits/ 8 <", indent);
+	write_bytes((const unsigned char *)logo_clut, logo_clutsize * 3,
+		    subindent);
+	fprintf(out, ">;\n");
+	fprintf(out, "\n");
+	fprintf(out, "%sdata = /bits/ 8 <", indent);
+	write_bytes(logo_data, logo_width * logo_height, subindent);
+	fprintf(out, ">;\n");
+}
+
+static void write_header_comment(void)
+{
+	fprintf(out, "/*\n");
+	fprintf(out, " * Boot logo generated by ppmtodtlogo from %s\n",
+		filename);
+	fprintf(out, " * %ux%u pixels, %u colours.\n", logo_width, logo_height,
+		logo_clutsize);
+	fprintf(out, " */\n");
+}
+
+static void write_dts(void)
+{
+	fprintf(out, "/dts-v1/;\n/plugin/;\n\n");
+	write_header_comment();
+	fprintf(out, "\n");
+	fprintf(out, "/ {\n");
+	fprintf(out, "\tfragment@101 {\n");
+	fprintf(out, "\t\ttarget-path = \"/chosen\";\n");
+	fprintf(out, "\n");
+	fprintf(out, "\t\t__overlay__ {\n");
+	fprintf(out, "\t\t\tlogo {\n");
+	write_node("\t\t\t\t");
+	fprintf(out, "\t\t\t};\n");
+	fprintf(out, "\t\t};\n");
+	fprintf(out, "\t};\n");
+	fprintf(out, "};\n");
+}
+
+static void write_dtsi(void)
+{
+	write_header_comment();
+	fprintf(out, "\n");
+	fprintf(out, "chosen {\n");
+	fprintf(out, "\tlogo {\n");
+	write_node("\t\t");
+	fprintf(out, "\t};\n");
+	fprintf(out, "};\n");
+}
+
+static void put_le32(unsigned int val)
+{
+	fputc(val & 0xff, out);
+	fputc((val >> 8) & 0xff, out);
+	fputc((val >> 16) & 0xff, out);
+	fputc((val >> 24) & 0xff, out);
+}
+
+static void write_bin(void)
+{
+	put_le32(BLOB_MAGIC);
+	put_le32(logo_width);
+	put_le32(logo_height);
+	put_le32(logo_clutsize);
+	fwrite(logo_clut, 3, logo_clutsize, out);
+	fwrite(logo_data, 1, logo_width * logo_height, out);
+}
+
+int main(int argc, char *argv[])
+{
+	int opt;
+	char *p;
+
+	programname = argv[0];
+
+	while ((opt = getopt(argc, argv, "o:t:cp:f:r:h")) != -1) {
+		switch (opt) {
+		case 'o':
+			outputname = optarg;
+			break;
+		case 't':
+			if (!strcmp(optarg, "dts"))
+				output_type = OUTPUT_DTS;
+			else if (!strcmp(optarg, "dtsi"))
+				output_type = OUTPUT_DTSI;
+			else if (!strcmp(optarg, "bin"))
+				output_type = OUTPUT_BIN;
+			else
+				usage();
+			break;
+		case 'c':
+			opt_centered = 1;
+			break;
+		case 'p':
+			opt_position = optarg;
+			break;
+		case 'f':
+			opt_offset = optarg;
+			break;
+		case 'r':
+			if (strcmp(optarg, "cw") && strcmp(optarg, "ccw") &&
+			    strcmp(optarg, "ud") && strcmp(optarg, "none"))
+				usage();
+			opt_rotation = optarg;
+			break;
+		default:
+			usage();
+		}
+	}
+	if (optind != argc - 1)
+		usage();
+	filename = argv[optind];
+
+	/* "10,20" and "10 20" are both accepted for -p and -f */
+	for (p = opt_position; p && *p; p++)
+		if (*p == ',')
+			*p = ' ';
+	for (p = opt_offset; p && *p; p++)
+		if (*p == ',')
+			*p = ' ';
+
+	read_image();
+
+	if (outputname) {
+		out = fopen(outputname,
+			    output_type == OUTPUT_BIN ? "wb" : "w");
+		if (!out)
+			die("Cannot create file %s: %s\n", outputname,
+			    strerror(errno));
+	} else {
+		out = stdout;
+	}
+
+	switch (output_type) {
+	case OUTPUT_DTS:
+		write_dts();
+		break;
+	case OUTPUT_DTSI:
+		write_dtsi();
+		break;
+	case OUTPUT_BIN:
+		write_bin();
+		break;
+	}
+
+	if (outputname)
+		fclose(out);
+
+	fprintf(stderr, "%s: %ux%u pixels, %u colours\n", filename, logo_width,
+		logo_height, logo_clutsize);
+
+	return 0;
+}
-- 
2.39.5


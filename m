Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E53428830
	for <linux-fbdev@vger.kernel.org>; Tue,  4 Aug 2026 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876999; cv=none; b=gbEPqEgcq6XwNwuUfc2HX+U5TP/1N07Av/R9HOCXtBVMaw6XAwajQUxFxJEMC2awsv3MXWJ8PpsXQulKDncz3TAux1q1FgIXih9JgrHzt3QGHmAlltacsbh1bhFPyXNuvtTC5BKA5iI9HHH4d/Oa/Pz7riT3blKtiu5E0iXSYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876999; c=relaxed/simple;
	bh=Sc3RdNoHAxHHoHapSrdLmmJERSIsY5kD1xNxOX6do8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khHbO87/gjuwjKEyShpf+kkYzJPtk7hUQwP7xAjFJqkHVc8WN+s4U7bxmRhPoWCYjcWQXwKMYfVZj3cP+IvV7DimhBFEelcLBj/yTm45J8ffnCihPDq2N5tPHdq4YNZtbgrZKfen99IA41t7xdAREMSSrVdJXxEbMw6+rrMsFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwnEmM8L; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwnEmM8L"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49800c6a846so2013665e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Aug 2026 13:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785876992; x=1786481792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0rdtrk8XXOPPUZBCUeUX/HYP4M8McVi1CQOTrbTXLV8=;
        b=WwnEmM8LJQPLjY1BDkLpyYPIs/YcLAVU1NDYe5W7nrwPBVoc4OiFF255kC+U/gx+bo
         78KAMOyslLFWh6DOu07N5J64/bQBRrDQtMrPsyBEX6/Nbg6K+0Lj/OZdAGbKsXjc6rcw
         cxXaEgS1xT9ncbjrVssBx3GLp9tEHiZCJpREiCjxBx42bpMQrwIE2zmqJg4y0GxYFRh7
         8LmPR8WU+86zVSJSdblIZXMUKpdOPdzgYaqMMS1Lnvou52vmjWEbYloNvMvNZo5MsZGV
         iOudiMAQgbVHbAwzMV2QNDcDAbgQzwdJ7a27MI1WvmQEZcm2X+QP6vUWOPs0AzGAoi+d
         Uv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876992; x=1786481792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0rdtrk8XXOPPUZBCUeUX/HYP4M8McVi1CQOTrbTXLV8=;
        b=JWTUIEdhVsGcL7l2WcboSEu+kCbaK36/irepLiVG1h+k1zf6oKZbSiT/JO7E78u2z9
         zuaHtte/1DRRLHzcLNhWtIC6XcRP2GhfGJeijTyeJxX6H57DDYceejP6/FzGbXBjv025
         QMnVlnAGrwGy8H7V75KW1mfoM4ObQDn6duNgPBwBZZEJ/8mudWTSrJ/JK8Mad6WL28Rf
         4cGHcFZh2a+XMXYxtNrqW7AtoOg0JjGb4Mf7gUTcYeK/TjsdOkxZ0te32y4LeCRZwrwx
         dKzY68wjlKgBUCJhHQskDhTgVWCQpCdIo0YWADQCc7uW1j91UbjQhFFT+HZ6+NssBoi/
         u80w==
X-Forwarded-Encrypted: i=1; AHgh+RofSL3G+oflmp9j6P62JCeK14HU8qw1//S4R9PHgVYuvMayOtw1rnAUnIOu/KJ6bjpcL3IMGWbFEr5/Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFFO7zaEnOGQsR/7GBQb1KgGDbIrOIaDOM9tq+oiHxAQqs1Xdv
	giJwAoli1IZxw/pydBhcWGLXQvAZv9Zi89s1hFWcGKSyszkjj9WUMpAL
X-Gm-Gg: AR+sD12i/QTfhEEA9kIgq/tTojn2R+IQ3qUNKOiVoKcnonFlMNIuI0pY+d+kdCT2Y0Y
	X6He3MlDySXp0gUY2NJWfdQ6mhjkjBLdf/DFoZMMUJ3cVy07WK4Uan/gVyQdwPWoLsG0Tn7ZcjB
	yUIrzes0xmDD2qUo1MF3BjMiRzmSEUPXTO1VyzgU2kvNyb7FygYPo3ApNFC0il3/j6ndJLadWqD
	FxuB3rtsaG0jG+1MHuAL85FRuT7NwQIG8kEcC/dXOeqZjEWskcPY3jp05GkFtm9zQn+/yQ2NqU5
	uN/j4abL9s5iDbpCDHQMMDGYc9jxxUo8aa+WKswAhLGoopDDWUv5CNyn4M5Fnl3XTQ/F6K7A2sP
	rX85dNVokzraM43bJx8KNrIDRM8JRGZJf2+BoA+wX0sdVbJBMnu/AmzGadTozbEQdplUF36mJxA
	SLcRbN+a9n3CWNI2UnBw1GFpzRq2hEH6aoD+S3cc/a27bks31ayiRBHhcJVtYL0sObt1hBGft+T
	tOZz0OJC4VPC9I=
X-Received: by 2002:a05:600c:8582:b0:492:3e69:a86f with SMTP id 5b1f17b1804b1-4994e79b93fmr11058805e9.1.1785876991477;
        Tue, 04 Aug 2026 13:56:31 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.176.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4bf820sm12070645e9.0.2026.08.04.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:56:31 -0700 (PDT)
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
Subject: [PATCH v2 6/6] video: logo: add ppmtodtlogo host tool
Date: Wed,  5 Aug 2026 00:56:17 +0200
Message-Id: <20260804225617.264861-7-maximpedraza@gmail.com>
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

The byte arrays a "linux,boot-logo-clut224" node carries are not meant to
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
 drivers/video/logo/ppmtodtlogo.c | 408 +++++++++++++++++++++++++++++++
 2 files changed, 413 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/logo/ppmtodtlogo.c

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 937b37d3b..49954272e 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -10,7 +10,11 @@ obj-$(CONFIG_SPU_BASE)			+= logo_spe_clut224.o
 
 # How to generate logo's
 
-hostprogs := pnmtologo
+hostprogs := pnmtologo ppmtodtlogo
+
+# Not used by the build itself: converts a user's image into the devicetree
+# node or memory blob the "linux,boot-logo-clut224" binding consumes.
+always-$(CONFIG_LOGO_DT_CLUT224) += ppmtodtlogo
 
 # Create commands like "pnmtologo -t mono -n logo_linux_mono -o ..."
 quiet_cmd_logo = LOGO    $@
diff --git a/drivers/video/logo/ppmtodtlogo.c b/drivers/video/logo/ppmtodtlogo.c
new file mode 100644
index 000000000..a52c61cec
--- /dev/null
+++ b/drivers/video/logo/ppmtodtlogo.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Convert a PPM image into a devicetree boot logo node, or into the binary
+ * blob the "linux,boot-logo-clut224" binding reads from a reserved memory
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
+#define MAX_PIXELS	(32U * 1024 * 1024)
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
+	    "Convert a PPM image into a \"linux,boot-logo-clut224\" node.\n"
+	    "The image must use at most %d distinct colours.\n"
+	    "\n"
+	    "    -o <output>     write to file instead of stdout\n"
+	    "    -t <type>       dts (default), dtsi or bin\n"
+	    "    -c              centre the logo (logo-centered)\n"
+	    "    -p <x>,<y>      logo-position\n"
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
+	fprintf(out, "%s/* Placement. logo-centered and logo-position are exclusive;\n",
+		indent);
+	fprintf(out, "%s * logo-offset is added after either of the two. */\n",
+		indent);
+
+	fprintf(out, "%s%slogo-centered;\n", indent, opt_centered ? "" : "// ");
+	fprintf(out, "%s%slogo-position = <%s>;\n", indent,
+		opt_position ? "" : "// ", opt_position ? opt_position : "0 0");
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
+	fprintf(out, "%scompatible = \"linux,boot-logo-clut224\";\n", indent);
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


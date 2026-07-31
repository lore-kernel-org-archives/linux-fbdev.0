Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2853737FF7F
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534657; cv=none; b=ZIcaY2zpbUtdZrUMwsVzZFSCZPeZk3n4aePLGNP/L8fCrO1+QfiDdQeI0VPHEVCw5hpxVutI1geJsT4qbwjBd3a0Qa+L1DogEQGkDyR08eKsknpqy1K3XOViFljdPmn2I7xSRnE75ES2E60TowTsEHbrJDnBse1QvCIM7lR66bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534657; c=relaxed/simple;
	bh=FUSb4djeAKTsB6gFNwuUzmazTZ/koeaQrRWuyzt4COo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KL+B9T7RcopTP0saTH0RVg8v99TuO5OMBjk3SqPqVJOeepDeVqo+KlBINKvYqGrYW56LVSdTVr30MKPEQy+Kj1U4enaKcJ05h6cTBBANQSDHSfv4YKTNNv3vsI4hpWBMhgRx9CXFy0ITu4YQCHYcoekpTGX+DjiEeGuBdyGOEvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBWC/f5e; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBWC/f5e"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f703a9d05so1005046f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 14:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785534653; x=1786139453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UhDpqiiaD6DYnxd51cG0Til5Fllj5+soFBiJbl5gk3M=;
        b=JBWC/f5eO0ReLaSApU6jFnCuvOodlNVctGhn2Y7Kt4RBzZog1e1ann1rww5sPsIZkl
         sUtwhsBuUtHuttago8vD5p/Cgn+aDAA+8KJtSvuTaHIz0W8+CB15VPq17wCtxH+eZHEN
         YnemIZcPCI2o33NmwGPXhj0hm5fTC2ZpWh32SlqyyL2Qn3xduXCbz9yDRsvGsSzpjL5A
         6Dvvo86+3ZxJyXDXf9NLgD+UVkDRnVSqMMOKstWdXA5+O3lrskFMHOzZv/dRLSeBfdLG
         wI5p6Q4IPlB6gOEXFemh004eIZFL1lV87MF5ONlIOytGZ2/+eGlbso4ZEp8C7RrLv5AC
         v56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534653; x=1786139453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UhDpqiiaD6DYnxd51cG0Til5Fllj5+soFBiJbl5gk3M=;
        b=kpGU74hLW+LQLshYDu9O4JN247Nwojoe8OM7UZKNrI2GF2SkriQUBRTHKFs+THQAjA
         fa56TXuviifYBv/qd+0vYc6ipOEaspFjDBBvX/cFtEQEzNOHZP0r3yWzrY2IwLV5tcqV
         94ZhRfWKiGJizJ8k9LxM/E2d8Sl3zqnZQBrQO+pMNQfokhQdH5Ci77Jm4WXOnv/x3nMN
         maMAi6HyceIQP6/SRjfsRoaDtwOr7CVxifW2CblwUbujTD4OgqLamptt88/3AwJCgD3/
         AFnFtoHFjLZoXJK8lbw2cOVJKLYB2BU3yQTzCTq5WZSjXe/EinSioUwTr8cQjWxKQaxy
         pQ7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqV+TIhOcRJgCH9BSMo5llrJHHjW/9MSYqGDURep8oyd2kbe2K2h9bFULNtm8yRwsW7sMsmnxTLdy3mnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3EVcQdgGr6xyoi7WxCo/8YkUlPafdqURDxNgAurX6ateos2K
	mJDtaKQOl/hjgJxfhzoxZqG2EysDbsOiD/R14ZC6FqSILAAlZ5pZDK0WXFlaH2rx
X-Gm-Gg: AR+sD12c2vqY+0wNH0i/9L3Ug/jsRYjaUzV1pHj8DSR4e+yZJGRD5dz1RGmXjDBciJd
	irSFmzjLtpRtKcP13sGmoNWcINN+9DmnnqtaEAMBe4HsPCwlNcpTJZT1+tduf2ApCBJT8L1VvgZ
	X8QRXqy/OkQUZ9AICmoVyl4jEBmwAA/ScOoA1YlMf3GWxrm9+IgkkSQgYQl0QjJTdarVu2APyut
	tN5NprCtxVOWJ+oPkqh1GWMnnkrjdHA3RAwI6gYR05wxZZNISodj2Jbp8J4XCMzsZtv6vsEfYpq
	coE8ot9jewn9T8EC16shXHVBOrtFWnCy0NVh01TaFYhoe6R8gSxdjrF6m+VuQXkDiKGvhdTr91E
	PTVkuG0L15WmoSG3BWaLWANrqgqnJ3kmWU43Oo8b54HsYMC1O37XOQBE5NUzmVE8BF0wgSw95RV
	VIzKbp9ObtYwfOqeuJoMkTKslhCVrukMqyAVYLqnNGT8HqfUzi8w8mkHYVNkh8hSR3C4hCB9dKj
	PwYwv9WKPf1dQ==
X-Received: by 2002:adf:f191:0:b0:47f:921f:3a2f with SMTP id ffacd0b85a97d-47fd72e1c69mr1704509f8f.25.1785534653209;
        Fri, 31 Jul 2026 14:50:53 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.62.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2484sm10186342f8f.11.2026.07.31.14.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 14:50:52 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Pedraza <maximpedraza@gmail.com>
Subject: [RFC PATCH 6/6] video: logo: add ppmtodtlogo host tool
Date: Fri, 31 Jul 2026 23:50:43 +0200
Message-Id: <20260731215043.30392-7-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260731215043.30392-1-maximpedraza@gmail.com>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
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
 drivers/video/logo/ppmtodtlogo.c | 402 +++++++++++++++++++++++++++++++
 2 files changed, 407 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/logo/ppmtodtlogo.c

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 895c60b84..e7c77bf7e 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -18,7 +18,11 @@ obj-$(CONFIG_SPU_BASE)			+= logo_spe_clut224.o
 
 # How to generate logo's
 
-hostprogs := pnmtologo
+hostprogs := pnmtologo ppmtodtlogo
+
+# Not used by the build itself: converts a user's image into the devicetree
+# node or memory blob the "linux,boot-logo-clut224" binding consumes.
+always-$(CONFIG_LOGO_DT_CLUT224) += ppmtodtlogo
 
 # Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
 quiet_cmd_logo = LOGO    $@
diff --git a/drivers/video/logo/ppmtodtlogo.c b/drivers/video/logo/ppmtodtlogo.c
new file mode 100644
index 000000000..de823131a
--- /dev/null
+++ b/drivers/video/logo/ppmtodtlogo.c
@@ -0,0 +1,402 @@
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
+	fprintf(out, "\t\ttarget-path = \"/\";\n");
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
+	fprintf(out, "logo {\n");
+	write_node("\t");
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


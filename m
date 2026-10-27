Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109235;
	b=NkdSQdSySCGq6NGi8/wnpmZNpeFOhKgDXFb5wEVJLQ4B5knZApuCnfIFnJDrmtnrn7w7
	 yN2jeYyrfZzlCH7ICUIr3TNUOCgwGBuoWLrnGquYrG1WYtli1PiLVDHF7MgLrxZA0LCVV
	 gl1OTyDofA+Zln4w0vz++v92kUAjfjacXQ8QdrLuoAthQnT+eIh5NyxqdLTfceT1J8CXF
	 SkYukaSObda9pfjoh/yqIrvfEVHyP2rb+hK8agoFPHhz2T7geCwIdPfpevhZpPluJEDKl
	 T+ZtM5K6EzqORrvMka1QB9xsNe1ojmF75//cicZOHXqMt01sMzNESVFhoXd1y83QNWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HFwDNLv3n+wl+JreLzg2KvEaj4Ho3mAm9pShsdfkSdI=;
	b=H8ykrviLQOtRXqcdKnjfk+/GLiDTH7XBuGZ6RTx2yNsVoSB6bt9c3yl7VHEWIxhfI32a
	 OF1kAzHdnvRJG9GZop/jRwTYO437qhMJhb3v74YcXGetnLn9mZkqWMle63U0jaflhhNKg
	 DacP+TLSWU5JXJmHMRO9OCRe5/sjHDU0m0vglFgd9LKM3pKGjMI3bsbDvZ8OhganU9L7p
	 dnw2qhj1SZ5Ljz8+TZRmlUNQZgzWSpK06t5l7Inb+yBHDs4CYgkQ9pb42SsmqfLxTZZOT
	 nPHl6TOvW97IgdMF+62TyQhKNhYR2nwHjOdBQVMwxqgyHS6h7v80uAXNY98cTy+yBOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Axq6+pnr;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01E2606A33E
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 13:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D01E2606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Axq6+pnr
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso2712086f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793109233; x=1793714033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HFwDNLv3n+wl+JreLzg2KvEaj4Ho3mAm9pShsdfkSdI=;
        b=Axq6+pnr1Vtgqr4v69LLt3RaAq7k1IMQ7FhaSOZzz89a6lHBeFOr77M3j91ygjKvDH
         vW1kEPOwTfJv6/v6coa3mh6BRTlsIYo4Qq7xRSyeEeUmSEO+GVswzV/hYPn+7FVDs9wV
         75jFsCMep9vJ95+PGlhl/75UmcGwA8kotHZEseurbYCEdN5S5yOonMuxsR5mS5odrdsj
         9eo039drmgS50WpZbllG3q+FX9oC8RtwhQgJmGnX/tXeOOsp7gaEs7C3uUyuNwAMbmGN
         BoDUegWv6aUwvVjscZXEFPhs3604EOOAYkN1fypwmG0rnidrhWGwFb+WpMSdhA+JE/A5
         c4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109233; x=1793714033;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HFwDNLv3n+wl+JreLzg2KvEaj4Ho3mAm9pShsdfkSdI=;
        b=enXvW8kGlE9w44l1rT7KMWzx8bEdksRm5ceDp8W9pC/MRF00TYxLF99rP5eypatr2y
         JrLqCCmL8ebAm/ZYXEBig6qSnP65fmADTiEAEQueMFmby63n85z76FCOdDrY6SjElYHd
         1aeka39vNDiIhcWqoWdqTQlE0pk/hz+3ui+OeHU3o1quuXO3ah3Fz/uanr3P6GzAgHV0
         lsOBqqyjkCr1OLGPWvE5SmP1zep3B4zlX75TdDysddYNFD0bnDSGQxqQJjf3/PZpbM2M
         0Kmo7F8VI5O1mK6l7lszPNOe/UQ26s8tSNxbC4MWwRDiQfGoHL/vuvtg03dedFK7NsWp
         jP0w==
X-Forwarded-Encrypted: i=1; AKwUvBwzTRNITM8C4VHiZLAVYAHnZwlV7U183/4mmbDhpYyoFPA5RPZ6i0n9gkPrLXUNPHBh9xiAcgBve2ECtw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKXj9LtTjg2t8TRksNJwVkCN2FOH/biSoqr5ph7TDS1wkNwh2lC
	8Ub4kh3r1ksEHX4rKuk+bKNjizkd9jkgsWQ2xzdtfoSzPafCXwMHhJ1O
X-Gm-Gg: AYBFou2/GfE6E2OhCnwOe/eBvFGLOCOka4X9nfUkoYINbqH0mukv74UUWKnPCJBAQA4
	LNQPpkZNciJdJFdfh8Gk3rM8CVY4jfAKW6tzy8j7kMihUxNZid4UXmPi9k8MDj94NLjNFvJp209
	Q3b27SYQAq9crQ+GaKK2p7tQ8Fo3eBmjMGogCkikBMBnq92bE2S6zSn7geuLOQEnl2UCVIWPGIa
	wAHv+FIKGcRLsAkyh3jQOp5dMPIveQj+ByldYkTGH359CPehavMNZZaNCHlh4sLSt+Tx0jqwwet
	rjQnc3eVReSZk15CtT9tcQ8QiLdLZpyAZfZfCtpCq6fGTXFU47LJhWGCzpJhsICM0bsHm/PDSyR
	JUq8Lz4VsQm2kIggZaMdlotyCs8Pl2N48e8pHz4gZJrsINyp9oIHOcAAkz7cNjMLxMMJfE2izkk
	+RuQ61gUH4JXHiLto50PvjKnZdhdKS4ZLuWos7pJD+DD8x0c4iRs0IzcneIDn7R4Fx3wfiKSjCJ
	tSG0dS14rNCLce309vVLPGk7waP/0XsNlho4HqCIsd/9SGPonDf8KZPNL3O/7RoLacIo77RMBpi
	EZQSvjY=
X-Received: by 2002:a5d:6f08:0:b0:48d:f034:7fcd with SMTP id ffacd0b85a97d-48e3eba1207mr20313170f8f.51.1793109232976;
        Tue, 27 Oct 2026 06:53:52 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:53:51 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Helge Deller <deller@gmx.de>,
	Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-embedded@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/15] fbdev: efifb: move the BMP headers to <video/bmp.h>
Date: Tue, 27 Oct 2026 14:53:30 +0100
Message-Id: <20261027135342.2003632-4-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261027135342.2003632-1-maximpedraza@gmail.com>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The DRM splash client parses the same BMP headers as efifb. Rather than
keep a second copy of the structures, move them to include/video/bmp.h
with the magic number.

BMP is little endian whatever the CPU, so the header gives the fields
as __le16 and __le32, and efifb now reads them with
get_unaligned_le16() and get_unaligned_le32(). Width and height are
read signed, as the format has them. No change on the little endian
systems EFI runs on.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---

Notes:
    TODO for the efifb maintainers, not changed here so that this patch
    only moves the headers: the bound check
    
    	if ((bitmap_offset + bmp_pitch * bmp_height) > bgrt_image_size)
    
    is done in u32 and can wrap with a crafted BGRT image, for instance
    with a bitmap_offset close to 4 GiB, and so can round_up(3 * bmp_width,
    4) and the product with a huge width; image_offset_x + bmp_width against
    lfb_width is a u32 sum too. efifb_copy_bmp() would then read outside the
    mapped image. The DRM splash client checks the same headers with
    check_add_overflow() and check_mul_overflow(). I can send a separate fix
    if wanted.

 drivers/video/fbdev/efifb.c | 49 ++++++++++++++-----------------------
 include/video/bmp.h         | 40 ++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 31 deletions(-)
 create mode 100644 include/video/bmp.h

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 3411be06d3e6..fd348a72f780 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -16,32 +16,13 @@
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/sysfb.h>
+#include <linux/unaligned.h>
+#include <video/bmp.h>
 #include <video/vga.h>
 #include <asm/efi.h>
 #include <drm/drm_connector.h>  /* For DRM_MODE_PANEL_ORIENTATION_* */
 #include <drm/drm_panel_quirks.h> /* For drm_get_panel_orientation_quirk */
 
-struct bmp_file_header {
-	u16 id;
-	u32 file_size;
-	u32 reserved;
-	u32 bitmap_offset;
-} __packed;
-
-struct bmp_dib_header {
-	u32 dib_header_size;
-	s32 width;
-	s32 height;
-	u16 planes;
-	u16 bpp;
-	u32 compression;
-	u32 bitmap_size;
-	u32 horz_resolution;
-	u32 vert_resolution;
-	u32 colors_used;
-	u32 colors_important;
-} __packed;
-
 static bool use_bgrt = true;
 static bool request_mem_succeeded = false;
 static u64 mem_flags = EFI_MEMORY_WC | EFI_MEMORY_UC;
@@ -145,9 +126,10 @@ static bool efifb_bgrt_sanity_check(const struct screen_info *si, u32 bmp_width)
 
 static void efifb_show_boot_graphics(struct fb_info *info, const struct screen_info *si)
 {
-	u32 bmp_width, bmp_height, bmp_pitch, dst_x, y, src_y;
+	u32 bmp_width, bmp_height, bmp_pitch, bitmap_offset, dst_x, y, src_y;
 	struct bmp_file_header *file_header;
 	struct bmp_dib_header *dib_header;
+	s32 width, height;
 	void *bgrt_image = NULL;
 	u8 *dst = info->screen_base;
 
@@ -186,20 +168,25 @@ static void efifb_show_boot_graphics(struct fb_info *info, const struct screen_i
 		goto error;
 
 	file_header = bgrt_image;
-	if (file_header->id != 0x4d42 || file_header->reserved != 0)
+	if (get_unaligned_le16(&file_header->id) != BMP_FILE_MAGIC_ID ||
+	    get_unaligned_le32(&file_header->reserved) != 0)
 		goto error;
+	bitmap_offset = get_unaligned_le32(&file_header->bitmap_offset);
 
 	dib_header = bgrt_image + sizeof(*file_header);
-	if (dib_header->dib_header_size != 40 || dib_header->width < 0 ||
-	    dib_header->planes != 1 || dib_header->bpp != 24 ||
-	    dib_header->compression != 0)
+	width = get_unaligned_le32(&dib_header->width);
+	height = get_unaligned_le32(&dib_header->height);
+	if (get_unaligned_le32(&dib_header->dib_header_size) != 40 ||
+	    width < 0 || get_unaligned_le16(&dib_header->planes) != 1 ||
+	    get_unaligned_le16(&dib_header->bpp) != 24 ||
+	    get_unaligned_le32(&dib_header->compression) != 0)
 		goto error;
 
-	bmp_width = dib_header->width;
-	bmp_height = abs(dib_header->height);
+	bmp_width = width;
+	bmp_height = abs(height);
 	bmp_pitch = round_up(3 * bmp_width, 4);
 
-	if ((file_header->bitmap_offset + bmp_pitch * bmp_height) >
+	if ((bitmap_offset + bmp_pitch * bmp_height) >
 				bgrt_image_size)
 		goto error;
 
@@ -222,12 +209,12 @@ static void efifb_show_boot_graphics(struct fb_info *info, const struct screen_i
 
 		src_y = y - bgrt_tab.image_offset_y;
 		/* Positive header height means upside down row order */
-		if (dib_header->height > 0)
+		if (height > 0)
 			src_y = (bmp_height - 1) - src_y;
 
 		memset(dst, 0, bgrt_tab.image_offset_x * 4);
 		dst_x = bgrt_tab.image_offset_x;
-		efifb_copy_bmp(bgrt_image + file_header->bitmap_offset +
+		efifb_copy_bmp(bgrt_image + bitmap_offset +
 					    src_y * bmp_pitch,
 			       (u32 *)dst + dst_x, bmp_width, si);
 		dst_x += bmp_width;
diff --git a/include/video/bmp.h b/include/video/bmp.h
new file mode 100644
index 000000000000..8aa249f2302f
--- /dev/null
+++ b/include/video/bmp.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _VIDEO_BMP_H
+#define _VIDEO_BMP_H
+
+#include <linux/types.h>
+
+/* "BM", the first two bytes of a BMP file */
+#define BMP_FILE_MAGIC_ID 0x4d42
+
+/*
+ * The headers at the start of a BMP file. Every field is little endian,
+ * whatever the CPU, and the headers need not be aligned in memory: read them
+ * with get_unaligned_le16() and get_unaligned_le32().
+ */
+struct bmp_file_header {
+	__le16 id;
+	__le32 file_size;
+	__le32 reserved;
+	__le32 bitmap_offset;
+} __packed;
+
+/*
+ * BITMAPINFOHEADER. Width and height are signed: a negative width means
+ * nothing, and a negative height that the rows go top to bottom.
+ */
+struct bmp_dib_header {
+	__le32 dib_header_size;
+	__le32 width;
+	__le32 height;
+	__le16 planes;
+	__le16 bpp;
+	__le32 compression;
+	__le32 bitmap_size;
+	__le32 horz_resolution;
+	__le32 vert_resolution;
+	__le32 colors_used;
+	__le32 colors_important;
+} __packed;
+
+#endif /* _VIDEO_BMP_H */
-- 
2.39.5


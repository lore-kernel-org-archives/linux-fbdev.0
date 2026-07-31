Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70C436197F
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534656; cv=none; b=CbmfSaTH6XKChYqE8fLbNCrmNWqZAYFRi8EqyFjtc2YtYjEdluFmxjRQwLyf83mbDpNvyYK60WuVJiRoMds4Ue7wgzKB6+QyERxNQ0Wh8w6AeSGb/jJcoq83A6VdltWQOpoozvC645cNRilvoK5xwbW1OU0PGPeB3CZ6efRP9aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534656; c=relaxed/simple;
	bh=4elGExiqb/CWf4gkl+dBDCh6SXY0uWu2hMm5yoGfMlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nhB/40yQk470GThSdQzgSMSwOyQKVZEOi5rUVYLFOxdMpkGwGY9B+7OHxbhmf+cPNiwcBqe2voyKBaRVwUrF+dwsMPCZp050snxq4FJHdtVHQG9IfuWqRGFBYxArknVZOKwI6eClhk3Z5MxK8jP0uwrDgnP+NKVIxAy65ng7JYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4UGDSRH; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4UGDSRH"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f64ca1c2dso532290f8f.2
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785534652; x=1786139452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mmFMZ3fYEoGkcqSYuP3/MajdLDfVjK6tOo68kSisc3k=;
        b=g4UGDSRHCHXGXr3FxXh+3ft4jySONAdMVxxOgUFgcGMDNF6XuFbjBfPQGyhJ8YH7ZM
         sHNdW6tKs0a/svL0ujUAQLkFSUV8qz/cJHOaANxfrX41NUhd4hhs5v6tjEvTUTSa3bM8
         R0lyLTyhcA/i581RuxPk1cd66XUeFkJbw0uq7vvp6IrZp6MNM7T6YpJbw/73UBzR4Efb
         VhUm8XVaA0C/arTPZARe4r+qodXVr/uz75RSkDfDWoDWe6T2HlnCtav3Mn03C3bq9bpI
         +fHyf+FZjhwrWhfM8oro2bNA1Vv0U2KYRn0LPPOnqQCkRZn6wc7UD77ucOiexl9r/0it
         gQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534652; x=1786139452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mmFMZ3fYEoGkcqSYuP3/MajdLDfVjK6tOo68kSisc3k=;
        b=An0jds5+ciUOwLr1LwWvjWtGCpZ5ZPUa6AH2+QUDFvNDDjl8Wqf1b117XVKq93tit0
         d65MuMQI1UxWlhAOFdW2ZaK20mgQ5stTr7kA+CxGyykv74exRaXEq1uDph4sz/SmRv5Q
         XaqUE1xgtcKKUNlg5og43QqUUfTvbzhZMQPO3Yp0nWa9DMBjtA/Q+/OeRgiQiarLb7Oh
         ZIApyHanxOdPsirL6NaEL0SoUiny2JAgTAbDg33yjDg2jrDhjXgR9ltDkhENkRC7udTY
         RWDQeZgDZbmAEf4x8uLqHwMYa8eHjdPAaUR1tCVjgFehdfZp1NzqsrPvsSItYfH1f5cU
         gbsw==
X-Forwarded-Encrypted: i=1; AHgh+RpJmJiCFL+16OAlxHtfGPfDdsGSNiEgMuJx7Yljtrtixrg/XV0wK/XpdlYNx/EKn1T5g7ng2rsHiC4Myg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfaDOdcA/EhTGUGcfkNzZGiwuyDTO1ksN/LPIO8eYmUEz8OoJL
	q93NIW9T/RpPh9D0BbUbHpknjCTV0xzMPIrZrzoeKRzNzPf2zWSHCMZ5
X-Gm-Gg: AR+sD11K7VqSyhP6QrtNWTW2lNCYZ9/9UF01T4aZmDyzyckceNQfQ1GWRy2wgGNFNJx
	Cj9DiPD4vJNaNGw/euA+lN/1DO3z8zFdpTPJL2+JJ9ZS4H7DVI4TF1mtF/C0xdrSISZqS0GOIkG
	AhkPlP9W/aQ0/b+utfMhtpJ2IIG4Xt1OqiVxqKBaAuONnapZICVXoAx54GS4/xl5SEnO4A+5jCy
	TZjgfXknKO/V8T4qTi2mb6vgR9tjE6Hiy5J2iGVurUlYB7DkNFSvD1sB4nuwIcQTfTmF6aaPbkf
	Ejjy9O3k7eC4x9vbbPcqrOuDUrllIj+WPOTblnmefsR6wnCZI0HrvcnD44TO1EpvEksRNMlxBYm
	/RLbb470/FIri3mcCSTnal5+4uqk9RJHWS/R8w1yfllBUV5QQYcl69Fr2cQS/jmypPV4kQVEdtQ
	nL7vK55IX4r6i/pR4qfqz/ZOziK7dnruSAO5webH2Fu928CPgXxsn6BLkRQmZkkK0k2j15Cm7IC
	OgDVMG7x7Z97A==
X-Received: by 2002:a5d:68cb:0:b0:47f:d01b:a691 with SMTP id ffacd0b85a97d-47fd72c6d17mr2157623f8f.14.1785534651962;
        Fri, 31 Jul 2026 14:50:51 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.62.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2484sm10186342f8f.11.2026.07.31.14.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 14:50:51 -0700 (PDT)
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
Subject: [RFC PATCH 5/6] video: logo: allow the boot logo to come from a reserved memory region
Date: Fri, 31 Jul 2026 23:50:42 +0200
Message-Id: <20260731215043.30392-6-maximpedraza@gmail.com>
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

Take the image from the region a "memory-region" phandle points at, when
the node has one, instead of from the width, height, clut and data
properties.

Only a declared region is accepted, never a bare physical address. That
matters for more than tidiness: the region is reserved before the allocator
starts, so the logo code can never be pointed at memory the kernel is using
for something else, and a size is known, so every field can be bounds
checked. The region is mapped with memremap(), which copes with a no-map
reservation and fails cleanly instead of handing back a bogus pointer the
way phys_to_virt() on an arbitrary address would.

The image is validated and copied out rather than used in place: the magic
number has to match, the geometry has to be sane, the palette and pixels
have to fit inside the reserved region, and every pixel has to reference an
existing palette entry. Anything else is reported and ignored, falling back
to the built-in logo. Copying also means nothing that happens to the region
afterwards can affect what has already been validated, and it keeps the
pixel data in the same shape both paths produce.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 drivers/video/logo/logo.c | 171 ++++++++++++++++++++++++++++++--------
 1 file changed, 135 insertions(+), 36 deletions(-)

diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index b4f533df0..95d75b905 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -10,8 +10,10 @@
  *  Copyright (C) 2003 Geert Uytterhoeven <geert@linux-m68k.org>
  */
 
+#include <linux/io.h>
 #include <linux/linux_logo.h>
 #include <linux/of.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
@@ -38,6 +40,15 @@ MODULE_PARM_DESC(nologo, "Disables startup logo");
 #define LOGO_DT_CLUT_OFFSET	32
 /* Sanity limit on the image size, a device tree is not a good place for more */
 #define LOGO_DT_MAX_PIXELS	SZ_32M
+/* "LOGO", little endian, at the start of a handed over memory region */
+#define LOGO_DT_MAGIC		0x4f474f4c
+
+struct logo_dt_header {
+	__le32 magic;
+	__le32 width;
+	__le32 height;
+	__le32 clutsize;
+};
 
 static struct linux_logo logo_dt_clut224 = {
 	.type		= LINUX_LOGO_CLUT224,
@@ -46,58 +57,41 @@ static struct linux_logo logo_dt_clut224 = {
 static unsigned char *logo_dt_clut;
 static unsigned char *logo_dt_data;
 
-static int logo_dt_parse(struct device_node *np)
+/* Reject geometries that cannot describe a sane image before using them */
+static int logo_dt_check_geometry(u32 width, u32 height, u32 clutsize)
 {
-	unsigned int clutsize, npixels, i;
-	unsigned char *clut, *data;
-	u32 width, height;
-	int len, ret;
-
-	ret = of_property_read_u32(np, "width", &width);
-	if (ret)
-		return ret;
-
-	ret = of_property_read_u32(np, "height", &height);
-	if (ret)
-		return ret;
-
 	if (!width || !height || (u64)width * height > LOGO_DT_MAX_PIXELS)
 		return -EINVAL;
 
-	npixels = width * height;
-
-	len = of_property_count_u8_elems(np, "clut");
-	if (len < 3 || len % 3)
+	if (!clutsize || clutsize > LOGO_DT_MAX_CLUT)
 		return -EINVAL;
 
-	clutsize = len / 3;
-	if (clutsize > LOGO_DT_MAX_CLUT)
-		return -EINVAL;
+	return 0;
+}
 
-	ret = of_property_count_u8_elems(np, "data");
-	if (ret < 0)
-		return ret;
-	if ((unsigned int)ret != npixels)
-		return -EINVAL;
+/*
+ * Take a private copy of an image that has already been range checked, so
+ * that nothing else can change it under us, and shift the pixels into the
+ * palette slots the frame buffer layer leaves to the logo.
+ */
+static int logo_dt_store(u32 width, u32 height, u32 clutsize,
+			 const u8 *clut_src, const u8 *data_src)
+{
+	unsigned int npixels = width * height;
+	unsigned char *clut, *data;
+	unsigned int i;
+	int ret;
 
-	clut = kmalloc(len, GFP_KERNEL);
+	clut = kmemdup(clut_src, clutsize * 3, GFP_KERNEL);
 	if (!clut)
 		return -ENOMEM;
 
-	data = kmalloc(npixels, GFP_KERNEL);
+	data = kmemdup(data_src, npixels, GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
 		goto err_free_clut;
 	}
 
-	ret = of_property_read_u8_array(np, "clut", clut, len);
-	if (ret)
-		goto err_free_data;
-
-	ret = of_property_read_u8_array(np, "data", data, npixels);
-	if (ret)
-		goto err_free_data;
-
 	for (i = 0; i < npixels; i++) {
 		if (data[i] >= clutsize) {
 			ret = -ERANGE;
@@ -124,6 +118,111 @@ static int logo_dt_parse(struct device_node *np)
 	return ret;
 }
 
+static int logo_dt_parse_properties(struct device_node *np)
+{
+	const u8 *clut, *data;
+	u32 width, height;
+	int len, ret;
+
+	ret = of_property_read_u32(np, "width", &width);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(np, "height", &height);
+	if (ret)
+		return ret;
+
+	len = of_property_count_u8_elems(np, "clut");
+	if (len < 3 || len % 3)
+		return -EINVAL;
+
+	ret = logo_dt_check_geometry(width, height, len / 3);
+	if (ret)
+		return ret;
+
+	if (of_property_count_u8_elems(np, "data") != width * height)
+		return -EINVAL;
+
+	clut = of_get_property(np, "clut", NULL);
+	data = of_get_property(np, "data", NULL);
+	if (!clut || !data)
+		return -EINVAL;
+
+	return logo_dt_store(width, height, len / 3, clut, data);
+}
+
+/*
+ * Image handed over by the bootloader in a reserved memory region. Only a
+ * region the device tree declared is accepted, never a bare address, so the
+ * kernel can never be pointed at memory it is using for something else, and
+ * so that a size is known and every access can be bounds checked.
+ */
+static int logo_dt_parse_memory_region(struct device_node *np)
+{
+	u32 width, height, clutsize;
+	const struct logo_dt_header *hdr;
+	struct device_node *mem_np;
+	struct reserved_mem *rmem;
+	size_t clutlen, datalen;
+	const u8 *payload;
+	void *mem;
+	int ret;
+
+	mem_np = of_parse_phandle(np, "memory-region", 0);
+	if (!mem_np)
+		return -ENOENT;
+
+	rmem = of_reserved_mem_lookup(mem_np);
+	of_node_put(mem_np);
+	if (!rmem)
+		return -EINVAL;
+
+	if (rmem->size < sizeof(*hdr))
+		return -EINVAL;
+
+	mem = memremap(rmem->base, rmem->size, MEMREMAP_WB);
+	if (!mem)
+		return -ENOMEM;
+
+	hdr = mem;
+	if (le32_to_cpu(hdr->magic) != LOGO_DT_MAGIC) {
+		ret = -EINVAL;
+		goto out_unmap;
+	}
+
+	width = le32_to_cpu(hdr->width);
+	height = le32_to_cpu(hdr->height);
+	clutsize = le32_to_cpu(hdr->clutsize);
+
+	ret = logo_dt_check_geometry(width, height, clutsize);
+	if (ret)
+		goto out_unmap;
+
+	clutlen = (size_t)clutsize * 3;
+	datalen = (size_t)width * height;
+
+	/* Everything the header promises has to fit inside the region */
+	if (sizeof(*hdr) + clutlen + datalen > rmem->size) {
+		ret = -EINVAL;
+		goto out_unmap;
+	}
+
+	payload = (const u8 *)(hdr + 1);
+	ret = logo_dt_store(width, height, clutsize, payload, payload + clutlen);
+
+out_unmap:
+	memunmap(mem);
+	return ret;
+}
+
+static int logo_dt_parse(struct device_node *np)
+{
+	if (of_property_present(np, "memory-region"))
+		return logo_dt_parse_memory_region(np);
+
+	return logo_dt_parse_properties(np);
+}
+
 static const struct linux_logo *logo_dt_find(void)
 {
 	static bool probed;
-- 
2.39.5


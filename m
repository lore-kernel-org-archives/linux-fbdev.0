Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15D3410D19
	for <linux-fbdev@vger.kernel.org>; Tue,  4 Aug 2026 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876997; cv=none; b=bo/yf9sQ+znf6n7dYj34w1M4PePu9uIcFDq/0/ZDSxP3Uc0rIYxcnXvGyaCzENDy0PdLNwNc+01E24BxRA/imzGjsOdda8EWMvaq2GPqiNe8WqSPC4F4kxCyo0erpOMQDJkrwKPfiDRVPDErxHQBq9wZ7A9E+7oTJGQac3/unJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876997; c=relaxed/simple;
	bh=xGIABBsXaUoJaXPxJBCwzJ6/LRKxGWYYgzXd5in9Gl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qPoWm/cQW/fjymvTmo5u4ru6guT4ieVVw7VHuV1BXZFZ7RzlzdUIzaGdAP7/sO2gxjL2tcd21HjMUbTC3JtwrdwHmZVuenKfvf9SfqqnIb4MiiZaoub/HuHQzzSfWeF87uLGVDsNwIi09MJG3mYGl8X0+06XBr2nlaTYh9vlESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dp8jQCK1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dp8jQCK1"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49553515a8bso3166455e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Aug 2026 13:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785876990; x=1786481790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ei4wu5HfRa2wxht5dmisRmUFZUNWVNZz+Xwp09rdeeM=;
        b=dp8jQCK1YaYirOoxHAGZTLCnTeS/buaok+RRZGMULE+p2axPEaXayjhtGmZ1HRvfP3
         xB9af6sTkYd3wLR5tJdglDlWNy52hCKbp6tS0bHFlaxkjsTii+gy+vOfmSm2Ek0fugrX
         dg3bkh14ei6NS23THNwPOrjYTTuMssJDU5tCKvwC8F5U3JpF/WaDiz5Cq5iegfbjWDbm
         bgjIJTIchdeuk7vaz6Kvt4Lsaiqg0+ihz5AItnYj7iYrnxE+Nx915+14ZPhfl/vrOBmj
         YblI4XAPSHhDImTR669JSs5pd3kn7AY/mmd3KBerdeCTrQt4TdXGdHIxvUdhQpDPw2zb
         +B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876990; x=1786481790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ei4wu5HfRa2wxht5dmisRmUFZUNWVNZz+Xwp09rdeeM=;
        b=kfBgo9Xk3y5PWXrT6vxO72hdO1DhCESUbivAypC78Y+4lN11GZI4OELR2XF2ExcMXt
         xMA4ypPWubUF+fabJ0qAzrQx8bP5ltSoKRAvHR8YxZaDrazkgFv8pooH/+rLvQqWFeSm
         dRSgOdb4+z3APIrQiaFzdJ12z6UnxsdNJIFgN7IoDxtcEofNDqe1Glu/yUqL2F3PkwGl
         Mmn/UKyr4M2Of/Zi5+y9zYujgEql6Nxwo7u2eiLRsaoETSCQ9ejddpAw4cytrTMW5aGG
         zlbnmNNIDZDUmQJXVa9XXRsYAoXMi4Dwdj6pjCbBloThcCuGQrLKUG0BUyaKhYhwBenW
         HK+A==
X-Forwarded-Encrypted: i=1; AHgh+Rr7mBDQ+6x8qgZxZsjLvXTY0YHuU+Ju2Vf0Jsz6iMath5e+c90f1YDFQcfx8QDMR17AZCshdmJW6InO7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHByvrizMF8qGcCp0gkkiLfxB/mNKc+lN+NsG2g0FYH0OZwMYC
	KdtcWKxss0MSFLSGtYvGvkOe2rp8ynm18coOO3ulRHoKc7ZWHZtQ5Cmd
X-Gm-Gg: AR+sD12Fidd76FIyG7cUc7W5GX3zJMlzca73k6UVi9yz8qCUBe9CcvJaR5qpVM3yCb+
	u3nqFZM3NSsYF4fXFCx79ik0y2pQPNt9Df0qzOweSQYDdabCwmuGR1bIKfYIgOBD01lK/W4q8pH
	WpwN1R3RAOnmPAnHhQJDY9U3BEaM+nHwS+vYzewrqiEyrPzlFO4YjEQooAxX+xuzdUEcsUK1FYe
	pxQGKhzScW19TRv1Ev1Cf9i75HJHf8Ld+HCKjZGlNmuFlkbXG3OgcXiBx6qVgx0KJi7KxYGGDFs
	tjlT+z1hfd5W8oz8XCsmcc5dTq6ixwFq2HtALKZWpvEnU1jUmpK/kqitaxrxsKMnRi0ZUhl3ESN
	B7h+1cdUFB3wnFRZfOtZ6h9HO/CsrGMzlLLl4/G8HFqi9KSwyZpkVkmzjqa5cR30OOSXV1+WRgJ
	GMUan7O8wKUxBBYVWVsASBeqx8HwYRv1o9inUNjRoupiJxgSeYFksXDZ10+5m2XlpPu2BVba6nQ
	pMlqFPPrZK8nB4=
X-Received: by 2002:a05:600c:1c22:b0:495:734e:4825 with SMTP id 5b1f17b1804b1-4994e7dcf28mr10141705e9.16.1785876989801;
        Tue, 04 Aug 2026 13:56:29 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.176.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4bf820sm12070645e9.0.2026.08.04.13.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:56:29 -0700 (PDT)
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
Subject: [PATCH v2 5/6] video: logo: allow the boot logo to come from a reserved memory region
Date: Wed,  5 Aug 2026 00:56:16 +0200
Message-Id: <20260804225617.264861-6-maximpedraza@gmail.com>
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
index 7f8b04ecf..66bcb37e7 100644
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


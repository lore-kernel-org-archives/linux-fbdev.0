Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60A580393
	for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194276; cv=none; b=JvZhdJ0pUrU/bNefWhy0NNaT/JnLgdj9WzCkQbtUnJBhXyDAVKTFlP66DlPzkX6q4UPwQ9sjOFRGjWkKjs5ppjjRaQ+0qB7zIAhSqKGXBvtlpZ9OgY9ga7wKfB3G6TXs81hwOEIZaA5uOZUizshsf85hdOHNE6cg6X6vSYQlbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194276; c=relaxed/simple;
	bh=mFQyvIj6reChEL67BBSeB3Wkx8Rn724plptNKQo7mR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nxg5ujG9D5Rf48y4i9vr51CWljIpx/wp50JaT/6HuGwFMMxJSmbiHX57P5fC8FJ5cvXcanBuMmiYEHaw2DflxLqqXkPfa8V6dlaf+xjwXRshRrofx07G3MyekiCrTj2MSzFVxD6bhAmo+UOkNll2gOPfeh4hIhlazR2mRGj5X3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kegrsdY2; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kegrsdY2"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccff31419so11458605e9.3
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 13:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194260; x=1790799060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i2OOLJKEASfUrtwVJ4InIXktjShhe/Ob36b0n3ix6zY=;
        b=kegrsdY29H3k5aBzxWO5TR8bqhrk0Ehn5vBhXEH3OFigqwq4fKZuPpBC+J5nrVrjXd
         WhOBriRfHAVO12QYu00mqbIyFT16BJzBOEF0zd9fEiyKcjmoBpVZJOMWCsYFE/r+RDoD
         7NLIKXRnBNN/Btp3CDSYDh3zrbMJaihfD0OXXwiFJZzLx8dNbnHMlYpsJ7ElBvw2Q7mC
         S7WLKLqHHawbb+DuyeVgaDGlc8vLU77ffI/T4VID1A9BrE4UDKv8FuG20lLyO2oUyJc/
         Zbyuqy2zXgQBH28JEVGy/OjlA+W45LcTLjQMDSsD1F1sOEKMcC9+E3sA9LBD74w2Nahl
         ddMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194260; x=1790799060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i2OOLJKEASfUrtwVJ4InIXktjShhe/Ob36b0n3ix6zY=;
        b=vgEm4hufGhhDWft5ZqDZeWnmmzokjrUDVmCpGce6fHI7cdS7pgY688iSKRdG8DojKY
         1DM/6Z0FYiS81RUNb0wBXEKLrN9kCdaEMncjqTlVPQ7F0/eE3N2NlPS63/bbW77UXfTA
         qY7SSs3NmnTRJJ5JoLc6aWI1weeiOagTUR/Q7LAAnZo/I4S58BofQiknStMBydQKsUxw
         YOEL948CHPAHJINqtRvQl0x8F8LtlDZMgjdDKoA/1QBwNQ04g23mTohGCYVefOH2v9wy
         z7iyhrVMDiwD28tv3PgOusz8aYt5tgyLg3QdeleLH73NtVOjOWnmry3d1rpB93TVLgEd
         4NrQ==
X-Gm-Message-State: AFuF++nKkm7kVLvjB/cuuq4aEJ87KS0JJkU8lcgHM9u+gdmZutbHSoQZ
	5cStoLd8XP2gIYY2S8qjaKfEYZOfdRTo7Dc3P18QUWkSiEBJuKSZLx2BmwjrOg==
X-Gm-Gg: AYBFou0fwGpFysyc3odALDUwaQ/hExgGSESgd7hNvKuJSnO4hTgmcizsGg6T9CVxRWc
	uCyRBcwDIH+3neZGqCIcyx+bZUGF1jXDpqrDG41tCi/ko9vih+CrOUhVnyPFBf6JS8IsK19R9nP
	PBRrVpoB5UvQeVHqzIV1AD9ghjZc9VNWkAAttDUasl72+iy+xVxf7sCGuyQ5XqNbp61P66JUy58
	DclB7vhzIMgumLXpQpLFHU5Muimz/Ps8cx6L4pJvb/lxVtjT+aJYRYFn4qovPmesPTLs10/N7FT
	Gr7X62XA4+S2ga+oLwUrvrVfbTg15ko5Axnu7y+gcvOuOiFP+9fRx52UrfdLdTgX9PcEo5Q3H3R
	NgllkB7GfOgCEuKvi/7m7YwoaqwslDAVNDKFrCldN2xCjRBmofdnQJNEKcFt7hU3kqtLO3GKL11
	IyMYODr1xa3J3vlj7MLo2FtEnVpuud8dxyxJcSK/hw9qoNVWvSHCMvOZ633VpsWCcyfghyT5qL9
	gYliRxBsPPrAjxr8fZGv8DtihEC1bdU/ws=
X-Received: by 2002:a05:600c:310e:b0:49e:8377:c880 with SMTP id 5b1f17b1804b1-49fe6716468mr4217415e9.33.1790194260255;
        Wed, 23 Sep 2026 13:11:00 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4c8dsm13559295e9.3.2026.09.23.13.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:10:59 -0700 (PDT)
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
Subject: [PATCH v3 6/7] video: logo: allow the boot logo to come from a reserved memory region
Date: Wed, 23 Sep 2026 22:10:34 +0200
Message-Id: <20260923201035.51007-7-maximpedraza@gmail.com>
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
 drivers/video/logo/logo.c | 176 ++++++++++++++++++++++++++++++--------
 1 file changed, 138 insertions(+), 38 deletions(-)

diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index b600fc3aab..6f0adcd34e 100644
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
@@ -38,9 +40,19 @@ MODULE_PARM_DESC(nologo, "Disables startup logo");
 /*
  * Sanity limit on the image size, a device tree is not a good place for more:
  * a 4K screen is 8.3M pixels, and the copy is kept for the life of the kernel.
- * One byte per pixel, so this is a byte count as well.
+ * One byte per pixel, so this is a byte count as well. Keep in step with
+ * MAX_PIXELS in ppmtodtlogo.
  */
 #define LOGO_DT_MAX_PIXELS	SZ_16M
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
@@ -49,59 +61,42 @@ static struct linux_logo logo_dt_clut224 = {
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
+	/* The palette is at most 672 bytes, the pixels can be megabytes */
+	clut = kmemdup(clut_src, clutsize * 3, GFP_KERNEL);
 	if (!clut)
 		return -ENOMEM;
 
-	/* The palette is at most 672 bytes, the pixels can be megabytes */
-	data = kvmalloc(npixels, GFP_KERNEL);
+	data = kvmemdup(data_src, npixels, GFP_KERNEL);
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
@@ -128,6 +123,111 @@ static int logo_dt_parse(struct device_node *np)
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


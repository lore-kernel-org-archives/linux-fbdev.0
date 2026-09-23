Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902BA572675
	for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194267; cv=none; b=imlxRvFQukB0r1m/7DrKhPcOiUfHjJC4qF5uiiO0vayjZeDV3a9f2Flgg874iaAeN8u5ilGvePY6q9lSRttcRq3ryhnV/8DYklrYTrcfG7EexY6lF9sVckhFPDmg217r01/3TWsd7xSDLXdQGixVgRy1ORJ+3yVO1CVXnZ1gDMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194267; c=relaxed/simple;
	bh=7oqKquhakJe90oiy+DxuOhrOlnIl+OIGd9ser/F9AeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O00CfI6xfVbXjqQMbflY4ToAGApLjsIVZq/1hrdXdwATQG0bDw3DveFdeL1od7Ry20rF6yTga/lS1o2B50WHahi4qqDI+73e/M9vpN2KU6fDz7UPd5TrfUxYclGzXqZubqLY34/ah9kNhULLnF/POmbbI7ehBZ15erWC3M/R5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4Jd6et6; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4Jd6et6"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so9264235e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 13:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194256; x=1790799056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5EUHnFPULkkfl9EPKbDpfgSFJiqys4NK1JcsO8IiCyo=;
        b=U4Jd6et6NatnLFrAhJCTQsC5cuINZRmg111cCCHHYlyjG7Gj1bodZTXOsG4puSQJqr
         IR2k2QW3Znqdz78D5WIjSnepRFhtW1+oCGTsz+24DY1kg1ZFmdwjY7iev8LlOspxMQMN
         3eSDqNa8slwWu3y+3Kfk2qM+zD3s4KjFTAsapUSXDUCk64G0dfYqFLQinMscYxGr7YUN
         Z++T+qGGcjIKSljR8rqZMBzB/3cbfK3DTfvqyVDvRF6yiMg9v7GbjjC6JmZb4WO9O67V
         e0UhrjDRSZOw1DxVxlztXdk0nFCf12gZBFAT0nUp5t2r3LESdAlUUV1K/Lt2vcS6+FO5
         s+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194256; x=1790799056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5EUHnFPULkkfl9EPKbDpfgSFJiqys4NK1JcsO8IiCyo=;
        b=FHsyU0XVJ0rYcebrB36EFNEIoN63ISpYqgE+rO9nkVtn3I/7wRMYkSraItXiujc2dQ
         AxGdiqE8BQEwJuL4wULSOftctMlvlkFrVv1fGDHnBKw5lKkUQcYswDfaN+BTBcKJPhLp
         7Nid01ccGOnaT52SWReql1taCDO5MjFZihJtQEZ7vejZsd0l+S1thWtnNosGW3PzHpAO
         mABK5RZyRxpjS+Ni8tuKekoL+3BQdtqBmBvzAxODtsA9HSgtTbc8IwnmtvhJUTso5JPh
         JfHiWHIAAIA8A3DHJgWLjtS4TOus9kirKZMGgFREGx90MLHe0gz/JZ52gZFX1W0r7j5o
         H1ww==
X-Gm-Message-State: AFuF++lEYO8dgDxePI4tUgVGVA33nxs6B7QJun3du6myHftJzw6t9AqA
	tSCXkRY2/oXt9AjgHQPfdvS/pbrLOy2bUWmAwNQjnuYgqThQ/b0nCztU
X-Gm-Gg: AYBFou00PjYx6K9fJRTC1yaSrgQBx26xFcgCN0JXyskDudAS/NestgDVRs7KA3H0nUZ
	nDs7illKcP88YlCTe9/P0DwxKmulmREXm0l6ZeHCqJpGpGS8/DBeCKBVHze1g6YEBYPTfaLxfYV
	HsiisBlfhBAzzf/YAP/PGiTBav4y65pdqEZpMcxK17mMtO/OYKVXeX8wlhsMEUsxsoeHNh+Yl92
	xWB0srHocZG+12XsRJ2aypWNVGp8Vyg9oCLqXqHsuBT8H/fa8YQ939pARDrRCNH+H/hBo3ezp+9
	6feOOj4vBZ9bPiYDCUPsE50DUWq1x7+xt+UghWUDstqTEZX1QoIiyjOr2sCkYZp+k/Nf0tLvu4R
	vPLuhs/XsWt8t4aIRKdwnOdw/eh25wijigd4HraExKX37V+Y6vgRK3sSYcoLx6QWpBWYF2+UiDX
	E1retZSg+F9x6piHtfB4pD8xeQo/B0dABYp5R4dT9DjbnBAw0Sxu6cSxUud49rmtKPKnck4O+A7
	4y00c7kFrnSXaKlF2JCq+ky
X-Received: by 2002:a05:600c:c8f:b0:49c:dc14:d681 with SMTP id 5b1f17b1804b1-49fe66bdf3bmr4527355e9.3.1790194256374;
        Wed, 23 Sep 2026 13:10:56 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4c8dsm13559295e9.3.2026.09.23.13.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:10:56 -0700 (PDT)
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
Subject: [PATCH v3 3/7] video: logo: allow the boot logo to come from the device tree
Date: Wed, 23 Sep 2026 22:10:31 +0200
Message-Id: <20260923201035.51007-4-maximpedraza@gmail.com>
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

Add CONFIG_LOGO_DT_CLUT224, which makes fb_find_logo() look for a node
compatible with "boot-logo-clut224" under /chosen before falling
back to the logos built into the kernel image.

The image is validated before it is used: the palette must have at most
224 entries, the pixel data length must match the geometry, and every
pixel must reference an entry that exists. A malformed node is reported
and ignored rather than drawn, so a bad device tree cannot take the
display down with it.

The image is copied out of the device tree so that the 32 entry offset
the frame buffer layer reserves for the console can be applied to the
pixels. The pixels are allocated with kvmalloc(), since a full screen
image is larger than kmalloc() will comfortably serve.

Unlike the built-in logos the copy is never freed. Those are initdata and
go away in free_initmem(), which runs after async_synchronize_full();
anything this code could hook into runs before that, so releasing the image
here would pull it out from under a display driver whose probe is still in
flight. It is a modest allocation and it lives as long as the device tree
it came from, which also means fb_find_logo() can still hand it out after
the built-in logos are gone.

The node lives under /chosen because a logo is configuration handed over
by firmware rather than a description of the hardware, which is also
where simple-framebuffer nodes live for the same reason.

The lookup is guarded with IS_ENABLED() rather than wrapped in an #ifdef,
so that the code is compile checked whatever the configuration and the
compiler drops it when the option is off. Built for x86_64 with CONFIG_OF=n
the object is left with no unresolved of_* symbol and none of the data.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 drivers/video/logo/Kconfig |  12 +++
 drivers/video/logo/logo.c  | 154 ++++++++++++++++++++++++++++++++++++-
 include/linux/linux_logo.h |   3 +
 3 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index cda15b9589..cce89948f1 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -76,4 +76,16 @@ config LOGO_LINUX_CLUT224_FILE
 
 	    magick source_image -compress none -colors 224 destination.ppm
 
+config LOGO_DT_CLUT224
+	bool "224-color logo supplied by the device tree"
+	depends on OF
+	help
+	  Look for a boot logo in the device tree, in a node compatible with
+	  "boot-logo-clut224" under /chosen, instead of using one of
+	  the logos built into the kernel image. This allows a single kernel
+	  image to be used by several products that only differ in branding.
+
+	  If no such node is present, or it is disabled, the built-in logo
+	  selected above is used, so saying Y here is safe.
+
 endif # LOGO
diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index 91535f8848..84afd5b337 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -11,6 +11,9 @@
  */
 
 #include <linux/linux_logo.h>
+#include <linux/of.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/module.h>
 
@@ -22,6 +25,139 @@ static bool nologo;
 module_param(nologo, bool, 0);
 MODULE_PARM_DESC(nologo, "Disables startup logo");
 
+/* Boot logo supplied by the device tree */
+
+#define LOGO_DT_MAX_CLUT	224
+/*
+ * The first 32 palette entries are reserved for the console, so the logo
+ * colours start at index 32. That is an implementation detail of the frame
+ * buffer layer rather than a property of the image, so the device tree stores
+ * plain indices and the offset is applied here.
+ */
+#define LOGO_DT_CLUT_OFFSET	32
+/*
+ * Sanity limit on the image size, a device tree is not a good place for more:
+ * a 4K screen is 8.3M pixels, and the copy is kept for the life of the kernel.
+ * One byte per pixel, so this is a byte count as well.
+ */
+#define LOGO_DT_MAX_PIXELS	SZ_16M
+
+static struct linux_logo logo_dt_clut224 = {
+	.type		= LINUX_LOGO_CLUT224,
+};
+
+static unsigned char *logo_dt_clut;
+static unsigned char *logo_dt_data;
+
+static int logo_dt_parse(struct device_node *np)
+{
+	unsigned int clutsize, npixels, i;
+	unsigned char *clut, *data;
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
+	if (!width || !height || (u64)width * height > LOGO_DT_MAX_PIXELS)
+		return -EINVAL;
+
+	npixels = width * height;
+
+	len = of_property_count_u8_elems(np, "clut");
+	if (len < 3 || len % 3)
+		return -EINVAL;
+
+	clutsize = len / 3;
+	if (clutsize > LOGO_DT_MAX_CLUT)
+		return -EINVAL;
+
+	ret = of_property_count_u8_elems(np, "data");
+	if (ret < 0)
+		return ret;
+	if ((unsigned int)ret != npixels)
+		return -EINVAL;
+
+	clut = kmalloc(len, GFP_KERNEL);
+	if (!clut)
+		return -ENOMEM;
+
+	/* The palette is at most 672 bytes, the pixels can be megabytes */
+	data = kvmalloc(npixels, GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto err_free_clut;
+	}
+
+	ret = of_property_read_u8_array(np, "clut", clut, len);
+	if (ret)
+		goto err_free_data;
+
+	ret = of_property_read_u8_array(np, "data", data, npixels);
+	if (ret)
+		goto err_free_data;
+
+	for (i = 0; i < npixels; i++) {
+		if (data[i] >= clutsize) {
+			ret = -ERANGE;
+			goto err_free_data;
+		}
+		data[i] += LOGO_DT_CLUT_OFFSET;
+	}
+
+	logo_dt_clut = clut;
+	logo_dt_data = data;
+
+	logo_dt_clut224.width = width;
+	logo_dt_clut224.height = height;
+	logo_dt_clut224.clutsize = clutsize;
+	logo_dt_clut224.clut = clut;
+	logo_dt_clut224.data = data;
+
+	return 0;
+
+err_free_data:
+	kvfree(data);
+err_free_clut:
+	kfree(clut);
+	return ret;
+}
+
+static const struct linux_logo *logo_dt_find(void)
+{
+	static bool probed;
+	struct device_node *np;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_LOGO_DT_CLUT224))
+		return NULL;
+
+	if (probed)
+		return logo_dt_data ? &logo_dt_clut224 : NULL;
+
+	probed = true;
+
+	np = of_get_compatible_child(of_chosen, LOGO_DT_COMPATIBLE);
+	if (!np)
+		return NULL;
+
+	if (of_device_is_available(np)) {
+		ret = logo_dt_parse(np);
+		if (ret)
+			pr_warn("logo: ignoring malformed %pOF node (%d)\n",
+				np, ret);
+	}
+
+	of_node_put(np);
+
+	return logo_dt_data ? &logo_dt_clut224 : NULL;
+}
+
 /*
  * Logos are located in the initdata, and will be freed in kernel_init.
  * Use late_init to mark the logos as freed to prevent any further use.
@@ -45,7 +181,23 @@ const struct linux_logo * __ref fb_find_logo(int depth)
 {
 	const struct linux_logo *logo = NULL;
 
-	if (nologo || logos_freed)
+	if (nologo)
+		return NULL;
+
+	/*
+	 * A logo supplied by the device tree wins over the built-in ones. It
+	 * is an ordinary allocation rather than initdata, so unlike them it
+	 * stays valid for the life of the kernel, and is still there for a
+	 * display driver whose probe finishes after the built-in logos have
+	 * gone.
+	 */
+	if (depth >= 8) {
+		logo = logo_dt_find();
+		if (logo)
+			return logo;
+	}
+
+	if (logos_freed)
 		return NULL;
 
 #ifdef CONFIG_LOGO_LINUX_MONO
diff --git a/include/linux/linux_logo.h b/include/linux/linux_logo.h
index b3b15d3800..1e7e9db6dd 100644
--- a/include/linux/linux_logo.h
+++ b/include/linux/linux_logo.h
@@ -22,6 +22,9 @@
 #define LINUX_LOGO_CLUT224	3	/* 224 colors */
 #define LINUX_LOGO_GRAY256	4	/* 256 levels grayscale */
 
+/* Compatible of the /chosen child describing a device tree supplied logo */
+#define LOGO_DT_COMPATIBLE	"boot-logo-clut224"
+
 
 struct linux_logo {
 	int type;			/* one of LINUX_LOGO_* */
-- 
2.39.5


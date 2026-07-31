Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258C7351C04
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534652; cv=none; b=A952H1Q3nUuaPR5ygcbGal9cky/i8Dt7D3zIM8uhVW7EJWZlQ7xpqUNl2ZQYPg8yO/V9cOjtt540p0qxVxEgOZcJSy3vrMG1ZYYSl1JY4xGCRJ2Vl+CZjrEwrgNPTHlzU3uSvH77LhjegTVzHBwEzF6SZUlLCLrpjfYHyF30GiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534652; c=relaxed/simple;
	bh=1t1Xcl0vx0rLkiOp8M9P11f9v6z8fBleVFwCSvlK7k0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C9zpfu3XTWMxUWBSsVqW/rExNE7nKyraVZDPIVIXDjMT4gkILU3RAC/fVxdsVuWV2LcUJiR0yrYqeYGTwNZ/vmb7FVXu/MVYTKRrbXHFsNVjphroXcbCcsNnltlHcACEA5tjWP30ON0KX891NDtXGchtnoU8+FCsTOnum0RJ6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5H/4bsg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5H/4bsg"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47fd66a094eso331983f8f.3
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 14:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785534648; x=1786139448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xecpazbmAHToNRI7HHvo3rBeU785pIEnzPP95T0hHMQ=;
        b=p5H/4bsg+Y5P7YGEF3/HYA1SYqhUxHmtGkKcjCKKAzZY90Z8Eot4ZVFphXqYwsgJ/l
         SPvMd+vpjK/zXNThrNdb0MWGsZ6XjQbqbKtspZ1/kCACdFyjFtXFTdUl+9CC1zAjAJC/
         5PZIvS3IVo5ugQsWUs+MB1AaR28MfIOuhrq3kgA7GIx60zBDrXL2P+c4MWPXZKLXjo+Z
         JcpICBk1W7EiQwEMsUT/zc4O8PDCgzwQCPGsZp9IcIPTgPvZgwlOoS6bmwMfMiurU3Ly
         YgWWLhIQY0jTuubVk1U99csM/n3bMnyidPfET4K+400p4DegmejAgX08ERsejoKvyCJX
         Nrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534648; x=1786139448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xecpazbmAHToNRI7HHvo3rBeU785pIEnzPP95T0hHMQ=;
        b=L/xE3wtvrxRl/zZYv7zVjBN36EKQvt+yBAVDahAgcyq9aHa1pRcmAWq57lv5WIy8FE
         trAl9uA/aMQOtUDwryplBM6o25Co1ExrARy3W5PO0vmlnIolZITtP0cc0TaE+B1Z7Hja
         P/tHinEkAVRf3o4Dlw2nEngWAnszn6FIQ/1sTOpdWbMz/kY2qU+K8p1aQFhqdajt5QDN
         Ar0sesNEjfDO3y4xW7Yp8/rF9GFbK86yMN/zq3B+g8BZ4z4m3Zm4dR4ZG9SGhdblPewc
         97bh+a9hFyf8YOHjKQzrWyhydzUomTv5X+8Iw+jv4MU42O9nARFIDOMvu0PWCKBfGd0Q
         USXg==
X-Forwarded-Encrypted: i=1; AHgh+RpgSZjONsbtqKdIWIcRmlj28EkfTsebU5JbARNOLt13z/vnsxh/Bz49LbHwcaxgI+P1iDE7RNHb6LZrTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0G3Oj+TU//S09pOaJa/PXFrIMyo1NXtpm7wx2gmNsgrtmOZpb
	M6pLvn0HSVCW5rcgzi8m51Xpi5cS/NMsyuLZxAaGzE++itIMtXtX8Omu
X-Gm-Gg: AR+sD10KmFBpnpEqjTZd2/figECp91rE3OqStI+2joXIUf/IxOcneFgN8nhf7cgxAsT
	xiOQpgAuzvFJednM4TRMjE//uOlKbTuGauSwxnSOmSM3Gh0FT/ouhCASLM9hKZfDd4bqx8QFwNg
	VFvCdKxaHeOK6bAH1h8B97P3xrOWIN+yWQqkh3swvMt4G2eKsrKKVCUc7bcpoYRBeKXJ6N4vQ9r
	XLTSNYQFvIqXViV36/PbXzdtXLVRgyyQO9I8/Jd/nnk78e5KGTxOC68/2WL1iqMfarqZ3+fcbz/
	59jiAxNIl7LwDhhCVdyB8dHiPHpQs0xnzFbJVV+OBBg0Vq1t9P72jl/woH3m/HkfWAW7OFy/djg
	02d/u06devCQFZSACwrfNjUyz0mQ+jz/q1ob3HZCMoIhcEkIUwVFnFuelFRwQxOVgeSzqviEeTE
	hZTv8pfgzbIBHqI1X7sncVp//EqeVECkfZvmqWLT73slyudfjG0vbnPHS2bobtI5oS2XF+ScqDP
	1BfIh+Oh+c1NKvDcAQ6LRZR
X-Received: by 2002:a5d:64ed:0:b0:47f:77dc:b072 with SMTP id ffacd0b85a97d-47fd72c65f5mr2415622f8f.18.1785534648239;
        Fri, 31 Jul 2026 14:50:48 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.62.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2484sm10186342f8f.11.2026.07.31.14.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 14:50:47 -0700 (PDT)
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
Subject: [RFC PATCH 2/6] video: logo: allow the boot logo to come from the device tree
Date: Fri, 31 Jul 2026 23:50:39 +0200
Message-Id: <20260731215043.30392-3-maximpedraza@gmail.com>
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

With CONFIG_LOGO_DT_CLUT224 enabled, look for a node compatible with
"linux,boot-logo-clut224" and, when one is present and enabled, use the
image it carries in preference to the logos built into the kernel image.

This lets a single kernel image serve several products, or several
revisions of one product, that differ only in branding, at the cost of a
larger device tree blob.

The image is validated while it is parsed: the palette must be at most 224
entries, the pixel data length must match the declared geometry, and every
pixel must reference an existing palette entry. A malformed node is
reported and ignored, falling back to the built-in logo.

The two allocations live for as long as the built-in logos do; they are
released from fb_logo_late_init(), next to where the __initdata logos are
marked as freed.

If the node is absent or disabled, behaviour is unchanged.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 drivers/video/logo/Kconfig |  13 +++
 drivers/video/logo/logo.c  | 157 +++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index ce6bb7535..4af349b20 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -70,4 +70,17 @@ config LOGO_SUPERH_CLUT224
 	depends on SUPERH
 	default y
 
+config LOGO_DT_CLUT224
+	bool "224-color logo supplied by the device tree"
+	depends on OF
+	help
+	  Look for a boot logo in the device tree, in a node compatible with
+	  "linux,boot-logo-clut224", instead of using one of the logos built
+	  into the kernel image. This allows a single kernel image to be used
+	  by several products that only differ in branding, at the cost of
+	  making the device tree blob larger.
+
+	  If no such node is present, or it is disabled, the built-in logo
+	  selected above is used, so saying Y here is safe. If unsure, say N.
+
 endif # LOGO
diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index 141f15a9a..b4f533df0 100644
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
 
@@ -22,6 +25,155 @@ static bool nologo;
 module_param(nologo, bool, 0);
 MODULE_PARM_DESC(nologo, "Disables startup logo");
 
+#ifdef CONFIG_LOGO_DT_CLUT224
+
+#define LOGO_DT_COMPATIBLE	"linux,boot-logo-clut224"
+#define LOGO_DT_MAX_CLUT	224
+/*
+ * The first 32 palette entries are reserved for the console, so the logo
+ * colours start at index 32. That is an implementation detail of the frame
+ * buffer layer rather than a property of the image, so the device tree stores
+ * plain indices and the offset is applied here.
+ */
+#define LOGO_DT_CLUT_OFFSET	32
+/* Sanity limit on the image size, a device tree is not a good place for more */
+#define LOGO_DT_MAX_PIXELS	SZ_32M
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
+	data = kmalloc(npixels, GFP_KERNEL);
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
+	kfree(data);
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
+	if (probed)
+		return logo_dt_data ? &logo_dt_clut224 : NULL;
+
+	probed = true;
+
+	np = of_find_compatible_node(NULL, NULL, LOGO_DT_COMPATIBLE);
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
+static void logo_dt_free(void)
+{
+	logo_dt_clut224.clut = NULL;
+	logo_dt_clut224.data = NULL;
+
+	kfree(logo_dt_clut);
+	logo_dt_clut = NULL;
+
+	kfree(logo_dt_data);
+	logo_dt_data = NULL;
+}
+
+#else /* !CONFIG_LOGO_DT_CLUT224 */
+
+static inline const struct linux_logo *logo_dt_find(void)
+{
+	return NULL;
+}
+
+static inline void logo_dt_free(void) { }
+
+#endif /* CONFIG_LOGO_DT_CLUT224 */
+
 /*
  * Logos are located in the initdata, and will be freed in kernel_init.
  * Use late_init to mark the logos as freed to prevent any further use.
@@ -32,6 +184,7 @@ static bool logos_freed;
 static int __init fb_logo_late_init(void)
 {
 	logos_freed = true;
+	logo_dt_free();
 	return 0;
 }
 
@@ -71,6 +224,10 @@ const struct linux_logo * __ref fb_find_logo(int depth)
 	}
 	
 	if (depth >= 8) {
+		/* A logo supplied by the device tree wins over the built-in ones */
+		logo = logo_dt_find();
+		if (logo)
+			return logo;
 #ifdef CONFIG_LOGO_LINUX_CLUT224
 		/* Generic Linux logo */
 		logo = &logo_linux_clut224;
-- 
2.39.5


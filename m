Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250242AFA3
	for <linux-fbdev@vger.kernel.org>; Tue,  4 Aug 2026 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876988; cv=none; b=LJBbW6wOZkSecjeKMxKJbedXbYPjIsHHOyDRZ1SKT20QlNqIBlsR/kAVL7i2ZueQnzx9qq+blsfVfIrkyOYoXtyuO+MPYQRd+31tQIGUE/IZ5gre4v3ssytC1vNCGZcaeg0ucqjAriUzAKJUSbTMkAfDPyM7yp4EFoVvGHWEQ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876988; c=relaxed/simple;
	bh=lt0mcBR/xBSiSFpNw9TpFma/Wx/XqysIpYFDw49QURY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ubqYWZN9oCPGI1o4LwCCLTghQbiPt6SFnHzdJRc7jV1c31IoLLaoPPVUTIl/rBa1i+X3zVnKksb/8NAGCvBnZxd8LS/7q3c68fgytKMRAz1Ik6/F71wlI+EHZ61DKBNBMUiNlkExJzkfhXfYuB6iiNVtc6GtyNHELt0jV4K+Eoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbSD8Mqr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbSD8Mqr"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b966dd74so1284855e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Aug 2026 13:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785876985; x=1786481785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xEGbIZ53FjPXZVHPJc+jEB5q1hKyvKtu0OiAqfcxBNQ=;
        b=TbSD8MqrDqYP5d847lhWNiJw75ByTFAiAvXhC3TOvSyEGiG1yULS1FXvdcCRVtSci0
         CTEEb80+Bf3Ns37H/p1HGve4QUxxrSxjQJLnlDe2AiHF4WZQZA6KuH2usR2Xop/OJUAm
         +awPLz4Sxl1dvL5XN9MkB9S+mLWvQ9vYo8VxVBtI7V43tGYSPB/zf0JaZrQYrvXrnxV0
         r08b0UyfqmBbjzVKCf78MeoRiTqAvzMb1P+HHkqCYyEx2aT3XvXsL0BM4nzeR5c7OO/S
         ZR9/EFSL/moUyBhPnvlqkz4zEcP3Le1sc91B2uL/7HPox2cy70QKd90ZQGjCPYH8rOEG
         dByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876985; x=1786481785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xEGbIZ53FjPXZVHPJc+jEB5q1hKyvKtu0OiAqfcxBNQ=;
        b=ZGGx0gJD6j3elNIncmm7UOFeu0+WKW0bUtlNUAOYTkCTnuIpKv74Lm7Km4z+Nggtd9
         JgqWhJl+P2rstYGWMcJ1eRqQwpUYzdgXavwLMGynGkKIqKU9AtpHAkuMRp38wbCzJzH2
         O1jdUf7ut3DIbRdvlVUbp5mvgTvA+h5qKBjhQRe0gekb8N32sKYx7vW79xDLF+VZ3DRO
         qSkQg1966L4CQTzxGuCNcvl6TJUz17LBsqb9cuRelg2zZnrDLsbEwnVKHTyK8339TvxD
         Znay+fT6j60xdA9SzbbxyI2DFkYPMD41wwtDI0Kxu9KXlWboBvwNkfOs+uSWO6GBTliJ
         48NA==
X-Forwarded-Encrypted: i=1; AHgh+Rozng9Orl1gCCpRpzRdAer1BwY2BEy5MSrpLTJc4haTSnN2PnOfyyJ2HIecUU/U9d4j5W4mwk3qRLc2ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0W87QkzrxptWoM6AEpk9jlcKcBnieWQM0wgHrv+1b+qnadkqG
	IyJTDg9gxRIhoESL/EjO+2B9BSPn5X/dKMFzTdyyWrG0w0qO+1MaA+Uf
X-Gm-Gg: AR+sD11ew9Ty8VC+KL4cwaLQsAMRBg4hzctrI8bqSnMo9IZY5SLApOx0tsHlsehLiNs
	nX+ecWM1NcvJ/fXFFcq+OdoMiVvGIFILdwNjqoWZGvrfmvENxMDM+M9+beQDruM9iC3vSBWZflO
	FSgzz5qsczHEt+hwzhKitPVluV+Lo3cpZPMcArf/Gd0Kfy6GUmXPTPujoUtp1dMA0bMwt0wf52X
	Vao5Io3BlvhgeMPZf+4MjZNrJoeLDxbjnyo37/k6TrSu0NM5s9YoEGYot/HCoTzEGsw16zTAUKa
	YDhyRpoPebSNSSY81GrzORCONWeiKw4WXKhtwMkwyvWWHXX3eET508QZt2M6KnD9J7EUTM3DrTV
	XlHM0SDR+ll2wrIMA1DlpRE7RQdWHOt8ASRm0HjAtuuW/GEnCdFzgQxTBhPo3v+NgiKymxX3ul6
	07VfQL3kPgSmFEc3GgDrJtZlTrW352TA8t071yb00NfmSbeA9Anl5KP16stSb+Ue0k6bpUqQbzb
	Cv2W7FL1SSPK+8=
X-Received: by 2002:a05:600c:a20b:b0:495:737a:7afe with SMTP id 5b1f17b1804b1-4994e7d5b82mr8732495e9.15.1785876984840;
        Tue, 04 Aug 2026 13:56:24 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.176.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4bf820sm12070645e9.0.2026.08.04.13.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:56:24 -0700 (PDT)
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
Subject: [PATCH v2 2/6] video: logo: allow the boot logo to come from the device tree
Date: Wed,  5 Aug 2026 00:56:13 +0200
Message-Id: <20260804225617.264861-3-maximpedraza@gmail.com>
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

Add CONFIG_LOGO_DT_CLUT224, which makes fb_find_logo() look for a node
compatible with "linux,boot-logo-clut224" under /chosen before falling
back to the logos built into the kernel image.

The image is validated before it is used: the palette must have at most
224 entries, the pixel data length must match the geometry, and every
pixel must reference an entry that exists. A malformed node is reported
and ignored rather than drawn, so a bad device tree cannot take the
display down with it.

The image is copied out of the device tree so that the 32 entry offset
the frame buffer layer reserves for the console can be applied to the
pixels, and the copy is released from fb_logo_late_init() alongside the
built-in logos.

The node lives under /chosen because a logo is configuration handed over
by firmware rather than a description of the hardware, which is also
where simple-framebuffer nodes live for the same reason.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 drivers/video/logo/Kconfig |  12 +++
 drivers/video/logo/logo.c  | 160 +++++++++++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+)

diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index cda15b958..215afa7ef 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -76,4 +76,16 @@ config LOGO_LINUX_CLUT224_FILE
 
 	    magick source_image -compress none -colors 224 destination.ppm
 
+config LOGO_DT_CLUT224
+	bool "224-color logo supplied by the device tree"
+	depends on OF
+	help
+	  Look for a boot logo in the device tree, in a node compatible with
+	  "linux,boot-logo-clut224" under /chosen, instead of using one of
+	  the logos built into the kernel image. This allows a single kernel
+	  image to be used by several products that only differ in branding.
+
+	  If no such node is present, or it is disabled, the built-in logo
+	  selected above is used, so saying Y here is safe.
+
 endif # LOGO
diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index 91535f884..7f8b04ecf 100644
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
 
@@ -48,6 +201,13 @@ const struct linux_logo * __ref fb_find_logo(int depth)
 	if (nologo || logos_freed)
 		return NULL;
 
+	/* A logo supplied by the device tree wins over the built-in ones */
+	if (depth >= 8) {
+		logo = logo_dt_find();
+		if (logo)
+			return logo;
+	}
+
 #ifdef CONFIG_LOGO_LINUX_MONO
 	if (depth >= 1)
 		logo = &logo_linux_mono;
-- 
2.39.5


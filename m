Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558873A6F1A
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500367; cv=none; b=YM5FyP2YNQ0QrRPc+w5D3zncyEUSbYEnncvHKoqroOq6TSTuKvxj2s+kMW8sD2drrub9PXj25jsU8RvXZ2qYaoaXPZ3yvSffahrAjA1NPzs1yWAiA8dEghnMJS4th1uPjTevSesEkVbShZ0v9J17ukXjzEEPWSitAo71RF8DITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500367; c=relaxed/simple;
	bh=h9qalZIArzdoQAUY+7lzxjQ2sUlIYUk+R1bFw7ABpoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTDd7byYIYIP5YWHFGHqc2z5/pxSUUw/fGJY+VpnkRwfesJnn/2FjJmMeqF6MS/BB83Q8ryKOBelUOteyf4T/VqwTRsqvMZXxQhLVOGSaYN4V5wZp3QiyU9f9L58DsQTE8O819o1qxZIUGk4GGlgP9zNh6qOvOyr3o8aRjAvZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=QFvDM4xw; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="QFvDM4xw"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so921289a91.3
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785500366; x=1786105166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/zgk2khl+gAzXyZ3o1YPLCn48UL/rzoP7NqltzArtxk=;
        b=QFvDM4xwKL00MpyJaHx5JTpn9I+1mPCU+74vI+dAiEMejgcuHVjRnkccaqxH0/XozZ
         LMNpKb4xWP5ZvkIp0oDepmdIXo10Pxf9e+Cbp1YxY7sGfdBVwqM269Z3Amf6s/XJ711P
         +vBSx7FwlDyVyxFx/IIxKpb9a2WJ5DNnVLn4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785500366; x=1786105166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/zgk2khl+gAzXyZ3o1YPLCn48UL/rzoP7NqltzArtxk=;
        b=oxCi/YV9xTRczHmWjjLsuR2qaFTjg5Fdszd680fn2tpZJEZazfuJOVAMjjimPeIp69
         vNTaYkiVzUGPrJPRmRQw9jR4LDm7RjaktiRLXer18MZdDx//KEyU3s0GS3SjWExNXP3z
         z6TYOtU2lCHTvqJ3U+5OzALw7+7IVpCIIANOumG1MgNYU1+0x8INf4jNz561PL+CZ3o+
         IvmGT4Xk0TMlIUFdCmxKutOHok6ZjN83uUaD6nDE99o6XHNQOwbTfMdgCXB2lMG6EDzh
         L3DntzHnIAUsySpNfP+hOVfliD58Ff+E1dudKqEImH/gojPpuP/rDrqwoBrypTSEwT93
         KhAw==
X-Gm-Message-State: AOJu0YwDvfobUSG8mqXt3i1pgFdGbPywc492O2XSfB/kQkaecVVZR2Qg
	LfMBWlGttE651kd46yeQ7qDsZY5xGJS8E66jfrGtsR+E3LuIq3ZC0VvF8DTFITuIlHE=
X-Gm-Gg: AR+sD10lAMUlmYpcZMsK15OxONGJtMYYwlbKZAknpny4M1HJ3tlDEfRZ2mKdoolKY9M
	13dfNMCCCyXBfGsYpLijbEYkybY8fPDh2paVxCywJHzLkFctAPhkSFDGGDI/S3+Kr/r6A+QX+Ty
	00SNrqYv0tZDgqM4MbILy8ghAAwGx4vKEhua6MKDld6CI1CUaF5GPHnSlyemgrotsR+62W1Y0S1
	UtK1NAQDNb/rokAjL4adYB7wdLx00owh4Xic5MZlrVUc8lrFVkERDGj4K6yV8zktc3ybFpK98em
	q+Sh/xR60gMc1lDYEzxktHdHAtBACeA1t/L1wkv8fI4Vrd9cJcSFoMkTxXjd/4wRZkvHlppQOqr
	EMUzMDXp4x74ubcJYYSE/o7WmfyRkKJz89w1CmaM0LfCeqhq1bqo3atCO74eV9LII29+FJEtXZF
	zkWIc39is6NsHDLrcr1bkPMsM6UAODZW7s1D+ehQwpCjb6nVVshAY=
X-Received: by 2002:a17:90b:582c:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-38fb1117e8cmr1766904a91.8.1785500365608;
        Fri, 31 Jul 2026 05:19:25 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:77cc:841c:1fc1:22d4])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-38fb2b8c5c5sm321981a91.4.2026.07.31.05.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:19:25 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 1/5] fbdev: tdfxfb: Add helper to read config table from BIOS
Date: Fri, 31 Jul 2026 21:19:10 +0900
Message-ID: <20260731121915.3362232-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731121915.3362232-1-daniel@0x0f.com>
References: <20260731121915.3362232-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case that the video BIOS didn't run because the card isn't the
primary card, the BIOS doesn't support running old skool video BIOS
(modern BIOS without CSM), or the machine isn't x86 it needs to be
booted manually. To do this the config table in the BIOS is needed.

Add a helper to get the config table in preparation for manually
booting cards.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 78 ++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index cc6a074f3165..e92658274411 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -71,6 +71,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -336,6 +337,83 @@ static u32 do_calc_pll(int freq, int *freq_out)
 	return (n << 8) | (m << 2) | k;
 }
 
+/*
+ * Convert a pllctrl register value back to a frequency in kHz.
+ * Formula from 3dfx documentation.
+ */
+static u32 tdfx_pll_to_khz(u32 pll)
+{
+	return (14318 * (((pll >> 8) & 0xff) + 2) /
+		(((pll >> 2) & 0x3f) + 2)) >> (pll & 3);
+}
+
+/* Layout of the "OEM config" table in voodoo 3 BIOS */
+struct tdfx_bios_cfg {
+	__le32 pciinit0;	/* 0x00 */
+	__le32 miscinit0;	/* 0x04 */
+	__le32 miscinit1;	/* 0x08 */
+	__le32 draminit0;	/* 0x0c */
+	__le32 draminit1;	/* 0x10 */
+	__le32 agpinit0;	/* 0x14 */
+	__le32 pllctrl1;	/* 0x18 - memory PLL */
+	__le32 pllctrl2;	/* 0x1c - graphics PLL */
+	__le32 sgrammode;	/* 0x20 - SGRAM/SDRAM mode register data */
+} __packed;
+
+#define TDFX_ROM_CFG_PTR	0x50
+
+static bool tdfxfb_get_bios_cfg(struct pci_dev *pdev,
+				struct tdfx_bios_cfg *cfg)
+{
+	u16 romcfg, oemcfg;
+	void __iomem *rom;
+	size_t romsize;
+	u8 *image;
+	u32 khz;
+
+	/* This only works for the Voodoo 3 for now */
+	if (pdev->device != PCI_DEVICE_ID_3DFX_VOODOO3)
+		return false;
+
+	rom = pci_map_rom(pdev, &romsize);
+	if (!rom || !romsize)
+		return false;
+
+	image = vmalloc(romsize);
+	if (!image) {
+		pci_unmap_rom(pdev, rom);
+		return false;
+	}
+	memcpy_fromio(image, rom, romsize);
+	pci_unmap_rom(pdev, rom);
+
+	/* ROM[0x50] -> ROM config table -> OEM config table */
+	if (TDFX_ROM_CFG_PTR + 2 > romsize)
+		goto out;
+	romcfg = image[TDFX_ROM_CFG_PTR] | image[TDFX_ROM_CFG_PTR + 1] << 8;
+	if (romcfg == 0xffff || romcfg + 2 > romsize)
+		goto out;
+	oemcfg = image[romcfg] | image[romcfg + 1] << 8;
+	if (oemcfg == 0xffff || oemcfg + sizeof(*cfg) > romsize)
+		goto out;
+	memcpy(cfg, image + oemcfg, sizeof(*cfg));
+	vfree(image);
+
+	/*
+	 * Make sure we didn't read garbage from the BIOS and will
+	 * end up setting a frequency that explodes someone's expensive
+	 * card.
+	 */
+	khz = tdfx_pll_to_khz(le32_to_cpu(cfg->pllctrl1));
+	if (khz < 40000 || khz > 250000 || !le32_to_cpu(cfg->draminit0))
+		return false;
+	return true;
+
+out:
+	vfree(image);
+	return false;
+}
+
 static void do_write_regs(struct fb_info *info, struct banshee_reg *reg)
 {
 	struct tdfx_par *par = info->par;
-- 
2.53.0


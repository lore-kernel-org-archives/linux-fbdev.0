Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB5374A1D
	for <linux-fbdev@vger.kernel.org>; Thu, 30 Jul 2026 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436025; cv=none; b=mkI8Zr9SkiCCsWf16x/UrxVG5ULrDaluAznz+vwq6+oIsKGiNPIhiDsHBLhYkUZZFp+2TXEpPDcGHvXeZSVrAaiom1FlfWVHpCydJ+6lRZdZXgsw9y1N8qdFy7rtwvCmxLaTHdD2e3ZgFdACHyPdtpYDLF3KMFpeoiVwnunSNic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436025; c=relaxed/simple;
	bh=GTK2THP7MWJ0yof2BVUNAFv+47a5FW3it4lWqBn2RZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ot2EPQ9QmLppmcjXkpc+RJ7VBeGifrgiXbfae3LJCOMIEMSBrhb9GcEVdnbTTTHbjVYlVUoIVM9Y0+CvDlerSHTmdcpsnr1YfCDgg3WsamNcKYbh58qDc+l5sufuK9aviIRrnENx7Nzo23Pi7hpCL9HO2PwGsydzHfx9ZZLFD7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=HtFZC8+N; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="HtFZC8+N"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84867f07d63so244492b3a.2
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jul 2026 11:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785436021; x=1786040821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kDb2lpOWcTmtm+d/TFdlb5UDpwayQCJmDNQmiV6VIlg=;
        b=HtFZC8+NvLNTWUuHsui+N/YiWDeN2bo9kuW1sZw8jpkwD7kWinNUe9obmRKx7pwaCY
         2uDMKa7UZR4QlHDfzRBjWOg9TeE6rgfVq6cWZo+xrlAA7OnxMiBa+nE6PFkEUMqeR/ow
         go7LbIkw0DEUHXPYzbKUoeormWbQWjgytHGcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436021; x=1786040821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kDb2lpOWcTmtm+d/TFdlb5UDpwayQCJmDNQmiV6VIlg=;
        b=TFsHWTqclcpfdk2yshYlOfr1+EB484V7aRekGnojsXwP1UygLGNU2cyjXRp2mwZlaD
         oADcROayfxCCgiSmohNURAxHPVsjwnzCKwY8a5OUmb/TRjxl6fh/rnoR7lAEN8HeKLxV
         Cw0HutjE6ppeY9nmD3MateDGWDdC2UoNft4qxJjSPGPeBUp85dCCs/GawR0J+PHBImrj
         +GozGaDRN+rpp0xPWIBls5lypBXKiNw68Cz5p9b8JfUb60x4hM5DPKS3AV9OS1ymETk6
         gPbfteNkDVYligoo8DwBmV9b1xg/Mgzok8ae5YU21ylPiAb6djmm9vJZmxkJR35sVwbN
         tqZA==
X-Gm-Message-State: AOJu0YzPI8TWAPS74RK/xt3VGmgINVGkLCv9kDe3RkGtpSWEIi7AYHj9
	+vN2KXBZzcZ2V2CSraWjgxFtM48kF3ldtzIBA/JWSTWYagAS16gC9+29Du9VrqVu+mc=
X-Gm-Gg: AR+sD13Ol9vvkGyZwTEYG0NoEGvIUuZcY8bE4cYLLrpWYBo4Ztr/xKIWwfqkL6Eymhv
	agIZ3vNpb279ee8d/HAh7WoG1h38OprN0KIZC8mCcy492Jg3T7/PVvcTjD/yoxBxi5n20T10po0
	+R5iWnXpHJDTk/34zWBwr3+VXSbTMpXiYhiwxPDqiArweh19L2awUfSdOpxhaW11HTlVP2oO8jJ
	FAs8du3sxdVRxqifMzHFIVIDMI/xegn/i/QEBjXjlVTjrrFSrJ4km3+d7cecnXd0KZhNIXFthLs
	XZO9ZYqT5TLNY0vCTCQqBdf0euAzdkoeoWG0CrXE7o3QDrx6ABzNuIV3p2XPk6dK9y0Xu9tuY15
	wn93iFIoMlNIR9ivxt39Wxa3DIYE3AgdoFZH47UPQZaNXgdIxFmoxU9oKVZBsCSpGF4EG7CmwfU
	Z05Nc8TZkmMO6lbYpYIjjGvavPexK/B5Ysxs/xbk5W9/S3836V00k=
X-Received: by 2002:a05:6a00:4143:b0:848:2f7a:2e58 with SMTP id d2e1a72fcca58-84ebc4471aemr3293938b3a.71.1785436021391;
        Thu, 30 Jul 2026 11:27:01 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:f84d:1f36:28ac:c15e])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84ea0378b18sm3428806b3a.48.2026.07.30.11.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:27:00 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/5] fbdev: tdfxfb: Add helper to read config table from BIOS
Date: Fri, 31 Jul 2026 03:26:36 +0900
Message-ID: <20260730182640.2808572-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730182640.2808572-1-daniel@0x0f.com>
References: <20260730182640.2808572-1-daniel@0x0f.com>
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
 drivers/video/fbdev/tdfxfb.c | 74 ++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index cc6a074f3165..fa554b09a0a6 100644
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
@@ -336,6 +337,79 @@ static u32 do_calc_pll(int freq, int *freq_out)
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


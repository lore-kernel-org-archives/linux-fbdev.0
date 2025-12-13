Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8DB2253B0
	for <linux-fbdev@vger.kernel.org>; Sat, 13 Dec 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765637589; cv=none; b=f3jCm2I+zIsHsdf83Y9b+5T3DHraasqnQR3dgCJ2J1ezqkGnPJFBTjFg7XC/KrBk/rrYcmR+tB89YrMXDY1gmx99HxF3Xx8UW9SVz2w9BNHcWJSKiHNeMPap34TEXwumL/xSK5qHvYUnW1koKsdjW6MzWVfivzJPCg09F1Z4ntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765637589; c=relaxed/simple;
	bh=4R6TSlXfUMmFdJR4o1UhCXmiq6RYJfcD5Q+FvL+r66M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UdXgGmDZEdghG1FM1GFIoDZD4+Tc3o5vaIQctmIBsTOkCvxikGIpwmnsaUfVGBisHoO8DgzKeKoAKQImps1oiEGzoorS8yPqZmEM1cd7CR6eZEtVx5ue2XmTevDjFs6skzom3SyTP0WdV5E32CBsBW2ywDJh4DxeIH7C/5t3/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tqhbs7wh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqhbs7wh"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-349bb6f9c86so2796161a91.0
        for <linux-fbdev@vger.kernel.org>; Sat, 13 Dec 2025 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765637587; x=1766242387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dqhPVfC6SZiXAXM+VHctjJfUvTdA8pHgty0TuL9jqcc=;
        b=Tqhbs7whYrArHRnvRodg0hi8GFZu5sqdCJfTDyqOh4kUQtp7u6axlx6EhLLNStZ8Mc
         8R7p9WaD9q1oKUCj2Bmkp0Ktx5jnh3af+AQD1J6akjXm7tv+nL/bLF3TdeRpqBgZi41n
         U5EbWyrI2HbZ0I+F0yiLhpoK5cp4BhdvXZ88+DK1uBbA+l8OMK4kQKckrqe1dCWks0y3
         3bFUQbzm+FpVFQdJH5ZO3+Bj1DTIKV7SyvS4qm4Od/YRhTHMl9AMhj7wMzD2fcSKMb/K
         QNwISYyuGfDffGSQkFCAbHRVOqxZdhg3fmk1ErFOqlmiW2y8685uT3pjnjCtAaPook9p
         4fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765637587; x=1766242387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqhPVfC6SZiXAXM+VHctjJfUvTdA8pHgty0TuL9jqcc=;
        b=tECAZVm9XZK4UwBgrU9p6UnOyFCH0IVibVRVOHbVHQoMP+IMp9edqrOiCCcL/OI4sW
         TgiFck48puGefzj26ZtGqbsn8W35ra2Cat6Zs6j7WH7mog6i1cGI2Lib21Djzts+rSHO
         UVmd5HWfyQirK6gMVASx5hLsblSEfua5WB6XvVAfkDRZz3LiHx2UHaoeJ+rdspTmHshe
         1wkLcyJ7+pZt7/GfH4qOAtwTY7m+uYiXts7eqbplinfcPlgWwD1DkQ+vAxKE7VxaJr5D
         UlDr49PBNymS87mIW66fnGm9YKd//04if8pWLvpKO7lz3VXgZ3aFGCwmM3a3QO98hkVo
         JVCw==
X-Forwarded-Encrypted: i=1; AJvYcCX5choOdg3Z7qTy919qX9nmlV/6GV43jvA/rxW8vJug/dS51fKVAQOuk/9kFAvAmgde9D5cCJIqvNFmWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQQs3hcbJ2vtfpKIzFj+oqdTDWeRPfoSe2VbgesB0pEs0k4h9
	XvUnyn2Z33MTDZ9OAkDgb3lV3j8SDzldiTR3M1svWLJhvgFEwszfGaUu
X-Gm-Gg: AY/fxX5+AztlxmXXud8F7MC/F81N35NZunQQ1THiMVQROwXKizScvpMc275jIJgCbCS
	c6T7jIgCHMs4Y5M5udc/B6k2Do7ztIyIAs+/JX4yXDKwLyhVJ048jDipVN9QOICdgit+bsef2Ac
	dhLfoeu2adgl6IlQg50EYkE1pZXZMwcnXPE9MPeTPDroTM9trrP3Xx1lAbXckxs6NKEDhuCTUIf
	6Y1HP152NPDPkMXvNPam7ooQ4R2KxzJVU/ILinQLmnODzC3gsV6ZvxSPecrV4rmF/G4ct5YJkpA
	1CNlRJ2bzFyDU6y0UYONEiv9bntHI5lnw08s5vg4zR3Oz3y7ZgEr8G5axfFxC+X9QatunjwWztO
	xJ+oIzUrtaWfsy30FLb8uJZu2T9oLM3ezIEH3OWryN8nBsnHiEDVJo2fAM+wMabpG8dbLoU/16+
	VMmdvRfCsXp6b+ww6Kn8g=
X-Google-Smtp-Source: AGHT+IHs94AtaIdi/LK1f1GL3oQjfIDINw0e2ryNLZ6e/m2MH5qRKb0B7VnFS+f9bCSyi3GmlCJ2Sg==
X-Received: by 2002:a17:90b:2e0c:b0:340:ff89:8b62 with SMTP id 98e67ed59e1d1-34abd78fbedmr4750217a91.21.1765637586883;
        Sat, 13 Dec 2025 06:53:06 -0800 (PST)
Received: from LilGuy ([2409:40c2:105b:dc88:1107:395c:23c0:2b1b])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c0c2c48bf7asm8146647a12.32.2025.12.13.06.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 06:53:06 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Frank Li <Frank.Li@nxp.com>,
	Zi Yan <ziy@nvidia.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Yann Dirson <ydirson@free.fr>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Kees Cook <kees@kernel.org>,
	linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
	dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH v2] fbdev: arkfb: Request legacy VGA I/O region
Date: Sat, 13 Dec 2025 20:22:34 +0000
Message-ID: <20251213202239.8772-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arkfb driver uses the legacy VGA I/O range (0x3c0+) but does not
request it. This can cause conflicts with other drivers that try to
reserve these ports.

Fix this by using devm_request_region() during the probe function.
This ensures the region is properly reserved and automatically released
on driver detach.

v1: https://lore.kernel.org/lkml/20251213154937.104301-1-swarajgaikwad1925@gmail.com/
Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
v2:
 - Use resource_size(&vga_res) instead of hardcoded 64 * 1024.
 - (Feedback from Kees Cook)

Compile-tested only on x86_64.

 drivers/video/fbdev/arkfb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index ec084323115f..24e4c20d1a32 100644
--- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -1018,6 +1018,12 @@ static int ark_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)

 	pcibios_bus_to_resource(dev->bus, &vga_res, &bus_reg);

+	if (!devm_request_region(&dev->dev, vga_res.start, resource_size(&vga_res), "arkfb-vga")) {
+		dev_err(info->device, "cannot reserve legacy VGA ports\n");
+		rc = -EBUSY;
+		goto err_find_mode;
+	}
+
 	par->state.vgabase = (void __iomem *) (unsigned long) vga_res.start;

 	/* FIXME get memsize */

base-commit: a859eca0e4cc96f63ff125dbe5388d961558b0e9
--
2.52.0


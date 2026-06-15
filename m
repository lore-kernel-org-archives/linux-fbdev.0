Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035C3C06
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Jun 2026 04:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781496332; cv=none; b=c/cxYSiaiN1Us7Zd1/WLdRfzX+6926ui/uS8s/hr5e8t4gEbOv+Ew3niHfGykuxqlK8Iu0hLiDcP1tbPE9pu1rLQRsuOBMHnwM888xCudCAjcIncg2d6fWww200RDxWDoiJSoXDpIoZD3nsk67z3xMxD41FjtXCqCKlfIOjOdDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781496332; c=relaxed/simple;
	bh=B8KpBZqy3pC97YxiknXglJWsMAZBDEIxBmMupYgIfs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMfVvna2kyaaYTDm3FmoHz9r8gAtaIKo7FekfpFx3hwacS75W+Yg1KfHrJzlE7psagMAG2cF14ILpwRuHgKfkZF6dIrSXsStnRrNvryiebB4vj5/ah9j2BQB6OzNSzspyGdwE+QemgtGE2h5v2DEKykS3Tey43GRp8RwJcKcBb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s0D+96Mi; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0D+96Mi"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c859878eb48so1029020a12.0
        for <linux-fbdev@vger.kernel.org>; Sun, 14 Jun 2026 21:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781496330; x=1782101130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Il3yPCA60ecMhKNK7A4W8smtXWdIja1/mHJ4Opu/D+o=;
        b=s0D+96MiD8wYa0S4sNXkx0cRh2ZF9t7u0nNGm6qM8KDrCsVecH/Rym+EQM/xjtSlKf
         oYXp2Rf5cWT3lAU4OLh5vmfSqWH1054j1ttkvH+D10VjV2hvAwFDVStQ66Sn6Yd0niCO
         BpK03yowDTk972FzUa8seaK0Wq9F1ODtzjqTPNKCkboxKtMekOwMJ4flFPPpjPkLfCvD
         40yS3aHcSjNwKyOiyDN4rjoMkemCeJAKi38HNjtFN++EgZLt8o6xg0b6De2UWJaNQzo6
         iQT4rN3L/RkWHWJzo6Z3KvFglYJuM2tOqwhypVcGty6z1CdrsCyTqLCgm90Mxve4AXV1
         71HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781496330; x=1782101130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il3yPCA60ecMhKNK7A4W8smtXWdIja1/mHJ4Opu/D+o=;
        b=KHaXVwhXz88JPIf3zavu86M7op+QYJnltpdfXQFLLBm6K9dooyTIeObwSB1YSCHKk4
         YVGkkbWRM84qMldzcZdMJtgQErQHMy6ReelMd4o4w6V85Ugcbfgrb9/a8yZC7oNb6bat
         QZYD0rNvLqnyL5rC4bYiHqVErAlW/I+ZI8A1fUOY8WiXs1L2S2xYLvj3t89YldaeEzGT
         qwFtMBRd4s3vTkPwZS6cJwZMd03HTd1VKgIEm1E0TtXSn0FkrcdzLJz37iqb0jzVnw3C
         cMS5nvPATvXDoRTKab5j7P0EXWfGgJiD5v08D+ArMkv0FVSgQeE/sQeod30yAOC+E7W2
         GEjw==
X-Forwarded-Encrypted: i=1; AFNElJ/E4FQCUhWNSBLPDKplQvzAiWwTsKvvKtxT2hKRYD0UdQgg+E0QBXP5kzXenHP66myRL9rFjirrRq618A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3nnv0Ff88EIDzM020RyIbf3w82FjBSBHQmXXICcK9d9uSXNi3
	mF2eTBpUd29MeACSnK5nCs2bQvaBNLjVlkx+p6Wn0fXn9LXOfvGmvmV3
X-Gm-Gg: Acq92OHkqgKcGtwEd2OHxXy4qBmaiZ30JtldBQeJTm4Clgk0ZeBi5leWiq/FWWDyb6f
	sLjdCyC7KblPprsfR3EB/nfIIm4huqkcmIKJCjOLr3BcKL/qXoZFLzLEyhhZa9qeaG5D/3xVozl
	MRGtfRkAkieVtrjTN1ALZKLRBXV7wvNi1T/ZH0NibayN4xyVmK9X8MwTeTC2Yq7ALaNgYkLM1F/
	uU2FUEYLn9eJqVWiSRufEFjZDuM+wY9SOueZ+MqAWrlBUKZBcOTDkVlaqsF9usIWbYbR0OHMEVL
	JOAKUffT5gn8arxsHrs5j19MdCiB4wgcxZcsCLKNaFIayOsHUdJdxGGzMELrpDpG2qLNh8Fz4Jg
	nlj8Dig7O4zF+q4Y4+oOJDDwoL+y5FtSZmnlT/3I/nykfOsvmMKu4Zd9jKMaZEz7eNT5GQAMUnP
	7rHTKOVvvOP9MgQLpxThl+kbXWNVpopIeBrrX3I9nB4HCmvuO/iwvfrDDZUq8wPIqzNCFV2zP3G
	HezMoVAtAaIzGbFgmVt1ArOOKYLYNkB45blEn9EtwMrAeJSxSCWDjWaaiLaZ5bzuFjwwv0Bp68S
	DJJikhl72y7LhKGK
X-Received: by 2002:a05:6a21:7107:b0:3b3:2703:115 with SMTP id adf61e73a8af0-3b79625bfbemr10526987637.16.1781496330174;
        Sun, 14 Jun 2026 21:05:30 -0700 (PDT)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:e093:9ee8:780e:953b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86651adc16sm7044892a12.31.2026.06.14.21.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 21:05:29 -0700 (PDT)
From: Chintan Patel <chintanlike@gmail.com>
To: linux@armlinux.org.uk
Cc: deller@gmx.de,
	tzimmermann@suse.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH v2] fbdev: claim Cyber2000 SPARC I/O aperture before ioremap
Date: Sun, 14 Jun 2026 21:05:10 -0700
Message-ID: <20260615040510.9299-1-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Claim the memory resource associated with the Cyber2000 SPARC MMIO
aperture before accessing it.

This is part of the effort to request memory regions in fbdev drivers.

Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
v2:
- Use pci_err() for error reporting instead of printk().

 drivers/video/fbdev/cyber2000fb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 2d12f8e96c7e..0b362842cab3 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -47,6 +47,7 @@
 #include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
+#include <linux/ioport.h>
 
 #ifdef __arm__
 #include <asm/mach-types.h>
@@ -1620,9 +1621,14 @@ static int cyberpro_pci_enable_mmio(struct cfb_info *cfb)
 	 */
 	unsigned char __iomem *iop;
 
+	if (!request_mem_region(0x3000000, 0x5000, "cyber2000fb iop")) {
+		pci_err(cfb->dev, "cannot reserve I/O area 0x3000000\n");
+		return -EBUSY;
+	}
 	iop = ioremap(0x3000000, 0x5000);
 	if (iop == NULL) {
-		printk(KERN_ERR "iga5000: cannot map I/O\n");
+		pci_err(cfb->dev, "cannot map I/O area\n");
+		release_mem_region(0x3000000, 0x5000);
 		return -ENOMEM;
 	}
 
@@ -1633,6 +1639,7 @@ static int cyberpro_pci_enable_mmio(struct cfb_info *cfb)
 	writeb(EXT_BIU_MISC_LIN_ENABLE, iop + 0x3cf);
 
 	iounmap(iop);
+	release_mem_region(0x3000000, 0x5000);
 #else
 	/*
 	 * Most other machine types are "normal", so
-- 
2.43.0


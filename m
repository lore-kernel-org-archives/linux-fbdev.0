Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F0748F;
	Fri, 28 Feb 2025 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726621; cv=none; b=fFxaKYdYoamyQAkVNh8FxA3V6b/9trAAywwcrfBP7ozHsHo7VmwV6ceGVL/NAyWrTmYtIp+Y969lxGINw0Q+okAyt92GSW2gbG5m7db0UM/tlTfP9zYD+hmpuMoG57Bh97qkIUwJNhGQoZpqojblGuu84ZX1UkspSPKzjYTNqlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726621; c=relaxed/simple;
	bh=DCd0I/cVPewufc8cgvPCOtcy/0V6+cNp1IwfSlZ1nyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g/kUI8lDkDVPJAgpz4Xx2eup94epg7ztGdVkCNbX2/GsCwXXcERZp87fbGVqkVh2yxqGv+2yceV69tPLOkus9RTsojh0PSLuGNm/rk/ia6Pn0CUyFZLxpbb7UpRJ+kwvT1tOCfXzBvdmmL3GNgNCQU+8GSYYJvVGge6/YpfamXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9ZjY+9K; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9ZjY+9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740726620; x=1772262620;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DCd0I/cVPewufc8cgvPCOtcy/0V6+cNp1IwfSlZ1nyU=;
  b=U9ZjY+9KB6hG6XCCqb+gaxBKslepulWfWvW4egHLA9KQ4MVV9bDegi4k
   lbxBa2Hs+4WTSh504nOIWQ93Jsr+1LSVLAvpzY1Oy0wVh1vySa0fNKnQF
   ekEG5ZPh1rFiSklhQogPJgiiCud29ZZ3C9n66D1Ky/cwtjkTpb3WRkLt+
   yacTAfliFanlP+vkqczd3GD+zYChhwZuXLB0+hoW06p1aoAhfJRJzcclb
   7Yt8AhGjoKqJOrfmdjP35vO4Qjuoh9NEV88wEWhB2xmZ/J2huXF34cchY
   FtQBmVvrDPSli4Hh7R1MnkyvQslnMCtFSEoTFLaQ1QzZj7ukkhNfCBwn2
   A==;
X-CSE-ConnectionGUID: kXBVsSAfQ1mk9CDGUrXVkQ==
X-CSE-MsgGUID: NcbAfDmtSYudxpdGlkYsTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41675328"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41675328"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:10:19 -0800
X-CSE-ConnectionGUID: Qpy+oCb3SKqgmF9RCcACRQ==
X-CSE-MsgGUID: 6ou7cYgKT46WlAsCotsgRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117780392"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa007.jf.intel.com with ESMTP; 27 Feb 2025 23:10:16 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	andriy.shevchenko@linux.intel.com
Cc: linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2] fbdev: pxafb: use devm_kmemdup*()
Date: Fri, 28 Feb 2025 12:40:09 +0530
Message-Id: <20250228071009.150971-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup() and devm_kmemdup_array() which are
more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---

This depends on changes available on immutable tag[1].
[1] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com

v2: Split patch series per subsystem

 drivers/video/fbdev/pxafb.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 4aa84853e31a..ee6da5084242 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2233,32 +2233,27 @@ static int pxafb_probe(struct platform_device *dev)
 {
 	struct pxafb_info *fbi;
 	struct pxafb_mach_info *inf, *pdata;
-	int i, irq, ret;
+	int irq, ret;
 
 	dev_dbg(&dev->dev, "pxafb_probe\n");
 
 	ret = -ENOMEM;
 	pdata = dev_get_platdata(&dev->dev);
-	inf = devm_kmalloc(&dev->dev, sizeof(*inf), GFP_KERNEL);
-	if (!inf)
-		goto failed;
-
 	if (pdata) {
-		*inf = *pdata;
-		inf->modes =
-			devm_kmalloc_array(&dev->dev, pdata->num_modes,
-					   sizeof(inf->modes[0]), GFP_KERNEL);
+		inf = devm_kmemdup(&dev->dev, pdata, sizeof(*pdata), GFP_KERNEL);
+		if (!inf)
+			goto failed;
+
+		inf->modes = devm_kmemdup_array(&dev->dev, pdata->modes, pdata->num_modes,
+						sizeof(*pdata->modes), GFP_KERNEL);
 		if (!inf->modes)
 			goto failed;
-		for (i = 0; i < inf->num_modes; i++)
-			inf->modes[i] = pdata->modes[i];
 	} else {
 		inf = of_pxafb_of_mach_info(&dev->dev);
+		if (IS_ERR_OR_NULL(inf))
+			goto failed;
 	}
 
-	if (IS_ERR_OR_NULL(inf))
-		goto failed;
-
 	ret = pxafb_parse_options(&dev->dev, g_options, inf);
 	if (ret < 0)
 		goto failed;

base-commit: b8c38ccb2ca52b9a38cfeb9f89abab5d6e713221
-- 
2.34.1


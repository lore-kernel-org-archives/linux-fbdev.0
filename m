Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6DF32C8B
	for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 00:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085329; cv=none; b=o7wCxBm48MmTmphSclwWiLtctpgEZwrWz7jawQ3hkDO0Yh1/Bw1rGjXFT9nn+Vq7KFvgZs8KpGoNronkIadfExNA5Qh/uyz85A2IjM0HYROJtVp/cbbhOCm1X3kaxWPfk9zU7s6ZZY68RcMP2JZK3VbHRkGvM1U+h/OZV9FMGKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085329; c=relaxed/simple;
	bh=v2XJNi/Y29xgo2PM9yU2/1tfHLxfQOc8Xy9oLXfuIbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nsfac28nKB4eTujwSTZxIabSYBDHpo1CG5nABX5K+KM7F7YE5Tz5Xr7sFYMsINeGKMGBUCPICckVbBDl19LuMzjmO8BJhJfo+2pNufIQ6BncoZxoQgPHVBDpPruwNa5xgbysd9SaePwyfd9nft0Erv5GfTTYdv9En9dAcUz12A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ton5mef0; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ton5mef0"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafddso26806985a.0
        for <linux-fbdev@vger.kernel.org>; Thu, 10 Sep 2026 17:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789085326; x=1789690126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bSaMAuaPgc7+sGFbHWGL+A5HmSLpypXBziPyfL/qmaQ=;
        b=Ton5mef0H8KvHg31LiINad2ZtLRH8lkVKFPf5kVkXqOQkb5l1LPVyZlVN8T5YRvodd
         9veLYeMgdO+q/MpTZKyQQF01MBMT18EFFJK1oLtaj8AMQb0RsC2n8zcZiQn5ykBaUVYK
         GlZWx733ZIttDCqUhG0rcWQmbnUe1ne86BKWl4JyFYACyQkndQloOxl6+pbgh7YiJIAi
         m1Kkqkj7hH4EOwZfAO4x81PnEHS7C3sbdQ3uvLEXKkMTQShMT1jAYQE4q3LItcmNmBdd
         Uq9eUUrFH/MJ0AzuF93zGxUhB1ug80nPqITY4OwuzmDYD5km6dYFsBylzOs8HybYGACv
         NJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789085326; x=1789690126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bSaMAuaPgc7+sGFbHWGL+A5HmSLpypXBziPyfL/qmaQ=;
        b=LWC6G4PiOQ2ztiIoVb2LaVOkQwWA5xLxDCsCMvdmyAupkP74NqLyTID5rHoLiY3tZP
         U7Jzy1DI06+Of2klMUkjzYBo/l0fXxbNKXLZJLaBpTuamHSKPdptowuvs3DI2dhPyo8D
         haXeDnB6w+kqfH+GKUXjp8aboVyBvybxQmMIMSmgT5nnG4m04E919wQAqxWdvHNt8uho
         wLJe7cFJlcYCA24TRgXhjrWDvibJpro7fHf+WYmNmB9vB4JofrClayKpQtYTbYtRtKZC
         3aO8Dwei+qy1vDDBy10MV05Khw/kuwqR63C98QJEKRjqFySZ6hi6r5H64wSz/CjZ6R1R
         mBmQ==
X-Gm-Message-State: AFuF++kvMV+oSrdUqDvj6B0NZXyfAmVu+6vTp+D7b3pEkZUqKYcqz63f
	DG69hWdseivgPDArO+AOZ0xjSkZtumlPwNlxU22mM+N6TPMl4tnIEds=
X-Gm-Gg: AYBFou2Yyll0oGi8xfwcvjl3J+iTr9mPkT9rTIl4iHc5elEvnyfXHG2sa079vWNWJJG
	7LFtWYJpG8qC/++ROOdCgDuaFYyz6jqrIYCJWRIzudQQrnWCW8fS+yX3lU9M7qT12nzZvhavIyY
	REwfe40EOtTj/jtoePJGA41Ibk0K2zstALhSLWCfwA/Wab36p8kw4k0zAi92hIO9WvffSIszKSd
	ObiaKC0K6A7q9sRiMGxGp5awbD2pVZIXwiD84UnjW+OOmoojs5MV199YI0+tdw/uGjFLQ6kbbWR
	sYF3lcNxJ3CfZN6nKj6n8eHJ7LrfaRVFyiWzebo8fqd2k3ssz0jeE7s+PvK2apgY/a/V4AkfPCJ
	wmXxYEdvbtimbhBKMTAnPmF0XAqin/awSzutYwci/tk3wQbdFdi4WCKTqROOmohqq6ZTNHGXa3L
	XJBuN8CQjg5S0vGwNa1GQ9WJefXBOLsKi7dnp04deJSKB/rt+pRTvHIErz8WvM61M6Uoy5et6b2
	n3g8oWmHhWhwUrDbHm6dS/8mvh6pmM/HhJGPz/w0B/xZ5Tb7UxnmTWqBaq/xubLiWhMP8bCM1jF
	60mBiV9McXWQShLSeE99Lf7car8pxf9tqU4=
X-Received: by 2002:a05:620a:4409:b0:939:191c:cac7 with SMTP id af79cd13be357-939ea0850abmr180782885a.13.1789085325637;
        Thu, 10 Sep 2026 17:08:45 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e811cffdsm106263285a.46.2026.09.10.17.08.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 17:08:45 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] fbdev: sstfb: use managed PCI device enable
Date: Thu, 10 Sep 2026 20:08:35 -0400
Message-ID: <20260911000835.88909-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sstfb_probe() enables the PCI device with pci_enable_device(), but
failure paths after that point return without disabling it. The successful
probe path has the same imbalance because sstfb_remove() releases the
framebuffer, mappings and memory regions, but never calls
pci_disable_device().

Use pcim_enable_device() so the PCI core disables the device automatically
after probe failure or driver removal. The driver still releases its
framebuffer, mappings and memory regions explicitly.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/fbdev/sstfb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index 2ea947f57efb..0496b9d5ecc4 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -1332,7 +1332,8 @@ static int sstfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return err;
 
 	/* Enable device in PCI config. */
-	if ((err=pci_enable_device(pdev))) {
+	err = pcim_enable_device(pdev);
+	if (err) {
 		printk(KERN_ERR "cannot enable device\n");
 		return err;
 	}
-- 
2.47.1

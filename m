Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE44175A7E
	for <linux-fbdev@vger.kernel.org>; Mon, 20 Apr 2026 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776646894; cv=none; b=LTAIzDv1WpfArXN2vhV0HjFxcCtcfl7grfIbLYRfQs2eJVy49sZJU0dSj3ZAmNrawLusnCHDSxGh/e7WUpndgNqWaQkWrkNtPR0kfuT3W/4Yqj7iif7j25SWzLI5HYkaC4E7PcjrzcIxCbtSDz5LC5WHh1/YgxKa0laDu4oioHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776646894; c=relaxed/simple;
	bh=CAFACS5bc7bNOjL5ZrwKpBgULCMFmthkCdlQILDVQP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EsOEk0FjGYg43fWNv3E24XGqKpxBL0zCCRqyGdsCoas62nIrbU9Oy3rY0Gi9NcJ6hRZG6/J6sNABJhtAvL9NJQoUnw6N49vle5FKo+rOSGYdYLGwmn21pyl/FdBHing0QBQe7tuqY/3DMtaAGyAgd1YOUNnqZs7Nbdbd5SivDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bA1eIMk7; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bA1eIMk7"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-613207140bfso817006137.3
        for <linux-fbdev@vger.kernel.org>; Sun, 19 Apr 2026 18:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776646891; x=1777251691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cExEE0g/VkjWFezfORG8uwyZglaid4Bs+rAW28gYyow=;
        b=bA1eIMk7KL5A2M36QGuPVDOcJ7p6HC94JffrgYzFJYBwPItqN4bm1nZiQt3a/68uyl
         9KJKHMXhe6tmud9IfmI2i59u8zviB7RaZv2rnxyTzQMisXopDO/ypxgbmM1/tGobzd4J
         4e/HB8lnHHBYrgZaWYwNPZjpZ0EFv3IFmz7unYIBJ3DoJVeExuG6ZrQ78gmiZELegesl
         Bn+4O0dFbzeC72AHWmk/O/brc3URqdAMBmJbmvyVd12K5MQuhlWPgkkZYgqf/6LGEC4x
         w8naRsPQMOyk0rYiWddcoTikiqnBq6pD2k1POKg8BItPNGtyItjhH5MLQ18nGYhAfDXg
         UkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776646891; x=1777251691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cExEE0g/VkjWFezfORG8uwyZglaid4Bs+rAW28gYyow=;
        b=c0P4DCTbL/xETuBmwPXmQnpOzwFBZ3+YeapRLDgGZOsA4PuBws/mF5RE9QbF3c/NOb
         q40tKoBsRrCEmb1kqzpvYzii0xBJBA/9zxVPXwzoBtATdDb1O2wMaH3DDt/A+T+hp4+g
         KCqzfgggtEiq8TpOSGzX6+z9+PvBboMBzn+IiLtG1sw1ekza9RhxGT+rG/mnA3d3r5F2
         oXnoFUJ8hD8XllmSVrQeGPlBsdrO79hIIuhHQ/j6yCEEoZ276gpqaMLE/aKEtostNPFY
         tNrCh0WHOdyHKsDq1uKLcJ6aNMR7cI6/mo69KeU/K5k3BG3DCK8Xexf/htKkfiGtha+l
         wCxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rRFD8+gLAf5gZ9Nw4kRLOWHk+rID/kwYdLpKJUkjzTRufenFi6KkiF0iWgqQvbBac1t66dfrLGUdq5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJvSOVp5WU2+ZzwARtJaYwo9jQklHammnBMDyCH8ozjFLRRiaL
	ZpPu4VmjOTFsH+NH6s/kahlF0SvMyuaWe5JTrM/HMSMep8NHOhUm0boR
X-Gm-Gg: AeBDiesNrbnMYSOtoUcWhnzDqUCY1XuIC/DVPrjnTU5eM49ftSdQ+H5tguYJqYTmBOO
	v/A4a3rvcKO7Qa5iJHe/X9Q19f2QWWUM+vsjr7sjW0uIXJ0B04Ialw9QC1p+RzkbJ73cAd/GeZi
	Svm7AxMH5vKG5AT7CfUjDzd61MwZigyfI60Bs8N+3uT8FIsKH7tPR7mNV6Pg1eNaPrGZG7A4nfv
	ALW7f2ta7mM1eEPDf8KPubdFz0SuMpCFmxGvXfFTbGYQIfK+QmXegdymX1SUJX2c309z6/lS1/G
	46yCAdjTc3gf0wzOdTOrRFtIt9l7hPuCBvtXQhkGhuQZRoekhBG1IfxEn1oUkUcrUS+Ve//j1eC
	swV5U13pURBzEdvnWqNBVaG1o8z5F/n+9z8wy/8es0t7tWiXIZ9beK4dOv8YkMSHJtfOvcuZ6o2
	APwI1POo9/c+2Nf3Lb3kGYR6R8rw/3kSghLoFjQLUEDhYqsquW4K0KDubvT9Y=
X-Received: by 2002:a05:6102:6c9:b0:607:f24a:1bef with SMTP id ada2fe7eead31-616f60b3913mr4269910137.13.1776646890798;
        Sun, 19 Apr 2026 18:01:30 -0700 (PDT)
Received: from localhost.localdomain ([165.85.38.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb9becc6c3sm44376885a.39.2026.04.19.18.01.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Apr 2026 18:01:30 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Jason Donenfeld <Jason@zx2c4.com>,
	linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Taegyu Kim <tmk5904@psu.edu>,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] fbdev/offb: fix PCI device reference leak on probe failure
Date: Sun, 19 Apr 2026 21:01:18 -0400
Message-ID: <20260420010118.17960-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

offb_init_nodriver() gets a referenced PCI device with
pci_get_device(). If pci_enable_device() fails, the function returns
without dropping that reference.

Release the PCI device reference before returning from the
pci_enable_device() failure path.

Fixes: 5bda8f7b5468 ("video: fbdev: offb: Call pci_enable_device() before using the PCI VGA device")
Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/video/fbdev/offb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index f85428e13996b..166b2dff36f59 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -640,8 +640,13 @@ static void offb_init_nodriver(struct platform_device *parent, struct device_nod
 			vid = be32_to_cpup(vidp);
 			did = be32_to_cpup(didp);
 			pdev = pci_get_device(vid, did, NULL);
-			if (!pdev || pci_enable_device(pdev))
+			if (!pdev)
 				return;
+
+			if (pci_enable_device(pdev)) {
+				pci_dev_put(pdev);
+				return;
+			}
 		}
 #endif
 		/* kludge for valkyrie */
-- 
2.50.1 (Apple Git-155)


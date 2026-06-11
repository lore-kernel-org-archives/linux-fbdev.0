Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8D331ECF
	for <linux-fbdev@vger.kernel.org>; Thu, 11 Jun 2026 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149986; cv=none; b=ZN1JKb6b4MHeW8CR/eTXwWoxGhFBHlr2oKvaJmXqPGKJwHUC9/JB3uYdM1lp2m0KXiDKLMP4DVgCYVEZnj0pq0coK0eJ7FztZONRfJvG2LBZovX66Tp5bMf8/3+Y+zNlXKOOHiHL1v4OkDpvSu2zgY3A6n4jdHX9ZHlccPvH+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149986; c=relaxed/simple;
	bh=J3cjpUXt0gbpqgODBiZhOxcRUP+t1AJfgHhw2YU7dmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGDt7xFCB4Fk/T3+oBf2HDEUKAAkb4/+Zf7ZLM/CXLvtM0+UWda0xGdXkA1Eqky22wAnclnXbCXU/6q+AfEnirvHSkNBzjp0ETwAbRH7hHPm970G9QFSP3Y4dhiT5gq2LJwBgYwI0WVC2s9Pvv7foYXT2IqyTn9LcFFs2matFEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVYVrVL5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVYVrVL5"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-842273a2c4dso5115537b3a.3
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 20:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149985; x=1781754785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nuLe52twcTi+x/X3rOvTkNMFrTH5BVuejVrED6FOMYc=;
        b=fVYVrVL5YFjdAyt4dQuDStGV1aREsSP7emzdyAJOapEUmPqxqpr1OvoEr1pVESBPb+
         WlyGf+8YHjIsYkHCWAcgJpzvVvOOkdZg/lZIhHcEuU6I/UfmUDSO04kLuH2ZEvDyAQYR
         m9vdQp0aa4Dl/zJLMnLkBroxaTRwE3HE5htx+4wPi7psNFyOFbOnQOppjROktr/BKWek
         dM9vL0H3Y5RtfEZ2GyPSq/1/2DBR/pdxlUFN9t2jSgI0A2+rW/734LAlmxkZCRFxPtTo
         VJ3XnyyKO+kMnn+MJN1RnTcn5oGcjnTFrWhgQWRnkKk0lWdRmIfF6aOW0nP0jOdOZFLd
         pfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149985; x=1781754785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuLe52twcTi+x/X3rOvTkNMFrTH5BVuejVrED6FOMYc=;
        b=KMH6ZhFV73si8yNYl464erVRzEmGVwRtLP9ka7yo6p4kIza21vfS41qZ4mMp7dW4qY
         Lv+76Vz0S04Uxsb+cTAL9keEQwkZY+eS/AAE/0kX+b8CH2PLFT3ZhfxI8uDzNdejuTjJ
         oFIhINqzZZ0BkmB0U4Rrlb8itzTCVFlvZGOV9ytqVnyazyRCRRcO+wyJOMWWEJvFPoiB
         taHDCY3D6W3YNMYd6WPdpMNQJHjtDGt8YZEfSqiC3AGSkkcC8tkHBx/os7+vI1nkqqqk
         wgK9m8P8mXcm5lE/S4z+ywBXvnBPtIOFJ9usgsw4y+QZKi7hMTa2xPK4WF7z7nxRk4jb
         1nBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9Vpaci/gwrV1YZ5JhfGfu6hxkli3A6mWZDPdlcjad8DEeTgV+xfjr+5CQaKqiwea+OTHTyUyUIkw4zA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkA7rQiqde7cQ/2Nmp5WkOrNJllrZQIEAM8Qp05tjm+WLowlML
	ePeTdJGAXNWmN+ulQyCBo9EEOOUvUUAxdBmuHEV+Ukofte7bZZCjjE73
X-Gm-Gg: Acq92OEc6T/N3oo+KRzI/cwPt2tvXEit7NiyFUzqOwtnO5f1H5chKYimY8XcSokAXNJ
	KhCjEC49iTQh5XtXfmFIYQkZqdJqJvHW7EnkbF+sb1r/ajtgaJfk1dp+qg3TERc/bg1a9jMPIOU
	U93WpS1hgUBGnm2usBT/KpfsXf4iic9ekjIH5VYfdYilf6llJgX1sUVlKGFLu7HIOV5UQnSO8DE
	RyiOwE6n228eNH50i+wLhGSmiu2sQao1g3pO1Kijk5Q373tmdgmw2cucrq30fQgvOXG8xMZotuW
	DJpuiW09uKP647WEv0WeUfVTLToBUR5mwVnQWqD+36JZUNb3Ko4WTUt7onpFOssZC2FD/iRsuaa
	G79Rq/xiilWiYsRdixkLNfCx+NiShGCmDBukm4eBwN3v7/+rxZsehx8NKNXnkmOmsQx3P9OSLHT
	JVF7RE8kGIO7xHZZsp7VGCHagjr1WhF93iNmsz4AK3CtVl11P5LkuaUCxs63VsB5Os8RTJlSUzr
	4bKIqYUQFTRRoQaSIi4hMgH8JeePr4fJEdQ1rbwKzLjO0ddU9vtpZdfhGk/BUKgrxUwgZZY3Jos
	zjLCyylP4NW5oRKCYghx2a5Vhws=
X-Received: by 2002:a05:6a00:12c5:b0:842:6004:3fce with SMTP id d2e1a72fcca58-84336bba668mr1064103b3a.26.1781149985157;
        Wed, 10 Jun 2026 20:53:05 -0700 (PDT)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:5dea:bbec:bf0c:d151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bb6cb2sm380130b3a.15.2026.06.10.20.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:04 -0700 (PDT)
From: Chintan Patel <chintanlike@gmail.com>
To: linux@armlinux.org.uk
Cc: deller@gmx.de,
	tzimmermann@suse.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH] fbdev: claim Cyber2000 SPARC I/O aperture before ioremap
Date: Wed, 10 Jun 2026 20:52:42 -0700
Message-ID: <20260611035243.16192-1-chintanlike@gmail.com>
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
 drivers/video/fbdev/cyber2000fb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 2d12f8e96c7e..16ed56180ce2 100644
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
+		printk(KERN_ERR "iga5000: cannot reserve I/O area 0x3000000\n");
+		return -EBUSY;
+	}
 	iop = ioremap(0x3000000, 0x5000);
 	if (iop == NULL) {
 		printk(KERN_ERR "iga5000: cannot map I/O\n");
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


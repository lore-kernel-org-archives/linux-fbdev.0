Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4371357CE4
	for <linux-fbdev@vger.kernel.org>; Tue, 12 May 2026 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567721; cv=none; b=ST80w/ArsJGD1J/RcP0BRuh/axzMpsQfbrrhEv5uwWMFmJFDerwTG7NI/yf0dNK/6eLg1hWaYyRyLBt7hDRunYntmrHxh/S0pSajOFvtKIC7Sug+IVl4zxnKRZ+6sJXm/wDxNv7U4eFKYOKCj65imfAFnyOWexJcJkL/xgJxt4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567721; c=relaxed/simple;
	bh=CQ0Pqhp/4QAbSk8gZsBCYrlwBk8J/VBMcD/nYEp7h/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOmsGmJ/Saj9QSom8/soFSPRznqZa+i4bYeNcPdsYkDAWWyECUT5d7S9PfSrvVavdUynBl+LjWc6K5TlyS9v6qftCI8xSeMT0wg3lz5a1ru8LDu420+TpE2KLdEVH0jxZnrC27g+/zYicH4qI+O74JTMtEPgcexCBynGOd5M0Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQK9GKIl; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQK9GKIl"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f8893bff3so2319740b3a.2
        for <linux-fbdev@vger.kernel.org>; Mon, 11 May 2026 23:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778567709; x=1779172509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bfTIHcuxdABvkVe+pMs5cot1hi6l98N1mvQQvDnmrQ=;
        b=JQK9GKIlWD/Yjc6PPDDmDufh2s1Ec8cD4XAKnjK32/Qq19rbkfncdHKSyZBA8pOApv
         8MIK8w+wZvEtJkbZSuSE5mDtxNI9mWY/84eCUDdm4jYMcWwNcafyGnqLtFFEWKD+KhWT
         p5T12AGL7Aimn1PVfzu+wti8uohznIoUCDcMPEK47t14vav82xufQXUOOOR8GdLCPMAM
         Mqhch1v+7rrW/6iavZrn9hqmYfBhs8y2gfmgHqTUAWFfEY4fuK6Mj51NpbOKodlofP/K
         VOGkpLmd4b0JAgVL5Mn78KT+bk021nTI7DvPEbslDhCY36Q1a81OHU4b74Kvu6eZW2f5
         LQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778567709; x=1779172509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7bfTIHcuxdABvkVe+pMs5cot1hi6l98N1mvQQvDnmrQ=;
        b=EtW/fn4lFlFbTEF6PT9sn0NracMoGP3XAxksCSyzx54lZqrEmZsPTrKUliBKiMPv/a
         BZJvaFrefJnsnWqNvM6+l3Nb0QcnfDmtq9w563H0DFYjOvpZrtsGDmKV1p28ZSgDysL6
         HpkWz7Sw7VgiAKVBv0Ue2QefR+l0V1DjiQpynI+OJbRvPwXsaDvkbX3rsWF4Xqj9EGEC
         cyON9rojYzIBb0nxsidlkST/JNwYp2htD4J5Qz/BnKUxHaI7AEa0gXUWIb8GO/g+wl+T
         B0BlmbK1C1iBE2lHhS/XdX7ZzrRFx6Kr9cjpOZqK06tbA8IXfQBTW4pnRr9JVcw1iK3I
         LqXw==
X-Gm-Message-State: AOJu0YzLd87vn/w7uZ7HY3S5G9eqXSBbqP3y/+drTaqol5ScmKdTSojG
	NzwUPPIXC+Add47JGa5wOd+VCMEyMJKpzK57h2IFmXnrNmAsbS6bAfkB
X-Gm-Gg: Acq92OGk8wO39ohoF1x7+TBS9tm9ocNyzLvq9DcEDZwCDv/oUcLEfoAmF/K2ZDKIn0B
	rPPc+6Yflw6ymjlXtKLdQ/GCSJE33aWzMLdtmrwQ5dhWMqIWjgpwUX3PwlGRq7dTEzKRH9Wsl8K
	L0+vNiF3qYE3ZFbHzfs+NDuTZr+R732Cm+ws1Z7F7+xyKRq5HJgQ8g1KUGj9zaWlntcoMCggBBN
	BZAQxbGCg7Pi+zJYOtrK1ceA+na6qkJ4CTEunDPEs7tFBsIe6MgljSQFylGRY0SXJY/O/kawDyV
	qMKPMt0GAoJnRbK3jcllXIt6/51qLyClJNdHLBGGbLK07eMFYqeJ0JC1Q/cO8X6BCegCeWU1XD0
	a3pQ8OnFbB5+Rz6AA5ZE3qBvWqu2BRaocS/4theWhpVgOWqV28Xm0Il81MSw0MsF/yzaNVAz96P
	SNNP9qDDVEWYff2MyiH45TceotxhgJXMYQR/2RUywi+X0+673ngE0OMwrnQ2M1
X-Received: by 2002:a05:6a00:4ac4:b0:82c:6da7:2d3d with SMTP id d2e1a72fcca58-83e39c3312cmr12860106b3a.11.1778567709152;
        Mon, 11 May 2026 23:35:09 -0700 (PDT)
Received: from localhost ([2404:7c00:52:d485:aae2:91ff:fe57:5e15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbee14sm29994346b3a.48.2026.05.11.23.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 23:35:08 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH v3 2/3] staging: sm750fb: remove unused <linux/platform_device.h> include
Date: Tue, 12 May 2026 12:19:56 +0545
Message-ID: <20260512063457.80882-2-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512063457.80882-1-yogeshdangal66@gmail.com>
References: <20260512063457.80882-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sm750_accel.c and sm750_cursor.c include <linux/platform_device.h>
but never call any platform device APIs. This is a PCI driver.

Remove the dead includes.

Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c  |  1 -
 drivers/staging/sm750fb/sm750_cursor.c | 44 --------------------------
 2 files changed, 45 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 0f94d859e91c..0100fec6533b 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -13,7 +13,6 @@
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
 #include <linux/console.h>
-#include <linux/platform_device.h>
 
 #include "sm750.h"
 #include "sm750_accel.h"
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 7ede144905c9..552fd30e0d38 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -13,7 +13,6 @@
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
 #include <linux/console.h>
-#include <linux/platform_device.h>
 
 #include "sm750.h"
 #include "sm750_cursor.h"
@@ -130,46 +129,3 @@ void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
 		}
 	}
 }
-
-void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
-			       const u8 *pcol, const u8 *pmsk)
-{
-	int i, j, count, pitch, offset;
-	u8 color, mask;
-	u16 data;
-	void __iomem *pbuffer, *pstart;
-
-	/*  in byte*/
-	pitch = cursor->w >> 3;
-
-	/* in byte	*/
-	count = pitch * cursor->h;
-
-	/* in byte */
-	offset = cursor->max_w * 2 / 8;
-
-	data = 0;
-	pstart = cursor->vstart;
-	pbuffer = pstart;
-
-	for (i = 0; i < count; i++) {
-		color = *pcol++;
-		mask = *pmsk++;
-		data = 0;
-
-		for (j = 0; j < 8; j++) {
-			if (mask & (1 << j))
-				data |= ((color & (1 << j)) ? 1 : 2) << (j * 2);
-		}
-		iowrite16(data, pbuffer);
-
-		/* assume pitch is 1,2,4,8,...*/
-		if (!(i & (pitch - 1))) {
-			/* need a return */
-			pstart += offset;
-			pbuffer = pstart;
-		} else {
-			pbuffer += sizeof(u16);
-		}
-	}
-}
-- 
2.54.0


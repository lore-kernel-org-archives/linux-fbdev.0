Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900561DF980
	for <linux-fbdev@vger.kernel.org>; Tue, 12 May 2026 04:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561371; cv=none; b=YH9r++4Fo3mFLYebZeJ7VqivJVdNeE216sk/XwgmkS0L8zFjoUg/AaTXyYJHGnCwlq227/Jtxolf0ByYymrIHVWoIlLQ1okkftxoDqcHoMfsDsUT9UszwuzD8KBrscEBXz5x0RA+jUJvclWQzQ2RsXmpillA2tuTtDogH9rDuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561371; c=relaxed/simple;
	bh=Ma0BSUg9bsTO/AFUYgwKn9V2eUxec5cfDk/klMLGG78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzQcRJUcf68teOC2PcTo36mwO+erPb61Nz30BHiTx7VIETO/XaNyeigPwEKR+Bv22jZ9i1btFYOkST0ueyaufQ5Wc/v5rX9WUu3fF77qrhliEKgrLhwuRq7eDDhtcbf15drOU+z9+BZtW+NIcviSZ8rCRrIy1mjePH7Xre7IFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2IpsZ1Q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2IpsZ1Q"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2baef9f5ecdso28979115ad.1
        for <linux-fbdev@vger.kernel.org>; Mon, 11 May 2026 21:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778561370; x=1779166170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YGtucP5dOBTG4jR9fIrSqVWI8MpzdYIq/BvnyuqHI4E=;
        b=p2IpsZ1Qnl+KmFkv1LBVV9DX2+6kafx67HUz6CKtkrpNGN/gYw8yJohOVaUd7bNhxM
         zT/G/80WhZpZgPMDNULdtcbBquAX96dWNjydnph3svosHd85NRnz7i/pAHEHapCNN778
         My1jWOIuD9pxZvydfDdKUkYl8rgpOy9WvTztCgdPy3eh1P2seGvYrVTWOJ5cH6AklwIc
         d6R0PeGUgsm4RyiPx3sQ/YffPYXcF68aZ9gZ6j/TKy9CtQT2vddfgWwYC/djfXTtv/Wd
         MIS4q2Uucwyl3NB3uRz3mRKCjXdDjDHNMrnzEN/Puqau/P/ZZkFlGBTinVlGGII0C9Se
         R03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778561370; x=1779166170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGtucP5dOBTG4jR9fIrSqVWI8MpzdYIq/BvnyuqHI4E=;
        b=RikI7aTemHiKw7l5fdn0fvq/MT5QnP61GmvWf6uWDPOBjQ5MJ1HBRIZRdC5H2F7DeS
         2MLL5CZfvOtpvIFla4Q9UAoJ8ndl1b28EdlrNBzpYXGlrrOb6YAAj7NCHU1QIEfYzhUx
         m66Yhbg/A4fFEgjwQ6dx7XKDXjMC5wMn1N8NmaQ7VzEnDjDZiUxySDOV8m49gPx6XYSz
         LXjKPdwda9Vc9V7TtwgfUIX1JL2b+DKxhpxpDA+oRNZy5lZ3FSb4DL36ck3OjEJdjEL7
         7IcKSr8mhrGSL+2To0qB5GcNNDgrSPTftRiaSCjawPj1uro2Yb6eytl/Q6xzAndrDhNE
         m2KQ==
X-Gm-Message-State: AOJu0Yy3IUwhDpyEKLC/1WeT2kpk9gYS7TmOy6pvuU0tG5rTiSpOFFrx
	bge0n8QEYAMtH36wt1Q0kZLwjPxS7w8pIx0PmR49cb9fs0vjpWlyxJdI
X-Gm-Gg: Acq92OHij6R1sqOFpl6wjfBOsuRdxY9E7xHveDCCgq+pWDg6M2pDHA4J7710/NJwW3c
	Tz+3UDhFulaecsgucZGcNh9S3piwbMHSUN4aSpfP0CAndUcNw2/sb1dObn56+f1UBYDhwcvOaf8
	ftSBbgErZ+2qEuktdmE+wFKUdqtw5rAiYfxQ+w9yqJHsN3NoFactyI9tX9Mst1j+L3e/oV/z+ka
	tUL4FCOb/28Jh9b7Y8PVPej1MVq8tCmrE1FovV45+xvixdneSVWMcau0ZEYkiXt7M79bRWCYrXd
	oVJ9BvikirREONPyQuKw1F9jMNq3Jn+aUO6YVPLW/pzNPKCGHUEWKcu3XygrhbOBxzdNVtrjZbQ
	3yQZLZ+KQHPWp3G3MquKevxLUTxXxG1iMlWgRYLadOKyTrerFUbWo4++sQ3M8xTvpl0KEokyUE+
	yiP6O4vbr7QZ/LCMwihJPE45QLYmkIAkRFAm39fxZBGvsieOcoS6fDUFYR2IB8s1j7zDFnCNQjE
	KU4
X-Received: by 2002:a17:903:248:b0:2bc:8ebd:af76 with SMTP id d9443c01a7336-2bc8ebdc2b7mr115945355ad.0.1778561369949;
        Mon, 11 May 2026 21:49:29 -0700 (PDT)
Received: from localhost.localdomain ([2404:7c00:52:d485:aae2:91ff:fe57:5e15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2700dsm123919925ad.2.2026.05.11.21.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 21:49:29 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH v1 1/2] staging: sm750fb: remove unused #include directives
Date: Tue, 12 May 2026 10:32:31 +0545
Message-ID: <20260512044732.56417-1-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sm750_hw.c includes <asm/mtrr.h> under #ifdef CONFIG_MTRR, but no
mtrr_add/mtrr_del calls exist in the file; the driver uses
arch_phys_wc_add/arch_phys_wc_del in sm750.c instead.

sm750_hw.c, sm750_accel.c, and sm750_cursor.c all include
<linux/platform_device.h>, but none use any platform device APIs.
This is a PCI driver.

Remove these dead includes per the TODO item to refine the code
and remove unused code.

Tested by building the full kernel and module with CONFIG_FB_SM750=m
on x86_64:
  make -j$(nproc)
  make M=drivers/staging/sm750fb modules
Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c  |  1 -
 drivers/staging/sm750fb/sm750_cursor.c | 44 --------------------------
 drivers/staging/sm750fb/sm750_hw.c     |  4 ---
 3 files changed, 49 deletions(-)

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
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index a2798d428663..f491d3aca468 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -13,10 +13,6 @@
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
 #include <linux/console.h>
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
-#include <linux/platform_device.h>
 #include <linux/sizes.h>
 
 #include "sm750.h"
-- 
2.54.0


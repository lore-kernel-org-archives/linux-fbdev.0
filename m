Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA442B747
	for <linux-fbdev@vger.kernel.org>; Tue, 12 May 2026 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566258; cv=none; b=jRT5TC1nuZ9czlzkFGuuSHWkoq0lCppPiE1fvGqmd3LDy+HbmdVIIlGzFCgAiTcMIrfvu9UAFy1tOcRGzaAcsuZKO7CLHJnpHpWY4GYfpOCTWRKA6o65mH9MeyxDKYZFAKPe2kD+Bcpz8XX1ziq9qcUNwLE/uL8wD4t9PxVcvdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566258; c=relaxed/simple;
	bh=CQ0Pqhp/4QAbSk8gZsBCYrlwBk8J/VBMcD/nYEp7h/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMK+XK+d7tVAuSVynYR7MTSac9IkwYA7FhyxKBIktZFnBDq1DB4FP7DoDTPDxa1fDmwB02ee5hLQLu2flRmb8FSBj6ry+fnDxsIQPRboVVw69ImiSw2k6MhMF2kRdwfHpjcSlJ/m4HMXZVQaf/nj6ptvef983u7r22LBWdQrmCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idxygRlr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idxygRlr"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3667cf0136fso3340119a91.2
        for <linux-fbdev@vger.kernel.org>; Mon, 11 May 2026 23:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778566241; x=1779171041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bfTIHcuxdABvkVe+pMs5cot1hi6l98N1mvQQvDnmrQ=;
        b=idxygRlrkpX5HGhligrNM4dVh8gX24fzGHsihSL+Weh3qarQZH0mNtZ0KTEXYoG2Lf
         ahxSt+tv6xbWIuvGjFKE4rJKJbCyKv6CxvD7dg849AmETK/q4Eoj36y4XnQAEviuZJBJ
         vy71OoTZbX8yRwVWBCwLKjiKTXdcJfps2C44KcsgSfhiQI52Z1dNhIRhJQSqomL/fr2+
         IwsRKqkyWAXYKjKJfHNZdwNxrU+hXTaQmNtOIE5cwj48BKLef0JTxWFNCWyCu2XZ3TuE
         W/siqSahmGYH6Roh20S58qgmF4pU1dcHbnJQeyedwm/5OAgQ8L27XBwZ970urAkBEOeT
         RaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778566241; x=1779171041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7bfTIHcuxdABvkVe+pMs5cot1hi6l98N1mvQQvDnmrQ=;
        b=VCJQdMpQFm+UVi7w1N+L6A5knabEzTbF9S1sG2gAgheOXcp+ACHfXOA3HJffuyyk6H
         NU88TBL/LzVYyl3BvJxliNQ0qf3AkK2ahDxNwoqW71UiIJvoKuuLYfZglaUU+iHvxv7m
         14t+wpoGYucWLjJjHvbQiZCXiIPwu+h4TK8vUWuXnMFYhxkYmslapBHYnJvN/9oQkk7V
         xnFItAwSnNc7Tp4ZmNsGC+ua1artVEd7B65GtlnBU1ZBiGQwlyHOz5uqOaDmTJeaeOqr
         ZPWaE1KHsHWFX/siu5sJHQhDXIaP7LxlUVCwiq8qNOQ7rmhUn+oPEOp/CW0HfpVzC3Pb
         GHRg==
X-Gm-Message-State: AOJu0Yz8ADleaix2OzhqxUSRQwvZD9CKHj/zAwlZ/YR+MKyX3fPg7wHy
	I+QhSqCW41/ZzDJxoKTQSpHp4ri5cwOyy/lBVXzL4V+WFHRW8q6MV+7A
X-Gm-Gg: Acq92OHVa7dM6caYseIzygvVENFYxLEXW3jCuHIHegEkk9Fo8x5EoyQCRfZ//+/4X6H
	nrHsyiEs4EU8lPa85biB1tgNv7KXo+54+M/rXBXW4CEwxKT0T4/5KoxyQc8Zgucnrldwp+cvCwR
	26wCNrMMTbTFC5KiFp2fQnU+RhRSVxuHQgI4YHw56VvSoSej0ZmUrufg+0MZ68kvsTq80KX7bSy
	0Uo2VEYEKGShDjBJNDO3ofswLtC6L9tEXKprzyfk5khxlO5LcHkyK6AOvNNitsoizrvXwmbLMmg
	aCYQuKrwzDPKGs749GAVAaVNdZljOrjnMUaVbvZGoBrFiPz32sBIhEb2L3WrVdlWKX3MJLewSzV
	41QLKMuRW8rpzeQjBHYJY91EV75s3fUD0/l4KVNsOzglqJIPYV9aazc+NC36LFu3x+7I5cRPixA
	z+YP5xqU137j1JzE+7zaQhiFHtwb9XjU4FbnpTwSehdENMmHULSumIIUEMIUjlsFs5TinEu8qXE
	eit
X-Received: by 2002:a17:90b:5744:b0:35e:3b08:8fc4 with SMTP id 98e67ed59e1d1-368b22bd10emr2013834a91.5.1778566241263;
        Mon, 11 May 2026 23:10:41 -0700 (PDT)
Received: from localhost.localdomain ([2404:7c00:52:d485:aae2:91ff:fe57:5e15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d628474dsm9827915a91.8.2026.05.11.23.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 23:10:40 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH v2 2/2] staging: sm750fb: remove unused <linux/platform_device.h> include
Date: Tue, 12 May 2026 11:55:12 +0545
Message-ID: <20260512061012.76252-2-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512061012.76252-1-yogeshdangal66@gmail.com>
References: <20260512061012.76252-1-yogeshdangal66@gmail.com>
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


Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EFE361DAB
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Mar 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773587223; cv=none; b=OIOoJmvyGIv6SpuGgl0ET3DNo1QEBFNYIeXfxcuIFSRlLBNDn9aCQvJg2Rcsjb6CYMmZX08KvaDLloSNfYmJ5hgP2XMYtfn8YZsuiAEhBo0lkRQwi27znGffUEDvkoENC1EGL1JXI2aQZAG7CFdD6bt2pev/bO9u3zXlcLSnFOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773587223; c=relaxed/simple;
	bh=lHBKOQBGm6Fxx9EJIkZRGsrEONe2639UKB4uauCnkoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8dZIgKuOvVxBgMLc4NS3LpMgUN2Zr5A/Dhm7EDK8FuAdLNI44EllBd+w5ImUHbDo2hlQtt4bRpGvJm4/wicUvVQr1CMfGvwSWzBjP1T80d4NpABCSqwBHR+7Rqmv8WK1FTC3Pms09rPOvs1SFKLCk6gYTIcM0ab4UQ//3VWHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGGO4a+P; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGGO4a+P"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so33070485e9.2
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Mar 2026 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773587219; x=1774192019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+oFKCqczy45ErhHsr9BjH0dVnyXksSjS9S6Ban9x4A=;
        b=fGGO4a+P5BbLZyW7yBlLpIJYbZabiAsIdg98E+w3ZvhvforLH8B8ad6pnk3BX+cNNG
         O1J4L4EscqOSpQLVgbXQhyCzdNtIkPouWY1pU7cyBrM47owa9Q0kB2t06QjP03BOnRIJ
         LG7r93swcKKFEgbhadEL1rOFUELIqgJUj/VaNx31kby6Hp6RZvuc7uaqH8FZBpLm8KCL
         0Wk2hQU23uIod04p7nUo3cL1JMzIcDvuKkyVGCzJwFxOov73LwNyA9sJKtT52Uytrhfh
         o8O4JPqB9LLI2uvIGpedHbaAITObAjdZRxzQioqmWLEkOsGOQW7wRfkqs4iQThVYRTHC
         SLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773587219; x=1774192019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+oFKCqczy45ErhHsr9BjH0dVnyXksSjS9S6Ban9x4A=;
        b=ms0LthaVshUFZbFEF43ZWEmTyEbKzSes2LxYlo9c0pO7AXKnry6v6E080ossWcx0fp
         u/g7SjpLeV97DKxOYGFWLlm3nLJr8NzlcUy9gLcEx51ruukpxe/uYZa+aLsNxLmvbGFa
         XupqIB1rM4IeL6EWgx5IQYVe488j4PTU9oHTpVMNmkJ+7LgTw6BDW1xqajj5xyhmARxf
         uCgj02coMl0b4xUrGiMlxhebhtlldHm+CcUWOX23sa2iaZzvXFXHnpBRJpFnlNPagYoY
         Hi5s11H12PE2L3BDC1EX2X+pWBZjEFG24B1T38SNWBucl6U/Mke5sD2hBRgTyx81e2RF
         JvQw==
X-Gm-Message-State: AOJu0YxG5az7M7nlsdDWEWh6hc1E3rlCLHe4QPI1Atu9NpeCRCP2LbOz
	ERv4Xi4uwXPuXwQa6lHQyVL3CQGz/i2duP+pMyeo9AgoXFlk1IDGr4cR
X-Gm-Gg: ATEYQzxe0Ee19wZ+0UFiYrEKrQ/G5ok7iX1sEgefIdCfPYRSov7Ixi7g1+Xy5WxSpGR
	Fj0k5HQ0GPqsnFdAS/wcfRCx0tHYdpfC1J1j4/TMEvOuG8VjMuQ/xQtl7OjkwyHD0IXYlyazT2B
	8Fi1U3We1JVmNjAXbxUyZV5mA+hOg5kWfguovciNtfrARooWIIwvCmXXzPj6JXzPRYb2aX8iqQT
	oC8nlFIBKQSCBlYrDeLjlpZS9fkch4EBJCzHZNul02nRxSiRlXZco/CEAkLA00U82Zj8BWAyJkh
	eNK5D0CRWSIdjxi54ozz/KOZr6oEVPiiOOL3r8cyWhphhZevVo6xrJZVjkgrLHsunXI6kY+QcT6
	PDEheIFRTOXxVushfg6vGpaPCctbG46i4m8yZb27xnJzceHsydxoI+AKRejKh1ctDu/2RG9imK2
	Zth7coVfkUJuuPsXdC0hmF/WtV8oELrYJP56J/1UgZqgGXZQtz2f9/ztg=
X-Received: by 2002:a05:600c:a46:b0:485:358b:e80c with SMTP id 5b1f17b1804b1-4855649971bmr180990195e9.0.1773587219183;
        Sun, 15 Mar 2026 08:06:59 -0700 (PDT)
Received: from OaroraEtimis.tail60902c.ts.net ([2408:8956:4c20:952e:71d2:7185:4299:35a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c0b4sm36924829f8f.25.2026.03.15.08.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 08:06:58 -0700 (PDT)
From: OaroraEtimis <oaroraetimis@gmail.com>
X-Google-Original-From: OaroraEtimis <OaroraEtimis@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	OaroraEtimis <OaroraEtimis@gmail.com>
Subject: [PATCH] staging: sm750fb: Replace busy-wait loop with udelay()
Date: Sun, 15 Mar 2026 23:05:32 +0800
Message-ID: <20260315150532.87280-1-OaroraEtimis@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The empty for-loop in sw_i2c_wait() triggers a -Wunused-but-set-variable
warning and can be optimized away by modern compilers.

Fix this by replacing the unreliable loop with a standard udelay(2).
This also cleans up the unused 'tmp' variable and outdated comments.
Include <linux/delay.h> to resolve the implicit function declaration.

Signed-off-by: OaroraEtimis <OaroraEtimis@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 0ef8d4ff2ef9..d0aeb917be92 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -11,6 +11,7 @@
 #include "ddk750_reg.h"
 #include "ddk750_swi2c.h"
 #include "ddk750_power.h"
+#include <linux/delay.h>
 
 /*
  * I2C Software Master Driver:
@@ -80,24 +81,7 @@ static unsigned long sw_i2c_data_gpio_data_dir_reg = GPIO_DATA_DIRECTION;
  */
 static void sw_i2c_wait(void)
 {
-	/* find a bug:
-	 * peekIO method works well before suspend/resume
-	 * but after suspend, peekIO(0x3ce,0x61) & 0x10
-	 * always be non-zero,which makes the while loop
-	 * never finish.
-	 * use non-ultimate for loop below is safe
-	 */
-
-    /* Change wait algorithm to use PCI bus clock,
-     * it's more reliable than counter loop ..
-     * write 0x61 to 0x3ce and read from 0x3cf
-     */
-	int i, tmp;
-
-	for (i = 0; i < 600; i++) {
-		tmp = i;
-		tmp += i;
-	}
+	udelay(2);
 }
 
 /*
-- 
2.47.3


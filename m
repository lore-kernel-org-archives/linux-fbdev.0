Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6392F279DB3
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Mar 2026 23:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773616854; cv=none; b=FYTsOtNHKg2alC6rFkzidSmoIooiJX+MwPuDpzn7nHHr5ym1Sm7mjEd4i3jFyJJ1VbLd5ceO2tJeP4eRB0g9viNO8jFDSVcAOz+FiqxDuGWochxgv/15JWtHs+rwpQWLkX6IAwrCJm6nN7Tt0fOpJC4uOPzVGT//GiZE0jw+FN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773616854; c=relaxed/simple;
	bh=KQK47r2le0rxX7oS8QCQCkyGSHeorWHnC5Ym4uWq5O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GaKdfKaqPO3Zas2/ECe2bnzOWB49WokNCXvOV42DdgXHHwSD8/3XyRYJgVSRSWNF0U4pBWXzGGW++oea8k5qJ9kcZZCLVgdrnHFGiH9n6nLAzpxjhSbAsb60NBSBtYQYtNkURWXxQWDjfemd812erMWhDjA2hdpiqm3XYmo3rSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhmJ8hqY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhmJ8hqY"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso34550275e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Mar 2026 16:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773616852; x=1774221652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RimPbUvdW9AjfMzbYKRW24j+VJGJ9iTe06ziE7Uy0js=;
        b=MhmJ8hqY5PBaAPLZjMNHUSA5eqJ+sCGo3IsUN0tJirFgXDuW9PmEWu4RJ1GFq+BcdH
         blrjZgyyfoEb3rFyDI0AKm0DeZSXH4rluxi7J9VmzezE92xlq88nB+8Zx7HdX5xWXykJ
         I/iZuvsROUz2NkROLzzqzxLyolZId9JPRk1hp6LYaNscpsWR6imhnFiA6sMjMGrgHaiv
         Gxc4mIrinKTX8v/XhAIAEa2Z0emIozDr9E6fh1H1oUoi9JMyWWpoCSZtEw96z0OwUtn8
         qVjj6bZToIviHmqB93GbjFztZfuofYTnrPai5Ld/Vy8inn4G/Ts9ZRNcim/isr6X2rOA
         yv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773616852; x=1774221652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RimPbUvdW9AjfMzbYKRW24j+VJGJ9iTe06ziE7Uy0js=;
        b=tAHo7R2nnnV2yqdOJgf6c1ALL/SlLRXe8mtmCmTqVAMJRR9GmnfmDFtoA3LgY7EJwn
         201cEuzjC0dqpLPMF2UJjo/5SRb04T04jk3cHcPgQ3vqGvx3Ev31XFt7F62lHhewNtvD
         irxz8tojfWeomb/GtQpK+tDfJB+epn3k2eAfv/smpWiWy57zAgiQl22rDXg9ocpUl0ld
         Jw9Z6ZxtpkQ0OKsUozhqUUqC3xX/oC4NdqJVLSXIGYU6r+g90JTiBcB53oWn9QtdSxVZ
         Onp+63FamIvMrA1A7KjkgCUnb/SOq1Q3+SKnwMErV0JhuV/DHWLjtNJYGx+j2jCpREsl
         eKCA==
X-Gm-Message-State: AOJu0YzUeUyD6o3DfsfMPD5vNc9GQM8SlUX3kzJZJHN6H6RnHfGo2mD7
	drkTI5qThML2xZx7tHYNE7ItZebVH/5SmorBRibmpuECSmYdpeeDtWzs
X-Gm-Gg: ATEYQzzGZaLHYk+Se403LKTVKn3Ek6SroWGv15ZVbjkYPzY+Nz2juZbWNrnZ+08lcQV
	B1Z7QPQ0N+JFyT+Ml10aqRs8jQ4cDfD3uvAxm6s5yOrC94j4g1g+8ljnufAS6z71i8eM6cJdYm+
	TBjNXdqQEpXbUp4MV8nfHOWoZOYPkxtoIU8gIrLCtzInxnCMphBA3mXRYB78n+Ds0bpdk3P2Pqb
	M7/bHv6nyY9BMvNXdeYOw2qkiRuqQWHqlJz4m+QmEiPBhupxA5lMItSUq/MdaFfwLZalIDahAWa
	EQKFjLo6dIzdQ2/iqBuzFtU5MkFUvQg+iklkYKQwrRnNRCyXRJNjc69tJFsL4+Q0sgap7SQsZyW
	kJekLJfU7NtvPBftzOKSPhwzlLaPt6zZwO8Rjgt0dOtykODa0H6go7lNND1AdTeFPkBwFSyOWkp
	MMlBNfWVSZpWnjzxpD+G84g4hIoCbAZQT7h7GJ734b2Mk2VAzpFUOj
X-Received: by 2002:a05:600c:46d2:b0:485:3a03:ced1 with SMTP id 5b1f17b1804b1-4855672737fmr190627665e9.28.1773616851586;
        Sun, 15 Mar 2026 16:20:51 -0700 (PDT)
Received: from OaroraEtimis.tail60902c.ts.net ([95.179.249.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73dasm1133387005e9.2.2026.03.15.16.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 16:20:51 -0700 (PDT)
From: Oarora Etimis <oaroraetimis@gmail.com>
X-Google-Original-From: Oarora Etimis <OaroraEtimis@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	OaroraEtimis <OaroraEtimis@gmail.com>
Subject: [PATCH v2 1/2] staging: sm750fb: Replace busy-wait loop with udelay()
Date: Mon, 16 Mar 2026 07:20:42 +0800
Message-ID: <20260315232042.231620-1-OaroraEtimis@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: OaroraEtimis <OaroraEtimis@gmail.com>

The empty for-loop in sw_i2c_wait() triggers a -Wunused-but-set-variable
warning and can be optimized away by modern compilers.

Fix this by replacing the unreliable loop with a standard udelay(2).
This also cleans up the unused 'tmp' variable and outdated comments.
Include <linux/delay.h> to resolve the implicit function declaration.

Signed-off-by: OaroraEtimis <OaroraEtimis@gmail.com>
---
Changes in v2:
- Rebased onto the latest staging-next branch to resolve merge conflicts.
- No logical code changes.

 drivers/staging/sm750fb/ddk750_swi2c.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index e63f3b00ec4c..d579cb9da79e 100644
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


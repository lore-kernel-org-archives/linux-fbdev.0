Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E94457D8
	for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792315631; cv=none; b=hwXAaNTNgNnkeFY02yZ0m8EFfo2q6wWzQ4Tmn/gu5V7B9/CQ80Pqk+x6N4c0pnItFejRoGfKvVkI3pMiu9Enut4v7PsD8B4Nk3TuLCpml6R8SYFb5LiyB5NxdapXu/6fB/nXbxWlCgY1f//EpT4QhKCD5JilKvzko6VEfrT4WgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792315631; c=relaxed/simple;
	bh=Wsa1/xhWCYq2/IBwiWNMt2tj93MBzhsZUygXRpg69xM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TkXaio/afCO0crU4nl2aaHZXBcX4ojQvWWo74F0gKUgQm/kxzx1QGC2gz65lXwJQw+0/TaJuE2xExgLr2x7if03OXWY8cednoOdH5tDGVzmZ9cfajk0ecK212JenTThkt9H2YrVWmc20LaGwbQgsoWanM79ksP10+edwa3MI/uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OswCbOGe; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OswCbOGe"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35f036b17easo2418778eec.1
        for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792315629; x=1792920429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r6jUk0an0lKrrWdJXHLKdAJiipusBLjsQVAGLXI1SyU=;
        b=OswCbOGebAXOE0BXT6s3sSs9jG5CeVPtdhDl+In4WVjxQnSB2x/WbZAhAErapj/Iv1
         zKOaxXnKtzRiT8fApkRmVTy3usTJSemlGQw/vmrgbxI5IEkoMOEX0WPI84XU8BCe/rpl
         C1oqQc4dbpT+f3qR6O8CX9vDaMQenmy3JJRYu8YC5NAjZehdGwhyfBqHs3kaT4yXSeLo
         Lzz0tGbSbxjvWvjZHN//inaVp9xXhWSrsSGEjdiIeMDuSWyfenXEh2pwjT9NRR02/54Y
         4yvTo90G0osjYnDc3JiUpgUDyLQRT+lapu1+CKD1RUaXJeyBHLNQ6LYXG2Vtj9TBMBsG
         jqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792315629; x=1792920429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r6jUk0an0lKrrWdJXHLKdAJiipusBLjsQVAGLXI1SyU=;
        b=pZL7XyTGi89qAzCqLIm36K+W+tLoQ7agEC6oEIwjNai95cSkFwbtHegtQWsOuLN0Nz
         bsNdOEOgOElHTsnw6LVsjA5kUxB9POfeWFFXPnbGRpIZSC4WUy012ftlfusYCtWk47Ds
         QKzZtMo/FST/8rhelLZcuTkqqkYB4L65GSTw0sYcQSZA5esAXyPr/FbhWSt3tJ6u6xvS
         pD++eMm3ujHSkgkw821c2Rqs3t22DTlVA81tXaM51+Y++faFgXcXF3rFGoAjeUcTL/WW
         KgcwKJkWaC0UIk7O0uKirb6QHrZ6mkNkIvD1C/0a46xwKxDvaWjWC+SaDZyBhqA/x+Of
         +RDg==
X-Forwarded-Encrypted: i=1; AKwUvBzdRtgFQNB1PrY2vbnQ2kc0BfQbPFxYvE0XsL8kyDhoQcrqfdf7Z3x89EO/4hiqaAgL82bpdaFBm5I8FA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIc3r3wS2h2JmlRaqv8Z08xpb5QpLmhgykSw39tccpGip5Yhvca
	LqzHPmDOXpnP57blxOwNYzNsgSYT6ILgF9TSDi4fzr5JNX9BzfI02Nmt
X-Gm-Gg: AYBFou1Pw8nWaCxL8dCHkpIuMU4PSTnTed4wOVYmNgMMcHcVcUQj7HocX1m88iMJLs6
	i86Lk7BG8CXvs0mXQAWkVmlos8GkVHQ51lB4KHwHZM8yoIAegxvxSD/pAMuuAQziEyIbK73sW1c
	zqbBfS3zwrSdPEXnMo2f8cgAStt0KXOMsLKhoJ4NawL+iCC48XLdd0tQBs/wiUp+b5RfHTInMUm
	0Qe2L2BXKob6jWdP9IiwojuyCNMPPDUV2Oxh3MY2xcHA6kzyw7GhvmZZAGnRRb9NDLL0h9qN/9R
	pol0btso/qCXLbmiIG28r8AEywDWtkSOsqNakfAYhbFo4A6v/mnxHtS3n1IpIXlJVxdDAUg24Tm
	f/JeeMvV6V0M0cBQtB/1tEfZnbxFEF7z4dQD0s0Z9XUmJg4D2EsONhQJayFoYiwGQBn3MjkQw8s
	Uo6QwuuUlrpK8AQtF8peyoZwyRY5t8BkVUg9gPk5mKf5nKYvhS10hHy4BS0CLS7Q0b/qjeZJHoE
	VT0HIB0yqCOVLEKuQ==
X-Received: by 2002:a05:7301:b13:b0:360:dfac:6817 with SMTP id 5a478bee46e88-361a18632fdmr6512862eec.18.1792315629172;
        Sun, 18 Oct 2026 02:27:09 -0700 (PDT)
Received: from himanshubakshi ([2401:4900:1c2c:5bac:6f4f:b477:6604:1f68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm23637101eec.21.2026.10.18.02.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 02:27:07 -0700 (PDT)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	himanshu bakshi <himanshu.bakshi478@gmail.com>
Subject: [PATCH] staging: sm750fb: Simplify M2XCLK divisor encoding
Date: Sun, 18 Oct 2026 14:56:51 +0530
Message-ID: <20261018092651.49924-1-himanshu.bakshi478@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the switch statement with a macro to encode the M2XCLK
divisor in the corresponding register bits.

This is my first Linux kernel patch.

Signed-off-by: himanshu bakshi <himanshu.bakshi478@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 18 +++---------------
 drivers/staging/sm750fb/ddk750_reg.h  |  5 +----
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index aa78d0bc1..2cb849dea 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -109,21 +109,9 @@ static void set_memory_clock(unsigned int frequency)
 
 	/* Set the corresponding divisor in the register. */
 	reg = peek32(CURRENT_GATE) & ~CURRENT_GATE_M2XCLK_MASK;
-	switch (divisor) {
-	default:
-	case 1:
-		reg |= CURRENT_GATE_M2XCLK_DIV_1;
-		break;
-	case 2:
-		reg |= CURRENT_GATE_M2XCLK_DIV_2;
-		break;
-	case 3:
-		reg |= CURRENT_GATE_M2XCLK_DIV_3;
-		break;
-	case 4:
-		reg |= CURRENT_GATE_M2XCLK_DIV_4;
-		break;
-	}
+	if (divisor == 0 || divisor > 4)
+		divisor = 1;
+	reg |= CURRENT_GATE_M2XCLK_DIV(divisor);
 
 	sm750_set_current_gate(reg);
 }
diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb/ddk750_reg.h
index fe412ead7..b796e32ab 100644
--- a/drivers/staging/sm750fb/ddk750_reg.h
+++ b/drivers/staging/sm750fb/ddk750_reg.h
@@ -312,10 +312,7 @@
     #define CURRENT_GATE_M2XCLK_112MHZ                (0x2 << 12)
     #define CURRENT_GATE_M2XCLK_84MHZ                 (0x3 << 12)
 #else
-    #define CURRENT_GATE_M2XCLK_DIV_1                 (0x0 << 12)
-    #define CURRENT_GATE_M2XCLK_DIV_2                 (0x1 << 12)
-    #define CURRENT_GATE_M2XCLK_DIV_3                 (0x2 << 12)
-    #define CURRENT_GATE_M2XCLK_DIV_4                 (0x3 << 12)
+    #define CURRENT_GATE_M2XCLK_DIV(divisor)          (((divisor) - 1) << 12)
 #endif
 #define CURRENT_GATE_VGA                              BIT(10)
 #define CURRENT_GATE_PWM                              BIT(9)
-- 
2.56.0


Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2485228E587
	for <linux-fbdev@vger.kernel.org>; Tue,  6 May 2025 03:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746502453; cv=none; b=C/ydkr+184njSbtHyh5QaMTmL/FDgoAvvQfqzgap5A2n+329OVWuvkNqx3/KLorIdlLOAsVKUMIN0JUjeEMJUAsPz36BoVZYTDcbgf1DmunpJIEeM6ctFX1sXceKmsPXXirf9JjAHtMcWrSWXKYaeF/sLcBZJ0vL1s7AQKiK/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746502453; c=relaxed/simple;
	bh=QYL9iza8qksAkCLYKPMeAryX0p4dodMnCX2txJs3q0I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sBruHXQFbQpoP/kM8tF1wSl5NtXH6uZhvtJ1K4UF6Sa+H0phdp6GaPJ6i8E6MkXm5FGoEps++PoLP/26dKe3ZFA36FrSOIXWj8d1RC6BbtZnbP9MnecNxRcz4GGXwOuWd45KGy4trRAKTUjZbLKpAeAzV+tsnqxoeLjajyAhZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hlbj2G1z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hlbj2G1z"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242ade807fso78066925ad.2
        for <linux-fbdev@vger.kernel.org>; Mon, 05 May 2025 20:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746502451; x=1747107251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OTniG7IE3xX9P3zbqpr3aXl5LjPn9JBb3AM8ohKnBMI=;
        b=Hlbj2G1zR3SHjf4TNCSLOpKOWvKVbw6w9mO/sPEyctDv1WJUlWU1+VF9UXRGOeqGbD
         J2UdzbNoeioyvz9hWa2AsEh8c71keCkKAHtD1QlMfxYzWC58ICWmWiNTwDsc5xYC1wjS
         gP8Jn2INXtj8rm/1WDY9TDYzExjV7ugolAXb4ctMcfFQ8MpyZBudxTcLvD8J+l6i9TGd
         0zYp/pcGKvOt/lElus3JAxk5S8TzlNzMAcuYJ4huMhDzNz2B7jL/pezkPD8wYnaDmL79
         m7AfhrQbCGOVcm0io6qbtDnSeKO7oIJktJNiGHwX3vciEmF+G0RlI/faDnz8IpAiyqvq
         lZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746502451; x=1747107251;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTniG7IE3xX9P3zbqpr3aXl5LjPn9JBb3AM8ohKnBMI=;
        b=cKu2NX8ApU++TK+jrzobVATncruzBBgbBL+LrqsT2q7N1GnVkS/aaeWShN2zgdLILT
         z0y6YGxLZ7k5nlsPIbMBja+PBBF6t2HEsyUE2hW7UZo39ud0X4QZ0xMAkP6oie5cFkel
         +eqmVYwliE//5gLQCClX1YM5NUiSuZ5D1HDiiW5flIMdJa8zkOWV6RzIi4StbRzJyZZh
         oge0gH0Y0w5W015SQrlXri9fvpgo+pHL/UpouGATtl6bKXj1N1D0U3yABas0lHLVuJ4Z
         nExUxQnTrp8roFEr2NKyntWvW6TDMnf11ltNoBf7EAqFTiKp2F84ost9O114vkUNk0Xb
         UmXA==
X-Forwarded-Encrypted: i=1; AJvYcCUZG+h9UJ5jI7V3aoMC4P1fbo6gDqFWY77Zbst3aGYRfCjfBWDWCRHP4YqCkn196x+koVHrtizq3uRRGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Wkl9x++92AEjQkQhkFiSNzDxCEnNJcGFb8aipHyF7DZ0aVl4
	YGYknZlabhBVFT3XpCMsxXzEf2jX3EHUjts5EsMnAAXQUoOADBdAW7Z8lkSX2vH7uaEJyZF0yjQ
	3l37Gig9sDBu+W9IyMQ==
X-Google-Smtp-Source: AGHT+IFWjZYRJEiXFLhjLTzrSR4D3ISD/0V6bYvA5Eq+ZhoMPEht1Ky7kdvoBWJ/wlHcTS6E0fkbiRswi0eStTHz
X-Received: from plsd10.prod.google.com ([2002:a17:902:b70a:b0:220:d81a:8975])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1aa3:b0:224:a96:e39 with SMTP id d9443c01a7336-22e1e8e9f54mr138686135ad.9.1746502451339;
 Mon, 05 May 2025 20:34:11 -0700 (PDT)
Date: Mon,  5 May 2025 20:30:13 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250506033340.3689818-1-ericflorin@google.com>
Subject: [PATCH] staging: sm750fb: rename `regValue` to `reg_value`
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename `regValue` to `reg_value` in `write_dpr` to conform with style
guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <regValue>

Signed-off-by: Eric Florin <ericflorin@google.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 44b9e3fe3a41..5648476a8f3c 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -17,9 +17,10 @@
 
 #include "sm750.h"
 #include "sm750_accel.h"
-static inline void write_dpr(struct lynx_accel *accel, int offset, u32 regValue)
+static inline void write_dpr(struct lynx_accel *accel, int offset,
+			     u32 reg_value)
 {
-	writel(regValue, accel->dprBase + offset);
+	writel(reg_value, accel->dprBase + offset);
 }
 
 static inline u32 read_dpr(struct lynx_accel *accel, int offset)
-- 
2.49.0.967.g6a0df3ecc3-goog


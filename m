Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB6738C400
	for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385374; cv=none; b=ZpJV9/wK5suo9ihVTXxpALWIq2IZ29j6bKv4TSkaQxMKgGp5J9mNkU3HxMNvcTWMvowXA3cZd0ND6rBNjjXn1CYEMkAhWu3y3QcTLzn3FFJHbP4DXbchRQ1qVeNCiWBMMZXwURRz1WQ1K7KfeQAnD0rwyrlPKaVg30RkN+ji+uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385374; c=relaxed/simple;
	bh=NR4F+ieQeaovMU2nyAUcUaMtGH8xlJq5lhLjB9nQPQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCJ40xpGIMTYZcePpi/EpQymMpezR+o7gpcCI/h+Bim3+P/42S4puft5D41u53A5TNb255fVF08EE+iWewyIR/rJ/+CzKkEN+2gHqBAl0W5Ql7nQqMbmP5VeCYYVAv8Wnyz/HfwRScwc3hzrZtPbwHrAqFByuUXFuAa3EG/uwhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxL9MgvF; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxL9MgvF"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30bc806fcf8so2590964eec.1
        for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 04:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782385369; x=1782990169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzVXIO2M/zZGRMQrA3as78zSud+6/fQ7nehrf8i6Zh4=;
        b=AxL9MgvFZxxMyng/kLtQZDESdOFV3GFWZXaxkSB6UYO5L6y5XcMM1ZxnD9/2vMUrxV
         jqsClJpTBPPkX3F+7pF6JEGkrf0HDdZ7y/6ARplIiNOmspHR/qGVlbvli1Ik5TZwJhU6
         r+JLdE91628bzcZSJzdubtP60k1ng39afA1sj0rimiLs2kFDKOmGv64miiZMXqVJ7mem
         60tKGD/5wMrQRAZErxeSnia4NpCnZ68xS6aUAXFh0rwiq3S8mzqRIgIXgqGccDyX3Oi+
         TOuSvex9tZg3jcaNx159Av/ZwlIJ89APdLFRt74OSEDRAnRTjdimd9tH8Ihd6LQT/jEr
         sF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782385369; x=1782990169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzVXIO2M/zZGRMQrA3as78zSud+6/fQ7nehrf8i6Zh4=;
        b=pO6k0qIGePGFnvt/FDr9Z15Rq62y5hH81TWJNA5HmUZcLM8AD6oNG1dMQhA/Jd5LQA
         wHcExqU4aMzByhwV1JbDCkrsx/bUpDaCoRN3AlIpGIBOwsxZVM+dk5DsYoF0hsrk0PVH
         9hVqNdpXrru9ZYOlnC4tVh/68oT3/qgruX752V2urqHZfwGrDK1chPVQ+p6NXgydN8f6
         KV/BAZuCckzXXCjYgMFVscNjTtP8ZIx6K1SEQX2o9LIg7RuuF+BqCWLEitPtrEC5fxa7
         GbWVSE3YKEaUh7b+mDzyrc8+0iQHoHlyI8sAepIk/BajJ4ZgacY8iVlinb1QSmG+jRdP
         l/xw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6kK368BJYgykDp1z+0JHSuntdqO6ZJR4hxW3SrQCzUOZSRXolqXvq+s0N2L0MZbsB1o7eRNHXjz5x9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8x0qIiATSq5bnNJZeOmVuFO+mMpOnfma7jUXZjeTMeimyHZEb
	8jW6SyZFFXRvAiTnJZ6esNAFsPTFvqOKWnXsbrLWSNzWd4PPZJ3Qn3yB
X-Gm-Gg: AfdE7cnO0givP0LpTFc6VnJUWtbn5QvaVplSk6Vz97Y5wNRAiquk/RmhEwrH6gdN/o2
	6rHA6zCt51Pi8GbigLn3Q7cLBb3gKXmLDcKmTNnsKQp8VL/6pON3pDAnotjap6b1/5Yd5pO8InP
	czJQOADngygTaHmgQ8An8KznIraGXEu3CLLjIuKJ4iHVd/FzCwTOv1Chs8bxqvkxjjoyJgRtQsq
	xJQ0xkaHQScyRTfCtTG9wIV1vEnyjZn8ePWihujHUrkpk8JTtYvcjibWtM/OF2YNfaS1Yk8Px2m
	F3qSARZZU9gro+6tqmLxuB4AfFRVVby1Qj/eNhk4dGD+M3I/9KOdS2RvZZ5zdMXOmsA+efsedfi
	gv/YPcZnQ7B7tNoh5ZWIqWkPvKzJkc3VGvx31e4GNUGDTqpneLO+lkks8UQTv5bwnciIBu4+8ks
	033W9Med7rg8NmHbm8Jg7SgASm54EQUSCZ0S4vJew+4mvM
X-Received: by 2002:a05:7300:8606:b0:30c:5807:abc7 with SMTP id 5a478bee46e88-30c84cac264mr2452317eec.17.1782385368531;
        Thu, 25 Jun 2026 04:02:48 -0700 (PDT)
Received: from 10-86-27-11.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca87caasm7229314eec.27.2026.06.25.04.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:02:48 -0700 (PDT)
From: suryasaimadhu <suryasaimadhu369@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: [PATCH] staging: fbtft: fix unaligned vmem writes when txbuf is byte-offset
Date: Thu, 25 Jun 2026 19:02:37 +0800
Message-ID: <20260625110237.304435-1-suryasaimadhu369@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625104220.21E5A1F00A3D@smtp.kernel.org>
References: <20260625104220.21E5A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbtft_write_vmem16_bus8() and fb_ra8875's write_vmem16_bus8() offset
txbuf16 by one byte for a command/start prefix, then store 16-bit pixel
data via txbuf16[i]. On strict-alignment architectures this can fault
the same way as the write_reg path fixed in the previous patch.

Use put_unaligned() for these stores.

Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 3 ++-
 drivers/staging/fbtft/fbtft-bus.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de664..5b95b0095 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 
 #include <linux/gpio/consumer.h>
+#include <linux/unaligned.h>
 #include "fbtft.h"
 
 #define DRVNAME "fb_ra8875"
@@ -262,7 +263,7 @@ static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 			to_copy, remain - to_copy);
 
 		for (i = 0; i < to_copy; i++)
-			txbuf16[i] = cpu_to_be16(vmem16[i]);
+			put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);
 
 		vmem16 = vmem16 + to_copy;
 		ret = par->fbtftops.write(par, par->txbuf.buf,
diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index cfcf4d7e7..fc3faab7d 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -158,7 +158,7 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 			to_copy, remain - to_copy);
 
 		for (i = 0; i < to_copy; i++)
-			txbuf16[i] = cpu_to_be16(vmem16[i]);
+			put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);
 
 		vmem16 = vmem16 + to_copy;
 		ret = par->fbtftops.write(par, par->txbuf.buf,
-- 
2.47.3


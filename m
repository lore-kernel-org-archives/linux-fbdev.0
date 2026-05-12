Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9D367286
	for <linux-fbdev@vger.kernel.org>; Tue, 12 May 2026 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567720; cv=none; b=nNRF8xEen0X2K0YSqJCbcIvcr2DEooExA6zr22kC3ssiP4Vd5zhpxtmqRx1mjWz7pPytbBc9jqrrju2l/ZA3HCjIw/PMceb1iEMCg03N4SUPTFCehpPTyufmpaR3dM2F6A0DAN5bZqp788Hj3b285ZGMW2/c2g0hG9cjvXo9kZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567720; c=relaxed/simple;
	bh=2doWczqNtnCVGsUAUmmyk0SfDHaoSrWEhkfH1ShARKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DdcyTlDKrg+gIhqsA8viGxdvETmIeIT2SHCz1+qVaddCPRfolrur8HPhEqZIpufJalebE3MxAtMlNSBSlsi6koCHtz6Y/i9k+WLfftd6Ohke9i3HMZDKVp4dNzzcLf3nrjVfDebRPBWvtG3IjaBmPBjtjJY9+kJxIRyRWrHlxME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHi2LtKB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHi2LtKB"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-83ef1d17904so175023b3a.1
        for <linux-fbdev@vger.kernel.org>; Mon, 11 May 2026 23:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778567703; x=1779172503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hdBRmXm0EN9CDrqJgubz6nI5ID1Ljz0DfpQ5I23ebu4=;
        b=mHi2LtKB/ARUaHLFyAG5h+TB605ZbcDuEzgDkfRb99hUlgcpl/6RbMzuQtUS8TdcKV
         CkOVv/QeTbQ/jR2Cp9j+xAIl8W2FyQnqMPu1l3VT52ul0M8DjpVjsXbzmQCX/4bgo16J
         JcH5Wj/LTSyh//9r/npxB4Fhv/B9see4W/IdycUVmPs3ywigonaYdDa+0WdBuyY2Imhq
         YzIyV8KQGCxMm7vbkz5s3XLfhx2sCbun8bGRPpJ174qDEcLtD4lKy4E9XdiFseugDt1P
         guY2/tGbeqYR8Dol+sb4ZmlZebz9gUtGP/WVlgXj4E/G1Ug3Ij8J1RG45jfyMQPObsMN
         1yzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778567703; x=1779172503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdBRmXm0EN9CDrqJgubz6nI5ID1Ljz0DfpQ5I23ebu4=;
        b=q0Bupo5hB3JIdD+Zpz06mkJifvVovK5mCEcdRmgdXrpqK0ZBcz79jm6Y8P/HzVesnD
         fd1iBBu40lQKcW+i/zQL5uS7MhfC2z9GJA81o7bVRFhCgu9Z2kIBDFwQBVOdgiwsnT5y
         lZX0aFHFqPiUrNcA+yNBEh1xT5YFIzovy/bdnKJg6rwoH/f6Vetu5rfWZaOc1nv39yY1
         rkT+Up4GUs14gbYw4cAgP4OB512QemOQEaZ0088KVztq7bEXOxx9wujtcEyByuW4+N7+
         lFxpT3MrVcjZtayWAeyHIqjst3FcdXWahmuJ9IbyURICBmKORGn0KJBLKciEJ04A4Tvy
         f5eQ==
X-Gm-Message-State: AOJu0YzfldMzfDGk1iHdeewjiNdtRNliSsBcm3rECN/dDt1YrqghtW7T
	1m7n46M8bcvL/kDvmroq1OP/QCnmA8HkKsTZ/p4Rl7ZgfpONMroTMuYU
X-Gm-Gg: Acq92OHGltmL/bjmObn1q2KAzBqeXYdjYeeLS0oYW78/1FgW52qZzQWkbJEZuk2gsQg
	Y6w9weBGNDZuujzfkX1j6HkOlsg5ZPBZ3SanNavwKjGLO1EIw034zBiUgObooqbVBU7dRgGfu6x
	zai9R/6p3aSrbjMUxR9/13OUeaMm8Pp6NNUETx3InL3BEHmqxAPNVZwQWze0K4bIOkPoh87w8EV
	llR2q7CUCPMd1ATFbStld0GIJuWI2n9DdM5/K+MKW5L91H8AylBYel1PbYYKBY16MeQhuivQ/Yu
	7E5+gbXCvH03ARhVPH8g44uzGT3zCWJQhPALg9i1+LxaF2OMJIJ2ryxEmt9yiSEPSqj0cgtZ73q
	uo4Tg+8gisETAuODdImlolmIUkfbLCo9uA/9x+rG2NN/lR93BlLX+nKz0YzS/Qa2PBMmktZ1dIp
	FlAulPePvCjZEy0NH5lN7HmYGbrtLvoudN1yXS3swFejlKLJ2M7SGOJe51rZ5z1m3zqovfwIo=
X-Received: by 2002:a05:6a00:2e87:b0:82f:5034:77a4 with SMTP id d2e1a72fcca58-83a5c4be2eemr27641558b3a.21.1778567703220;
        Mon, 11 May 2026 23:35:03 -0700 (PDT)
Received: from localhost ([2404:7c00:52:d485:aae2:91ff:fe57:5e15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d36c10sm27475783b3a.25.2026.05.11.23.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 23:35:02 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH v3 1/3] staging: sm750fb: remove unused <asm/mtrr.h> include
Date: Tue, 12 May 2026 12:19:55 +0545
Message-ID: <20260512063457.80882-1-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sm750_hw.c includes <asm/mtrr.h> under CONFIG_MTRR, but no
mtrr_add/mtrr_del calls exist in the file; the driver uses
arch_phys_wc_add/arch_phys_wc_del in sm750.c instead.

Remove the dead include.

Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 4 ----
 1 file changed, 4 deletions(-)

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


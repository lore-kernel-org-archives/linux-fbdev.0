Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FC61C5799
	for <linux-fbdev@vger.kernel.org>; Sat, 25 Jul 2026 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969243; cv=none; b=CbNF5+tPjRCIr4doZNgPjRtC9BRFYMpIfdKs/+xdF5a47geDBAKkUELfC/h7z0Mrbg4Nk4lhXrXAXg/hvv+OUpP5hIqFUeUr5z8NFqh1gcHoPkkqW63O8t11hR539r3zW+RlLhN5YkiLLOj3jTBK3DmV3vEo51zetZVttSBoQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969243; c=relaxed/simple;
	bh=0Av68wN57SFEL3QSLrtDoLnK4quY/MDeqY9qTXeFRys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yn+60VsZ77HKiaOYG740nQLAQm7qq/h08UxrBO47nRpHXdbSsQHzKKWBz6dred/BG/WIapszEZjowSL2SH7SSx9ipd7x4BuG8EpJNAwj+pmOZRtbJa0Yv4ifMsT+KG2JuJEfZ7H9pCwNoKhgdFFpsB/kuPjtATbK4c0RKKbxCh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE14iytW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE14iytW"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1102036a91.3
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jul 2026 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784969241; x=1785574041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjZQz3L+xdWq/feFkJjqK6ttqoUhVBIYHHEB0gOlh8M=;
        b=RE14iytWJlAwPopOnJBPG+f4GLzNdlFSFoxMOLqii1XbYOzOSlwyK/PgBXRPsQ1x+G
         6SanDscIoK88MQ3G0/IL1QXmmVWTOvG+ppkTZEiASHIuRXBzF2gIzELufTerYz8Ykjy5
         b+IaYRHQCbTuSu1w9jSSWMXReT9dqUcjHxM5iLIEDUFNrtlYRlsuq5pfy7uDdxHOQYKC
         bNQNz3EiMjxipF15VPI9usqjEgVUsiJN8QpIw1uaO5hFCBRe0fWVkWSFXpMrcJeiiA7Z
         bav7JXXVDk8oW+XnO9kMvhn1SGH6obeftYVKRT2pqbLq4+mpRs3TStTuylKbTqqrGWFr
         HpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969241; x=1785574041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IjZQz3L+xdWq/feFkJjqK6ttqoUhVBIYHHEB0gOlh8M=;
        b=cJj3RgYEvIJqHxeL0vvuXeKVJVbYPeCrbrGF2mXShEryS7FawQiWIw3eRLqJZ48xQu
         6CO2uz0k5onXaLM8zSd5/R1qrYfhGDUA7rysEO3wG80kK9DJQdFQBGIbU/Dnm11GF1sx
         sO8ahiVJ5lkpP6DpT3HBN2dPEgN5FeQOS/C+eSgvsV6nW5am2jMHLM3Uzl0+leiaqsWU
         u5JOI2ZKT9rm0qvwYCoeim9Caasp7qTte39m5QsS9us8E9YOrHwgADMonVVOo7eJMpnd
         dhE/5IcBnFNrMUhuXR/uVZloJYAFRm3q4V0zv2E+ldPx8wQQ+QWky+EVBoyHHP8x/HF3
         +zWQ==
X-Gm-Message-State: AOJu0YxXo6fTMOXxm0zt12PkQzcMjp3I/58YC3RwfxEzoY3DM+iz/x/l
	JzItZJLPgftGZuFjIzxfpINVJHhWi5ryPUaTLu6uacLSHiowSYtz7R9z
X-Gm-Gg: AR+sD12CiZkr6xHA1/UkaHJ+vzTSpzUobUjalFpC33+zCPej4jMMTFJv9K5Ie27RNyB
	gaipoRSQU87VvJUKzsoiorn1ZiwUgGNl6exZdlCF6+rE0GV2Isg6KrSn2T2u9TajSvEhKDverOv
	jyLG0T3P/SRY/XmO2a0ata0vz2Ls8y59eOo7IqWQwNXdFAuroyejyHvOu7M79yfzGboVnUfhieG
	3BfCBU1TIEYdDH5Jf1cst2fmcjCjGcndzLI/Yt686zU/zycFZMpLnjBCAdlynzOPmUPLPhAKkvg
	85vAfuk5Zs0lsgP/rBYYpGxZ7KuLroWGgFoxlMEn+4Jtjk+aUcEMiRyaRPrLvcm6MR/ggOQJWCB
	9C6aH4WwWlGyj38Taeu6dRksVf+wbTDuFRUqn7GdqzqMm/2MFeI6mFbpYMDRgfd6XjoIhyjsZUl
	Zx8Q==
X-Received: by 2002:a17:90b:5102:b0:37f:e326:6559 with SMTP id 98e67ed59e1d1-38f295bd22emr1717141a91.22.1784969241124;
        Sat, 25 Jul 2026 01:47:21 -0700 (PDT)
Received: from PC.. ([103.172.209.188])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm6232352c88.8.2026.07.25.01.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:47:20 -0700 (PDT)
From: Mohit Mishra <mishraloopmohit@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mohit Mishra <mishraloopmohit@gmail.com>
Subject: [PATCH 2/2] staging: sm750fb: Remove unused function sm750_enable_dma
Date: Sat, 25 Jul 2026 14:16:49 +0530
Message-ID: <20260725084649.106589-2-mishraloopmohit@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725084649.106589-1-mishraloopmohit@gmail.com>
References: <20260725084649.106589-1-mishraloopmohit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function sm750_enable_dma is defined in ddk750_power.c and declared
in ddk750_power.h, but it is not called anywhere in the driver.

Remove the unused definition and declaration.

This addresses the first task in the drivers/staging/sm750fb/TODO list:
"- refine the code and remove unused code".

Signed-off-by: Mohit Mishra <mishraloopmohit@gmail.com>
---
 drivers/staging/sm750fb/ddk750_power.c | 13 -------------
 drivers/staging/sm750fb/ddk750_power.h |  5 -----
 2 files changed, 18 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index d617f554f58d..e4bea8da1827 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -90,19 +90,6 @@ void sm750_enable_2d_engine(unsigned int enable)
 	sm750_set_current_gate(gate);
 }
 
-void sm750_enable_dma(unsigned int enable)
-{
-	u32 gate;
-
-	/* Enable DMA Gate */
-	gate = peek32(CURRENT_GATE);
-	if (enable)
-		gate |= CURRENT_GATE_DMA;
-	else
-		gate &= ~CURRENT_GATE_DMA;
-
-	sm750_set_current_gate(gate);
-}
 
 /*
  * This function enable/disable the GPIO Engine
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index 1c4f054d7276..0c4ab2120385 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -23,11 +23,6 @@ void sm750_set_current_gate(unsigned int gate);
  */
 void sm750_enable_2d_engine(unsigned int enable);
 
-/*
- * This function enable/disable the DMA Engine
- */
-void sm750_enable_dma(unsigned int enable);
-
 /*
  * This function enable/disable the GPIO Engine
  */
-- 
2.43.0


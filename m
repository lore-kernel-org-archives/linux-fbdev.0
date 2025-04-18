Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E28274FCF;
	Fri, 18 Apr 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744980705; cv=none; b=V6hToU7JgWbqkN/iErGfRfMl970N/P8yAOg4wKZAtVHQzX9Celq3+v6u9+MVQwjYUrP9DJyHr+J4nGLrmBBVUMC2hTAWWp3wp/1iywf4KfpG+hrVs5XFghcMk1CkIPEqE4xwQX8GVINnOb/7oglE90sv6PS5UZFhp100v15IiZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744980705; c=relaxed/simple;
	bh=Tx6xVN7cw+waCo9fc73br/PHvimvHBxuXDpSvbHxWCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n4kCjYiP9MkM+4sv3gNdQY9B++KkuHG44SEXpPzONROACstlAlWsuy2Cpr2hNKIOtkHZq6/S1rj74T5iSoEvompZNbQkfyYGnWk/YLRNON3/8ijAOqsZOd7VWFD+j+o1kKwe9/8VXGHqMbqj1UoOsl5t4abck5DtuNk04VJD8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWP8VhYc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWP8VhYc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0618746bso13227055e9.2;
        Fri, 18 Apr 2025 05:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744980702; x=1745585502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSI7eAOwKER7UtUiex4GHzeLYi9Hq3SA4vwSh7WcZHw=;
        b=EWP8VhYccRqhGCM1wFXi0fkAv6OU4IYnDTWZRtEsyp1lZk0QNo9Qn9E43QSqiWRnI3
         kICaMdbnlSiBzgRS1WK/5AKEOBd7OqH8PwDgopyP/fW1zP1pRH1zEI3WqgR0BSTTN5HJ
         iktwv3uIZUe91gwYT9+9PVkq49t+GBZH6/7dEiRskqMOOmGRh/Gks3rgxrFUbOiPJgHp
         L5iadlRrBVCRZixwrq+zEkhyae0tTSxw0HfEf+KkjjAMk3mK3oNAPh7JFFUV06SiB89t
         z6YKOVTVn5tmhIN0Sd3JOzPh9ldUp6GlTpJXAikzQmOJc43lFCvlESUi+MFyvLl9Jmxa
         qzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744980702; x=1745585502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSI7eAOwKER7UtUiex4GHzeLYi9Hq3SA4vwSh7WcZHw=;
        b=WTt5BdQpdu1MgYOknFLOH7kFLOHx7QYhx+TKsnHwuT8zVVsYPEGYd3MqAyAa/L6xgR
         bRxBpzm5c/ea058Eikm5+Mv36jFbpKdOT/XIBz6gHh88vnK9hagxh+FEohijxyqDRwNU
         MZwGXSoziJjv6AZ7yXj8z41JPK3sE6lgNJW2WsbpuJaTntwRQVz0e2hZeylEyBiNDieZ
         WhB/3gD2YE7de+LRUYOhFtt8NgADfFru7mgAwHmSsE2TWPM79tm44hln8sIokqS9Hmfe
         4PZEvEBf2wlLDnssJKX7MCBPI9zfojwINQ2ktiZQBK3SFohjB++RMio2dJvy4MfUBQ+9
         WOwA==
X-Forwarded-Encrypted: i=1; AJvYcCWrURFJzvKF66ULDAP1Nb3jAYWmnAWqEq3BkoCdusl4uG5BKLx079ivfU66cxha8T3wZGipDozc1nuLLQ==@vger.kernel.org, AJvYcCXqpPwp1D/V/467pyF7jcbnnBd/AHMHPMdJqn75ACgR860lX1OO24mEi+EmXFvxlekMqUfYai8GUJrpSilj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz9dtWlToqOhFT8RpaMMPHmbFtIcaPRaFTP31U2L1+pFhyQNSH
	EwSUIMxNimjltKqDP8W9LFonJIBvOWE6EjuBD+9y4OaNGepLNDo3MnBKMBdxtF7pEg==
X-Gm-Gg: ASbGncsYFdkSYS7y1NfnJNQ8bxWjuAvlSkGJspMWeZsPfTQjtNkLCZZsGh0tuHqMwRs
	KMyILHJXxcRfbQQ9/GDGc4mmA1Yxth/HXmjXX+SLJY+DNaoDsCickD01cStpwTYbM88+Aod3cC1
	NLdDuWEr/w7u154g/UXFwbJxsHKWQKVS/sJECQKH2+oPWW/dm+BiJcTip8hnngdtafh8zFeuet5
	PcoDXdc/yUSQrYUkcEVMzwgh15ff6TPSns4ovbAWZ/ACisvhSckUYJ08kIgxg0xAVJtYb715Nl2
	TrgMcPq1o1h/ACOuLIEXWHY4owJR0on+HdDhyDPQ3g==
X-Google-Smtp-Source: AGHT+IGRLN4xXyDof+aLmH9LIsvIdtLHzEudvt2mvZiXNlcTq7vBl8qMI8mV10llHh3CBdT7Fc0KOQ==
X-Received: by 2002:a05:6000:2283:b0:390:d6ab:6c49 with SMTP id ffacd0b85a97d-39efba6ba65mr2283592f8f.35.1744980701688;
        Fri, 18 Apr 2025 05:51:41 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa433133sm2656282f8f.28.2025.04.18.05.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 05:51:41 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Colin Ian King <colin.i.king@gmail.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] fbdev/carminefb: Fix spelling mistake of CARMINE_TOTAL_DIPLAY_MEM
Date: Fri, 18 Apr 2025 13:51:35 +0100
Message-ID: <20250418125135.539908-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in macro CARMINE_TOTAL_DIPLAY_MEM. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/video/fbdev/carminefb.c | 8 ++++----
 drivers/video/fbdev/carminefb.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/carminefb.c b/drivers/video/fbdev/carminefb.c
index e56065cdba97..2bdd67595891 100644
--- a/drivers/video/fbdev/carminefb.c
+++ b/drivers/video/fbdev/carminefb.c
@@ -649,13 +649,13 @@ static int carminefb_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 	 * is required for that largest resolution to avoid remaps at run
 	 * time
 	 */
-	if (carminefb_fix.smem_len > CARMINE_TOTAL_DIPLAY_MEM)
-		carminefb_fix.smem_len = CARMINE_TOTAL_DIPLAY_MEM;
+	if (carminefb_fix.smem_len > CARMINE_TOTAL_DISPLAY_MEM)
+		carminefb_fix.smem_len = CARMINE_TOTAL_DISPLAY_MEM;
 
-	else if (carminefb_fix.smem_len < CARMINE_TOTAL_DIPLAY_MEM) {
+	else if (carminefb_fix.smem_len < CARMINE_TOTAL_DISPLAY_MEM) {
 		printk(KERN_ERR "carminefb: Memory bar is only %d bytes, %d "
 				"are required.", carminefb_fix.smem_len,
-				CARMINE_TOTAL_DIPLAY_MEM);
+				CARMINE_TOTAL_DISPLAY_MEM);
 		goto err_unmap_vregs;
 	}
 
diff --git a/drivers/video/fbdev/carminefb.h b/drivers/video/fbdev/carminefb.h
index 297688eba469..c9825481d96b 100644
--- a/drivers/video/fbdev/carminefb.h
+++ b/drivers/video/fbdev/carminefb.h
@@ -7,7 +7,7 @@
 
 #define MAX_DISPLAY	2
 #define CARMINE_DISPLAY_MEM	(800 * 600 * 4)
-#define CARMINE_TOTAL_DIPLAY_MEM	(CARMINE_DISPLAY_MEM * MAX_DISPLAY)
+#define CARMINE_TOTAL_DISPLAY_MEM	(CARMINE_DISPLAY_MEM * MAX_DISPLAY)
 
 #define CARMINE_USE_DISPLAY0	(1 << 0)
 #define CARMINE_USE_DISPLAY1	(1 << 1)
-- 
2.49.0


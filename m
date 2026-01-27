Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96010304BA3
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Jan 2026 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528465; cv=none; b=LnCiHgleG42ZSYiY4BC0RuuJu99NCs3eX1AUVa3gP1V5G50GMjEEnn6oZ8T7T8fl74kLcqL8SyDzuFy0dRsE64eg3yP2LHenX7iayb4ZjhWEAkX5PbgFkcLso+Tvk648tuVJV2OO7BD6WxboZERYbF2tWie1Yro+wnqF34B94pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528465; c=relaxed/simple;
	bh=aFDX34ybk/Kqa5bE8bFWwCkyvn6Pr2LS21JJKYV7n2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oe3bI016xSlY94vM9lB9Iy/lCBUL5TLBVXoBb2aeIlBi+ok79a0ggqFknay3k1wSxvv730oNnzwqw0Pxyj/gABDzfN7GrsnLc1s2Yw1X4MJ04G2q9p/fhRlIB7JEOe0pQdoS/8Y/WmSy1J7nnt7aaLChHqXmRLEHpvluo3LpT9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGmljhsi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGmljhsi"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43596062728so4169386f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Jan 2026 07:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769528462; x=1770133262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vxdGKRED/GezH50A93RC3QHz4tAJqHqw5Wvg3bxqlKY=;
        b=JGmljhsiLYN9Adt7r8B3UTMuq4Y0p+SLrV4HyHaX5SmIMnrsrX0uUCPKBfROpFzaxV
         R5aCQcaAvi1rodcAu7hldWy8szw76Jkyg/yTveAuTgHnpR3DS4ca3ju7t9LxmL/8Fblo
         e2ZCRKrI7DLwlSRwjakAG4/XaXb/WG4EwYi5wDLfWQsHojEdyks4J3a8qVishCTxIT0m
         FIoPAFm6uhpPh3GbAKS9Cc6k2pzwvstJpRSM+Ul2gPJrEsGxOhBkOk8hQgrQYTjSGSPr
         djgHrhSHhv6MBgWDHXVcpnZhiw1dazdgdbGen+vCLmbC0jzmkL6PTpPPG2VNdToU7oD6
         bDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769528462; x=1770133262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxdGKRED/GezH50A93RC3QHz4tAJqHqw5Wvg3bxqlKY=;
        b=FmXFjDVWyoSQlyJX5ygQJuOXQHpCjHz1bWn3PhXRSj3G5DPE7F+sw4OzJxRls9CJm+
         09RXzDE3g1n8rZRUTyt1aIcEoxL0s/tKisTEWnivnIuTkk4BYgVgytNokigsp3La/tSt
         NKPkp1gN607TR+ZQsu+3xga2Ivluq1z2GDlShBDeBKtFWy+wsJKpr6B8MMZDMOADOI3+
         1IjZ/e1kjMg8aPG/Kb/zaQOtV121Lz8JkgWIG07sWQP6K+Gh28QzRy2ifxR8cKB5Mpm5
         MNJoNhwzCRCXn/EcMcqWX7u+vfyIVeC09q5BJZR8Q/xI6sQVzji8bIL156/eTlAI3ZtH
         Pvlg==
X-Gm-Message-State: AOJu0YxgAkUYpN44XVghw1tKNrbcPOXO0AZotfoOqJDYAhGMGOKE7DKC
	MBlqWpaiP8mqPWmajddMeNnZYrhF9mX+oy/UZbL6LuISRsMT2itKtWwI
X-Gm-Gg: AZuq6aLOxPZR0DfweVgrgc5Qf3xWuV1qdzvaFCrWJK/2zy5Cu/XlzKmsEW3In55vKOf
	znwp9Ft7Uz7UeGW9a8YclIKEdUjNl956JCmX3+1agadqZZRgGDQc8ELk9XROr93d61xfesy7WVJ
	n2w38+JaJl9OPUbtw4Nwtz3RSaOMH2MAPgoGLP4fFzkItlMBTEhBF3y+Z3yeD6MmCK5e/ZgvxR7
	4xXlAUbk42uYSp/09nOz2TE+qAxZHBaGIy3eNGco+NP5Ipt0Wp6yQ7Q7cWYb6Zigj7qiQzUKMyC
	+EAKS5CUMLomtwmG3Bm2kUgD3P+asy+mxN0WhChl/9IIhC1sKSJIHPD84Fz7LfkLGOz/lLf+UuN
	eJOrjx9gWUVNYlv1Dw79ut0vgXSmwcSa9QJauQ9m87q0Id6FL4VXAu/vvRAdCL70br5Tiq86/2i
	CS2FXWhHPZulXn9+laeY8=
X-Received: by 2002:a05:6000:1acc:b0:435:9538:939b with SMTP id ffacd0b85a97d-435dd0bdf07mr3190440f8f.8.1769528461541;
        Tue, 27 Jan 2026 07:41:01 -0800 (PST)
Received: from Madhu.broadband ([83.106.123.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c0179bsm38451602f8f.1.2026.01.27.07.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:41:01 -0800 (PST)
From: Madhumitha Sundar <madhuananda18@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Madhumitha Sundar <madhuananda18@gmail.com>
Subject: [PATCH v2] staging: sm750fb: replace magic number with jiffies timeout
Date: Tue, 27 Jan 2026 15:40:56 +0000
Message-ID: <20260127154056.74855-1-madhuananda18@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware wait loop in hw_sm750_de_wait used a hardcoded loop
counter (0x10000000), which depends on CPU speed and is unreliable.

Replace the loop counter with a jiffies-based timeout (1 second)
using time_before(). This ensures consistent delays across architectures.

Signed-off-by: Madhumitha Sundar <madhuananda18@gmail.com>
---
Changes in v2:
 - Switched from loop counter to jiffies + cpu_relax() as requested by Greg KH.
---
 drivers/staging/sm750fb/sm750_hw.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index ce46f240c..b24d27a77 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -523,19 +523,32 @@ int hw_sm750le_de_wait(void)
 
 int hw_sm750_de_wait(void)
 {
-	int i = 0x10000000;
+	/* Wait for 1 second (HZ) */
+	unsigned long timeout = jiffies + HZ;
 	unsigned int mask = SYSTEM_CTRL_DE_STATUS_BUSY |
 			    SYSTEM_CTRL_DE_FIFO_EMPTY |
 			    SYSTEM_CTRL_DE_MEM_FIFO_EMPTY;
+	unsigned int val;
 
-	while (i--) {
-		unsigned int val = peek32(SYSTEM_CTRL);
+	/* Run while Current Time is BEFORE the Deadline */
+	while (time_before(jiffies, timeout)) {
+		val = peek32(SYSTEM_CTRL);
 
+		/* If Not Busy (0) AND Buffers Empty (1), we are good */
 		if ((val & mask) ==
 		    (SYSTEM_CTRL_DE_FIFO_EMPTY | SYSTEM_CTRL_DE_MEM_FIFO_EMPTY))
 			return 0;
+
+		/* Polite pause to save power */
+		cpu_relax();
 	}
-	/* timeout error */
+
+	/* Final check in case we succeeded at the last millisecond */
+	val = peek32(SYSTEM_CTRL);
+	if ((val & mask) ==
+	    (SYSTEM_CTRL_DE_FIFO_EMPTY | SYSTEM_CTRL_DE_MEM_FIFO_EMPTY))
+		return 0;
+
 	return -1;
 }
 
-- 
2.43.0


Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08129F50F;
	Sat, 14 Jun 2025 00:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749862265; cv=none; b=TPM/vyvYxz0cBxTUfHnOv+9UUO9DK+4HA3W5Dbh94kGRESPiLKaSGegmLYOqkgtT4c6pl+1rtHfG6AFIqQrkAkH3HBYBqF26gx8aStPv+TsdVNRLxVMJmAFrEJBmv/s231L0keebBwSw4hzIe4APThE/9Y4eiEi17nGm4r+xW5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749862265; c=relaxed/simple;
	bh=QjxExhgrl9lF8XR8OVzaUuJbjCmCwGrqDlGqJiLGARQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lhWSIRBtPrF0uSNfmchMkKqRxnBrlVHXkpLumTD6UDzAtkBwJTWsQg55OLBqi/WU6JUIP+OHrl4LuROfxCOiKWK5sa9KFZSr9uirsgZ0n296iM8AufybU/BHDuU2O5gDBD8/K/t9Dt28uqTJxiGbT1dQc52PyRrYfg0Vji0WQ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eN94EsOA; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN94EsOA"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e81877c1ed6so3546750276.0;
        Fri, 13 Jun 2025 17:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749862263; x=1750467063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4BvcwXUpYpF53aglFHdWaMYuKTVfMzFy1gAx/zcHH8=;
        b=eN94EsOAW64HvqSQZEErJW6JklMCQDfrSW1xFwUCKdZb1lOq4FOafejWCjWDjrhtJE
         61xJcjPkY2Kb+mwpPCP/INOkWL9qzJksMIhlYiy7i05uQEn63HKDXKOXQowvo+g7Hl1a
         cxK4GZpjwVSdYMyr5kcvh5CC2GiGk3S+7CVNAp7WJ7khNgnqmIjsgYVOIMrg4GTNHi8a
         Bv5nJN92O1DmyKP/lf3tPTJZ0zzNUwl5ggTRQKmP846Yzi2giv5BkbXgx8WDR//r2+n/
         6mNJUBmXJY+CNLCG54ZL2T4PztDIwcVY7CJ9WoIoYXO+xzvhWXwhj6spiulRFc1iyvMJ
         hHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749862263; x=1750467063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4BvcwXUpYpF53aglFHdWaMYuKTVfMzFy1gAx/zcHH8=;
        b=e01qX6HUJGgi+nLTFOSe4vpJq8ICuni0aynU3Le58TeQoyM+5rZLkB6pXezrfDh1iD
         e0G6x0f/tXaHToqi3TIs1CNU0J8BlovdLHAktt2xXdYdmGKc195C1DoQl0uw0er32rTt
         btIGRU+Us2uEeShv+eysHWdn67ixgDB+p4zp8VbbCXetCs7l5VYQOmLJ/KYB5so8aY6v
         uNPrmOwATrmBxYUZcYW6Txgyhpr9t47gfWiZbKTuGwdwpDetwS4HD559knDS+JckLiHH
         Hk4w5/aYpNk8WrWsH4GUDc6XnIOFJJbkeCCHymNOfBwRCfV8yX5DJZ65CiG8IpnIDddk
         bcnA==
X-Forwarded-Encrypted: i=1; AJvYcCUTgpHDAJnZDPCPs7LI1PgHVhHlTWG3Jo7Vgs2EtGjJttO1lJ6cpyhWagJ0KTSBb1O3w2VEn/uX8mlKRA==@vger.kernel.org, AJvYcCXmQHjDjWkpMDQS5vH0FcFnPX7Eh4reMNSFLmU+EvBpmwykPcg9G7G/g9lonz9vVTehz5n/6a5IPZTob8P5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0ysd1e9jl5NHBOZznABmLObttgcAauxBfd2DuCnJH/rZpKEt
	fPtjPtNG4XR3H73bpMJRJYPBY7fVCJe8KDjxMCLrHQwVWUxQF4yt9K0T
X-Gm-Gg: ASbGncvgag3EXW8b+NYxTDVI/wWqaLAUBqGScuzno7vB7oIhe6AoiXzeA0CHWt/ZB0C
	wwE8oJ3DQRanVsotAxSX2UQNiMmmHw5t5+C7Q4NZrNtcXFLdIcTXbAGbCa63ffHUW/rpwAOCBmV
	0eGsLb/JTAEL7TguG3JPT+EPIycEGZe6UFfJnN5MMw8EPX7dF15nh6tRPviAF3V7kkjHMgR6TAd
	8jDRwHVk28niGLdyKE2WcZKTZETh3fDhI3XTsCXgiLv9skKKSvziQIFOFqUA7+gRwDBBqiQ70eW
	nYn473K3wAhN1VmdiNmOOhZhV5q/vy0JsThcF14iZq0VIxGw3cEwnpt9FlAfps9hv7mpShDnuKa
	FkBnmiSxU0A8=
X-Google-Smtp-Source: AGHT+IESW6urO3WUlGFtx1OVEKIz7u5UMPmvMN/XKB+gqkytA6iQPBFo0Ygy9Q8aFIp9XHXF40d4YA==
X-Received: by 2002:a05:6902:2186:b0:e81:b5c8:3d71 with SMTP id 3f1490d57ef6-e82281be2b4mr3513048276.17.1749862262905;
        Fri, 13 Jun 2025 17:51:02 -0700 (PDT)
Received: from trojai4.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e820e09b464sm1409902276.20.2025.06.13.17.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 17:51:02 -0700 (PDT)
From: Alex Guo <alexguo1023@gmail.com>
To: deller@gmx.de
Cc: alexguo1023@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: sstfb: Fix potential divide by zero
Date: Fri, 13 Jun 2025 20:50:59 -0400
Message-Id: <20250614005059.3108265-1-alexguo1023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable var->pixclock can be set by user. In case it equals to
 zero, divide by zero would occur in sstfb_check_var. Similar
crashes have happened in other fbdev drivers. We fix this by
checking whether 'pixclock' is zero.

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
 drivers/video/fbdev/sstfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index 2ea947f57efb..fd387ca8401b 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -359,7 +359,7 @@ static int sstfb_check_var(struct fb_var_screeninfo *var,
 	int tiles_in_X, real_length;
 	unsigned int freq;
 
-	if (sst_calc_pll(PICOS2KHZ(var->pixclock), &freq, &par->pll)) {
+	if (var->pixclock && sst_calc_pll(PICOS2KHZ(var->pixclock), &freq, &par->pll)) {
 		printk(KERN_ERR "sstfb: Pixclock at %ld KHZ out of range\n",
 				PICOS2KHZ(var->pixclock));
 		return -EINVAL;
-- 
2.34.1


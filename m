Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0DD2EC566;
	Tue,  9 Sep 2025 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397816; cv=none; b=merOCh7+3cOp+tDfThCovSTKpoiJ6rlPZxWYYxjcQRmMDUYOBJCxCsJxT2w1bDOeiIyXyYINbdeh3NfGG8/tJsrXuB6xZPDJgdhIOTFQQbB3s5YqUD32MShAKERhhXLw01fUq8Y4joPCV8VPZ3cDyRsEl+vEcFMmX5LuL17T4k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397816; c=relaxed/simple;
	bh=NYidWFhDgt/4rQVlgu/c+IOpo3PHLcdSChCn6MGsfy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzpX3UtAUxh8re9UYbmI+YfnBhOfgtK7t4lbtRWh3omtpxUaC6MGvCekqTiSZfbNAWCf2HlRocPRlrJMgcI3rK2GhoPn/mwNkItUikmCItcRho2SBvvwiKqz1jM3rco8tGqNILpIz2//YZwhI+OS+p8sRARLASl/St/6r/aAXHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StdSGVtd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StdSGVtd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24c784130e6so58068935ad.3;
        Mon, 08 Sep 2025 23:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757397814; x=1758002614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ybb16mUwQT+FBVaymvV+gG0Hd0qAFn+Ahs5rmcoHhyc=;
        b=StdSGVtdrq+z9xRd+gpA1nnCHxm8SXzUOVuUoalnZBewG/T12urvLnCGxyAS0OvA0L
         56pSFidCuzgVnPIi3wxf0SZYNPM5Dhy6jG4grWVDCkBQtPCpE+gmK3g8Ng0Ls514JMEt
         ldMaczV29gV/2wDd2iqRKNi2tGTsRzmHcHaLm8N43RX8of7xuXoA9/KdXuM4xr68XLHg
         u5/D5ttzUWDRbf3jpSCZ0T2v23oACwFJudreWatzqvAjBHV7xXVaeBFjtR1evnzGE9ms
         vdE05ur4q4FDwffYZEHZQYAWlscplSfCg/AAWB8FDcY3gWxuEs/aQtPrOjL8dNknXqhT
         rPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757397814; x=1758002614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ybb16mUwQT+FBVaymvV+gG0Hd0qAFn+Ahs5rmcoHhyc=;
        b=BYiE3UCPOUI3yCqnwWhmyO6f8W/6ACb/RwfTZ/PhZXtRG2CVrHmzOCf3HAHSIGu2/o
         tdTy6Z73v7BHlBRF9nVR/5olu5sD+U+bZh6TeBZw7/1VkYv/YZhe9q8UhdBq+m0twUxy
         OhKz7VAcV7AQUVI5WR0SmW2sEW7H8aPD+Vx+a3LPdq2z0pYGYaCXMwTwJUram7PKyaeN
         fUcqO1Ai43nLtpXVD9MzPAPlsPBG5Oco1leIGfxjVTUPuJvOtSnsn47B4UUuyfUpW37f
         9Fwn+EBRilBKNqd/+5NtniaXKxiPZ6GgQXCxQNVQfG6Aai27rrOnfa7Zc1CgCn9kHuI+
         iLwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGvEEToG78qYyjIu8j+ccrD4tl0/iXf4EOogI7D+D4kBiEXlEt1XPpSMwn+K9ujPjr2Ntqa5fHaLWXag==@vger.kernel.org, AJvYcCW7OKg0712pswPW7rWTRQ32ex8XG7dHX+sOApAYE4GKBf67E2i0Y1bsz63G+cEtyH6v6oTRSzJfQ0WxSs5d@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbbTy9FSXunfQh16jwVq12iC4/kmAhr1R7L6i11EeDJqr1z/K
	M2LKxQkW+PT11BfVCmMqR7CcEOwS25tEiogw8UGYEbbhf3DpFs9tL8dd
X-Gm-Gg: ASbGncvbrnlL3bVBrIERVI7WJK7VGTxCBa4ikQM7kyhtEDB7w4RRfLXgEaS8biYAgDs
	pfAFYvS0cVuwyoMHSc6p5dNz2S9jJok1WA8Ew1JvOnPMLSzzL9TXm8+KWF3QUp3p+RssNcW14wd
	IVX9854njJyV1uzSz1aOleKJcGJBU29yfu2md0Yb5xRumXpCQ/3w/zNOdE+Z0M6/wOc7S1DNOLw
	bY4aiMywtIkTdP8cNJ0lzeVNARyGedeTZ41xugo3k1kEyUgXBfW+jpjYbY0dP4d1o8bRcfat6bl
	a1FpjEJ5h/3mGPkOtIqXL7SUwLOq5Gst9+Pr7ZDra+Kbx0qBNm0txlCzyK3wSuChtpoMeV9oThl
	ukEmgV61vDfBJhqEvBbHx+GxGh1uc9cMxapMOtxqiwBY6zfXryB37WjINKZ66ExslTDTMnubBM4
	zb0V35b6z65x8mtZwL2miTQpU=
X-Google-Smtp-Source: AGHT+IEWUWYh4uKLh52T8RIw5gvJl4jnAS8UqIpPPCvXwtb088lnW3/RvdIz0c1aBVLTnnqXeAra+A==
X-Received: by 2002:a17:903:1111:b0:251:3d1c:81f4 with SMTP id d9443c01a7336-25173bbbab1mr171289945ad.54.1757397814401;
        Mon, 08 Sep 2025 23:03:34 -0700 (PDT)
Received: from klmny09 (n058152109064.netvigator.com. [58.152.109.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903724b94sm298665455ad.35.2025.09.08.23.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:03:34 -0700 (PDT)
From: Yiming Qian <qianym1996@gmail.com>
To: dan.carpenter@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	qianym1996@gmail.com,
	sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Subject: [PATCH v2 1/2] staging: sm750fb: remove unnecessary volatile qualifiers
Date: Tue,  9 Sep 2025 14:01:29 +0800
Message-ID: <20250909060130.12919-2-qianym1996@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909060130.12919-1-qianym1996@gmail.com>
References: <aL5tjv_2YkvHPs5C@stanley.mountain>
 <20250909060130.12919-1-qianym1996@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of 'volatile' for memory-mapped I/O pointers is discouraged
in the Linux kernel as per
Documentation/process/volatile-considered-harmful.rst.

This patch removes the unnecessary 'volatile' qualifiers from the
lynx_accel struct members, improving code quality and maintainability.

Signed-off-by: Yiming Qian <qianym1996@gmail.com>
---
 drivers/staging/sm750fb/sm750.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d7f40efe3..41f1fb390 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -50,9 +50,9 @@ struct init_status {
 
 struct lynx_accel {
 	/* base virtual address of DPR registers */
-	volatile unsigned char __iomem *dprBase;
+	unsigned char __iomem *dprBase;
 	/* base virtual address of de data port */
-	volatile unsigned char __iomem *dpPortBase;
+	unsigned char __iomem *dpPortBase;
 
 	/* function pointers */
 	void (*de_init)(struct lynx_accel *accel);
@@ -128,7 +128,7 @@ struct lynx_cursor {
 	char __iomem *vstart;
 	int offset;
 	/* mmio addr of hw cursor */
-	volatile char __iomem *mmio;
+	char __iomem *mmio;
 };
 
 struct lynxfb_crtc {
-- 
2.51.0


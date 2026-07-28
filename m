Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC0C3AFCF8
	for <linux-fbdev@vger.kernel.org>; Tue, 28 Jul 2026 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785278407; cv=none; b=fUdIU3DIX40VCk+mAYCDt3oAxp5X57zGOUY9e5yY7jFRG9iwrGzjw4byQa0vfHxDYTXaYv9MMYN0Q3EnKP4Z3k5UAi7FTL1QdVGUDi9TVhARWlF4UAFizT8t3QdVUxjzaMUzN+T9f1/9OlCKXcLHDV00UpZJORcdM12S4p9IywY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785278407; c=relaxed/simple;
	bh=2se3aOv9/5GrHaham5C+DJtZbUroCRjXB7PwS1jc+U4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUR6CWefTo+3mwi54+gTtFg0WovHJ1QAbdZWg/3ITicycN+GXAR0K3XM8AP4oNXF/nRprCcAwMuIJ0cBAZ3o+xN2tNHJSC2AisB38yA7MazBU8XXCkDffA5ixBJC68Wids+ZHMjgABvJPsHhYlBiRJiK6McwD/u1oUfG7f5rF+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxEGVz/U; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxEGVz/U"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so212572a91.1
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Jul 2026 15:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785278406; x=1785883206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HFtUghgVXhXCFuPyxhJvt/ikNqme5a7AZrChDZVSnc0=;
        b=jxEGVz/UxR9iEpbApI/JKEWZbi9e5wkjVoTt5X8W4iQt6DAyUmGzkKwC7NCNwbhCeQ
         VmOU4Gho3LKnWtz0hexhiEh8FZLyaoCuAZ0EOlZ18ckvM0n/mWklmCnriIf4eeOWebhd
         Ydpxb9ZzGTp0qnCS8ZIb6/2krxM40kBsnmxhhgWK6aFXbZGXYNTU652A/jDAMAQUikOi
         R/Be13iRyjN+JNGUj6o26pCdJLA+/hHWwNW6mEZug/IiLx38Nd6/32F1vm2SEFZfHnWh
         C5V120YFbLAT5KZeK9AkXUv+iplfP/OYpHtjxsUzeC0Iq6WcWFmNYJe1POvMwL9vvEEA
         RJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785278406; x=1785883206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HFtUghgVXhXCFuPyxhJvt/ikNqme5a7AZrChDZVSnc0=;
        b=cyqn8isItufFUZIlXX/T5GwT9on1PvnBbFTPwgMXn0nYn7gUez0FFnfapHKaIylepj
         hFkvpXGGK2e68W2KPbBU3YscKqUUZBaHJXNDmTCF2O7+JshkxT6nuLR1dAPr0QV9KheO
         qTZ4D1v9CZGedvbbBxsndfuC8Efx4aiDXLDvm8+zA8Y/NllH89ujfJg69P3ahT16e6wT
         KC5v2pAZce5EJuOj6WUYjiFmkoG7GFUCnCITFlRk1VMtDKZBlu83VlkSyybErva89b0r
         4XhWxWkU+uz4mMqsfNKhHAgjpA9TqM6X+4FCDtqM173wPsD7hVLD+kiHKc4lsPkAP8Go
         QUEQ==
X-Gm-Message-State: AOJu0YxxuItbIrdxSlzm4+exfSR+t6yxxcCvOPGlTvgYS7pGVgIr6qpY
	pCmnS+vbRl9IeHxj48irbq7PSTIdWNx7ivGaUVXNNjmD9l75pJ5BmJ0e
X-Gm-Gg: AR+sD10K6SuNFd3SwmDEbkmcNQgi4XBW4HnFA5fHqJKMKMFyFyxDu6uaf1xKKsFcUGY
	8I7hYshNSvRgAF7K6rayNstBKHnFEYi/cBhhxXmMrSXaLKA7oFDdLc5g8siMN0gr2tBA8R1R8+e
	PCdqmIGKZkVTvxm511dUpwuOMlrBp4jR5Qovwfp6PcmRT0HhFH7hwM4zH3rqI8k2VXAK6X54sAn
	bC5s6Nl2YeBac1Epxd/N2wFQUSAymsoq1yCL3my8cg3gx9gmuDNswXzLSV3NULF+5zX7bSsaqgw
	UkYcHc6Uo8udNo+D51qV3N3HgN7AteyivxLFkEynpS3jt/3Z3La+jxomuPpi+EG1LWJNoD0t3iD
	VQUFxY4aj3ZHtVxmeNatVRgJvvW52Wsfv1E2vvgHfIfxPTPbsQReYvzkm5G98I7QdyNK7J+piaf
	CpBz26PhiPEMbGgdNh/iF2mLxo5QnPmSVV64R140CQ8I6HM7BBWzWI8eny/p9FSpVHO2jy4eGKJ
	dHzAv0uKL2AnosLbUAjLhLvH7kIKks33OGTozw6WDdjbzO51vtjIH1VdrYJglzZ9Rw5nW2TlQfl
	/b6VIp0Krgr0Lhz17QRM96PTkuajRsxzz2FP2s0=
X-Received: by 2002:a17:90b:3848:b0:38e:4e62:f998 with SMTP id 98e67ed59e1d1-38f6a556542mr4751169a91.23.1785278405697;
        Tue, 28 Jul 2026 15:40:05 -0700 (PDT)
Received: from localhost.localdomain (c-67-170-60-64.hsd1.wa.comcast.net. [67.170.60.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f12f965sm480915a91.5.2026.07.28.15.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 15:40:04 -0700 (PDT)
From: Gabriel Changamire <gaberashawn@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gabriel Changamire <gaberashawn@gmail.com>
Subject: [PATCH] staging: sm750fb: fix kernel-doc comments in sm750_accel.h
Date: Tue, 28 Jul 2026 22:39:06 +0000
Message-ID: <20260728223906.350-1-gaberashawn@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the function name typo in the kernel-doc comment for
sm750_hw_copyarea() (sm750_hm_copyarea) and add the missing @accel
parameter descriptions for sm750_hw_copyarea() and
sm750_hw_imageblit(), using the same wording as the corresponding
comments in sm750_accel.c.

This silences the kernel-doc warnings about the mismatched function
name and the undescribed accel parameters. No functional change.

Signed-off-by: Gabriel Changamire <gaberashawn@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 617885431661..e76928bf260f 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -195,7 +195,8 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 		      u32 color, u32 rop);
 
 /**
- * sm750_hm_copyarea
+ * sm750_hw_copyarea
+ * @accel: Acceleration device data
  * @source_base: Address of source: offset in frame buffer
  * @source_pitch: Pitch value of source surface in BYTE
  * @sx: Starting x coordinate of source surface
@@ -219,6 +220,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 
 /**
  * sm750_hw_imageblit
+ * @accel: Acceleration device data
  * @src_buf: pointer to start of source buffer in system memory
  * @src_delta: Pitch value (in bytes) of the source buffer, +ive means top down
  *>-----      and -ive mean button up
-- 
2.47.3


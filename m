Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794650547;
	b=f1o1AGkEjl8n2R17aVY7j3TcUK2ycDGJ5ZATOhLgqL4UR+ydFz6Te+VmRs+e1fs5/+JS
	 du7t7wXxCvUFd0ty41xs3OHkEKXlcqXhi22DqOgU/wM9zYV+dN5tYjY0onb3biIJCIzsY
	 IFIF9U7fVcBHexGzqq4wjrbmxBdRx7iKSe3Dy6ObkXpeilBwT3GhkPVJUxs/w1oYXZso2
	 Xu7zxDWj/W2NzQGvUrlNuJ4vmPHtcbYcwdmcXNaHIlvwAwxnPlhVcEu17H8rOn9/Vbfrc
	 svQE0ONpiTjX39g9yQlZAJdMphO1DOv+GjoO/z+Ds6hS0vT32k/pNrCHZpfETfUEz8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794650547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=f5u5RK69/mPjrOb3K0zsus8OBr6kPMDbdsuU8MpIs+4=;
	b=K8ZVgODZyLoGsc/Ym71XoI0LtMd99L/EzAKxaL5XCFmAF4fxwktegs4R2qM8l9HDFNrA
	 GQOsHWmtlPv51PzO1YRwdQWN7pTCbo+UB3p+5YQS3VLFQELGKj1RODgMKn1ys1YVO2mqB
	 tmSMbotTU5u998N888hbAp6m+cQJBvACbSdvI14NRjp+E2ZFBd5lAxe+kkn/9yUUPSRNo
	 juljGWK+svb1oNvzSqaW2dUjg/EkIJy8V06VQK14BvwFDWdAxu7NNdUT2hqXCwOyRK315
	 MDH4K5KxQ/qecODfzBdXKAWXkz1qEH2wLM1djPcRfqeld9WFST+sDCyu84kOC0nGZyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MxwLk3DV;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE809606A88F
	for <linux-fbdev@vger.kernel.org>; Sat, 14 Nov 2026 10:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE809606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MxwLk3DV
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb61185057so3288565e9.1
        for <linux-fbdev@vger.kernel.org>; Sat, 14 Nov 2026 02:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794650545; x=1795255345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f5u5RK69/mPjrOb3K0zsus8OBr6kPMDbdsuU8MpIs+4=;
        b=MxwLk3DVfCLIFb1ydz/S3v35TM+sQoaNv9J6rVkZlvovrxMD0J4GOrpLGFGX0k+TZE
         vAnEA2AGZSYERfvJ75He5kwyoEC6orUcXcHVy2b+ac4w3PPtGpjmsjEONWR2eORbGsJc
         pZCYGDGDbRaSz/AHMbRiGVGYuK/CMaBasaVZg/gfWNe2yDGZ6Q9IDPvKFTAu0w84tejA
         nVndqfqYsm6n1BDJS+BbC2UZbL401ghzlNl/pLTGZRHNCXta+Kzb9o+1vBXqIXeMAsk0
         bZMwqVcf2AIc52RKPJE5ypXW25p/eapqQVvsRMt8c5elf93XDI5EHF5f6tSZobnlJfuX
         Pp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794650545; x=1795255345;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f5u5RK69/mPjrOb3K0zsus8OBr6kPMDbdsuU8MpIs+4=;
        b=biWXLFFYaWyQmKyw5S5t8uBWDoJPSe4bVMnZNfO1n5BCHwq+MSfbeaV4LMrwUr4bn8
         jlvyblPySVYjSuUEvYW5zr7VHuBHR27+gmGshwBK8DXfVcYqiAQViy17xXhA/NkQFl3T
         r/oPh84Z3qTWGPzIfd5tCxzpz+YWtvwR/fJwuKffC/acZyg0OMS2HwWywii9XSKWxBVO
         9DwadexyYZ9YiyTNPIcJSNYpBhT5rEZ+oLTdZ2kniHfIRitG9dELS/sN3J75jj5eGXVK
         p/e9/QxXM+cn/46VRr2qrZLpXrjo7Suhx/xUbogU31ofxYjMb30TQbeukmBs31RQDyFp
         NRCw==
X-Forwarded-Encrypted: i=1; AL+hErEOD9152L3RqvgOFSlrtVtzrAkW96IZojtrIy8wgsAbgu+5J/th2X542gvlf30Dw4vG4QGpQMVbfr6i6A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+fXucbM6ZDEyWuoFVjliST8Trb/bMuj4hw3lrjjhKtf1+R8ry8
	XvzmpxyxAeVXvKZNmhFL4mdZ/QGurZoi/ztiJ2/1hwH3RwMI6rwNrZ6o
X-Gm-Gg: AYBFou2Uha7+dIMcqPm9o31Q//RuDkhEU6DHMRNXCEf3fshaHD7on/dQnZIp+z9Gqfm
	dhtRITLJFJakrSm5i0XC2kkuvLV15F+s0hAYt3CENhs/CtDciVBJdW5SsO2RBhXUDme0MkXDZOF
	VWyuK4rZWczBiDwFbGoiZcLRJgZSMCobitVi1hPsPcQ5h6rzzJt0uDM85rRmAKuI7Ybyg58+X5q
	kBoig+cwslPuHOZXe8bnuPjjWWTq8s9QTAKcezize36GrPxhrfxgXo+LpSSvP4SvWNSNbeqO1Vu
	DZ6viCs91U8oK30bZDLRY1J8QF+yLRTe9JAkkH37M9Vi63snpBjgU5LwhIc2eMWC09kOAmLbMo2
	iR2ORkzi1ZWnptbcQUUFp/VIb6S8DQCcWPRGwMantk0Ok+mTJidP7cH5NZ13laOFk7FC1Pq7Dh2
	YEm91h2qSwvM/dLgBz/wqYIDJJkghAUP/Ghrd1ZAHQ0iOxzbVo+phOibrU4voXYRVEIbA0EujOT
	lZ3h0NAr0Q1LrdHOcSF0tP78+lQRBScG8+gXTDPLmleZfhf6lRC+xeMJWNva/CL5pT1jV/SnRtv
	0CYsevhqRvKcVlx5BwbKP7AtIXgs0kuEYQ==
X-Received: by 2002:a05:6000:430a:b0:48d:f14a:9182 with SMTP id ffacd0b85a97d-49c6fd93307mr12159903f8f.20.1794650544657;
        Sat, 14 Nov 2026 02:02:24 -0800 (PST)
Received: from DESKTOP-TMG47OE ([176.41.25.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608cf46dsm10520184f8f.43.2026.11.14.02.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 02:02:23 -0800 (PST)
From: =?UTF-8?q?Ali=20K=C3=B6se?= <shroot1337@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	rppt@kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: sm750fb: Fix DAC power-off bit handling
Date: Sat, 14 Nov 2026 13:02:06 +0300
Message-ID: <20261114100207.9124-3-shroot1337@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114100207.9124-1-shroot1337@gmail.com>
References: <20261114100207.9124-1-shroot1337@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The DAC state extracted by ddk750_set_logical_disp_out() is either
0 or 1, but MISC_CTRL_DAC_POWER_OFF occupies bit 20. OR-ing the
extracted value directly into MISC_CTRL therefore clears the DAC
power-off bit and, when off is requested, sets bit 0 instead.

Translate the state into MISC_CTRL_DAC_POWER_OFF before updating
the register, preserving unrelated bits.

Fixes: 5372350be30a ("staging: sm750fb: use BIT macro for MISC_CTRL single-bit fields")
Signed-off-by: Ali Köse <shroot1337@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index d619e00fd88e..dbbdbe08ad38 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -7,7 +7,8 @@
 static void set_dac(unsigned int off)
 {
 	poke32(MISC_CTRL,
-	       (peek32(MISC_CTRL) & ~MISC_CTRL_DAC_POWER_OFF) | off);
+	       (peek32(MISC_CTRL) & ~MISC_CTRL_DAC_POWER_OFF) |
+	       (off ? MISC_CTRL_DAC_POWER_OFF : 0));
 }
 
 static void set_display_control(int ctrl, int disp_state)
-- 
2.53.0


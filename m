Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F3391E63
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Mar 2026 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314297; cv=none; b=n3w1fyga4bFhnUBGmO0NnZ1i2RpfB8nKFNVAwMR+UKxPQuaPCwj8QGx62tSc3KN8e/vxqYpS5n/5CMKqu7tgJO6cT3UQrSMzLeRkNNb6Cj9BgeUJb+CvvxmlTxlTgqETi3cbmPi75u9YmN+rbpitdrJoOE9MMCb921yTcV2zbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314297; c=relaxed/simple;
	bh=74+I7mn4n1ShOD/BMucw49pL2aSRjVV0BFDABLPXVNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pPPDxxJn6H6+H11F5H/Lemhm0hbcRtMbkPP9eQQomFVB9k2evIlHwRzCIPU9dcFzCwLsr3y7yj6a4SjM3P6gadTZb3nzqYOxW5fEIglegPXO0AaLziJ0gIijFHcWvlUoYzVUe2SwWgr98TAHmazMYYgqLHtGzMX9L/41vKcQs08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNY+852l; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNY+852l"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-82989744ee0so915715b3a.2
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Mar 2026 04:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773314295; x=1773919095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnsElwt7VMv7UmravAhlKpCXV3D4/2WKIsiHSbwHPIg=;
        b=nNY+852lQ8rZOJQx2z1KhrQb+a5XLXV3MVGqfD8siTUMCJjSmREWFGD5kVwqXMcVjs
         Uci4AquHUNP1gsS2W6/PMRRDfeTgjrDgOa7ptSumEGEewGQ5St1zMULxCc6JNttpps46
         /s+QZVXJe3bGni+bcsTKbHmF75gKb3HDefHVMVEWxTsx4f/XhVRhAkEx+UCvY9S4XY0u
         xcAJewcOjkgeSwpGLpfvhsqu3QfgH4KKH3zdGJZ2EVhp1Ee6RCSbTjC76a4VK1DHmMWn
         3NHfxNBPIXpwZcXK4IIlJG/dWa5qcqd/OrvcJWH/1pn5B+os/UkEd18WFthV0IXI3Ss0
         diGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773314295; x=1773919095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnsElwt7VMv7UmravAhlKpCXV3D4/2WKIsiHSbwHPIg=;
        b=bQw3Q8KOxjjkYnrlqil1FCezOMb6vJad3xcjnZ46dCYrQ2egBF1XVotTEDbeD6NOhr
         32ztrcXWL910e2O235pUXMZDRo46VSG8Ahq3+yN1aA8vxcuhLGbMAjTNb7yRZQ5GBAJp
         fPcxx+pJrbRBXhXe0OjBdZ9+9anFg+jtc6mJvB70NAL03Roo8YJBsjbgSLyNEMTp6+b7
         qeSKk806A8mt6LKCjL8GjCVNRlZSUlOrNamprDf99zuEWTnws1AWBmrwmvlRVynVe5RX
         +YuLjmO7rbLe7EZMW42b8ydy4zESKuRLulhvCTI9bRVKkZosCjLHisi7pzpxBuYPTy+o
         AHfg==
X-Forwarded-Encrypted: i=1; AJvYcCVN+MQCsYM9OlyktHa5vYjyxD1yOJuWWWWS0tTKUIwJgWZrMBjtDKhrEaQ/go4mIhh/V8Sz8D754Jiz5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkdab/pkl8UwjzYny0z+eIFu46rdBUUWHGVQz1RJjTC/FOCyHp
	dEp3emBzrqi/iS8DxNToD08XiOEvR+6vViyIXmML7lmiE5CsC3U4/rWK
X-Gm-Gg: ATEYQzyEkxbCA0aew0YkdrTYQHn9Ewjy13lcY9RTodr2+3jV8xxrHcPscPbBzEb77a3
	fHZ/64DIoh2dTDZJrVtHX7/up46a6ToJABYmZsAf5wgojVU2wGVe0gpaxcv0tEuiVrPRuA+iQCk
	+ug/862XSVWDlU5bp11n/oTS7ppbiGQaqjqNgWlCskZlcHUlaA3+TvTxjLpNM/RCJyEM6D67+xC
	bytOl2KQU0764hs9UNvDvsODp5R7NUBiCDySY73QQt9ACGOzvRHEdJ7vUUJ2Sd/TIlYvvRQk71R
	fiIr04UB9Hj8+TJkmVq9+Lwa3Kj+qyYINVxF+Gf964mTzc1EQWyrU1aUhiGNxyEtq5d3lmmtOuQ
	pCEGh7C1BCq6f91Ip66hbK73LoIahtCgfrgpVnzyOGMoCZtTgaY0blxJBzhzCTpeC9C//uhawdc
	fwE4idld20ROWtyLO6+8SlNgM1yinH85TeTbu71Te6MPoLp9vzcBMf5EPX0/hrnFHK0ndpOxGQg
	vTkhi4Mg6b9GA==
X-Received: by 2002:a05:6a00:4298:b0:824:4a22:ec16 with SMTP id d2e1a72fcca58-829f708a071mr5592057b3a.34.1773314295052;
        Thu, 12 Mar 2026 04:18:15 -0700 (PDT)
Received: from CN4GKQDX76.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0736edd2sm2663989b3a.52.2026.03.12.04.18.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Mar 2026 04:18:14 -0700 (PDT)
From: Zile Xiong <xiongzile99@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: deller@gmx.de,
	abdun.nihaal@gmail.com,
	dan.carpenter@linaro.org,
	chintanlike@gmail.com,
	niejianglei2021@163.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zile Xiong <xiongzile99@gmail.com>
Subject: [PATCH] staging: fbtft: avoid empty macro argument in define_fbtft_write_reg
Date: Thu, 12 Mar 2026 19:18:07 +0800
Message-ID: <20260312111807.96789-1-xiongzile99@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the empty modifier argument with a simple identity macro.
This fixes the error reported by scripts/checkpatch.pl while keeping
the original semantics unchanged.

The generated code is equivalent and builds successfully.

Signed-off-by: Zile Xiong <xiongzile99@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..380dd374a566 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -61,10 +61,10 @@ out:									      \
 	va_end(args);                                                         \
 }                                                                             \
 EXPORT_SYMBOL(func);
-
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+#define fbtft_identity(x) (x)
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_identity)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_identity)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.20.1


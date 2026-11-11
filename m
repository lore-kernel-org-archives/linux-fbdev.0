Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383307;
	b=igyw8pCdXuUtnCiH7B/qI/54VkwXuxZdJzG0JebH+cHJozriVX4x9/Xyxa1Q69qQfBfh
	 dw8UEnca9d9JZEcwWAmUR8a5+9EQvBtmAoTQbDUCUMKwgNeVZF+++qy5n81GtcB4tpfo8
	 Xi6XFIQwIIeDflQ6hMKj/N1gNBK9R1uHykg0i8e8Dup6564VF7oRNt7dIZo0H9oAK9v8w
	 kmKrV4CeSCPPMfh9YdLUCy06k6krnvI8/jltsnUoKziNuqmJD1TvBCLPAnwaGalBF3oLI
	 4IMvVNviVSC6YrPdpBhYshAaqccaI7mXyFkpj5ew2x4UBYVald9a9epldan2SskyVHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/XEQ6ckoipbYo+1CPYyccgE+eWB58x58i5+B3lAE+Aw=;
	b=qpE+WZAcqtprTy4xju1M6yV/Fd0Vm3NA9Nj+p0wQnKt1pQbAmr7H97raUOT1WXFqgbwL
	 Z+MU4Qro6dfJuMoYHF3KF//fyaMUjIBTUt+7+0IG0aRgCkBx2+De9ll1JhqU7V+pGVgPo
	 8VPPFKJnnd5X78V6A319YasIoxUK+T1nzP/rGjPhZI7Z2j/93pVrrIBeBQDKAvO1aYfJf
	 mP/4Q2F2F+rG1kfZbRT6gdl9RqnSxfnypJHJ7ZjeGU+3VTxownoPvECvsfp7PBkVRmMaR
	 n5h2HmmXg12dLK6Jr3mHdlXX77yJTDJ9v9wMO8TajN6T0XVJX1mCahHeBd7m71mnQeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EGGSrrcM;
	arc=none smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5BB606A31C
	for <linux-fbdev@vger.kernel.org>; Wed, 11 Nov 2026 07:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC5BB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EGGSrrcM
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3acff56a300so25583361fa.2
        for <linux-fbdev@vger.kernel.org>; Tue, 10 Nov 2026 23:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794383305; x=1794988105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/XEQ6ckoipbYo+1CPYyccgE+eWB58x58i5+B3lAE+Aw=;
        b=EGGSrrcMeLfDFxWOomLxeywx6A7alK3eBmumFzjnjbe8ScErqCbOYF84z69Ni5lgQx
         D1VnUEjEyRebOBInG+8oLHXQhnz12mo9q/HHa2SaDg5e5G8X0zlg0ool7/x4dApfch46
         FIJx/LoGMSLZC2PHyd9MBvyg36gvlObXLUiK/tPbvdtMj5CxbWIG92mGb9G/gNUr3knS
         9CKyNQdmeS//rWhL2Wb9hRaFxYJM7FowzVCKKeQMpeC289F/evX9ZXlRwizKXb8P8JUy
         AqTR+erKuXblTMd9MjhHVQ36QYBl5ZFFJSCfiClmRUMJcIGdBADa9iLPXCKFzSZDY/1o
         CwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383305; x=1794988105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/XEQ6ckoipbYo+1CPYyccgE+eWB58x58i5+B3lAE+Aw=;
        b=VvcgkhEGDn4Y8ZGy9mlyIpU2gpfaukSZnvdLF7nmGqS30aRsMxXxtOexO1V6hlIt+0
         58vTz3JVkUL63kU8wDM5kQcHU9Ji4TK2FtIbMhn0UHx9Qx85utGpnFhB82/JQkyaHLhh
         O8vMyrhAj1UwwTI1LUtuPRTOGhLOEFa3+8W/zSmgXpmtop0v6vO3m/L/uCSKp+0+Lu4y
         M3D2beumwYKtWhQQ71UH2rzG1WVjj7CZIqyGYF9zEoubiwPFWbZ7j/Ac8J4a1lYJvDly
         iv4mUK/ywOB+vzSyMk/25Ry/i1RUUUGvOnq2xtrtwsWvrn7nRgTM1OLij+BJbjG8+Nd/
         4wUg==
X-Forwarded-Encrypted: i=1; AL+hErGgFA2aKy/Hd/SauvFQxCBeWT04D9sTdRXXw5mkTZqgq1JmetC4ivI5wZliLznGO/Z0HuUpVPBv2voReg==@vger.kernel.org
X-Gm-Message-State: APuU4Z//AgfpwrfPE6utns6zijGENDwfbkeK+aJEV/mikFwHVhnt/jY2
	06nfuMOa9Iy8i1zPe5iIC5mJc5Spiyy8u8hEhZ0H5U14xOfxny2Ywv1w
X-Gm-Gg: AYBFou06hyDvMmfXvLdAVw5c8fujiO9zkwgqoX92MH/RQzlPSYtD5YngmeCdk77ent+
	4kl7KPOX8TRxQLnBNdX9kBvXCe/tDgQDU3mkxMJDkfIzrBzX/ntDkLFB4UzgLX8lGEXzfckrovC
	DcY/YJ593N7edH2WD+gYyKUI4wO2fsm8Yn3xP3UU2BtYnwQl4N9WjngraZjB4i5UgVjZu86woN7
	VqW2FrmgqVVgX2WBXDmxFTdzT6JqGNmisXilMTvLWoPQu9dG+sEqHabWU2jMFFiyHLvmKoQjS/Y
	utOM3wGf+fCnUw3tvadKywgEkG/XeIw6TFiSpahdI3tW/vKDN7hYb/UEQd5BIwcw6gB7M0rFwIO
	XtvJ5udiXuyIwe9t+Uub9fFIIYQ+oIU5mEliEhGzB5dNMIiAiy0hgbUlvWZKqcXG3TiYAhnZrDU
	8vDtKPGUVcHm1bzZXqY2eBqhc92kksz981C8j5zhI9O0f3GvY8Qxf6d4/mAfF4uJriI6FZhA0JT
	OnT7SE2prOwxkuHpiOCo3er9j9uBn9ZIgNDJLk9/Ev8qgS4h2l2Le8LDFgvNCczxw3fk76KFIbp
	zKODRb7QYAc6vjEJZh9F0LNJDDZBCsrniszTEmJfWJzPCIzaMSTq3JUG1H44TD+PiK4aN0Pwn8e
	qUdjp4qGxYw==
X-Received: by 2002:a05:651c:1592:b0:3aa:ef31:e51e with SMTP id 38308e7fff4ca-3ae1268e13amr2497851fa.19.1794383304669;
        Tue, 10 Nov 2026 23:48:24 -0800 (PST)
Received: from sakairlinux ([5.165.109.20])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae0920535dsm9513081fa.6.2026.11.10.23.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:48:22 -0800 (PST)
From: Svyatoslav Mikhailov <sakairlinux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Svyatoslav Mikhailov <sakairlinux@gmail.com>
Subject: [PATCH] staging: sm750fb: rename p_PLL to pll in sm750_format_pll_reg()
Date: Wed, 11 Nov 2026 10:48:16 +0300
Message-ID: <20261111074816.27647-1-sakairlinux@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parameter p_PLL uses Hungarian notation and uppercase letters,
which does not follow the kernel coding style. Rename it to pll,
matching the naming used in sm750_calc_pll_value().

No functional change intended. Compile-tested on x86_64 with no warnings.

Signed-off-by: Svyatoslav Mikhailov <sakairlinux@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 10 +++++-----
 drivers/staging/sm750fb/ddk750_chip.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index aa78d0bc1d87..6ffd6a2a1b06 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -358,14 +358,14 @@ unsigned int sm750_calc_pll_value(unsigned int request_orig,
 	return ret;
 }
 
-unsigned int sm750_format_pll_reg(struct pll_value *p_PLL)
+unsigned int sm750_format_pll_reg(struct pll_value *pll)
 {
 #ifndef VALIDATION_CHIP
-	unsigned int POD = p_PLL->POD;
+	unsigned int POD = pll->POD;
 #endif
-	unsigned int OD = p_PLL->OD;
-	unsigned int M = p_PLL->M;
-	unsigned int N = p_PLL->N;
+	unsigned int OD = pll->OD;
+	unsigned int M = pll->M;
+	unsigned int N = pll->N;
 
 	/*
 	 * Note that all PLL's have the same format. Here, we just use
diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index 2a13debc179f..685fde67c2b5 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -88,7 +88,7 @@ struct initchip_param {
 enum logical_chip_type sm750_get_chip_type(void);
 void sm750_set_chip_type(unsigned short dev_id, u8 rev_id);
 unsigned int sm750_calc_pll_value(unsigned int request, struct  pll_value *pll);
-unsigned int sm750_format_pll_reg(struct pll_value *p_PLL);
+unsigned int sm750_format_pll_reg(struct pll_value *pll);
 unsigned int ddk750_get_vm_size(void);
 int ddk750_init_hw(struct initchip_param *pinit_param);
 
-- 
2.55.0


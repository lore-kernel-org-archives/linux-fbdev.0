Received: from forward201d.mail.yandex.net (forward201d.mail.yandex.net [178.154.239.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763963D45DE;
	Tue, 12 May 2026 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604850; cv=none; b=PqqdxT0SB2pzPp/AISLKcUCPenHHCL7rcvvbn+DZnyxRXlPsCC8sls2KNruaRyAjG4eBtYk87KaoH9PBcOGt7yHTc6WyKyzJS5KOtAowhvJ2dpxZpSpbrjfc8iOgPBF9+ePKzli7yjs3yPJAH0GwIhAdK0024a/x6ZvdFPfbtdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604850; c=relaxed/simple;
	bh=/u3E5r4BMpeh8UtVluRHgFfJElRK1+V1FFj8u7VEeNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lF0rtCOEDcSDlukrSIehhQG6if3VOfQId0ZOjJSg9shv4Dt7Yd8NMCHY3Xa4asKaIul2v2KrIOfcqHPcg3mK2MkYiucvVPl3xSx72DSiyFyI3zbXth96SCX4bUh0DoBMivKs8c9XGxw8Lc2f0n0gqFxiBNX5imI3y6Nce0rLM5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=X6i6TWVU; arc=none smtp.client-ip=178.154.239.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="X6i6TWVU"
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward201d.mail.yandex.net (Yandex) with ESMTPS id CBAF683BD7;
	Tue, 12 May 2026 19:48:03 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1f87:0:640:a06a:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id B5392C0051;
	Tue, 12 May 2026 19:47:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp) with ESMTPSA id nlNSSYsRFCg0-cQ9lIMaw;
	Tue, 12 May 2026 19:47:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1778604475;
	bh=djGYuQvNXpa9sAArIcWPO2XIUXUNsetAa9bOTrZwd3A=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=X6i6TWVU4/3XOemQa8a3DQWAeaoYEgLe1kZZVcy9+kG/kfaA3KbNJ+bTVkSDV+2xo
	 KgaayEFygZI5EhN4wbLT6aOSMxwzmFoJGwsLfjbJwnJM0bqsOysFf10ZpVWgn5O0BO
	 Vgmynri6C+EDvo+ehfxKZ9hj9Wx+94IlnXWmoDi8=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH 2/4] staging: sm750fb: use early returns in frequency checks
Date: Tue, 12 May 2026 16:41:22 +0000
Message-ID: <20260512164124.188210-3-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512164124.188210-1-ahmet@sezginduran.net>
References: <20260512164124.188210-1-ahmet@sezginduran.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invert the frequency validation conditions and use early returns
to reduce nesting and improve readability.

No functional changes.

Signed-off-by: Ahmet Sezgin Duran <ahmet@sezginduran.net>
---
 drivers/staging/sm750fb/ddk750_chip.c | 153 +++++++++++++-------------
 1 file changed, 78 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 136692b00804..0bb56bbec43f 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -61,25 +61,26 @@ static void set_chip_clock(unsigned int frequency)
 	if (sm750_get_chip_type() == SM750LE)
 		return;
 
-	if (frequency) {
-		/*
-		 * Set up PLL structure to hold the value to be set in clocks.
-		 */
-		pll.input_freq = DEFAULT_INPUT_CLOCK; /* Defined in CLOCK.H */
-		pll.clock_type = MXCLK_PLL;
+	if (!frequency)
+		return;
 
-		/*
-		 * Call sm750_calc_pll_value() to fill the other fields
-		 * of the PLL structure. Sometimes, the chip cannot set
-		 * up the exact clock required by the User.
-		 * Return value of sm750_calc_pll_value gives the actual
-		 * possible clock.
-		 */
-		sm750_calc_pll_value(frequency, &pll);
+	/*
+	 * Set up PLL structure to hold the value to be set in clocks.
+	 */
+	pll.input_freq = DEFAULT_INPUT_CLOCK; /* Defined in CLOCK.H */
+	pll.clock_type = MXCLK_PLL;
 
-		/* Master Clock Control: MXCLK_PLL */
-		poke32(MXCLK_PLL_CTRL, sm750_format_pll_reg(&pll));
-	}
+	/*
+	 * Call sm750_calc_pll_value() to fill the other fields
+	 * of the PLL structure. Sometimes, the chip cannot set
+	 * up the exact clock required by the User.
+	 * Return value of sm750_calc_pll_value gives the actual
+	 * possible clock.
+	 */
+	sm750_calc_pll_value(frequency, &pll);
+
+	/* Master Clock Control: MXCLK_PLL */
+	poke32(MXCLK_PLL_CTRL, sm750_format_pll_reg(&pll));
 }
 
 static void set_memory_clock(unsigned int frequency)
@@ -93,37 +94,38 @@ static void set_memory_clock(unsigned int frequency)
 	if (sm750_get_chip_type() == SM750LE)
 		return;
 
-	if (frequency) {
-		/*
-		 * Set the frequency to the maximum frequency
-		 * that the DDR Memory can take which is 336MHz.
-		 */
-		if (frequency > MHz(336))
-			frequency = MHz(336);
-
-		/* Calculate the divisor */
-		divisor = DIV_ROUND_CLOSEST(get_mxclk_freq(), frequency);
-
-		/* Set the corresponding divisor in the register. */
-		reg = peek32(CURRENT_GATE) & ~CURRENT_GATE_M2XCLK_MASK;
-		switch (divisor) {
-		default:
-		case 1:
-			reg |= CURRENT_GATE_M2XCLK_DIV_1;
-			break;
-		case 2:
-			reg |= CURRENT_GATE_M2XCLK_DIV_2;
-			break;
-		case 3:
-			reg |= CURRENT_GATE_M2XCLK_DIV_3;
-			break;
-		case 4:
-			reg |= CURRENT_GATE_M2XCLK_DIV_4;
-			break;
-		}
+	if (!frequency)
+		return;
+
+	/*
+	 * Set the frequency to the maximum frequency
+	 * that the DDR Memory can take which is 336MHz.
+	 */
+	if (frequency > MHz(336))
+		frequency = MHz(336);
+
+	/* Calculate the divisor */
+	divisor = DIV_ROUND_CLOSEST(get_mxclk_freq(), frequency);
 
-		sm750_set_current_gate(reg);
+	/* Set the corresponding divisor in the register. */
+	reg = peek32(CURRENT_GATE) & ~CURRENT_GATE_M2XCLK_MASK;
+	switch (divisor) {
+	default:
+	case 1:
+		reg |= CURRENT_GATE_M2XCLK_DIV_1;
+		break;
+	case 2:
+		reg |= CURRENT_GATE_M2XCLK_DIV_2;
+		break;
+	case 3:
+		reg |= CURRENT_GATE_M2XCLK_DIV_3;
+		break;
+	case 4:
+		reg |= CURRENT_GATE_M2XCLK_DIV_4;
+		break;
 	}
+
+	sm750_set_current_gate(reg);
 }
 
 /*
@@ -145,37 +147,38 @@ static void set_master_clock(unsigned int frequency)
 	if (sm750_get_chip_type() == SM750LE)
 		return;
 
-	if (frequency) {
-		/*
-		 * Set the frequency to the maximum frequency
-		 * that the SM750 engine can run, which is about 190 MHz.
-		 */
-		if (frequency > MHz(190))
-			frequency = MHz(190);
-
-		/* Calculate the divisor */
-		divisor = DIV_ROUND_CLOSEST(get_mxclk_freq(), frequency);
-
-		/* Set the corresponding divisor in the register. */
-		reg = peek32(CURRENT_GATE) & ~CURRENT_GATE_MCLK_MASK;
-		switch (divisor) {
-		default:
-		case 3:
-			reg |= CURRENT_GATE_MCLK_DIV_3;
-			break;
-		case 4:
-			reg |= CURRENT_GATE_MCLK_DIV_4;
-			break;
-		case 6:
-			reg |= CURRENT_GATE_MCLK_DIV_6;
-			break;
-		case 8:
-			reg |= CURRENT_GATE_MCLK_DIV_8;
-			break;
-		}
+	if (!frequency)
+		return;
+
+	/*
+	 * Set the frequency to the maximum frequency
+	 * that the SM750 engine can run, which is about 190 MHz.
+	 */
+	if (frequency > MHz(190))
+		frequency = MHz(190);
+
+	/* Calculate the divisor */
+	divisor = DIV_ROUND_CLOSEST(get_mxclk_freq(), frequency);
 
-		sm750_set_current_gate(reg);
+	/* Set the corresponding divisor in the register. */
+	reg = peek32(CURRENT_GATE) & ~CURRENT_GATE_MCLK_MASK;
+	switch (divisor) {
+	default:
+	case 3:
+		reg |= CURRENT_GATE_MCLK_DIV_3;
+		break;
+	case 4:
+		reg |= CURRENT_GATE_MCLK_DIV_4;
+		break;
+	case 6:
+		reg |= CURRENT_GATE_MCLK_DIV_6;
+		break;
+	case 8:
+		reg |= CURRENT_GATE_MCLK_DIV_8;
+		break;
 	}
+
+	sm750_set_current_gate(reg);
 }
 
 unsigned int ddk750_get_vm_size(void)
-- 
2.53.0


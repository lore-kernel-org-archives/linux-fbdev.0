Received: from e3i51.smtp2go.com (e3i51.smtp2go.com [158.120.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D7147C6F
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Apr 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367881; cv=none; b=Gm3sIuI7kFXrqYgp/SLAhVEH+m/8VyJFxLmzcREnFjGTnjQ9MTBTQt4RwXL4m0DumARkZPngQCM95tPInQ3h1Lze9tBc0/iaC0FDKmo5YSW2JuSFhK8YiEqFaLPEELTidMvDB3MTPH03xeXfYVzQm1lqLC0ZW8+YX/YqEzM4j4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367881; c=relaxed/simple;
	bh=QAaAzEsyWJ6IDkxlVVcZ5tyzuC7w2dB7WMtV6rpDDrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bgRlRLRXI70/ql7UDf1JMZwrAytORPP7PlLFGQq7g64+FHbw8nbb43zwq6Yv5d893OW8K9/VVFdkYkOiW1BtXQag5HlUBRndAp0PchTG2iy59ngm22L7w98lpB3g7uqD0BZ75fjfp6cLjASlvW44LEuxJagEeio0odDM+ai9q94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=t+SsSQMH; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=b4D726G1; arc=none smtp.client-ip=158.120.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="t+SsSQMH";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="b4D726G1"
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rx7Fg-Dv6PUh-3A;
	Wed, 17 Apr 2024 15:31:12 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Wed, 17 Apr 2024 17:31:10 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1 1/1] backlight: mp3309c: fix leds flickering in pwm mode
Date: Wed, 17 Apr 2024 17:31:05 +0200
Message-Id: <20240417153105.1794134-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417153105.1794134-1-f.suligoi@asem.it>
References: <20240417153105.1794134-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Apr 2024 15:31:10.0483 (UTC) FILETIME=[46242630:01DA90DC]
X-smtpcorp-track: 1rx7FgDv6elh3j.HztUDgdIuef4V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1713367875; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=Mli724MJChjXz9R7/aUL8LJ/Vf3NE+VV4VaVeAU9T0g=;
 b=t+SsSQMHFOzsJqFqPFOoTpohGcjHmTEtQkIHb1wvYjLSIkMr3quJndS8yt+B9+yz9czjj
 dNg5q9m9S8/qxpdnncd2Yix9WUmQjGkEtLnxBSrn9UE/vbZbAkugaPvEXNRSAdOJoMLgwU2
 KKUS+zK79NxBflqgqICYpWxXl4birwl9k4iIwiZwp/bfAokQqA4TEwq3nO9+3R3Q/HvaIJY
 z4UAq6etiqY69m938Dfv6f80BAPfdvdHbk+IY5aYAlIRXsgAv2EK1KSMQUIXKbkpIahJqum
 Uj2F2h2v8RBwfL+MQcGOdUInOX3KKRHwCuiwd3khFvEfW6rjh6sikgkX/Itw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713367875; h=from : subject : to
 : message-id : date; bh=Mli724MJChjXz9R7/aUL8LJ/Vf3NE+VV4VaVeAU9T0g=;
 b=b4D726G18pLD8pLFq1EtqXYYNNrIas3YSjG+PEdppfMxvKXWlCsDNjcIRU7D/m+8LPCdu
 RYyhOCPq44r5yy/PmdMxpV3TVm3ISw3np9ply2T9SAtImyhutW8BFeLoZR7meKr1lYg1tch
 7sjpyPE+WyZthZ0yJELk7EzwLhvefmPdqYtZbezldrU7xgVpybWA0l/wNNc4R5UaupMyWv+
 bA4/w/8iR7aI4PJcWS6GRNno+90uVCmxWreLRc5uKDN+7U3NZSM7xMhz6iyDbF3Kp8s55V4
 +MfoBvUPXaRDfJ9LHu4QM7DU6dS67fP+AMgYB+CoksLOAj9B19iQS/YYgAHA==

The mp3309 has two configuration registers, named according to their
address (0x00 and 0x01).
In the second register (0x01), the bit DIMS (Dimming Mode Select) must
be always 0 (zero), in both analog (via i2c commands) and pwm dimming
mode.

In the initial driver version, the DIMS bit was set in pwm mode and
reset in analog mode.
But if the DIMS bit is set in pwm dimming mode and other devices are
connected on the same i2c bus, every i2c commands on the bus generates a
flickering on the LEDs powered by the mp3309c.

This change concerns the chip initialization and does not impact any
existing device-tree configuration.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/video/backlight/mp3309c.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index 016c1296841c..a28036c964af 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -97,15 +97,10 @@ static int mp3309c_enable_device(struct mp3309c_chip *chip)
 
 	/*
 	 * I2C register #1 - Set working mode:
-	 *  - set one of the two dimming mode:
-	 *    - PWM dimming using an external PWM dimming signal
-	 *    - analog dimming using I2C commands
 	 *  - enable/disable synchronous mode
 	 *  - set overvoltage protection (OVP)
 	 */
 	reg_val = 0x00;
-	if (chip->pdata->dimming_mode == DIMMING_PWM)
-		reg_val |= REG_I2C_1_DIMS;
 	if (chip->pdata->sync_mode)
 		reg_val |= REG_I2C_1_SYNC;
 	reg_val |= chip->pdata->over_voltage_protection;
-- 
2.34.1


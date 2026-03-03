Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D37F351C37
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Mar 2026 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580364; cv=none; b=ogTv+HQvJ4uxIvLrLH5ffg/VJ2U30SxLUbIeEHNVuYgNL+nRbIACkfV6us8ZZXbIJ2CcCGt9xmfx858Qk8uAcyWSzeZlMo46OHh7k1YCHgmpkfUXOtbuuoVytF8EVhUaF8Ug/d7PJuaqXO9D3WTPvDnVHNQ6gh6waME+3rqNiK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580364; c=relaxed/simple;
	bh=c3ERkWhD9cbQaTRuGWOS7lOZK1bMgNpj7WxTjZQhGG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJSJ6ScIwD0on+/3VbXA1JqfE6+1qqxgLYYaJyQULxcNnFmsD1JYYY3/o0K/tkGN6MdaNkigZqg3gOTE/4wcYEKOBL3zliU2FuV5mih9+wTM49AJo3/UXufOOy/pHwReAs6TyepbTcV1G1PSO5yOhMy+E2Twq7VMpz0zgnh3aNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/4NR0gd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/4NR0gd"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso56410615e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Mar 2026 15:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772580361; x=1773185161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwxRWLyaa3AgnUQSozmfRcF7xtoXF7t1KAuB4nhzAW8=;
        b=V/4NR0gd/CZZnmHgWjowVXxzMVlRAp2F6Yel9qtPs9WBM3LhjhgNsQ9LL59MQEDGcE
         ckm8Ps/VtHeJZuxYMSrIioONWFxSAFvxHHxA621hsmTPoY2Frv6YJF7WD0K2a0oK2Lnw
         PwRYpQ+5xctOmot9/ro0VjsFaQtZeFNcaokvp8Qyt2AlW1ouWCSOVAZ7NL2tKiMzI4MP
         ZuZkHXlqogEziI0khSGKf8D+4o+Ny6uhq3/slguv0ajOD3k7FqM4GqWla7WGneYOZps0
         AY7k0GN21H0mk9bz4/Y+aFN74ewu6ue8umGr8qe4KhfQrxNJUYgWnzmc6dwJ2EhblE3G
         6Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580361; x=1773185161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iwxRWLyaa3AgnUQSozmfRcF7xtoXF7t1KAuB4nhzAW8=;
        b=D8/xbYezIj8sGeoz7TEN4sFUjAOeSaXEyYFHkRxjJ8asJ2jyjGWdNUbR5J29pf2G8p
         GlpydF9jpF8X7CCAv60blFLDZlaum3XCKcszoTeB7oxnkpWps0lpgOVF8L6ZK8mNJsom
         7iqwubN34t/PaOCn4h09mo9+g7Xgr8Z0OR0zBwCrYpz9bPoUQg8YAibDhO3Ahw0FkVg2
         E3DL3xk/Vxnv/oJjJTFKfkh93y/uQvPfKdifro+8ezKSdBE3oxd+fA0o1jriFtCRaRlM
         BidYXbpz2WMgviGybQDph+cY22R825focNk0aa8zSVenV0STpOZgqBvmZNkHzWa97shO
         eITQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZZC+wLLNSbiUHaEvCU3ATgsA8shvBEsFwaCOXHggxxo21lsUp6+zR/Ctyc6gnzK2QeG0v5+gjgyc9ag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1hB3PyD7eM1pDJs8/a3RSUO9NFF9uYfcfl+M9dX0eF2u0cIG2
	SUuq5S+MSazcAH1bzkBJUwxbeePK/5R+qkYznclV95DHkO0R+Tq6wr3dHSDnjpwD53Y=
X-Gm-Gg: ATEYQzw06HA2+QFIz/8SiUSY85V2DMog2ny7NTkhI5/vVvfNEGMpQ9r3qWcmUrtqxaH
	vDwrukKEPm7tDZDFrs/EBtKbPQ4PI4tKFU5SD3LYtNp9IkJKg3F7zUNAY7FIBeQyExAzuzv7Htm
	qfnNBbgnZeXhv/jLn4WR2FYHisq/VZU4hzt+R318QobbDPUuyYlMdJb3Nj4eN6wmer9yCx85dy3
	TVvAb+1uBZcGlCwEn3fkYY3GSoxKKuhPd1KP6BskdXYJ6sB4vsQ1o/hjLrM5NjYRLWzjkMHHb1k
	SKhtH5IcJUfXn4JaOE9kP5cF0ruzW/qYewDDoT5Qov6rVdZogkU5sM289UlaPy4kvptcRQIylzI
	s8NfnDF78HUQeQakbDUkKRh6GpLNaTk6T1A1ClJA/s7onycJgHKUeO0U+9/XerUFKqbio8d6kh+
	jiLeMICtMlPaGDWZ27qg7Ce6WC0RChYKfR0OLZLf3jELwQoz+X9w==
X-Received: by 2002:a05:600c:6992:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-4851984fd72mr688695e9.10.1772580360518;
        Tue, 03 Mar 2026 15:26:00 -0800 (PST)
Received: from arch ([2a02:1210:2e28:2800:36a5:7f85:ccb8:1176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851335648esm68036615e9.5.2026.03.03.15.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:26:00 -0800 (PST)
From: Gabriel Windlin <gawindlin@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Gabriel Windlin <gawindlin@gmail.com>
Subject: [PATCH 7/8] staging: sm750fb: remove unused CURRENT_GATE, CRT_HWC, and DMA register definitions
Date: Wed,  4 Mar 2026 00:24:28 +0100
Message-ID: <20260303232434.1850583-7-gawindlin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303232434.1850583-1-gawindlin@gmail.com>
References: <20260303232434.1850583-1-gawindlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CURRENT_GATE_VGA, CURRENT_GATE_PWM, CURRENT_GATE_SSP, and
CURRENT_GATE_ZVPORT bit field macros, the CRT_HWC hardware cursor
register macros, the DMA_1_SOURCE, DMA_1_DESTINATION, and
DMA_1_SIZE_CONTROL register macros, and the unused
DMA_ABORT_INTERRUPT_ABORT_0, DMA_ABORT_INTERRUPT_INT_1, and
DMA_ABORT_INTERRUPT_INT_0 bit field macros defined in ddk750_reg.h
are not referenced anywhere in the driver. Remove them to reduce dead
code as noted in the TODO file.

Signed-off-by: Gabriel Windlin <gawindlin@gmail.com>
---
 drivers/staging/sm750fb/ddk750_reg.h | 41 ----------------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb/ddk750_reg.h
index 8f227d974613..328254d3d7cc 100644
--- a/drivers/staging/sm750fb/ddk750_reg.h
+++ b/drivers/staging/sm750fb/ddk750_reg.h
@@ -102,12 +102,8 @@
     #define CURRENT_GATE_M2XCLK_DIV_3                 (0x2 << 12)
     #define CURRENT_GATE_M2XCLK_DIV_4                 (0x3 << 12)
 #endif
-#define CURRENT_GATE_VGA                              BIT(10)
-#define CURRENT_GATE_PWM                              BIT(9)
 #define CURRENT_GATE_I2C                              BIT(8)
-#define CURRENT_GATE_SSP                              BIT(7)
 #define CURRENT_GATE_GPIO                             BIT(6)
-#define CURRENT_GATE_ZVPORT                           BIT(5)
 #define CURRENT_GATE_CSC                              BIT(4)
 #define CURRENT_GATE_DE                               BIT(3)
 #define CURRENT_GATE_DISPLAY                          BIT(2)
@@ -602,26 +598,6 @@
 #define CRT_SCALE_HORIZONTAL_MODE                     BIT(15)
 #define CRT_SCALE_HORIZONTAL_SCALE_MASK               0xfff
 
-/* CRT Cursor Control */
-
-#define CRT_HWC_ADDRESS                               0x080230
-#define CRT_HWC_ADDRESS_ENABLE                        BIT(31)
-#define CRT_HWC_ADDRESS_EXT                           BIT(27)
-#define CRT_HWC_ADDRESS_ADDRESS_MASK                  0x3ffffff
-
-#define CRT_HWC_LOCATION                              0x080234
-#define CRT_HWC_LOCATION_TOP                          BIT(27)
-#define CRT_HWC_LOCATION_Y_MASK                       (0x7ff << 16)
-#define CRT_HWC_LOCATION_LEFT                         BIT(11)
-#define CRT_HWC_LOCATION_X_MASK                       0x7ff
-
-#define CRT_HWC_COLOR_12                              0x080238
-#define CRT_HWC_COLOR_12_2_RGB565_MASK                (0xffff << 16)
-#define CRT_HWC_COLOR_12_1_RGB565_MASK                0xffff
-
-#define CRT_HWC_COLOR_3                               0x08023C
-#define CRT_HWC_COLOR_3_RGB565_MASK                   0xffff
-
 /* This vertical expansion below start at 0x080240 ~ 0x080264 */
 #define CRT_VERTICAL_EXPANSION                        0x080240
 #ifndef VALIDATION_CHIP
@@ -703,25 +679,8 @@
 #define I2C_DATA14                                      0x010052
 #define I2C_DATA15                                      0x010053
 
-#define DMA_1_SOURCE                                    0x0D0010
-#define DMA_1_SOURCE_ADDRESS_EXT                        BIT(27)
-#define DMA_1_SOURCE_ADDRESS_CS                         BIT(26)
-#define DMA_1_SOURCE_ADDRESS_MASK                       0x3ffffff
-
-#define DMA_1_DESTINATION                               0x0D0014
-#define DMA_1_DESTINATION_ADDRESS_EXT                   BIT(27)
-#define DMA_1_DESTINATION_ADDRESS_CS                    BIT(26)
-#define DMA_1_DESTINATION_ADDRESS_MASK                  0x3ffffff
-
-#define DMA_1_SIZE_CONTROL                              0x0D0018
-#define DMA_1_SIZE_CONTROL_STATUS                       BIT(31)
-#define DMA_1_SIZE_CONTROL_SIZE_MASK                    0xffffff
-
 #define DMA_ABORT_INTERRUPT                             0x0D0020
 #define DMA_ABORT_INTERRUPT_ABORT_1                     BIT(5)
-#define DMA_ABORT_INTERRUPT_ABORT_0                     BIT(4)
-#define DMA_ABORT_INTERRUPT_INT_1                       BIT(1)
-#define DMA_ABORT_INTERRUPT_INT_0                       BIT(0)
 
 /* Default i2c CLK and Data GPIO. These are the default i2c pins */
 #define DEFAULT_I2C_SCL                     30
-- 
2.53.0


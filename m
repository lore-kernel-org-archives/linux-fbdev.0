Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E7C3537C2
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Mar 2026 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580366; cv=none; b=tBXxbjibuKIaXR4aIfMXHY9xtziXb2xg02e1OJ9a0nkMb4L9xkaVBXl9zHQ6NTeSmV1DhuipaoXSYzxaRecFNePYpNihun7JC62I1AIhF3k8rAGVa+uyaqUz5bwO1ep7vBq8ULp1wZe1ykVKqPK2SavG6VTyNGvG+f2IiiWdkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580366; c=relaxed/simple;
	bh=qV/0UT47G1yQzfkFgXEY+RNjtPkyqT1MQNXqMOS8wTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=la1NrF+VhXltIQ67KznVj99jHXttSYCoCl+VDc9jFEgLK8vbtrYc/r9DJ13HOkqxJ3G3PzH3tORdSlqhSYbiMFiFMF7YZirPRzDEvKCsSoi+x4DXgHuNeQJA8cODFXgmL6t+gMv2Jzn+eLG9Rt/FvcrWMi1fEUIZt6KYdL0Webw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CucOBrlc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CucOBrlc"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439c4bde55cso496041f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Mar 2026 15:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772580362; x=1773185162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZM92izGRmi9MJGoaWiyABzFcYIy1pivLl2UdegXzXw=;
        b=CucOBrlcxjMnmEG1kTNBZwjt1tWavVS3Bp5fqaO0AYJ+uWRNIGp2QX1EYLfmzFBouk
         zagP9MD+cpzmT/nO8SoPHZA9Vne+YApkM+wSayqAKrC+nm2dhaHsOd2nleeTf9QUGkCg
         VJuza5nKKXqomxtuJAmeT35Uhz9NRUGiDbEddvHOy0/Mosc18HGmQdU8MKOIKZARCm4I
         SN6CWJbWuVoolu8G3+CC2pvNsF0BHcJvmH8M5SgSF269T4y09LD9mpYINEwNbQXOQaRy
         tX3nCUAvWcCre2ABlljRcE9oNdecnCN7zGnIK/zKBpwzbJH1Vj0V8o/tbTzS4uwm5aXz
         KHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580362; x=1773185162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZM92izGRmi9MJGoaWiyABzFcYIy1pivLl2UdegXzXw=;
        b=Dp5esvwrEXHwMrHaBF/vVkKw22WvTYS16nTkScxWYgdZCbaRS0E1qvFDxN8bNYqhF9
         yHSLmESzayDXmpNlMyBSA1ry/k8X7oDFYu5qoNK2PLQXZYBmVVOVTtrYtjvyf6kv/Bn1
         FoWYzR7rO6PBSZiSe1J6PrbEZ5cgVfpP7y19OJifJmZBCYfcj/OI9CQNe6s4+ITxjhTY
         HLIbbRNWYwcd39ddjfKgEO29LF6GjGYHcCD9LVe133srqtLHA8GA+HYFnPsvqRhe7CDh
         gcd+jZ5cZyfOZuc3GLOy8lmolaMbSF9wm3NypmDNC3KJ8ERB+N8/nkFF5ONz6ERxuG/O
         TQWA==
X-Forwarded-Encrypted: i=1; AJvYcCWdBYEpjT1D/VomSWxQARye+82wH3VPyatvEGfFo7Os4oTWW5jwfw/+MDH3FzK8SJGg4K9b2UQ6P+Ptpg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4mzd1B31mpKefrPrlaAozfCenItFTF9psLX7U55Z16NPyh9mk
	jEw0oLIKyGfzBj4nEuiPxM9t4F1PRl4YDNx81RnhGDoONL6JHBiFAy2b
X-Gm-Gg: ATEYQzyYHFmzc3rE12Z2MrFwc+aDiZrxYygmmTJo3Y5tvryUhd6iwCDFbLq7/LlEBag
	I1NZJsGmbr40+rimL997vJu/QBhlO0b5TX65U8TNO8wg6zhSLgW9qIeqwEgow6Sfnv4eXKxRiUa
	F975Tyf42W2EtUkgQxyaglY1qyHuD9X/vCgkVnkq+fiezEnCd4z0nKK+lP1idRkZqtHxS4+teTl
	ICtp+QOEUrczXNd2D+R3aBxkl3pDuI0v9XrL2HNxFWrTJJ8hVKPWp/Xiwpi+fNDQePOOUGZxdWh
	8tQA3vjDK0cx5x5Mx0qYGYf8CVpLE8KlCpcqt2291ROD/RmVbjyzGmOinxPsTOT8bhFT5aJiiMK
	aKYtucLd5xnzONS9S85j2Vr5FIkdup00fIDvbGD0wyhBhVYNDt8Z4Bs0+mv7ZnEK/4XphR5ZtIy
	GrQT0L8pek7Nt/7xmdQA778wR0QFycjuuSoFfvYqF2FtDFXJpf3A==
X-Received: by 2002:a05:600c:a51:b0:483:a21:774c with SMTP id 5b1f17b1804b1-4851988990bmr608345e9.25.1772580361531;
        Tue, 03 Mar 2026 15:26:01 -0800 (PST)
Received: from arch ([2a02:1210:2e28:2800:36a5:7f85:ccb8:1176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851335648esm68036615e9.5.2026.03.03.15.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:26:01 -0800 (PST)
From: Gabriel Windlin <gawindlin@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Gabriel Windlin <gawindlin@gmail.com>
Subject: [PATCH 8/8] staging: sm750fb: remove unused GPIO bit field and interrupt definitions
Date: Wed,  4 Mar 2026 00:24:29 +0100
Message-ID: <20260303232434.1850583-8-gawindlin@gmail.com>
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

The GPIO_DATA_0..31, GPIO_DATA_DIRECTION_0..31 bit field macros, and
the GPIO_INTERRUPT_SETUP and GPIO_INTERRUPT_STATUS register macros
defined in ddk750_reg.h are not referenced anywhere in the driver. The
register addresses GPIO_DATA and GPIO_DATA_DIRECTION are kept as they
are still in use. Remove the rest to reduce dead code as noted in the
TODO file.

Signed-off-by: Gabriel Windlin <gawindlin@gmail.com>
---
 drivers/staging/sm750fb/ddk750_reg.h | 96 ----------------------------
 1 file changed, 96 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb/ddk750_reg.h
index 328254d3d7cc..d21e4a5e5ac4 100644
--- a/drivers/staging/sm750fb/ddk750_reg.h
+++ b/drivers/staging/sm750fb/ddk750_reg.h
@@ -215,104 +215,8 @@
 #endif
 
 #define GPIO_DATA                                       0x010000
-#define GPIO_DATA_31                                    BIT(31)
-#define GPIO_DATA_30                                    BIT(30)
-#define GPIO_DATA_29                                    BIT(29)
-#define GPIO_DATA_28                                    BIT(28)
-#define GPIO_DATA_27                                    BIT(27)
-#define GPIO_DATA_26                                    BIT(26)
-#define GPIO_DATA_25                                    BIT(25)
-#define GPIO_DATA_24                                    BIT(24)
-#define GPIO_DATA_23                                    BIT(23)
-#define GPIO_DATA_22                                    BIT(22)
-#define GPIO_DATA_21                                    BIT(21)
-#define GPIO_DATA_20                                    BIT(20)
-#define GPIO_DATA_19                                    BIT(19)
-#define GPIO_DATA_18                                    BIT(18)
-#define GPIO_DATA_17                                    BIT(17)
-#define GPIO_DATA_16                                    BIT(16)
-#define GPIO_DATA_15                                    BIT(15)
-#define GPIO_DATA_14                                    BIT(14)
-#define GPIO_DATA_13                                    BIT(13)
-#define GPIO_DATA_12                                    BIT(12)
-#define GPIO_DATA_11                                    BIT(11)
-#define GPIO_DATA_10                                    BIT(10)
-#define GPIO_DATA_9                                     BIT(9)
-#define GPIO_DATA_8                                     BIT(8)
-#define GPIO_DATA_7                                     BIT(7)
-#define GPIO_DATA_6                                     BIT(6)
-#define GPIO_DATA_5                                     BIT(5)
-#define GPIO_DATA_4                                     BIT(4)
-#define GPIO_DATA_3                                     BIT(3)
-#define GPIO_DATA_2                                     BIT(2)
-#define GPIO_DATA_1                                     BIT(1)
-#define GPIO_DATA_0                                     BIT(0)
 
 #define GPIO_DATA_DIRECTION                             0x010004
-#define GPIO_DATA_DIRECTION_31                          BIT(31)
-#define GPIO_DATA_DIRECTION_30                          BIT(30)
-#define GPIO_DATA_DIRECTION_29                          BIT(29)
-#define GPIO_DATA_DIRECTION_28                          BIT(28)
-#define GPIO_DATA_DIRECTION_27                          BIT(27)
-#define GPIO_DATA_DIRECTION_26                          BIT(26)
-#define GPIO_DATA_DIRECTION_25                          BIT(25)
-#define GPIO_DATA_DIRECTION_24                          BIT(24)
-#define GPIO_DATA_DIRECTION_23                          BIT(23)
-#define GPIO_DATA_DIRECTION_22                          BIT(22)
-#define GPIO_DATA_DIRECTION_21                          BIT(21)
-#define GPIO_DATA_DIRECTION_20                          BIT(20)
-#define GPIO_DATA_DIRECTION_19                          BIT(19)
-#define GPIO_DATA_DIRECTION_18                          BIT(18)
-#define GPIO_DATA_DIRECTION_17                          BIT(17)
-#define GPIO_DATA_DIRECTION_16                          BIT(16)
-#define GPIO_DATA_DIRECTION_15                          BIT(15)
-#define GPIO_DATA_DIRECTION_14                          BIT(14)
-#define GPIO_DATA_DIRECTION_13                          BIT(13)
-#define GPIO_DATA_DIRECTION_12                          BIT(12)
-#define GPIO_DATA_DIRECTION_11                          BIT(11)
-#define GPIO_DATA_DIRECTION_10                          BIT(10)
-#define GPIO_DATA_DIRECTION_9                           BIT(9)
-#define GPIO_DATA_DIRECTION_8                           BIT(8)
-#define GPIO_DATA_DIRECTION_7                           BIT(7)
-#define GPIO_DATA_DIRECTION_6                           BIT(6)
-#define GPIO_DATA_DIRECTION_5                           BIT(5)
-#define GPIO_DATA_DIRECTION_4                           BIT(4)
-#define GPIO_DATA_DIRECTION_3                           BIT(3)
-#define GPIO_DATA_DIRECTION_2                           BIT(2)
-#define GPIO_DATA_DIRECTION_1                           BIT(1)
-#define GPIO_DATA_DIRECTION_0                           BIT(0)
-
-#define GPIO_INTERRUPT_SETUP                            0x010008
-#define GPIO_INTERRUPT_SETUP_TRIGGER_31                 BIT(22)
-#define GPIO_INTERRUPT_SETUP_TRIGGER_30                 BIT(21)
-#define GPIO_INTERRUPT_SETUP_TRIGGER_29                 BIT(20)
-#define GPIO_INTERRUPT_SETUP_TRIGGER_28                 BIT(19)
-#define GPIO_INTERRUPT_SETUP_TRIGGER_27                 BIT(18)
-#define GPIO_INTERRUPT_SETUP_TRIGGER_26                 BIT(17)
-#define GPIO_INTERRUPT_SETUP_TRIGGER_25                 BIT(16)
-#define GPIO_INTERRUPT_SETUP_ACTIVE_31                  BIT(14)
-#define GPIO_INTERRUPT_SETUP_ACTIVE_30                  BIT(13)
-#define GPIO_INTERRUPT_SETUP_ACTIVE_29                  BIT(12)
-#define GPIO_INTERRUPT_SETUP_ACTIVE_28                  BIT(11)
-#define GPIO_INTERRUPT_SETUP_ACTIVE_27                  BIT(10)
-#define GPIO_INTERRUPT_SETUP_ACTIVE_26                  BIT(9)
-#define GPIO_INTERRUPT_SETUP_ACTIVE_25                  BIT(8)
-#define GPIO_INTERRUPT_SETUP_ENABLE_31                  BIT(6)
-#define GPIO_INTERRUPT_SETUP_ENABLE_30                  BIT(5)
-#define GPIO_INTERRUPT_SETUP_ENABLE_29                  BIT(4)
-#define GPIO_INTERRUPT_SETUP_ENABLE_28                  BIT(3)
-#define GPIO_INTERRUPT_SETUP_ENABLE_27                  BIT(2)
-#define GPIO_INTERRUPT_SETUP_ENABLE_26                  BIT(1)
-#define GPIO_INTERRUPT_SETUP_ENABLE_25                  BIT(0)
-
-#define GPIO_INTERRUPT_STATUS                           0x01000C
-#define GPIO_INTERRUPT_STATUS_31                        BIT(22)
-#define GPIO_INTERRUPT_STATUS_30                        BIT(21)
-#define GPIO_INTERRUPT_STATUS_29                        BIT(20)
-#define GPIO_INTERRUPT_STATUS_28                        BIT(19)
-#define GPIO_INTERRUPT_STATUS_27                        BIT(18)
-#define GPIO_INTERRUPT_STATUS_26                        BIT(17)
-#define GPIO_INTERRUPT_STATUS_25                        BIT(16)
 
 #define PANEL_DISPLAY_CTRL                            0x080000
 #define PANEL_DISPLAY_CTRL_RESERVED_MASK              0xc0f08000
-- 
2.53.0


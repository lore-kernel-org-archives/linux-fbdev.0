Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E8347534
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Mar 2026 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580362; cv=none; b=ridh9Emaw+JkzzgyE/fLDe4EwM5S2EE7SY9rlIyPFGlePoWfv6jK4X4zz3/2AuQ/zV3vRydZs+8DUFd33YS8Xxy133CNQJUgJLGd5EcJjrmIdGo+JBu7pd5DohrnzoFDzGN+7/VOouCi4FRKfYJ4RpFNNvj7WzBk5sj9v5D4/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580362; c=relaxed/simple;
	bh=A3+faAY7AXDtRwO5G5QmTMd3uq7BnRwjdVOM4uNiuhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILyxNnqC26Mz5yhJct+g7kmiRHWTqqEGvXycoYwp5+VBj8iKyx1HLL5vloipf44w0cP9YRc31mxu7+efV3zO313gkd2taKT5xgSIjd6pT9aeZ+j8w+M4HEan/TpPzVD9f1irJgDMMgYr7U8Vp+00vIe2eV27GO+vyW6OP/XSRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/rukHD/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/rukHD/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4807068eacbso51624595e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Mar 2026 15:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772580360; x=1773185160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAdMTVC0yzAIQdHQtiqVKDmjjcmet5Re2izhdAxquos=;
        b=J/rukHD/hD34SI5j9BRVvyJiHW4SW6tEFik/BDjkcDUYdNYUbVzB0ZJWc2At3Hj9Vv
         d7uOlZ99VUnbOFc2uLQzuYNcx2Ld9mBp4pjbaRZzER8CUUUdnrTAhek0iNg6K5kJxILR
         sVeQThwASJ+VshvH9775p6ayKZ2djrqhDnhIYA2vI/zezJIq/gCVHhLTuQuh3nqAnkAA
         4RnSr1lDErcknKwBTymE000Kk8JZyzt+oiMr9sUimIgdca4YAwYSHSbwRXqStMSpJP7P
         UveqW0TyIjIVQOKMAu1MHC8wpBSIU6224OHosiVa/ixGH4xct8CiTlRb73N6qFdFC54P
         wVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580360; x=1773185160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SAdMTVC0yzAIQdHQtiqVKDmjjcmet5Re2izhdAxquos=;
        b=kdQXrwmqjiUODknO4NuqK+E2A60yq0RFHtyqXrdNk2VIYXYnRKbABm4n8YAM6PB2hY
         ZmERxG6RQrg+1W9L1Ui8lwpTnjUw7df1T8tbFP8vpj61aWaSL5Rwl9xnmtfrR9awwN41
         YWGzVVJLY+HGTH1iUtbGeBqVTinOSBCQGPoQNLUs7KpaQzuPkP+OSM7NZ8qSuzhPOVnY
         V5p/9K46HyiPxUEWPBCr83gM0EXFb4cwVE6ZUEfBB5jwbXLYF3o5bAUnUBuHar6l0xrW
         GUEeOFmGBTJr1LpRhFCr6sJoWARN93mHkWRX6UpUB047NYL1J1w7k51pN4d5O0R1RuEr
         87Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV+Vi75JEe7oPiirHWqgURzDC3aR1hYjcMO7F1ViK8HrHcmRW/zVzRNTF0wBzMreM9lIaswbkqJI2lWtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5l1IVR+WaJSlksJtXW9XZ/Ahdg4KGY4stnz+ce7SODjM5g7Zi
	KehwzsYiCT2Gc77bQ4hMuiWqhOnrVFoi0I4htqzseXJs9bur6Pu92KPs
X-Gm-Gg: ATEYQzw8Y4QOqJ1NUEGWeDVA1o4A+CDw2b72r5F6EDW/iv5RdIJue9pLyILgHfWFnza
	kOEuX6CvAFEGqKzcin+e+uDdXvQsmXTab1fy/SsNq4mAkASjcDuCVP+5OhRZvLcwPzNA+airww+
	ExD0UEEPJl0OIe1FmeJE1W5aY91urP3LS5xpf0PU1CnFG/Jx3uUvWHskvpmv+nViD8Gr8UMkOIt
	wYSDD7/Fsp85I4cZ5EcThG2n+VLWdIlVeZFGV7tqcJYLIJxIwtrAjY5jpv0yQAVmEHjtwmvbZwm
	E1Vzzhpgun0mqbV0K2VroPno2NKm7fVsbu1rcOnggbHLJXzkjINor4UG0dNw0cHkFM5x4wMPtTC
	JPRtRTZfsq40UVYjhBM80X723h+QrwqwqzWrtsZEj4THpJx66U0lerXSLcwW6oxEuvAN76ShCSW
	jMZ/PvDxvg9ufqiSZLwkNe3mlT5w3AZ1WBWUiNY7f8O/+pkdZJKFchjvF2iiba
X-Received: by 2002:a05:600c:470d:b0:471:700:f281 with SMTP id 5b1f17b1804b1-485198a767emr458515e9.25.1772580359436;
        Tue, 03 Mar 2026 15:25:59 -0800 (PST)
Received: from arch ([2a02:1210:2e28:2800:36a5:7f85:ccb8:1176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851335648esm68036615e9.5.2026.03.03.15.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:25:59 -0800 (PST)
From: Gabriel Windlin <gawindlin@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Gabriel Windlin <gawindlin@gmail.com>
Subject: [PATCH 6/8] staging: sm750fb: remove unused interrupt register definitions
Date: Wed,  4 Mar 2026 00:24:27 +0100
Message-ID: <20260303232434.1850583-6-gawindlin@gmail.com>
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

The RAW_INT, INT_STATUS, and INT_MASK register macros defined in
ddk750_reg.h are not referenced anywhere in the driver. Remove them
to reduce dead code as noted in the TODO file.

Signed-off-by: Gabriel Windlin <gawindlin@gmail.com>
---
 drivers/staging/sm750fb/ddk750_reg.h | 51 ----------------------------
 1 file changed, 51 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb/ddk750_reg.h
index dd1d67fb9856..8f227d974613 100644
--- a/drivers/staging/sm750fb/ddk750_reg.h
+++ b/drivers/staging/sm750fb/ddk750_reg.h
@@ -77,57 +77,6 @@
 
 #define GPIO_MUX                                      0x000008
 
-#define RAW_INT                                       0x000020
-#define RAW_INT_ZVPORT1_VSYNC                         BIT(4)
-#define RAW_INT_ZVPORT0_VSYNC                         BIT(3)
-#define RAW_INT_CRT_VSYNC                             BIT(2)
-#define RAW_INT_PANEL_VSYNC                           BIT(1)
-#define RAW_INT_VGA_VSYNC                             BIT(0)
-
-#define INT_STATUS                                    0x000024
-#define INT_STATUS_GPIO31                             BIT(31)
-#define INT_STATUS_GPIO30                             BIT(30)
-#define INT_STATUS_GPIO29                             BIT(29)
-#define INT_STATUS_GPIO28                             BIT(28)
-#define INT_STATUS_GPIO27                             BIT(27)
-#define INT_STATUS_GPIO26                             BIT(26)
-#define INT_STATUS_GPIO25                             BIT(25)
-#define INT_STATUS_I2C                                BIT(12)
-#define INT_STATUS_PWM                                BIT(11)
-#define INT_STATUS_DMA1                               BIT(10)
-#define INT_STATUS_DMA0                               BIT(9)
-#define INT_STATUS_PCI                                BIT(8)
-#define INT_STATUS_SSP1                               BIT(7)
-#define INT_STATUS_SSP0                               BIT(6)
-#define INT_STATUS_DE                                 BIT(5)
-#define INT_STATUS_ZVPORT1_VSYNC                      BIT(4)
-#define INT_STATUS_ZVPORT0_VSYNC                      BIT(3)
-#define INT_STATUS_CRT_VSYNC                          BIT(2)
-#define INT_STATUS_PANEL_VSYNC                        BIT(1)
-#define INT_STATUS_VGA_VSYNC                          BIT(0)
-
-#define INT_MASK                                      0x000028
-#define INT_MASK_GPIO31                               BIT(31)
-#define INT_MASK_GPIO30                               BIT(30)
-#define INT_MASK_GPIO29                               BIT(29)
-#define INT_MASK_GPIO28                               BIT(28)
-#define INT_MASK_GPIO27                               BIT(27)
-#define INT_MASK_GPIO26                               BIT(26)
-#define INT_MASK_GPIO25                               BIT(25)
-#define INT_MASK_I2C                                  BIT(12)
-#define INT_MASK_PWM                                  BIT(11)
-#define INT_MASK_DMA1                                 BIT(10)
-#define INT_MASK_DMA                                  BIT(9)
-#define INT_MASK_PCI                                  BIT(8)
-#define INT_MASK_SSP1                                 BIT(7)
-#define INT_MASK_SSP0                                 BIT(6)
-#define INT_MASK_DE                                   BIT(5)
-#define INT_MASK_ZVPORT1_VSYNC                        BIT(4)
-#define INT_MASK_ZVPORT0_VSYNC                        BIT(3)
-#define INT_MASK_CRT_VSYNC                            BIT(2)
-#define INT_MASK_PANEL_VSYNC                          BIT(1)
-#define INT_MASK_VGA_VSYNC                            BIT(0)
-
 #define CURRENT_GATE                                  0x000040
 #define CURRENT_GATE_MCLK_MASK                        (0x3 << 14)
 #ifdef VALIDATION_CHIP
-- 
2.53.0


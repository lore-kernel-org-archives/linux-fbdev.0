Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF431B114
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Mar 2026 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580356; cv=none; b=Peb2mJo2wqRsFPRiCaVBp+4astgqytA+H6e/Pkb7BqK84BgJocoTBdnOm6HW1xycXtVx99dto44ubYnYr2jILOtNaTAO4wN3DJWsHBR83/KMxD0s7a7vGORquZ0sEoif3PY4Ol/ZEd5Qf1fu307b+C748I3BITIzbcMRWOtUe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580356; c=relaxed/simple;
	bh=Pa8F7PZEbktd8+dTv1wrWSTv+ufyPg9PDeh0s5sqG0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUH0DVtO3lkiqatRWpMzEHLXHKhXSFeDshGY4Ci0r1cOKmnPpDFPyDvvktez90n1H/v8kU6z5hhMm7cmD3BSxQD9LR2Tc8Ck56I+SR3vrMS0Bn0k8LWiCltPqYyx2wsloI0z/wPa23W2LtJkLZ4NpKjnkufQkUk3ZKi3AB4ObEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wu+ldzV4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu+ldzV4"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483bd7354efso83034285e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Mar 2026 15:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772580354; x=1773185154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h+Bz/MzrKKLJpBKItUCSkeFF5VnFb+6x6e0SzQdfs0Y=;
        b=Wu+ldzV4aIjFtVi3lPHkFpXV2VDSR1JEy12VDueYG7ZYkcHpuzTPwfOEkLeqCmaxNA
         QUuWF2iyiIjfcjjxv4+7ZUx1srWTdsDR2/PyHkCN4ibo4f/d80/Ir8dBZvwWkQcNUWPZ
         Q6G8mH6F9DvmSzAnpFiN25Qx0xF2uqmyU9a9kieyaWb9rcjFdBECa05v/yb58UuBvVWe
         xPQq4GYfL/iFPB4jP7icpDOPldaLpAvcn6LcUkzWCku/lBXI2/vNuabWkwDikxS2zJ4N
         MbG6jtSRze1gOsHy+IxPZUDX7nNBmaRV5Q5CC+Tt1A5qSnaNTaLRu5kPHl5gWC6gIBHX
         bykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580354; x=1773185154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+Bz/MzrKKLJpBKItUCSkeFF5VnFb+6x6e0SzQdfs0Y=;
        b=qSsmEvyPJdN/fXUAkH+g+TFRgHnrT7STH85IflOOYLqFozDfaR8wa3mtqjEtPKS+6J
         Q0kBxtWLK5PfIPHgfEYAyDskbnTvfFbIIqqVnUgjsGhnP+W65AVC/6FFRzeCN45Q9WUN
         6ypmvXcq7PuDKNYkNHufVH5FYXet0wQIvZYKSo/yACTjaO6B1lRLwvj/pzeA4LWmvLjB
         r2ye7UdnL/+0JB3AXTMc+ZqV2Ro0U94AGJn0Po+y3dO1j7fvcppc+XnJ4DVxKjD8PQCW
         kcgcLSRPilyDH9rZeSj2Q3VxqhMQmc6GMTuSo48f9wSWL7ejwiwhXkSdxMKk9GoN/SXz
         y8mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnCVxWRgIUqWlc5DysRuQAzb8HQiz7IaW8aIZudCjM5blazWNi14Q3wdaNQmWU2S3RgO52DzsPi2sSGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+oEHCpSNi5m/ALaI2ndRVfg9JSIZf+xzohzrGttKx/8sf5/BU
	p5vy1jG3lDQAk0KuXBWJHBKvh0UKUMXIfgnP7alkWyoXJsIbv4nUF4gF
X-Gm-Gg: ATEYQzwXGhft9Ov66gC11+c9fHDv6F9iJrbdzgHnRY04wfnfKKdIYgCk1f1ZV6jFeOe
	W2Iq4e2OZzdrsbhGNWrju5SuMmfFjEfSANmLCkEpSZvmcTRPA6IkUgT6laEMmb2aKBrVw9aIoLC
	v9yKW8m75m7TW4KMXgKiyoVtcN+WkgmkupRmFyVXzC3LNovLzXsimymzD3r2K1QxvgpmM2JS+Jr
	iB7/DJwum4XHaB9cUx4vGQxxiWpM8DHAIputWzYyg/D4Exw46zA2H37O5uZsDaQ1XzoTzMB05Yv
	6Rj0qJLutD6oobd8nhOQI6gKBYxjJi/1E19vl41KCnp4+qUwrYxw+qCQCkcNd0kfvgnbbNkbjz5
	sTU1XA024n5g0Ifjm2WZVQOsmZlGx224TgAfRmlwgMK3uK7hJ+Mg1oCR1yU/TFsbP69hSuNisCj
	DUCCh98Eaehz0loRpGdS5hk/da6h3YkoeOf5miW6UofyH0KWLkpg==
X-Received: by 2002:a05:600c:c84:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-4851985df94mr745515e9.15.1772580353491;
        Tue, 03 Mar 2026 15:25:53 -0800 (PST)
Received: from arch ([2a02:1210:2e28:2800:36a5:7f85:ccb8:1176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851335648esm68036615e9.5.2026.03.03.15.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:25:53 -0800 (PST)
From: Gabriel Windlin <gawindlin@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Gabriel Windlin <gawindlin@gmail.com>
Subject: [PATCH 1/8] staging: sm750fb: remove unused GPIO_MUX bit field definitions
Date: Wed,  4 Mar 2026 00:24:22 +0100
Message-ID: <20260303232434.1850583-1-gawindlin@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO_MUX_0 through GPIO_MUX_31 bit field macros defined in
ddk750_reg.h are not referenced anywhere in the driver. The register
address GPIO_MUX itself is still used by ddk750_swi2c.c. Remove the
unused bit definitions to reduce dead code as noted in the TODO file.

Signed-off-by: Gabriel Windlin <gawindlin@gmail.com>
---
 drivers/staging/sm750fb/ddk750_reg.h | 32 ----------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb/ddk750_reg.h
index fe412ead72e5..59ecbc0d48f7 100644
--- a/drivers/staging/sm750fb/ddk750_reg.h
+++ b/drivers/staging/sm750fb/ddk750_reg.h
@@ -76,38 +76,6 @@
 #define MISC_CTRL_EMBEDDED_LOCALMEM_OFF               BIT(0)
 
 #define GPIO_MUX                                      0x000008
-#define GPIO_MUX_31                                   BIT(31)
-#define GPIO_MUX_30                                   BIT(30)
-#define GPIO_MUX_29                                   BIT(29)
-#define GPIO_MUX_28                                   BIT(28)
-#define GPIO_MUX_27                                   BIT(27)
-#define GPIO_MUX_26                                   BIT(26)
-#define GPIO_MUX_25                                   BIT(25)
-#define GPIO_MUX_24                                   BIT(24)
-#define GPIO_MUX_23                                   BIT(23)
-#define GPIO_MUX_22                                   BIT(22)
-#define GPIO_MUX_21                                   BIT(21)
-#define GPIO_MUX_20                                   BIT(20)
-#define GPIO_MUX_19                                   BIT(19)
-#define GPIO_MUX_18                                   BIT(18)
-#define GPIO_MUX_17                                   BIT(17)
-#define GPIO_MUX_16                                   BIT(16)
-#define GPIO_MUX_15                                   BIT(15)
-#define GPIO_MUX_14                                   BIT(14)
-#define GPIO_MUX_13                                   BIT(13)
-#define GPIO_MUX_12                                   BIT(12)
-#define GPIO_MUX_11                                   BIT(11)
-#define GPIO_MUX_10                                   BIT(10)
-#define GPIO_MUX_9                                    BIT(9)
-#define GPIO_MUX_8                                    BIT(8)
-#define GPIO_MUX_7                                    BIT(7)
-#define GPIO_MUX_6                                    BIT(6)
-#define GPIO_MUX_5                                    BIT(5)
-#define GPIO_MUX_4                                    BIT(4)
-#define GPIO_MUX_3                                    BIT(3)
-#define GPIO_MUX_2                                    BIT(2)
-#define GPIO_MUX_1                                    BIT(1)
-#define GPIO_MUX_0                                    BIT(0)
 
 #define LOCALMEM_ARBITRATION                          0x00000C
 #define LOCALMEM_ARBITRATION_ROTATE                   BIT(28)
-- 
2.53.0


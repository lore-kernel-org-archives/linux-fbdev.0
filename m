Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D6301480;
	Tue,  9 Sep 2025 06:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397824; cv=none; b=KU1W0ArxAUQV+vV4l4gba/Lm+hELUWSn4amqkYzhUon2M9JEijjKdLWpG9pDBkpGRc+8Aqmw+akAtd/SEwIbOZJwPgJ2ivtM2Wm9n7wcjXn6anAhIv2h+RvOV81lcwSGpYbE3XhFs3mJ10v6zSl0c/CEZG1ijR2d+Yw8zE0IPMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397824; c=relaxed/simple;
	bh=sArw20JjfCGt3Tt3VJw4wcfrb4jGqV5C5oSbve8OqSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsXUDRa91WLseKweRez1yzLm1gpitIGR8G0c6Mzw18aCIMW30VTKWr3mkQMmXmj1sKk+uOxPEJRDBq132/ojB+u3YpCbfdMcGbO9gFnU9RPsBzK9gEp/UemgS5rMWtW0fFPro7gFWnXseLoKCrSDmZ0UrO5P2PjoHosYg+FJDvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5cY24hc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5cY24hc"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77246079bc9so6213107b3a.3;
        Mon, 08 Sep 2025 23:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757397822; x=1758002622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xUdZKaT5B2ZhU9BDE5iqzR0B7D+QHqptUpqCo3VtYQ=;
        b=E5cY24hc/a4QMqN1+MEjk/UZh/bpa5igthcrWSG9KXZmiTgByWE+9lt5sG7twuLtLy
         BKmPwtPawIOWfGW3V0h0ymXGnyPi7MlHY5qFzl6B/wjnY5L2gILGkig9fCxuvOzkZZVU
         Tvtexg7/O+BumkBLgdCDbPgnU8MpiIu9+t3fL4mn/MPTGzCIkDhFKSgzDN8Hb0x93T09
         L41UPcdsSb2zsiMCu+saz8HV+DOAY3ziwUmxzN8IBq52Rfnj/T2ry2SCMtZqjxMvFR+t
         7A+Vz5MiKL7WF9pHtX7fGyb+uWpfd1rrbKlPhfIVk+1Xh7INjmSTqONcpcRo5IrB3+VV
         ZZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757397822; x=1758002622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xUdZKaT5B2ZhU9BDE5iqzR0B7D+QHqptUpqCo3VtYQ=;
        b=GXfETsY9x/Ej7LyjG1NXgweazS+Yp7S8B6HAMnlZZ7hCt7X+S0uT4wcKljgwCDuvVF
         YRVO1Cs9P5GX4xDNZ26OUjhdCtLl0IsaQO/xycyryDezj3T6ARts/XxMSaOLzPug5x9w
         iTIFe7357lcvpt+u6a54Bo7FaD6dHDTvcoLen1yCwgy1pjlr0+Ym7NlER37ibGmHo+Mc
         j1bnKIRm7ySK0J4U24LyxroAFRpMV/Ii3KpZ3M+1dLY0WY6AWwpLglSOX3wdwJfUKBx9
         QHURIQkCKpJcEXuPwzplOcCGOMXVlCx1uMoLVQFxN/B2gZtQ4HO06b1TGOuyIHW0iVRT
         oD7A==
X-Forwarded-Encrypted: i=1; AJvYcCV8RGFeomWCKTqjEvTR6xT7VYFR93s6sZhiyQjqYTsnGWHFt3qPuZCrJHI/Zq1NuDrM7Vx1eeMgO2q8sg==@vger.kernel.org, AJvYcCVBE1Y9uJF6xHSl9HAL5BwQVJtlHPqwg972uEJuutflb2DHgatWbxxsDaDTZlXMosL898P3Qf/HuOUQ5gva@vger.kernel.org
X-Gm-Message-State: AOJu0YyxFqNJmp/H5urtu2E29iRqqRUoYO3sNTdn+3VTmrXFpBGiTZkz
	3eHdyfZWeiVyJVW8TTriTiqZMoR92QYSgsfwRL1Qm/YuPkEpT5l6mbAq
X-Gm-Gg: ASbGncsgsmBUIhTXnqd+mGqfhXFaGlTKucDG1X05K9Ogj6gkpfc7m4XiGXwgKz0Eiw9
	ma+ec/qu8DTkzHWBq08y+P/Yo/o8eS2ojhAA82Nw2Ckfq56TI8iOd0WHMVY6jGq0jnPy1fa+Kgf
	b5uPgzDwj2V5Uh5XN8YYye0/vhxut6FeEU4OmvrjkWfbVfYFPs8HFgijVnCR0BD2DttGi4QHFss
	GUOvEU2lL6W+eAmIZUpL+PQv71IrjFRlqoWlZ86BJFzOehsxh4jCjwh1yG6fTN2cQl9Mw352AP2
	XDUefCYLVaA6ZP3fkmib8fa4TYwrIp1xVPWffIyBYQZRp7OoX4/G9IOh4WWQOkcyIsD8adF5gQO
	u5UV5l0lnaYs2aRkb4Vq4Fnk8gyi1mEFuWPKmdHgYEVQEFld/YB//BrBQbQ8y4p3s8yYMyejmbm
	H+wBfZh6fZjFAhqbljIesEpg==
X-Google-Smtp-Source: AGHT+IELkEZWe7bc0mm4YjG+JrKa1xdnUFM2Qo97pI+DJaZi6VrJk2uBZqkDxhuO3JMPgeL9l6sllw==
X-Received: by 2002:a05:6a00:4104:b0:772:750f:4e2a with SMTP id d2e1a72fcca58-7742df53ec5mr13133323b3a.31.1757397822314;
        Mon, 08 Sep 2025 23:03:42 -0700 (PDT)
Received: from klmny09 (awork062176.netvigator.com. [203.198.28.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466156d94sm852148b3a.40.2025.09.08.23.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:03:42 -0700 (PDT)
From: Yiming Qian <qianym1996@gmail.com>
To: dan.carpenter@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	qianym1996@gmail.com,
	sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Subject: [PATCH v2 2/2] staging: sm750fb: rename snake case variables
Date: Tue,  9 Sep 2025 14:01:30 +0800
Message-ID: <20250909060130.12919-3-qianym1996@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909060130.12919-1-qianym1996@gmail.com>
References: <aL5tjv_2YkvHPs5C@stanley.mountain>
 <20250909060130.12919-1-qianym1996@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaces CamelCase variable names with snake_case:
- dprBase -> dpr_base
- dpPortBase -> dp_port_base

Signed-off-by: Yiming Qian <qianym1996@gmail.com>
---
 drivers/staging/sm750fb/sm750.h       | 4 ++--
 drivers/staging/sm750fb/sm750_accel.c | 6 +++---
 drivers/staging/sm750fb/sm750_hw.c    | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 41f1fb390..fcb7d586e 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -50,9 +50,9 @@ struct init_status {
 
 struct lynx_accel {
 	/* base virtual address of DPR registers */
-	unsigned char __iomem *dprBase;
+	unsigned char __iomem *dpr_base;
 	/* base virtual address of de data port */
-	unsigned char __iomem *dpPortBase;
+	unsigned char __iomem *dp_port_base;
 
 	/* function pointers */
 	void (*de_init)(struct lynx_accel *accel);
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 44b9e3fe3..7ac2e7b6e 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -19,17 +19,17 @@
 #include "sm750_accel.h"
 static inline void write_dpr(struct lynx_accel *accel, int offset, u32 regValue)
 {
-	writel(regValue, accel->dprBase + offset);
+	writel(regValue, accel->dpr_base + offset);
 }
 
 static inline u32 read_dpr(struct lynx_accel *accel, int offset)
 {
-	return readl(accel->dprBase + offset);
+	return readl(accel->dpr_base + offset);
 }
 
 static inline void write_dpPort(struct lynx_accel *accel, u32 data)
 {
-	writel(data, accel->dpPortBase);
+	writel(data, accel->dp_port_base);
 }
 
 void sm750_hw_de_init(struct lynx_accel *accel)
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 7119b67ef..ce46f240c 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -58,8 +58,8 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 	pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
 
-	sm750_dev->accel.dprBase = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dpPortBase = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
 
 	mmio750 = sm750_dev->pvReg;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
-- 
2.51.0


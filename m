Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390781F4E4F;
	Sat,  5 Apr 2025 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743858253; cv=none; b=HQju4qsJUIHA2ZrKQcB42iYsO5MthKKHru9z5oRO/26UHJx1A7J9oGZfWR1lhAAOqJ8Hf69hVu13rF1i9Pq1ct089IACPFsnA5KHn6GrCAgKj5M0v9UJztY8+hSiqW0TGPBodtcCd52eFdyjUY+txGTs7qYu1A8CR3FNhOBF5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743858253; c=relaxed/simple;
	bh=JHgSmpHywThLvhaNGwqkN6rlBmIZHywWloaU6MKIwBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NiGgK46QQYkyBEbp1ahgoWWuE2tOnXoRv92BVyqiyqQ1u0mOcv5uPmA6vmJmmWMxwYgaxzHEc+f6DTbyT/gr6AnLJK8eXaK7yi24Hj/NFsXXMJdg09PAecimDdv2xOti/O/KPnBZcO0S2Q/lqm9Dw0pMzyro4LTH4mtIMBPZSk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFLucr4d; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFLucr4d"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c1efc457bso1711364f8f.2;
        Sat, 05 Apr 2025 06:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743858249; x=1744463049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAIrh/4WE88oUvyzDDtUAXVVh7UEV5wee/SgtjWD0Rc=;
        b=kFLucr4dwtjn46rICfwo8r9hESZXT60DmNDLff2KQYPj4sT1l0aWNNoQq21mjzaZH/
         i3zVtLzaRzkpBLf8sgmxnIj882UgvMl4IvkXDzO7bvdPA9Cc3TCeIbJHOlgzQd2GeMTB
         eev4iHFDTlEi1eGdudH+WT15CE+bfi4LIqxyfufVHj6f8KZI0Wvi7UZWGUgHV5CeMr2+
         ObvXCc6Ox2+2XuRYPrK4w8/Lhw7+XWyrQpnUzOEz9cbvY8rC9ovDLxUtgfOo+Dk9UjGB
         z6z76beycsxr6a/wfunXgQ28uU3W3zDyp1jM46fepGKGX8snMYf2rFvmvBdUMcdJ4eYJ
         CJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743858249; x=1744463049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAIrh/4WE88oUvyzDDtUAXVVh7UEV5wee/SgtjWD0Rc=;
        b=Ru+EU67PHr6lBZCgdZljmQqTBSwc+pF2EHDuty7MfG1PKAGk+0UuJH8NnuPrYRMrOl
         nx0mRLl0H+Hm7lrueo1scOLFLLrBO8kdj1KekhtWaCP130CwOOBaTX0noMj0dNscn1/U
         A88Ckyazk1i/H7N/L+nndaPiayRRyq+y+9ekJzJ/pfoyhvs591awEVg1SY2nx4kenCVr
         K0m8bK0WO6FKSE3qLYzVkMQGMSi8hZOhlLwqitJep9nnTztuTLuWdJXA37BU33PUnat0
         EmSZgLKzDKIhp2X2qOSiR0BYzH0KreuPIKcqaUrrxsZ62OTkwOKoNVpqwMa3vk22oyH0
         SECQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjeeONZV1SRCXPYcdF+IUg60WjHE20bzm6HR+5X7grLQMNZU8qhNzQyImYsnB607elRcJugTTHDUAtoA==@vger.kernel.org, AJvYcCWIe3cKJ3+mxCacv2SfOx5YH5ZaOT3EF+jNK8Jr3UIJM3fDozW3Gvwore4z7t8mASAs7BoKWaZ/uZPOFznK@vger.kernel.org
X-Gm-Message-State: AOJu0YyyS9IwaIb+hhvvlLWQ05VReWlSr+TFEt/hxvKYDRC1dMTzfbGc
	TKQPTX6/JeAEVaFqbYHZ70ccHPd0HMZMu3kDskUMIXRabaAHipUx
X-Gm-Gg: ASbGncsq5O6ngAXma9SvK72HvdomGIpu11E1gEy/oyxg2dqH5NYNeSumBh2gquVGUDZ
	GJtc/yBwvrHesNbP3HtkchFwdtifmAbnatRKdy1Yijpa/RIhZGFvAm0j6FkmZewyRYx2iWc8jaH
	X2FxjC1QVUWqT119zN0QeLjSdMAHlUOkwPIvs97zRZzdnPnY9US1HF9EHhdqTQQMHcjoTcX3CDy
	ElAuHA6SyMh4dZr8gzXQOVSGmB+SDL5Zq0ODi61RtZ6V8jnNSTPk8ONHHyW5fCEqTZHowwJn7g1
	/BYNVG6Czn8m5EemfCFDiD6jZA==
X-Google-Smtp-Source: AGHT+IFy7/wUPqCvEakjCfStSAVFHHLZeyl0QNSgypg2iRDFE08Cl4cXLODnbt0O0X07/+O8L2IA3A==
X-Received: by 2002:a05:6000:4310:b0:39a:c9ac:cd3a with SMTP id ffacd0b85a97d-39cba93cf33mr5574261f8f.51.1743858249274;
        Sat, 05 Apr 2025 06:04:09 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1795081sm77366675e9.27.2025.04.05.06.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 06:04:08 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH 7/8] staging: sm750fb: change sii164CheckInterrupt to snake_case
Date: Sat,  5 Apr 2025 14:00:58 +0100
Message-Id: <c5c01f1840ca37c24fcca7bff4b09adba37c3a7f.1743857160.git.princerichard17a@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1743857160.git.princerichard17a@gmail.com>
References: <cover.1743857160.git.princerichard17a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change camelCase function name sii164CheckInterrupt to
sii164_check_interrupt in order to conform to kernel code styles
as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164CheckInterrupt>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index ac1aab77da28..1def02be4cce 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -23,7 +23,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.set_power = sii164_set_power,
 		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
 		.is_connected = sii164_is_connected,
-		.check_interrupt = sii164CheckInterrupt,
+		.check_interrupt = sii164_check_interrupt,
 		.clear_interrupt = sii164ClearInterrupt,
 #endif
 	},
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 6ce15b7816d9..aebde3d8b903 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -370,14 +370,14 @@ unsigned char sii164_is_connected(void)
 }
 
 /*
- *  sii164CheckInterrupt
+ *  sii164_check_interrupt
  *      Checks if interrupt has occurred.
  *
  *  Output:
  *      0   - No interrupt
  *      1   - Interrupt occurs
  */
-unsigned char sii164CheckInterrupt(void)
+unsigned char sii164_check_interrupt(void)
 {
 	unsigned char detectReg;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 90b7ae823a10..aa3f34c13979 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -36,7 +36,7 @@ char *sii164_get_chip_string(void);
 void sii164_set_power(unsigned char powerUp);
 void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug);
 unsigned char sii164_is_connected(void);
-unsigned char sii164CheckInterrupt(void);
+unsigned char sii164_check_interrupt(void);
 void sii164ClearInterrupt(void);
 #endif
 /*
-- 
2.39.5


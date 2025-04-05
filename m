Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD95B1E7640;
	Sat,  5 Apr 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743858225; cv=none; b=mWpz7l522LhQ5vh0uMz9qA+WUAoORS5/p+fAtdTmZ6teMNp5HF6EDu3ENQZQYXmDb8fX63BFYCc3dLqGDUpp9aUihzrAvgLN/RSOOwN+T3cS7CRz0L2YZLudUB4gK7w7+RPKf9Lxv/XdkZIqH6SkfVA3XtNGkUjmyzLei9xkXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743858225; c=relaxed/simple;
	bh=Z6xq/h+Qly0PKUGsSPTgPJbf66WR5pT+E85G1cdl378=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDg8hw/kS8LnHo5DlSFGsc5906F00UaDMdevy4F5SUaE/2s5RXtPQv7JGpXk5TdFUfcmDHO9rcvmJ6IAFny80ZPmu+DqQXJwu5DPZc3Gn9vS7KOzwzbAH/3aAaTLawdUiH3+eVJplbsjqubfcCSb3V1dtTTCDt1vdYvGGFzZsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY+qZpWM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY+qZpWM"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c14016868so2524467f8f.1;
        Sat, 05 Apr 2025 06:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743858222; x=1744463022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVTlKXlj09u3x3cF5cGmCUxBsTXjfJU7FwaBPii2bKY=;
        b=lY+qZpWM8J1fUNO5LqE2n3ZGMIX1UcSrpvzjU1winP+HlFlI4JDyfSu68ziPbAKtA2
         nNlsL6NLKAelY21R0t9gBhI4vIgwhToE585dCMmargGDb8ZG8y0t2Q4yeiaFAvyz8zwM
         nbv817be11CLv8Ewn35bdk8fHcq9AEoi9Hj/pe2P0dtnpHnf9NUwXgbTO00gXqRJtnwE
         6C0rUd96k8LGYY0R7xabKx1p+lewmA+98l8BzrEp7212qS8aiGwhY/CO2IjAJelBBN0S
         5+2i9bqlHXUX3TEXBgxjNzmkWPZWDhVHolr3Tblk0LS4kgwK2WW3ZxxLgvm4KvdzUg8B
         r4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743858222; x=1744463022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVTlKXlj09u3x3cF5cGmCUxBsTXjfJU7FwaBPii2bKY=;
        b=aiE4+/qZ95b4lQHIpc/FlRv4NgxBZsdxAv/E4EwvYsjUhUFW15KLsSqkdPoRj26dcq
         ShaQYpWgUwN5b3LcM9Wpl2qAGsqWeK1eqA8kbNYIQtOu6CmLs2wG3H51QhM7Mu3yzQb+
         HAn8/ddvJuvY6U0nTRD8FIuqDaznBDTo1BgtKiU8kjo57Maji6cqg06JrOipKhpLzO3h
         P1kCv8J+S3l4UN04W9lxn0oTts5XAjEghtyaKTLnMb2o57n3bfRl7z3C/1N86tk324Ka
         MSDPf9SRqZeAEcHVZrVc9MNgG0LD8jKmi0IJMBzrJ5yLYDz3OQX2b1AzZfwVQrcEsUT3
         2g5A==
X-Forwarded-Encrypted: i=1; AJvYcCWGh/t2NfcPX/kcS03yoALPxRAbAIumhXeCxMiHNgXsTI2lO83f8lxLebOMhdCDQm99hhs+qjSfQ43BtqJr@vger.kernel.org, AJvYcCX8YvGlIIbAWfvneD5c3BH/3NzNJB2i9j5pKe9y2TzgZF+l7078PJw5kRw6CCGevxPow7CNueoFUf7gVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKuqzskUnIfz0/pQ9T/+IvpBeeta/JScspx+N73pPeSyDxPI8f
	yu5msW5nZY2nBIOmKOkC0L2jwkIhGJxYM65AQeehPhehH/GENnHMr3QHqGU3Lns=
X-Gm-Gg: ASbGncsXgP8JXHY1e0XKUq8k5Nj+/BANW3EncAPolrgvICJA9Aj5DySyknlHDlIaQe+
	5aXpgl4bnPYxIcX1CWyfDR9cJt7be1wXFTODyQr0tYNl29igU/A6YrQx/I2TqFIMEdhdcJSefEf
	JVyO0e2SF2EvZiWe5Cue+Jb2bH0AUMnjhXoFQVJuJ7C+FVt/6CS+mVNB6GvGFVaBSb2CED3a1rA
	f4iUEGPRcbmsL5X0KXziRqnsvQGEEVKWKD1/egCnpugq7TeEWoGF8+A3b4YQqpNN0EQsgni3NHA
	w3wcC7OiXJOKeGguYfRduMKpdg==
X-Google-Smtp-Source: AGHT+IHbHQIzgZdPRIb/SjbhPaPxh4G8SN2OsFmIIY0sHDVmccSXtysb5SvsyLcaZ3/zyCp8ztHoXw==
X-Received: by 2002:a05:6000:2283:b0:39c:268e:ae04 with SMTP id ffacd0b85a97d-39d01f6f04bmr5425335f8f.0.1743858221667;
        Sat, 05 Apr 2025 06:03:41 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1795630sm78097495e9.29.2025.04.05.06.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 06:03:41 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH 1/8] staging: sm750fb: change sii164GetDeviceID to snake_case
Date: Sat,  5 Apr 2025 14:00:52 +0100
Message-Id: <16e6e40930d67bb6481638982da13fc32fb88f10.1743857160.git.princerichard17a@gmail.com>
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

Change camelCase function name sii164GetDeviceID to sii164_get_device_id
to conform to kernel code styles as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164GetDeviceID>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 6 +++---
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 8b81e8642f9e..3fb14eff2de1 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -16,7 +16,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 	{
 		.init = sii164_init_chip,
 		.get_vendor_id = sii164_get_vendor_id,
-		.get_device_id = sii164GetDeviceID,
+		.get_device_id = sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
 		.reset_chip = sii164ResetChip,
 		.get_chip_string = sii164GetChipString,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 2532b60245ac..223c181dc649 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -48,13 +48,13 @@ unsigned short sii164_get_vendor_id(void)
 }
 
 /*
- *  sii164GetDeviceID
+ *  sii164_get_device_id
  *      This function gets the device ID of the DVI controller chip.
  *
  *  Output:
  *      Device ID
  */
-unsigned short sii164GetDeviceID(void)
+unsigned short sii164_get_device_id(void)
 {
 	unsigned short deviceID;
 
@@ -141,7 +141,7 @@ long sii164_init_chip(unsigned char edge_select,
 
 	/* Check if SII164 Chip exists */
 	if ((sii164_get_vendor_id() == SII164_VENDOR_ID) &&
-	    (sii164GetDeviceID() == SII164_DEVICE_ID)) {
+	    (sii164_get_device_id() == SII164_DEVICE_ID)) {
 		/*
 		 *  Initialize SII164 controller chip.
 		 */
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 71a7c1cb42c4..a76091f6622b 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -28,7 +28,7 @@ long sii164_init_chip(unsigned char edgeSelect,
 		      unsigned char pllFilterValue);
 
 unsigned short sii164_get_vendor_id(void);
-unsigned short sii164GetDeviceID(void);
+unsigned short sii164_get_device_id(void);
 
 #ifdef SII164_FULL_FUNCTIONS
 void sii164ResetChip(void);
-- 
2.39.5


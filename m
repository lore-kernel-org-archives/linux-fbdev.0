Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117FF26A1A3;
	Tue,  8 Apr 2025 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107659; cv=none; b=lCpvmmmq1fysd30hG5X/McEu5x0AS5nJ3xqNBVD7gyauPJInCBWJ4wBAKcQMZ34g2Ike7vMFcGzIAM8oI7AhoLZ99p+LlLQ/0dQg7xvfm9JmaI228OuA19mgnfqrVU0uRRyOLRLokelG7jKjy8RPNvPRrJAaQ+Y50GIKNcKf67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107659; c=relaxed/simple;
	bh=gcvZnMhtR0XkyTMXHmFjgItkzTjcKo4d+SyWoFfroaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iPuGfZc9ZkgtjPwHxyD6F+XyTe8SFoXH3NwMeubJ4qUJ4GJG3CfE1VSFpegZIQ9wQnibcWZU5iw1CparJcYgtIOVYes/gWCHtgNRdxgu8izTiT+SF7ygyH/p2LbCRqyDEK9zhl6LlEcKw3tPcjbNqkb9Bo+628QNyn2PKeYMQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieM6RtGk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieM6RtGk"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so58428765e9.3;
        Tue, 08 Apr 2025 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744107656; x=1744712456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZIIlDBSj3POSZxjDzaSA5f1J19DQOtsWmRISrShn7M=;
        b=ieM6RtGkE79oA5Mid2EnBRHwK+6RnTkcvqWXauWcyajXu33voeMm6nnkx8oUe+HyQO
         oSc1WJIcFOZr/8U28hD6cXTtxcNlVsa9n4LsKOAKzsgKMHHWOVSxCROxm/VOersk0iBx
         A6QrD0dm+/vMpfd1knF722PU1xzv9R+SsI9Be9kCZURF8DEI6xMlIKY7iHSwZcsDUar5
         9dNOResNwSJcAbruxatK9yJBHNiB6wu6l+PoIH3vyvQEBQcNUeQh78TaFBDVcVJmVz8z
         y5zygtqoMabp8TzdKltk/W54cm58hx9tqvQSDq/s+9pHEyXV3tsgmvkbHPX9WpYYqepq
         QyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107656; x=1744712456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZIIlDBSj3POSZxjDzaSA5f1J19DQOtsWmRISrShn7M=;
        b=Swul0Npxn8OlOuT7oQesylJOKtHdspfT/4YGY/LSH3OqoZyALRbvJK9CIhfOLi1xJT
         MEKdn7hCgwjUZU7GTVIAybsAqI1ZmQRiJsNzmYxFl6BpxEJenHaPzt5wkZZZVKIO9W+K
         rKMjYd5+8VUxL0+EZycOTGeM6JHOJaSBlxfqy6wEpFO2h8wfIp7d7lu0enKzZjU2uQp8
         +Tu3ZM9kzvmiThfl9w4e3DbRrYSvYDRPNpX+lzIo+ZdqbZKdA/EcDfZv/B/GHBCelJmu
         e0u+zsBSQK6p1FNALodJxlVsXg6/5v9fwf2pVf6czz8lirkk69DK1qOPpiizXokrupBr
         HBFg==
X-Forwarded-Encrypted: i=1; AJvYcCV71L1+NKOVroMVBmj9FqKevsYjoYGtr/bWDkdv/un8vpzYJi3Du88190Gx6L9NmpgI1tUNxHdbGUQ0Hg==@vger.kernel.org, AJvYcCVxkP05+/OqgU9/FF48B9zN1W6QTe1GjAklXQ3b5m1MnWC5vYB3EwZCthRKe5N5Ylsb7vFqa8qphNEzJzVN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xIDMz+vT+V4+6uBg+oYVvyB2NhZqDFd7v9WfJFBuhMb04Zoc
	qNQIvPDLcOoL9Gdl/NAMq2edQmu6dIAyE/rYWtB93mKhZ7sP9sTc
X-Gm-Gg: ASbGncu9RTi9iikwzxcZAwdzGT8axbuTGB4RW1Z5ND9UrMT/W8wFKaURetK3j31c5RW
	0SYNJMTOJRk60cHdFzmuF0DFPS/vXHnni9v9/11QPhHKgwewkCUZRA1rWfvEKE9wTJbSFz+K5/e
	0F7q+7hIK1gP1TsI1AlteQenOKT/01O0x1Rxbwtq63BL5hDxy1J0i1kW23FsWakeXQ3OJEv0BgS
	9pQyKm+5XiNjszuH501AMpz6RGORs6UcZJOtk7LkO6k2uhjzjjX0SIKwAXCoIwVdmqLAYjkLjlk
	RkUSmWU6nZOUlCSlf9ejZUtxIrs=
X-Google-Smtp-Source: AGHT+IEsp9oOK66ROaMwepC3KzcapxT4l5rsKcKJpFOCzLDlNEmLKAbmgtEhBVuTg0sksgQ9nQYYCg==
X-Received: by 2002:a05:600c:500a:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-43ed0da06f1mr140654805e9.29.1744107656181;
        Tue, 08 Apr 2025 03:20:56 -0700 (PDT)
Received: from parrot ([105.113.112.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eda4662a0sm118419515e9.36.2025.04.08.03.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:20:55 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH v2 2/8] staging: sm750fb: change sii164ResetChip to snake_case
Date: Tue,  8 Apr 2025 11:20:34 +0100
Message-Id: <0974eb17fa67b707e8d2972668da4d8a692a9702.1744105388.git.princerichard17a@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1744105388.git.princerichard17a@gmail.com>
References: <cover.1744105388.git.princerichard17a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change camelCase function name sii164ResetChip to sii164_reset_chip
to conform to kernel code styles as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164ResetChip>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 3fb14eff2de1..6dee95e60a6e 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -18,7 +18,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.get_vendor_id = sii164_get_vendor_id,
 		.get_device_id = sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
-		.reset_chip = sii164ResetChip,
+		.reset_chip = sii164_reset_chip,
 		.get_chip_string = sii164GetChipString,
 		.set_power = sii164SetPower,
 		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 223c181dc649..284c32f7e9b4 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -250,10 +250,10 @@ long sii164_init_chip(unsigned char edge_select,
 #ifdef SII164_FULL_FUNCTIONS
 
 /*
- *  sii164ResetChip
+ *  sii164_reset_chip
  *      This function resets the DVI Controller Chip.
  */
-void sii164ResetChip(void)
+void sii164_reset_chip(void)
 {
 	/* Power down */
 	sii164SetPower(0);
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index a76091f6622b..7a71f94a1e9b 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -31,7 +31,7 @@ unsigned short sii164_get_vendor_id(void);
 unsigned short sii164_get_device_id(void);
 
 #ifdef SII164_FULL_FUNCTIONS
-void sii164ResetChip(void);
+void sii164_reset_chip(void);
 char *sii164GetChipString(void);
 void sii164SetPower(unsigned char powerUp);
 void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
-- 
2.39.5


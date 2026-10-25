Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792946443;
	b=wXU59AiYZm3hEjZsMBcwjxGje76Tzw+otfUCsz9YtC9rHrf3dZccLzMN9QdIOUPlwCeV
	 1MgRV0XwxQrRUY/3taUHjS5d6K+0HjZK1EzPPb56l+4cgCPeMkf7kA8d21iNqO8Ie3A9h
	 JEcFfFCSrCCN+xq5mpQN6jCTiIKjt4NzShVyVReUfFHL0YsTlu5bh4mGgABd3Yl4ctqGM
	 H5/3xeAxqz3BfNDQgo2LpxSbvTQNU/Hz4FqXX2Wfctfc8HQptPazb7cDniOpEh0GFNQH6
	 n7rh40f6sVrO1eXzybzTcZFaH0ytXpBKHHQQDOYzpiCpyclJkBVDBeEqZNXkpx4vINw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792946443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xv9NAEq9hQ0540bja4x3wK9UU5VFlX1ceZODo3NuB5Q=;
	b=JQ7FBucBQO9liFR/rFmPpBxZU5MIXJ1LClDy4fsR1FygWb3e8Uzd4pl+sgat0GpcOojL
	 4ERO7/b3cJgk3fP3XkLnBM6UgX5Uj3/EV+fSa75qX0omAznmM6gVYZ10AaMXXW33Kzb26
	 n+qoQ4dIKErCsoJ/pi5OnEnNL1M1MTjyHsYruo96wGpiAVAcyZnQZhGAjTlREnA6dD2Av
	 TZShIjbd9+PD36v+bKiMyW9CanvcarPM9Z20fpW7aEVTCKv0ENBuC8CLOBwbvmZuGDR3N
	 SQsc3UgkChOwbDP/EDEgdCQHPkPZCUe3HDisbQ4EX8VZdbDSr7adJjb5N18tWAOsO/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L+wAaBf4;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF4606A31D
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 16:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20AF4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L+wAaBf4
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1438d9363fbso1730703c88.0
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792946441; x=1793551241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xv9NAEq9hQ0540bja4x3wK9UU5VFlX1ceZODo3NuB5Q=;
        b=L+wAaBf4hK1NOTaPyxxY0g42upPhkjpjdeUiMZeUE+Y56EtN/LB+Zu7EteOUThkX8P
         KmzPxkAwy9Kc5ET7HoU3BnOi8xxPnp9W0aqPR4qXq2QkwKE9+YOsJVAOHkK3Dg1U2Dk6
         2+7u5PrMan60eMyn7BckCODwxqK8nMdXuZf3mKTjtX3yAApBQfa/uEnIZGLkhsbZ2do9
         baKdvqBQHc6tGtxH4dogrGf2dB5EiBU5+joNNxyXFFrjfWxIlG9bRDY/KvaITkWhf8rL
         SzwOAvZ4MhkWDXCTeg+VApOzj8+Su68djNAbV3vlJMjfyjYZscV7t9xwqFzklqhdQmRr
         HGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792946441; x=1793551241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xv9NAEq9hQ0540bja4x3wK9UU5VFlX1ceZODo3NuB5Q=;
        b=PjfK65gO2D2bgvraVWbWegYHqxUs6CThKiaubgMherECtJwUvmg7U7hr+8nCPIaaN3
         LkwLKvq2DYlzye7QXs5YmpKFk/RWNezMIKtBqVKBm2G5yYQwxPxBwKfVCvF2y7a2sgoe
         KlpTEqsMvCluby+oaSRbUjIDyDbqX8UikJ2uUmTIDahUR6zdx7+2DgQ7VHDdMyFhFxz9
         uWA65gA/lYKncljvENOhwAy+Uarg2WMOUDtGemNZe3t2y9jbfy+W7vPN+iL/zJ1b3t+7
         FMpfgztAUib/4D0dEH9G5cikNgO0y3pFcQGji1oelegvHBRrpN0rm9otwR4bn93qdA9f
         uF1w==
X-Forwarded-Encrypted: i=1; AKwUvBwhL/8OZN13BARH2I9P2Tz3s9O0va53MZjKdXUS9rA8CFKiCbs2kAoXS1X9Jkq9tkMnGCM6faqRAkYB/g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJmEKvaNcI37NZPWAjsu46JUWLvFh0XiTAIRZKSMYPMJ52WuNhz
	VWBwrQ770x0LYX69p86oKUY4DV0cd2wXUBPlmx9O9miTk3/QSa1HpNze
X-Gm-Gg: AYBFou0/HSqyYtQFFsSeIjy9jR6TKYwhXFr+kJWM1kRxMQXYSB3Ln2AzolcY0Wa/0rJ
	Rf4OU1DW3TZbU6Ql6sz3RIxZ0YsVY98dS0lqSmRyyH0zr+8nWDLrf4ECaSreqRI9YHT1A7gs1SN
	e8GF9ljTyDH2EamY527deZj0+rz8ZS3FHdAd6eaZ5mqppzmcskgsyQUpt/ZcbHpTv9qsTVma12q
	iRsy/Xw3ult8VR4TpSQg3jk96AJdmBDfPryXCO+mJ8AiurCllURrmCDvZLMn0kou/511BxxdtC3
	IvBNLZX8gmzQzO3ufaoOmeqzLYpO12wDQ+c9WOeTibWBeqUtyNKoNF1hNLqA8OQmG+Jul34qZgr
	b7nyuFiM5LOI20nhr2YcAWRRSlwOMm1ArCRX0/qSaKEesuryM8MKNVCfMjwD6JcVK9nvVjTswW8
	STBlweitqqMxXsnBTBrEu2rDmTxDtJqtOWlUtmNTxMR4HJv4w8lpEXkjpqJFVGeopZrgPiuuXqb
	8Q0sQBHrNFI4iOjVtZ+CbJ27vU2VFXolyWxg2BARNAXRQH0lCpJG9gaR37dAMp3W9lyxgfmgvWS
	pgEWpACvpdvfa1an9NdL
X-Received: by 2002:a05:7022:28d:20b0:15c:a04c:cd4f with SMTP id a92af1059eb24-1993fba292amr5562765c88.0.1792946441092;
        Sun, 25 Oct 2026 09:40:41 -0700 (PDT)
Received: from himanshubakshi ([2401:4900:1c9b:1c1b:d646:355d:1105:8655])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaebfsm17401503c88.15.2026.10.25.09.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 09:40:40 -0700 (PDT)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Subject: [PATCH v2] staging: fbtft: Fix line length warning
Date: Sun, 25 Oct 2026 22:10:03 +0530
Message-ID: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>

Hi Andy,

I have made sure that the \ (backslash) is properly aligned to the same
column as the rest of the macro. I have also taken into account your
advice and hence added a local variable for platform data.

After some thorough searching through the respective directory, I have
not found any calls for fbtft_init_dbg. This might be because it's a
helper macro that might be useful as the driver progresses.

I have also noticed that some other macros around this one have simple
style issues and if you would like, I can send another different patch
cleaning up those too.

I have also done minimal testing by using the macro once to make sure it
compiles and has no errors, if you would like, I can also run any
standalone tests for this macro.

Thanks and Regards,
	Himanshu Bakshi

Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index fd7f8fc2afba..ceaa9a3906ef 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -421,12 +421,11 @@ module_spi_driver(fbtft_driver_spi_driver);
 #define DEBUG_REQUEST_GPIOS_MATCH   BIT(30)
 #define DEBUG_VERIFY_GPIOS          BIT(31)
 
-#define fbtft_init_dbg(dev, format, arg...)                  \
-do {                                                         \
-	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)-> \
-	    display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
-		dev_info(dev, format, ##arg);                \
+#define fbtft_init_dbg(dev, format, arg...)						\
+do {											\
+	struct fbtft_platform_data *pdata = dev_get_platdata((dev));			\
+	if (unlikely(pdata && (pdata->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS)))	\
+		dev_info(dev, format, ##arg);						\
 } while (0)
 
 #define fbtft_par_dbg(level, par, format, arg...)            \
-- 
2.56.0


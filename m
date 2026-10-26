Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006681;
	b=VJA6PgKHNA3uusn19Xzt11lasIxPXKei27VqXGZL9aRNDMysc6T+k+DEHsiujEg1VkmD
	 ZwI3on6WvurYZ0lVxfUsce44pB29if9Dttfil4Rg+VtebfxQhVKcft3eB4ByanSKkymGM
	 qPTLTUT98tDy1WbCCocFAHXBdt8CocDwtsB44djfgX1sYqrhI+7ZdCkevlxd9q0T1ChDI
	 GiiC+OLtZx/6M70TiB2Q8HSE1q+Tpw57UcNZh8abx53JM4xzeVJomjQiaYWy+jlkBx+3/
	 E5FrvkBWUjwNtTs/EzP4NzvtxmSbP0jK4nU6mt+cn0hIu7S1GMz4oyJSvQ61/ciQAhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EKnTU2YcJJTvtAtaAZdLOGPL4mJYMsQRUA55KN9Oiyc=;
	b=2uSzuAuCg3rwBVfnZ3jiSvR3b9lIsHQNEQncQsunWx0q6rpmxwliILNRVUNp4R7aMxwB
	 SwUkmPWfK3vj6fz/VTRdWvq9DwGNSA9x8C/pzMUVmsXXeQmZqTNArMWyV4o4bZ1lfX6hM
	 T0bBvZfdq9NEvYrgxfv8/PeJsR29IBsqcNKaNFrbmX/qy5rG8ft8jfvG1/LMHDte+yTp6
	 WmXxGG7+U1TIXKGKgMXK6wO0vw8GknSMLKfG0e/nFqwhjLevOdU/upvBKmUYW5rF0fuPP
	 nYmR5tzGUzZuDwRwX4xci3cde27OFY8pEISdhgE33MlDbfzdvaMHrZlC6X9cHsGUhaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qaAS420E;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CDA606A31E
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 09:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92CDA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qaAS420E
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-369f33df08eso2431007eec.0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 02:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793006681; x=1793611481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EKnTU2YcJJTvtAtaAZdLOGPL4mJYMsQRUA55KN9Oiyc=;
        b=qaAS420EFiFTQrOs6XweruNecSqNFR3KwTo0uV+oCYPE0CKvgrzY7JAFrmQIzA+Swy
         tGD4Ge0gHZsti7q9ZEFv29luQ7f07y1Fuv6IOLCYtVdRiNefMbEjlRKeqzfkydftPqQi
         sPwSpfcmZvHAVX83jXgME0IBHiZoHnTjOiLSw0Wur/QG7DV2BFQXUCgZ5hYO0mO8soe8
         tY+y5eRE5OGTbjWeWX/gExOZJbwgpv8HDSUZff9iATCpL/ywjeFEzDDW8FeW5TxG/I/3
         fz5JrVAgcCT+BjVUEMLSqyBGpBcHhM7U31XmKVE1XXzcJ7mRCZhRTzMAp3wSPq1DypEN
         8CEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793006681; x=1793611481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EKnTU2YcJJTvtAtaAZdLOGPL4mJYMsQRUA55KN9Oiyc=;
        b=YPk5RxWRhBBr5Ao9yD5/xcRFhd4Jn8XubjxWe/ydy0HeuzMe2APBAnt/EmASQCCn3+
         cOf5R3c9yB19Uen8JMSZfbYZypLVamdSqtt+M2ljiPbwe9yGx+vNwoxD08/GJL3OpQzR
         x8VRhE8JuGOgFSXN6lqKcZ0ndOPoqx8VpxilIKqUnELmxPoe/BHfcqKXcolRUQcdA+uw
         3ZqZO+VwljexeaMt/keAPM0gQFEWHCVWQ/CSL51W9NHKHIfhkK2oUUz8FK9VXHTx/dDq
         1K2/+HZB4LMRhdvZTOsenIo1+FrWxWz8TGyOVNaGS6qioxckjHGBeKnrTSpOE2Lkig0Y
         p/kw==
X-Forwarded-Encrypted: i=1; AKwUvByzCnvlXpRENMuxatK3MnkVVItekJnhGbkSkQhA7LalBDvOffx+cFnALCPKte7qez3uVAS7xl2yA3WnYw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKPu0Me3wzthHH9AOuZdUviRUPYdidpO1NLsU9pLnh6kmZzmDG1
	UhVrx68QMXQJ2f3yhRjB2KMTGD/fW4Uz2POPn6neMXni8c4Ampj2/PD2
X-Gm-Gg: AYBFou2qk0PO4yTvlxpAFYPXO64wLETEbO/MWg76ULqJAUGLd09j0OoRHS35o8WZFKK
	T5XJ1iN4qCkZuCP+dg+nQQ/dtl23jziV6e/IweBtryYvF4oZzTOh9dSJue9Sm5bFjqLeYVaKxhK
	Tmrsf91peoP4dxJCENjF0Z3EgaiHw82MGomUzBxTN4cDCvz9cyH/WanV/OpYObJyzCL59w/qItl
	SSRMz7NtCovC+YyHgjOwNcreEtBsbmxbUFxBXVPPLt/3daIW8R/uQBrA33VKLoH5n8PyaFkKNFw
	YjIEcHMEzX2z3CTAawG4KOX5RV7+PqNdQb6IlJWHTxia3wHcBzIp1lpOHxNBuOqu1o4TrcDi6gp
	EXy03ue65lD/edByq78QqJd9FM1fAMbn3oHhfG+7rMgdU2YZLWeUcF0zZjCXxTJo10boobYLLOf
	ZZBYrhWMw2BX1rpFuw2LEEBT7k7ggzMZfqbfPMpgy8hCGam6y865ufkN8TZ9n89cC0EKZWzODGd
	v8hCtaHhKEsNFQ9BF37u54zuRz5zpATIZJwDY32xe5aiwNrD7i9sdv1B1kcOnySUiAD3uJH1ic=
X-Received: by 2002:a05:7300:fa17:b0:369:fcbb:4d4c with SMTP id 5a478bee46e88-369fcbb4e9dmr4419186eec.7.1793006680504;
        Mon, 26 Oct 2026 02:24:40 -0700 (PDT)
Received: from himanshubakshi ([2401:4900:1c9b:1c1b:d646:355d:1105:8655])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8c576ebsm23648985eec.3.2026.10.26.02.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:24:40 -0700 (PDT)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dennylin0707@gmail.com,
	cenzhang@linux.microsoft.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Subject: [PATCH v2] staging: fbtft: Remove unused fbtft_init_dbg()
Date: Mon, 26 Oct 2026 14:54:23 +0530
Message-ID: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
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

The fbtft_init_dbg() macro is not being used, so delete it.

Reviewed-by: Dan Carpenter error27@gmail.com

Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 40a7567df1eb..16459e4e0ba0 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -420,13 +420,6 @@ module_spi_driver(fbtft_driver_spi_driver);
 #define DEBUG_REQUEST_GPIOS_MATCH   BIT(30)
 #define DEBUG_VERIFY_GPIOS          BIT(31)
 
-#define fbtft_init_dbg(dev, format, arg...)                  \
-do {                                                         \
-	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
-		dev_info(dev, format, ##arg);                \
-} while (0)
-
 #define fbtft_par_dbg(level, par, format, arg...)            \
 do {                                                         \
 	if (unlikely((par)->debug & (level)))                    \
-- 
2.56.0


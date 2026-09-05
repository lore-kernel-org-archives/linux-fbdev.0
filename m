Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F874A2A4A
	for <linux-fbdev@vger.kernel.org>; Sat,  5 Sep 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613044; cv=none; b=r3VGamJQc1vr49n1W9V0V99ufHiw3VQg1eJfUww3UxBXGMkfrNWx6/Qj2+4l0zc54mRmV3wkR4rseHLA0SqsLHW0bNGwKcICrxS4ejYuNFO1VM2EQgtzoTksyJCENX/dYz/H78Wj5NDugnQQluencFN4HfbuAlPbw/sNnYVT6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613044; c=relaxed/simple;
	bh=fqRQGN2NtOQEQ6U4DtETKEyMZbTPYavOTcCPLbSO1d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlteljqLCQVKO63nzN24GWfzVkN+X9V/KXteymk0mRzANLnXCe2sjiBxGFImRCPW3LcgdH6g9ipj0gTxQYezF7ohhVJYrtJW/QrCjikMbtuuo/Ure88oMA8VbSvNa5gWrLaK1J4Ohwh+09C6oTGlrj+xrDINd8bQKOHVBHMibb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oL64eJiy; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oL64eJiy"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5c65d654c23so799979e0c.3
        for <linux-fbdev@vger.kernel.org>; Sat, 05 Sep 2026 05:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788613042; x=1789217842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=oL64eJiyZHx/JqXDa0DLvHL/BUopETrEFGRWlFErEtn5Vzcf0K1vZj5bfCjV0JTq5V
         wh9HWgh/Be4BkF4E75rIGN1PaxFiOM/a2z4Wkt+cGz9ucsTKSW2SPudorALbIM9YuLc0
         0/rMSo2ZsqcwuOKWbDecJDkcudLIJKxxOSF+EN2NhgZzrlPtP9aYhZdsW6sBI9OWyyUL
         zybdeZ9TJqBDU9IdHbsfUAWKFmiv5naM4CY2HTJj/oHoBgX3P9VfuE90DKXyEV8YZYE0
         uT0tLKEphUgSKWBDq5O05H82PZZj6CXecUWWtxF5ZkuyDmBzP1Fau+7xvpG8GreBgDkj
         UOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788613042; x=1789217842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=miQi2CcJKNHmajSAhKs7nivbU5mMH5TPUgAuLpEd9Rgkst7U98pSQUXAYKIqesFwf4
         zbmzgbllPcDiJOFhFZaiihmBQAlDkjb4RbGE2A3DqgLSa/6x9a/1vOv5rJ12WqSPh+F3
         T0b0CB9PaDN3iBfc6+wokVi6+o6FZewX5E/rGMsHCY2ltNNOkOmOOOXdQi8UuTeD2+7k
         TY27ISDuLP77OnrrZH4187zit6INr2U51P+3JId93AVBri9uX6Oi6NnSI6tf2GhiTatN
         Bgp2L/A5J7fM2CMY+xSHcLnEFiTV4pT/gc856SC3+d0QRMtqASbwnX74PD0BVQ2I1pD7
         GjBQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8RT3VTAdLZZyo0qdyiEsYlW/tR9SVZ4j6/L2Sd5rG5AerKZOCAUfzRHS3kVhki2XCuhPJcYj46XfFAA==@vger.kernel.org
X-Gm-Message-State: AFuF++mOxg5ulxVr/oFTacfUUHNbP0V80rfZdg8uH0cqVWiYJlME4y6Y
	wZXzEHLLWtRPVZZODIhbGek60T0sSqClOc22KrQ+y+JkYXkpg6ndicWD
X-Gm-Gg: AYBFou0nclhjmGGiBnQSXdal0jL7vvjtYj7vY/NToY81OVoRUaMxkEb7YD5RIJZZPQC
	u0KOBuNIQtR8887cGW3YnfWzqkLoFFXRJGxL4dB5+PznctXb7teXTC89Yr7pFCo+SOCHuH+xe7k
	D9QxUJVU+v2OQdO6qssZhjANMkW1+Yo+MN0svMcK0PMjgTn8CljkKKTAhf10bVBx9dDja53uHw8
	UmddzfngKUgm2ZY5Bh/sB2HybD19QrmkecVcRuwpknRkVgT6IsP8SV5luyP0PK6tv0b4R+8Tjfv
	aBDsTvPgsGTj7sT3q5TZIfIM2QPMV65znSfpDbFnHAcnF2kIzc26sujQpKIOIeEgxzqI8TELazD
	ps0HMO1Ogo1JL8cdw9svsvUoOJ1XIkeIGK8/JUPs6qROnz7mucB7LBaAM6zcZf2AWa8QblRNqIp
	3Tf4Cppj51ekidMADBrgnsZOU7JklUvfb8WF+tqpoDxvHYmB1FJDyLdZ8rugZIBpRBXMwMXAW/I
	WVa22Gi9gZKN02N1pUMqeK844f+BKxrPVFs4TwJIAs=
X-Received: by 2002:a05:6122:4fa2:b0:5c7:c666:ec22 with SMTP id 71dfb90a1353d-5c7ed407509mr5471080e0c.6.1788613041673;
        Sat, 05 Sep 2026 05:57:21 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec1ef7a5sm4349416e0c.5.2026.09.05.05.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:57:21 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v8 2/3] regulator: mtk-spmi: fix Makefile typo for mt6316
Date: Sat,  5 Sep 2026 09:57:05 -0300
Message-ID: <20260905125706.6550-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905125706.6550-1-breno3011alves@gmail.com>
References: <20260905125706.6550-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a Makefile typo that incorrectly placed the mt6316-regulator object
under the old CONFIG_REGULATOR_MT6315 configuration flag.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/regulator/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5a764cec8..f81d1f31a 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -107,7 +107,7 @@ obj-$(CONFIG_REGULATOR_MP886X) += mp886x.o
 obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
-obj-$(CONFIG_REGULATOR_MT6315)  += mt6316-regulator.o
+obj-$(CONFIG_REGULATOR_MT6316)  += mt6316-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
 obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o
-- 
2.43.0


Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28044A014C
	for <linux-fbdev@vger.kernel.org>; Sat,  5 Sep 2026 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611704; cv=none; b=FDt/2bxYO2UHO5rkxdIA0g3tyN+lREL76rEPC9aA6wfYP5wB56K8j47yAWrSiEQyB9SHZSPbabjNPkzEGHiXv0rRoSqn+tU/sNJfiPJmM6OhTTrDqFIUd+UKK9ll179dtwX2T8oKBBqZNj+I9+FtsTZ3wIalvf9cx+NCxg6iQ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611704; c=relaxed/simple;
	bh=fqRQGN2NtOQEQ6U4DtETKEyMZbTPYavOTcCPLbSO1d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnB4KdwyRSpfciFffX+5qWR0sdn7fwX9DN1AaHqSRgOpTOurZSyDza60mCm+9ogQRQ/tdmkr5Cox+rJZAGL2ODR9NYZlhxgBXNO9de19qeE+0xqMtqMWcMAWlxFpU/91jtxAmOsSR+twrc9A+khg9aoMy6hVc14kfTu24kukXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfFc8NvH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfFc8NvH"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2349984a91.0
        for <linux-fbdev@vger.kernel.org>; Sat, 05 Sep 2026 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788611700; x=1789216500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=KfFc8NvHycwffxp/MuDnnI6GzEu6tIHkW7Y9k8dKiMJfZJeskPB3P5q6k9dVF+jvmM
         Ydfr1SY5F1o8KsO693B+bapTI3AmcIOQ12mZdNgtxBsDzt+uI8iSj/szdJu6H07pswID
         u8iCSNqEj9vr68rZF+sv77X7kqqF5mgcH6wEp8ep1ZBshraYqUf6C7sX5GQFyCG6wSjl
         dfzPw+cDm9IQOLhTcptEpWKPK4shPYU1u3ooFNYAlUKrOtMEVQvSj2jq57ArrJsZdR65
         R3YTlfJcbI2egUYL501e7Etl32DKVwR7vi6VJxGAv2j+HB8slAKHeTVFYzsbD9isqzK1
         FW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788611700; x=1789216500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=OYgSFZokqQ+1dW8XZ8hZNyZi5LEAOXyzU4Sy/K60lyw2TzaGYaZ5a1thlV+ra+C9uc
         lw8ue2AoBsEzTtSkLNchKRh3xxh9ZAkb/+JcNPFQ3NuMYgO5pTvl0vWye+5zmdUHoBxS
         Ns99qr8Ev3dGxToiwlYcB4udJNyBvDkCfr3nZHwwhAU5sHh5OCs3j67K7FtMy+LTsZeO
         YxVVzEo3GPhu7PuGCVJmycnVOKWQvIrX5HEGmSU3AWXG74x9LkZGn5OCZnN45jPdj7Ve
         IJkPrwb/IqpPzR72Aojy9veCDnyejsiW3TIf62FW/jpnI3msk5ui1a3OdROei3XJXQIC
         Cmxg==
X-Forwarded-Encrypted: i=1; AKwUvBw8u89ENVV39SgdxekEQonmt0kSmlPlTNXqghhmgfYcpqSaabMEIZnABniLEWeIzaaD3VasfM7FYKro4g==@vger.kernel.org
X-Gm-Message-State: AFuF++nXN+uRQQnSBjR/6h4lTLhawfwtr6PQgapkiIyZoquI/1cjkEQr
	Ff92+2I6wc7RYhD08h4tVYGvG34zpePFx/EsD1z5a9FDOGgVp1iLQsx/
X-Gm-Gg: AYBFou2WTTEEwA0N4BGrRvQbxHJQ33pE7FlVquRBBXq3w9XyaUkhmCttBRoGp5VnwWB
	+/aogzMA0bN8gDEaX+ZMkQ3QewdGPO8iWIMzAyVWq+aLdOt+JUVmtuCE/W0F08EyhSXs9E+OJ33
	1FXujRIiDdO0zKo78QCX8fJ2qugVj8YrRtcQ+nKi2plSz7V36gHFI/tsUKcDhVTYY9w+nSPO+MY
	l/z5m0O0LYhLlVAOve5tgxMtthTrITzqLCn2BKy1WSrAcJFFm0FUg6yg7W5YQLhMJWhRIUjsX7Z
	4961EC2Ep1JR6yVRlhkWdNsWonaTXhzis/+PFGwt0EKCOFErkM3AKrH29tybLjqtTtYAI1Qxrgo
	mjGLpafvxHpK/XYpZB/guvU9D6UgLW1dht/LQzt/HMPZFkkbrpx72l3iGdcBsLLCVin/ZSqhVHf
	C1S9RfrFFkmZZVtm9AzpT1lddlKw/1MtbiAmb+L9B7kT6W8NszJDbRG5ApEKNCNgTajzgDmdduS
	ZAMHdTVbL1GBd4CYF1AW8ora5UudGxI
X-Received: by 2002:a17:90b:17cf:b0:398:9be8:ea6a with SMTP id 98e67ed59e1d1-39b26216cf7mr18508993a91.23.1788611699999;
        Sat, 05 Sep 2026 05:34:59 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm13829815eec.27.2026.09.05.05.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:34:59 -0700 (PDT)
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
Subject: [PATCH v6 2/4] regulator: mtk-spmi: fix Makefile typo for mt6316
Date: Sat,  5 Sep 2026 09:34:48 -0300
Message-ID: <20260905123450.5620-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905123450.5620-1-breno3011alves@gmail.com>
References: <20260905123450.5620-1-breno3011alves@gmail.com>
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


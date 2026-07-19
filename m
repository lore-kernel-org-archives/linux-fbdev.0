Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46D1E2858
	for <linux-fbdev@vger.kernel.org>; Sun, 19 Jul 2026 02:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784429351; cv=none; b=AHTbwBCGs998F+FpOK088IUpaGCV+DQsnLlVot7W9FQUeTjELTn/yX4v2ldd/K9rhFH9RG+2altEtTYVzczke14UnHzX91d67xhoYMe9gHipIXaPZaLQqQf72ArOsdwJd19S140O7fKPoDLs7ZRhY+PQ8s448aDz4sbtQwEqyPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784429351; c=relaxed/simple;
	bh=MXxB4GZiKHFAI1sL9yi81rfTb4Lw1/BnRWZYPDzq1KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rc/0xRBmpNhXJbtZiHJAhH9hFoN9wlp4J8j1SpN0CUuaoI0TYrSPpoY3BCiCV8SZp0Z59lHUf2rqgMq+F99w4TJWMYhrjTr1svjY++P55GWfrgDh6D5P9XCuEWE6lHxbHwD+DPJ1ogjJd8P0bmAgyfC97bSz1B0rojRzo58qUEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVQEgyin; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVQEgyin"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8114a4542b2so40670317b3.1
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 19:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784429348; x=1785034148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eUctq526SauCU2PxPCwSw6FjrhWQ6qRSV04+u+gtfls=;
        b=CVQEgyinN9swTCRAcMLpRhpaPxdtyApGgIg/hXiHYNE86z4gXg98RmqL/gTiAzp9aE
         MG0scfSxO7xjJIMK0n/ldsF3lulx4R9UM/EBfoTBtfu/EuiV7EbdI//5YyndqMut1OtW
         ++ryC4hquSHlmWEQ5LZr+v3Tbg6T6AyonKudC4hZtS9Hnqu8lvnvzke/tT5O7XBwd0+5
         orGPQYSQViy2FclekBaMFop4AGDBzOOT5p3IXbsZIAuvGh3aCbfkWc+KW9r91hlzlKzj
         pcafhv7fR6BNkiTNkHQY2HKKqMS8nnpo3dqJei9gl/eKN8fQBVRbkY5eCvJU1I5QDr8H
         eoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784429348; x=1785034148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eUctq526SauCU2PxPCwSw6FjrhWQ6qRSV04+u+gtfls=;
        b=bri+1KTUJJVwgfXXq74ingAigRxqlZ8nVDoUwg07YF6X69KW6hcIGQMCqb2hGTEPeo
         uQxtFsbKUW6lpAXQ5O/EDgvgPS/rIhtXjQVwb/IaQxcX+JaKv4bqmRsF36kwpqh1RPzl
         daY4k9/krESCVtDgw/+EsRIVq3ulgCwvpis4FSfrQD/4ylhaBTrFCogLTMwIJbYR7MEM
         vTR3Z6USM7IX6zdwMzFcr7st2NlyFLJmaYOZKwxgySUNQERKhTxeMAwiRdtcPJ8qWVhX
         L7WVLPpluJxt9nxVxadG8jiNa3Uf6oKV7xpGEkChOC6g+28Sb3/cjSIzBiLCtCw745bW
         X4YA==
X-Forwarded-Encrypted: i=1; AHgh+Rp54tnLI/u8WaO+Lv/8EUpyIfInFLpEsrpcyqG0IoNWgwu0M9/6Iyl7M/8i8ykMwK7/5+UHOdCAFhl2CA==@vger.kernel.org
X-Gm-Message-State: AOJu0YziwjljR80I0rl2fZT2wLqJlwuM+AqObSpMxlZr8RyzFRrVRazN
	Vx5vaWX6qQaZhQ1A7cFf2DW1sGqFZ+/MjousRw0bDzmfetuEQZdwfaC6VMX9Ee/l
X-Gm-Gg: AfdE7cl0jSidqL6YSg6M5uYTZcsdvBCbXCwVCSkjk57sl4zYID27loRBoAdkaEEXqVz
	j/Kytg+do1GJ2C/V9lEaeVIOrK1kJ7X5xvcZqqnPDJNtjFpDQKjKWPgplaD07TJ4wgkuClcd5we
	vN0cecmDaRCarTQQEM94fYZgvc2z0/PQQZu/iKlv5Ut0jQmMTTFtv5+ut36S1YzSa7PdXy2Y9gW
	ic/SaWw+gT3PViX6dEzhNjsUyonfNRI/BJHIxiBkxi1yxl05UBRXxM5cQIRfC2y1tRviUx6W6fo
	0A/eLAtx9vFGE5H6YP5g2277xYrGmODU7AqjDCx8kKara/jDKNrOCrG3Em8Sa8BDNwM/+IY0ckw
	J1xlncv2UPlR5eK0LGd8rX+HvqauTZ08EFEIFozNSU3vRXxZoQO4bYoRMxYqVEIdV8N9aM6aShL
	8zy3bPAggPpP5IZ4KxRX62au4X25mtExM5LyZS1wmLQrx78H0OLdgO5yETV3c=
X-Received: by 2002:a05:690c:6607:b0:7a2:842a:db7e with SMTP id 00721157ae682-81ef2857f78mr33203787b3.35.1784429347849;
        Sat, 18 Jul 2026 19:49:07 -0700 (PDT)
Received: from nixos-office.attlocal.net ([2600:1700:566e:ba00:173e:d781:2a07:621c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42eb72asm36996117b3.47.2026.07.18.19.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 19:49:06 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	deller@gmx.de
Cc: rdunlap@infradead.org,
	duje@dujemihanovic.xyz,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] backlight: ktd2801: fix unmet dependency on GPIOLIB
Date: Sun, 19 Jul 2026 03:49:02 +0100
Message-ID: <20260719024902.151710-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LEDS_EXPRESSWIRE depends on GPIOLIB, so its selector, BACKLIGHT_KTD2801
also needs to ensure GPIOLIB is enabled. Otherwise:

WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
  Depends on [n]: NEW_LEDS [=n] && GPIOLIB [=n]
  Selected by [y]:
  - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]

This unmet dependency was found by kconfirm, a static analysis tool for
Kconfig.

Fixes: d95963e309bc ("backlight: ktd2801: Depend on GPIOLIB")
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/video/backlight/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 7c66b8840d88..dbf4ca23a9b6 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -193,7 +193,7 @@ config BACKLIGHT_KTD253
 
 config BACKLIGHT_KTD2801
 	tristate "Backlight Driver for Kinetic KTD2801"
-	depends on GPIOLIB || COMPILE_TEST
+	depends on GPIOLIB
 	select LEDS_EXPRESSWIRE
 	help
 	  Say Y to enable the backlight driver for the Kinetic KTD2801 1-wire
-- 
2.54.0


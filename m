Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D7C2BB13
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198425; cv=none; b=B96MnWl9OZKwQg9w99wbqlkck3cF5TZo74HuQnVz3PWEtprc/JIFnHEc7fttMuVcXSYWGJKGIrQpNLLLiscLx/ndUmijWp1NhnpF/BA41PYCtcC9wfNVB6c+hFK9TUnYE5G52kzkpZJOx4znEtZJydl8dEXiziY+2mqxqXv1yCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198425; c=relaxed/simple;
	bh=uozvdbMQBMtquqml4NMEEzAMX5hTqQKt2p8A23ayY08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AtmQY5CZCzjTOfClxMnAqYAFb4+Nx7J6bThqCGe4ji6LT0SxX5am31spFCmgo+70u6BDNgz+6vV8qdu6Z0Eptx+uk3d00ai6ulraepcKbjjsX9a4/tBi69rtIN2KW0osdvIDMqmXrrCxmpTMQvtu2VDtyqRwsuLW2pMwB94pYmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KLiSn++6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KLiSn++6"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48378136adcso12061265e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 15:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771198421; x=1771803221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8jWJ2aXKPj6Qh0lM2R1FNp2IKfJGxSgtw7F79r6crc=;
        b=KLiSn++6lirqM3Hf40pFM1QUFYCjCus6sz5t2XeUxuQevqt7ARcvYxV8oqUhTZtio1
         Dz5SPRYShgA7OH8d8QPPXpAtXxYXF5J8mJw2rEKccgLu6kVaAdfnoVRhi8ONS8mibO3i
         Ooa3UT9kEXvFbOM9ZK4GlY7IsDQAWE5a9Zy/Yxf0o+olMDyaF9ECv7IQLuYS5/zc/Jrh
         l9xJN0/VY/7VpLrSCPbATV5W3B/Ixl6TBDj63yeBUNhagaWx1zMpvkdeUXB5rodwval3
         4LFKCIrgRL6badI9trgdkxYzVAN6PowswEdO7BivpmH5KuKFzarmjgMz27rRI/66UfAF
         UCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771198421; x=1771803221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8jWJ2aXKPj6Qh0lM2R1FNp2IKfJGxSgtw7F79r6crc=;
        b=r/F61UZl8w5wilk824cHlB+WmallclvMtUxq+BEkQXt8uKx6QLmlKPPxWt0XClzOm+
         D0qKTH0NtQ2VdopC2pwvE6DLU2M5+oTSO+5sLeUm2JnWLSU4EQmoXLtPWn0vzJIZnoBo
         QB0jbMHphNPVaUx4RR9nyYjAiUD7oE5FIecQi0ONmNWaJtl6U/76ttWFjnjL+Xm7SBf5
         tcubpA+NTxJGokU67HCTtgxVgNY4FZk4GOQaQHosJHNKaBcyfwz179MH2PphCQxYmWi2
         l9km5a2SSAM3NY0/HGVTyHyzm5Wnl5+T07I3rGkmpYLcm/rIwubDXig9yLPJ3I9OGc03
         xSlg==
X-Forwarded-Encrypted: i=1; AJvYcCUQTYW27IzzsdQ/W+pyruKreqHMGeBNdpvF1eZ+ap1ErANYD8NaT66Sa6DfRYYmPMRZKNm2vC3PsWP6gQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJo6NkLkW/kheYB4Jhh4oFhO8PRYHs30qJ9RQzq22QIFpy9KY
	GrbviRlKFyZcCjTrjvw7k8BEbwSYos1qBlJOtL5pIP0n0dirmtW/D2geuasAIeW+lv7551/1llk
	IfstU
X-Gm-Gg: AZuq6aLOpKMNXrtY/jxAzQ6agqvJ9IThjMOXUCto04TFdZ2ImC38w9DQ9HN7pwFfChM
	WKjYUC8HqOCdZ9H3xMgvQs67HMtxuB6+LF80mcttMK8ra0a1sJdmrpT+1fbG141K++WN4dZ5m7C
	DOOrcnZYyIPfTPivsWjONG/qWgCPfK5ocKdsd/JAPqJ4TVmpKQI+faDuwUVmilHRNnAM//QVOLn
	EbGC6Cj2/ATkH7d3H9tsBP9EirJKRP5+j8G+GSylHdquSkUne4Af0v2KDjs5u4qEtb75baEE7Cz
	t1MY85xu468G9eshW1In6FV9uav3to/UW3qd2WohHOIiKQcTzf01vEPv/w6NhuTfCcoMjb84+WL
	RBPZpz0U9zcyTBC4B1OdQ0u6WNAokA6Rfqg3SdT06GI4wvPNSO5SpIUL5EjTPe7wcA1EJWrydWN
	EIkE5hJMPOmHinjBSvzAc4U6nSN7+i7f1OMNnUtZw=
X-Received: by 2002:a05:600c:a09:b0:480:4d38:7abc with SMTP id 5b1f17b1804b1-48379bbc49emr95365535e9.11.1771198421343;
        Sun, 15 Feb 2026 15:33:41 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43796ac9d77sm21225426f8f.33.2026.02.15.15.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 15:33:41 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 0/7] fbdev: au1100fb: support COMPILE_TEST and fix multi-device support and other cleanups
Date: Mon, 16 Feb 2026 00:33:16 +0100
Message-ID: <cover.1771198101.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=uozvdbMQBMtquqml4NMEEzAMX5hTqQKt2p8A23ayY08=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpkle9VAc2+d+3YIVZwdPHcqkP3jZo75jAGyHUv t0sT3O8HYWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZJXvQAKCRCPgPtYfRL+ TuX8CACZ8Ml2lm8CHMdrmEcc1VAnwx0Lcyh6d3Yu4PNDD+r4Yxz28SQr+NkjUMmQYMa1SaxM7zO 4iG/l4JtGIM3vTJnC1gbFmoDSr0IsjpxzzZbzJDzoxAIKo3h8/cwcwpObXqmdCv6yj3lTtFYOwG /8KSxOfPf1qDiInl0whVZHVODrOnapyLJu8w+YlAw/PaEfBYqH19mUUDvquSYYC53iaFWZa77MU 3YLdhi5cUHmvb/cxw1ilZMkTdf8RfZjdmQihSQjn3bEAj7HtaAWzwBwvxnsaKcwpmLJzveIk3C6 EL35pHcdX4MiOtKf1BYZZvpq7kMCgFJyRGVi/XnKryAyr5ay
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

here comes v5. Changes since v4 (see
https://lore.kernel.org/cover.1771163316.git.u.kleine-koenig@baylibre.com)
are only fixes for the few justified checkpatch warnings in the immense
number of false positives. (That is: break a long line that was already
before over 100 chars long, a typo in a commit log and a whitespace
issue that was introduced in patch #1.)

Best regards
Uwe

Uwe Kleine-König (7):
  fbdev: au1100fb: Don't store device specific data in global variables
  fbdev: au1100fb: Mark several local functions as static
  fbdev: au1100fb: Use proper conversion specifiers in printk formats
  fbdev: au1100fb: Make driver compilable on non-mips platforms
  fbdev: au1100fb: Replace custom printk wrappers by pr_*
  fbdev: au1100fb: Fold au1100fb.h into its only user
  fbdev: au1100fb: Replace license boilerplate by SPDX header

 drivers/video/au1100fb.c       |   0
 drivers/video/fbdev/Kconfig    |   3 +-
 drivers/video/fbdev/au1100fb.c | 487 +++++++++++++++++++++++++++------
 drivers/video/fbdev/au1100fb.h | 379 -------------------------
 4 files changed, 406 insertions(+), 463 deletions(-)
 create mode 100644 drivers/video/au1100fb.c
 delete mode 100644 drivers/video/fbdev/au1100fb.h


base-commit: bc57657bd3e64feaac5b4bf3fbd7f8a2fd09f4f8
-- 
2.47.3


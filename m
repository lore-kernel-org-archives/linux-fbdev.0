Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49F248F42
	for <linux-fbdev@vger.kernel.org>; Tue,  1 Jul 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361769; cv=none; b=Xhl7D4eKQcm790+DVYnmKc1BL5BFGoB0JkGbscC2tEBS6sL6nlYeCjDuJTRB1Nu25PlLO3nGbhcsJ0QtGfv38DlFA5jd9D1gUpwr3rOraIMrCB+5+MpDz+r1xpq9sEieaV0kfCkrcWR0bfCEw40XNp2khVvMnK58EKATzovJBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361769; c=relaxed/simple;
	bh=WDPcSd680guMHutePUo2sb9AXNvKsSjrdc95DntYIlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tz00xsPq1VPy55HYrjlVBSG6GfWnGh5GiIYsVt+G28gU1abA1Si2Q2dlio2zeSkugIQxpUegoXyug6WxvUM8wcMWuHMp60duZW2/DltUiNEyYJ0vu2DYXWCj4ZtvuZQuCd1VyVcxjYPRyjWzCumJrGL3o/n1Cnn33cO+WBIrwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N1EzFnS0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N1EzFnS0"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3b37207easo49576366b.2
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Jul 2025 02:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751361766; x=1751966566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVT1yFp/HjeLlfeB/7qCKoB0uF7blBioZl7s6S0+Lag=;
        b=N1EzFnS0LaghW1ukPNvkkSVCou8gUZJZI6q7MwMijiOaklGZWfrSCJaX5jSgNY8WFD
         W4vgrKLeLzyluaIifBwIPRPoaLGGdgNE7Rar3JOtVDtMaczQZdS+bEwjYXqePzvJsGls
         iroII/DNuZzSJp+/t3LU2hkxims+z0bKmG0tYCzP4c82S4UpWYZatYuw0uHrTc7sEI3u
         yKhYXvuiakUNJFHaDMMi10v4fybeO2SFNUTxfq3nMWMmigNfmMXaZj6r0haiNhghh/xu
         G/7PD73YnOni512vauW2wjuL0c/ISWpIdpJoB5q+LtWM08s+Q6QGohsKD0shoHAhzv+Y
         kQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361766; x=1751966566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVT1yFp/HjeLlfeB/7qCKoB0uF7blBioZl7s6S0+Lag=;
        b=tCa45FosS760ZQ9N8YcKm5eWfj93yvjRMvvIHl0wZkzL/GvJLmXTCa/LIevgq/NYD8
         dPQJblFkxOly+1Wn0DNRwCqaDpUfLY7MVnMbGzNbIFiPRhyybIIusN/HQlHxgcDipCMY
         lVxdthx4ZfBDpscQrsuWQLoapfg1A/Yl6I0M1WndI4xRbPMvA+v24Tj6V/f2OdzpSiO/
         KIPHzHBHaHfGuWAjZAP+VYJM16KeTTEVt5pfQkTP1Xb3kQ4N5vYqfWqTlFsWgXb1QmZx
         ahFWwL/6i6zrCJ/jEFIAmcJ5Qb6nVYn1XeV78r51Ry6qN0fOkPRTR/sGgQYmoD+LHiOc
         ebxg==
X-Forwarded-Encrypted: i=1; AJvYcCUCiwXuvD+5DYKBfIZbUG6oYWtUolXr1omzthIPO3k2Ola4l3JeQ2JgI4QkQs70ySi0XT7okpk+6A3zPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbj8sHczh5Sjdn9IIO/eV/Mq5YwN80XTpGYY0ddqERCDhXMnBN
	O7+FcY7d/Ms7+DSgPAURdGn4wmMX0pC7J747NeCnqVY6i6Id/ecl4/ybozlTDLTww+A=
X-Gm-Gg: ASbGncs4DQ3ZTPy+ZlAtMnfOccAz0RR07xujLy/XRAqCgmDoSleQO2+LADFFOOPTc9m
	6bAn9+1imxfM0CjZ2kINxy1a9Vh5ytVYJnS5LLBjH06njJ+AcXTqQP3KywXochyLOqLC3cTC+Mw
	e9SWG6Xkxo2yyJkn6zTYL1hR2eMcETDNupELfBi9asHlf2Truoqwe9dM2rVNupM5Qyy3/7AkYpv
	Fl2HHldAKntTekjNGayI+4HX1qzbRcl4RXYP6r+jEEcYWabcJtCnAmiYB3Ib/MOBnBdGEZNG+4P
	mZeE/EppucGBaH1QYicSH2CgzBOYuGbGNnlF+GCJQbW7bGbRY9kUPCThBqHgjpoDTg2fEkeQJ7W
	v2s+Yicl80T60srQmEqroxxxYFIVK
X-Google-Smtp-Source: AGHT+IFZdq1NZHDIulXPlQuX5XMNUcKGdnIBul8pqvsYdBp1L4Bvr5WiImxevKRjwpv/ZiS3cZkfeg==
X-Received: by 2002:a17:907:3f0b:b0:ae0:ab07:7bba with SMTP id a640c23a62f3a-ae35011ff9amr1638414666b.45.1751361765635;
        Tue, 01 Jul 2025 02:22:45 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae353c0138bsm824291866b.85.2025.07.01.02.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 02:22:45 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Flavio Suligoi <f.suligoi@asem.it>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 0/2] backlight: mp3309c: Drop pwm_apply_args()
Date: Tue,  1 Jul 2025 11:22:35 +0200
Message-ID: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=WDPcSd680guMHutePUo2sb9AXNvKsSjrdc95DntYIlA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoY6jbC5oB8EE9E9gtWZWsipYaB2TH8+5R6T5Kt 9AdMrVoRX6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaGOo2wAKCRCPgPtYfRL+ TrsqB/44H74MvsBOGODdUXEVTHE6B31qnZdJQ6m46uqyRYqAc1xTitz9fVs0tI7m8L/HO4vrsB9 xhCPKF+qTY4FcR+zLCU6xw5xhp3J9Bcv+EPE4Yv34FVz2CgN32mvEW1HbkxHCCLyQDs1/087Po8 9pJ0VkX2TRM27UKnNMo+EhZcmWzkfqaIF8MUaMDg8w9Y6DbyT0oaIiu4FlSgaccJEAAlFH2mn46 clrJgdUXGGti2vmDiOC2u8d/cIftt+RAcFS5WW7zfUqwn55w846+sUf4I9mhrAGCBR9qtkLIP4K ASli44fO0rEJPMvs1HLHq+PuLP3k79oGPwxJrXX8Ft0ZKSzn
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the first patch of this series is what I really care about: There are
hardly any drivers left that use pwm_apply_args(). When all of them are
converted to not use it any more, I intend to drop that function.

The 2nd patch is just a change that I noticed while editing the driver
that is IMHO nice. If you don't agree and only apply the first patch, I
won't argue. It's an alternative approach to what Daniel Thompson did in
commit 7ee6478d5aa9 ("backlight: mp3309c: Fully initialize
backlight_properties during probe").

Best regards
Uwe

Uwe Kleine-König (2):
  backlight: mp3309c: Drop pwm_apply_args()
  backlight: mp3309c: Initialize backlight properties without memset

 drivers/video/backlight/mp3309c.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


base-commit: 1343433ed38923a21425c602e92120a1f1db5f7a
-- 
2.49.0


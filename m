Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A072D0617
	for <linux-fbdev@vger.kernel.org>; Wed,  7 Oct 2026 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367890; cv=none; b=gFhNRptM4FHvgCdq0dwWOj5/j6cgJ2LoyZUrU1s+KgkMmYCc3S97aEZlpXPfcSyHXcBzAB0HudxdN9VBVur2JdsTmymIQ74Ied+qqAS+/Npm3sZEuIGt8a3bEjwbuhOT5q477SPeYRUynwnz9YgYJAK+3CT9Z8RMFRG6i3lwdZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367890; c=relaxed/simple;
	bh=4tpoZwvY+uwwBry29ZcBQE0jX740QQCVLmeeTWleFIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZcoYDQ8/362fdQCJEKGvYDOSv96CSieWaW3nA4l2dDYNJg0CE2AoGozLhOQKKpTqC+jv20PWj/Bfy/khtIc4c8E9XuRNGz4hmCBq1YuqS8m0VpbT3MY63CyFfANi0vX6iRDPv8TcBy7zK8wSbvCWCR6BEJ5aD5zpudRN9W1v2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0MpQMsD; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0MpQMsD"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-141395927feso2393148c88.0
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Oct 2026 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791367879; x=1791972679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Y/2HgrGdfa3RjhvPeUuDU/lbciiQ3poM/eU576l20g=;
        b=q0MpQMsDw/AEOginptPIe9Cwyt3SSgud6X8cA7k0GvoLz5qtKAKX/q/7DLj2EDeM7+
         Mhv/cXhvWZ20zAsesLvLDf+QZdVcgegUFULdfhwKnpFzSvwtEqddMnEZRQIbb7rW6tH/
         mj5Zmja3RUEDiqeiBrAU4mhyxuex04Xj8d7aPNmFyx+YXFd5vp+9UjZEUCae4orDp3pG
         Ta51rnkhp33ulbDpBSjgG+RhbUlZA8Q1lL81dDWTExMThU1Kx8ihx+AxfblWwgXmFHyu
         RnHzbV1wIbMkH7etBBULVjBe2X+tkw0Ams/hTA22PYCtcojS41u2zATHlFGJwtxjjbLZ
         KLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791367879; x=1791972679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Y/2HgrGdfa3RjhvPeUuDU/lbciiQ3poM/eU576l20g=;
        b=IRW0qPxMEElo58czT3ikrMoPvc7HqIodMBu0ttRwxoXNS1ixumLMcfvz8i6hipJvD/
         yukJIhssSsscawOaKJ2W/Q3mFqg+ebOuqcjlMMn9mApeg0kXxIEGNHDMj5glaEIX9FFm
         mAYUvVSj5SfUdywlWlANrMnh/cJ1TZXM+CUMqCSd+s1Ml6wp+LtcZcy5W7u8KoVwwoES
         NiNW/6G2S+HblZYHn+iyCjZEeiPW8xd8xY7w2MuGs+V9CQgDk73c0nHolTbRH0cgi6OH
         qHfpTpn2Z2bqj8QFBOcBK3Jb2/J1i8N3PRJVsM7+YJXxjXzc4zZ8Uf5W9aOGcteDZ7UE
         r1Vg==
X-Forwarded-Encrypted: i=1; AKwUvBwGZVNIBxC7C+MJOjLapzJ/3L5wd5zp9uVbXe5EkOjDaNfhjlxU6/CmoAb1eh1f6tEw7c9U0MH+/Xt7Tw==@vger.kernel.org
X-Gm-Message-State: AFuF++l35VVvXKRU88QuqGXg8GUkqNqUCExsywmvK9oVWN0srDODAEIu
	f+3bapA4iro6c+6K7/nAuEVSuU9gZ9Wgj3Sa2iI660tyCJatP6gNqzeu
X-Gm-Gg: AYBFou3XCw5kixGSErLsy/NsM8N4f3+AOYBZHZcqoIlATeDfNY7oN2md1KZcViP4eKh
	/s8TeEqzTbFKD062qUuWqUj9QW8omj8AssmdswwfZ6aFLqU9N44KXjevjIj26B1hacCdSa2ew2L
	CJ2aTup9scJiggGkSzPcqPexH9pnsPAkT8axBhPINeS0duYD9QgxfWwLHPyCtauDlL/tdM9OeB7
	JGWXCcqdbkPuHFBe7TqSovONsJL675EPZGEDTTmWWMd6G+QaStZ2we8krx3m9v9yH3VchGODVvH
	IwhxNDzhLHfo3azdjTPTRUiShLlF7Sx6G9hK3mchojvnu+BEbdj+e482e/L91c3zCo0hjmVZQ9Q
	7aFKRFmqye6WsLRGfyY32S5T9MoGbbHFRDxXOjFqFsXjcyTvgOIlFIBrZDiNK42w97BaMShterc
	8atJC+SCKmgRFPYJMrEnHFjDrniQkYKpnYHmRDxBUDgK4Tprl2UQ9YvHbhGCzaAQ==
X-Received: by 2002:a05:701b:2804:b0:144:f096:4dda with SMTP id a92af1059eb24-16208711b35mr1709824c88.43.1791367878644;
        Wed, 07 Oct 2026 03:11:18 -0700 (PDT)
Received: from gmail.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16352800ed6sm2606714c88.9.2026.10.07.03.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 03:11:18 -0700 (PDT)
From: pdsj2807@gmail.com
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Palak Raval <pdsj2807@gmail.com>
Subject: [PATCH] staging: sm750fb: make g_fbmode array const
Date: Wed,  7 Oct 2026 15:40:59 +0530
Message-ID: <20261007101109.707077-1-pdsj2807@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Palak Raval <pdsj2807@gmail.com>

Make the g_fbmode array of pointers const since its entries are not
modified.

Signed-off-by: Palak Raval <pdsj2807@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8b93bfeb217b..a24b21f4936a 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -12,7 +12,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel __ro_after_init;
 static int g_nomtrr __ro_after_init;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char *const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview __ro_after_init;
-- 
2.43.0


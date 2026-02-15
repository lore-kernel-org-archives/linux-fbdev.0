Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045861E47C5
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771163938; cv=none; b=T72G34mZpCvPH9g3Fs06CMSNtBUostFIKFRHvLLR3P5CE+FCNtgDRKBS/GHeORYEyQddYdDcfKa2JiihafZiO/Ew0/ije1lj0It4tHLg8W0FfYdOg8VvJz808TL3vrhiHdt424S1cdVccxZmEoJFVbn3SQb6y5aMlr0hETIKj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771163938; c=relaxed/simple;
	bh=9uUi7nXMjeT93n+Xkdzqc2t9wJ4cGV5DzI4vsf5mkaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gJBtUM738KuB7tmQoce6UwoXwLcoCjPkRfla+hHvIt15QToOa+RlLDbEKberE9nc/pb7TnuuBI4rzymlbCSXx2cBx4SzXcyjeDa+aWoFeKRd+0Aw0vljaTqLLxOglAsHKSGKxccq0vVFx2X38mRkZz7g7io08/M0V9mwHptxESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=A3XMBy0d; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A3XMBy0d"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-482f2599980so26027965e9.0
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 05:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771163934; x=1771768734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMS55t/V9fY9Xp7NFJdKphTgR5hjSDfiqXHxnjBq6kw=;
        b=A3XMBy0dPQeh+wwFMUjE5tX3rZYTT5nf504L1NS7x5g/A/9eUD41kbBiVngLyF2jGe
         cHGsdStrj6Kr3ldhcCjzzt4rBt/Og6oRq+fUWHUveS3Zcp46AlTlMOibiMnjdARRJTke
         ZCtBRmyGoIWZkjr5A9tygtogdA+DtbYa1CENA+VJ337skRbFCHq5L4rCWq5M1buxl/GR
         hKrqk/47jhIcBgCjd8SPTEmbiOJWRAAdLESRt/r4qh87eK4Bt8HHwGoetTVjfUqymly3
         bOmi2R+/9u3U4dUWZ0n6BANz41TlsGbU24ou4vQAqvq2Pw7SBdheAeL7/kPdKTpgIdsw
         1lFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771163934; x=1771768734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMS55t/V9fY9Xp7NFJdKphTgR5hjSDfiqXHxnjBq6kw=;
        b=Foa9QYywVUMtQGv5rE4rDczK8gEzZvE5xNt7JIKhRkGootCswakEi5xie/CU49jlqI
         +oM9uVWF1X2XDD8CYnpz4ShpHAP3PhNz5uRE6JFe7L98REtpcD+V8RttQMT/eqwUPD8V
         SooHvsg2Nj0Lnw+MqCaCtwjG7A4iN7u2nQ+sgcuwr7AP9vOtpR9oNJrjL/DnzZFq9iwn
         u83Ep5iTfbCYmSS+RZ3hDaAWClybZZRGHwnUASrOUH1hQKH8xjaIdAtu0/G2OTltcAEo
         Ywhn4rzc9bYbUv5iUuBYQT2YIl/T5IL+rjAxD+6zz+l608l1c36VZqYE/I2QvIEVQIzI
         0uVA==
X-Forwarded-Encrypted: i=1; AJvYcCW5Dd+vGUVkGvmujHWYRHwBVzXPiKLb+2H64H2cMbfg5frN1ApIsBFT1pYKG4suCmnK+DjJfM6egbsrBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnFtrSIEpH7HJ/M1RDMp4CHnsz4Ul+kIqxbeWCinbcQPQW5Hdq
	f/+VUp7fPWItyYMVPXD9yc2jglXOsjXPuRoBiwqvn3JViVFoZhok9p2qokLzGUkH1YMReC243iS
	7pa1o
X-Gm-Gg: AZuq6aJLB5clfMp9jQRxBq28qmFbXkFL1t/gbPKUgOs1zCqOYTxfppGka6oZOtSJ0EV
	7q5It4QfV4w2qb1wawaIoF0JGKWTiczZGhrWzHmnJhsDDt9vJMAskvEfDHMZR0frSsJgOLpvORf
	9Ycl+40R4Ep7A3FzBfQm2gUhVHNCgqlUI17fupm9irS3yLhOvKoW8PphLBnlOrkGrLEpLAkCXrP
	8J1PV0b4UAHz+inXTSDsfoJiE40oHgq1t+YvqnJor4/rYmViASmpfK+nSy1t1DAgSYpdIpVNQ/W
	NQX3DfLLSzOzZQYhtvaSO75RNojVw4XW90Vt8VKbcj8gxRH9tB2drQ2Dsd/h8IR/EGWX8dJMKvz
	HH+hbR8CCBrcflgkSJq5Ng0EUMOahWWNXvwZFlBTwbcUHSI5mlxQfxD2Yy8VY8NOU97r2bT9+ha
	Y+ogQdCXR/Tk8+IAPIaAe2CGaM5PSv
X-Received: by 2002:a05:600c:1549:b0:477:7a53:f493 with SMTP id 5b1f17b1804b1-48373a5d7b6mr125230325e9.23.1771163933666;
        Sun, 15 Feb 2026 05:58:53 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48370ac3564sm168021765e9.5.2026.02.15.05.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 05:58:53 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v4 0/7] fbdev: au1100fb: support COMPILE_TEST and fix multi-device support and other cleanups
Date: Sun, 15 Feb 2026 14:58:27 +0100
Message-ID: <cover.1771163316.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1534; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=9uUi7nXMjeT93n+Xkdzqc2t9wJ4cGV5DzI4vsf5mkaU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpkdEEhCtlw8Y2ymPubtY2wyZRtmxMjDjgwb0JC WlUnh0EVXmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZHRBAAKCRCPgPtYfRL+ TssmB/4pcWObZqz7acQq4uBFVjrCI780gmeX3/zYHbtWsYTaZvKGTe8cMy/QmLq6w5YjtBV+NaK t6EXxx1MWKY3ZpDKRXVnIXLyo5trDGV91Vn8P7CdzcgwghEqVb2Xvpi60ySzU8TtZaQ10EzYGBa PplMGWB11qVBGXmgVi1rrx/OUCCWLGVnWkTt9687Q1jYe4O0xYlLj0T7Os27N3lX7VScwGHiVWM 16XJe5d++qJ1R8dnXl4m/LYB5FGdhAOj7r7MOv6qwf3cy81C7VxeClKT340FyxeTVHXqgi9El5f 2HTmicTpbzLQerM3rlLGW8axJ1c71eUNidSyYWtZYjvzaUSR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

here comes v4 fixing and cleaning up the au1100fb driver (which given
that it currently doesn't compile probably isn't used at all :-\).

v3 is available at
https://lore.kernel.org/all/cover.1770572936.git.u.kleine-koenig@baylibre.com.
Changes since then:

 - rebase to bc57657bd3e64feaac5b4bf3fbd7f8a2fd09f4f8 from an earlier
   version of that patch in next

 - Squash the two printk format patches into a single patch

 - Continue to depend on FB=y (v3 made the driver only depend on FB
   resulting in an FTBFS)

 - Fix a typo patch #5

 - Patches #6 and #7 are new.

Have fun!
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
 drivers/video/fbdev/au1100fb.c | 486 +++++++++++++++++++++++++++------
 drivers/video/fbdev/au1100fb.h | 379 -------------------------
 4 files changed, 405 insertions(+), 463 deletions(-)
 create mode 100644 drivers/video/au1100fb.c
 delete mode 100644 drivers/video/fbdev/au1100fb.h


base-commit: bc57657bd3e64feaac5b4bf3fbd7f8a2fd09f4f8
-- 
2.47.3


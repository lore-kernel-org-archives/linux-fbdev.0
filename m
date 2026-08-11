Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028928686
	for <linux-fbdev@vger.kernel.org>; Tue, 11 Aug 2026 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453700; cv=none; b=rItTCcw3rAH+tXbdwSRO16644p86kd+uwUsUe1Yj/zgFEHMIqvTxwmQJ2A2l0VyRC1lpnuO0ghx6cN4Ol+ZULdMpZv2/y4qJ+N4A5mFPg1sh515DavQrtofoW7cWJS2LS5a+rU+1KJUtR3ZzoBQWGaeCrZ0B43L1EvktXioAyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453700; c=relaxed/simple;
	bh=a9KO7Tse9tk2O/Wp+mdffCUvJ0UirYVIu1DkVWGwiJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WuglrE1fjTtWJLy0wkfknhi9Q8YJEHPui7JXNUVGd6iNTalZq1HhBbgjW1d6J3Weq9fJxYFAR/pWQH7YtjUn1Z0cmbsscTmoWNRYldv9pXKCZXoFJC4EV6Ru+srfghjDxoR7ITyxDxLi9ARWGmxyx5XEaK1BZA6hk/lLQZzumJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec5yNyTv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec5yNyTv"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so3213746e87.0
        for <linux-fbdev@vger.kernel.org>; Tue, 11 Aug 2026 06:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786453697; x=1787058497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kYnmqd9o2ccxCSK1AbFiMyB7/O/f7wvcG/IcJOVpKHQ=;
        b=Ec5yNyTvDRIdiFTF9R2vwUahHAC3z7jRWJCrZ99pR18PGOZ/7D4HgozmowoR80nAt0
         VGakfL14fJUajo5BgOt2kmggmw+0VTbzfXgWoh0adnudPx7LZkT/j5AuleMfPVHWrlIv
         /zK8Nf0lZYiX5flH7ueyvkAGIGj2e+M8EjRm1FEXpuyfyNkUY6i28bIvsk1/108v/gX9
         f6Raz/eqAWyKu7TrBVxCOwThxGWUxoAGIS/W5rgoxWWv601Rcf4bgMoKt+BQQjbTE+5V
         krioffS3XvMUni7luGkjqQZE9alfqvxyhZrn9mSNX1Y1zzJa7a6BNXaubQabtAfCGCJv
         DDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786453697; x=1787058497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kYnmqd9o2ccxCSK1AbFiMyB7/O/f7wvcG/IcJOVpKHQ=;
        b=syNNSvNPB91eMLCdGSswEUTCLPd6arduPGrkfWPXgEVoPa2aPOUO5wVIOyTWVf4p7t
         0F1m+zptV+z8dw/EnQAVy23fu27m3sZcablewMZN0Nq7IZeujR6EAzRYmQKc+CKXBlDF
         gQ9cBRqZNmSNPGdMGMxw6tl9tcfDZHKY66niA73g5RMl7f7mpvqBeTTS4w7kJQQTVAg3
         e+tQuSxn9klNRAkjPO1JocxClwxdKrI9VELwEYxwelB74lvSoT5IhWzBBerF0wtrmSvN
         jjYSpG/zm5Vd3lXuRLAwMxhZZgRl3f/DVgWaRbEWL6YqDr2arv234mVgqu9fxn8TkDQ+
         nh7Q==
X-Gm-Message-State: AOJu0YyWwy43GnfSYDQZkP49BRZibc8TlTLhrhPr7Vg8sO90tPiw41Nx
	L71SPrIPdALoPyuGN9zRfI+V1qomcMBMQ8Y5OK981Z3sEwS3ulu/s344
X-Gm-Gg: AR+sD10z2BFPHc/JNVkwc/676A5DhWbSQ0vDJf22FmsfLmbmYRiNDp9Kjoen8VSuDzp
	dkhz8SLHi+43e9U1Vw9ioENvHYikkeqyY6Tn5M0lifVuhWkcOyUwb1cCtEzSvf1N1B/YelzgdoS
	5Gq89PynU1m80GqgY9c0xlZ3l5xtEz6oIHBXFWnGNrnidBi2jYgfUpKAIN8kOHleewiqMKKKYfs
	iqAC7FY/6AltWW7FlkBtGFjm8IkZbT34duSbSypP7S91sQyYOf8trilWUuc1wmO6DDGf4g4FUk/
	ZpkZr6gqeX0/grerAxP8l/SAnm7yVz0rJf9stQNU/8na+w7wpgK8dFOoWVPyCW0RvE2UZ/mWNkL
	0MlGA4BUy+X7oY30Y9yaqlqUykzuBUo0V/hjMUOqDtSGmvtfy7JOe2+Aan3mGY7/IT5WYy2xU7a
	2/48fADEUUrNrE4de8RTo8xrexJ85ZWp25ZgJHLGbZSLtsOoYtfj6v+/pO6Bhi4ovCiKqF
X-Received: by 2002:a05:6512:1110:b0:5b3:f8e:396b with SMTP id 2adb3069b0e04-5b448658754mr424250e87.55.1786453696586;
        Tue, 11 Aug 2026 06:08:16 -0700 (PDT)
Received: from gentoo.home ([2001:2042:2a39:500:8a2b:6241:6d4c:773f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b448724b46sm273541e87.38.2026.08.11.06.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:08:15 -0700 (PDT)
From: Maxim Codita <maxkoditsa7c@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Maxim Codita <maxkoditsa7c@gmail.com>
Subject: [PATCH] staging: sm750fb/sm750.c: mark g_def_fbmode as const pointer
Date: Tue, 11 Aug 2026 15:08:13 +0200
Message-ID: <20260811130813.434660-1-maxkoditsa7c@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a checkpatch.pl warning for g_def_fbmode by marking the pointer
as const. Ensures it is stored as read-only.

Note: g_fbmode[] is left as non-const as its elements are modified at
runtime by lynxfb_set_fbinfo() and sm750fb_setup().

Signed-off-by: Maxim Codita <maxkoditsa7c@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c..cc38dac88a73 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -22,7 +22,7 @@ static int g_hwcursor = 1;
 static int g_noaccel __ro_after_init;
 static int g_nomtrr __ro_after_init;
 static const char *g_fbmode[] = {NULL, NULL};
-static const char *g_def_fbmode = "1024x768-32@60";
+static const char  * const g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview __ro_after_init;
 static char *g_option;
-- 
2.53.0


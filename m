Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8482BE053
	for <linux-fbdev@vger.kernel.org>; Wed,  2 Sep 2026 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788324661; cv=none; b=hN4sUKCGP9L17CbIe/SiYggFBRnnqgiSr2K+muXJkQeeI0xMwDXvNoonPoiTb9CAsT7mvwcPxSd00T3SuZo0w2d1SJ34WUfqjuwAjyznARgjj3frDHAs9LNnafkZxDq4FArzvQZbj5jai+Ne+MQjGvWHZpIF3XwSUlpcCTnssxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788324661; c=relaxed/simple;
	bh=LMSRCIUMLvwhOCCbBHYxtVhNFgFxXi8Mvt8mgmFphTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=osXExS+2SBvtB0EW3hKrgoWnbGjEAWyyiAGVBQapvOqCsr8Dev8mLbxhcVAdGeAiOnHG/66cDw22gAxcYSJ8JaqWRA/B87lwFu67A+Brbii6vDeuI0CA8b0PDu4YIxkL5PuInj9ppSXkkWO2oRrNrs4ad+kkci3FAus3Yj0I/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbAaE4u0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbAaE4u0"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8487214ad2bso914414b3a.1
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Sep 2026 21:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788324659; x=1788929459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gL9gEW7ayUvR98UbsWW5JS05cT2CnhJ1qoyjKu7J0AI=;
        b=NbAaE4u0Ygzx2Hj8dVT9co3N4s8wYCQ0qLldY4XYlQ9WQfZBAtfF5+SpT5iXDhmp/H
         8HoBXlV/K1gHu3bXnR855H6dIR9jJukk0gR/aoedvonIcK6mIy1xRRr+HZ+nexcLH+U8
         NSSnIhsGmwrc1Uk9rMyCTgIlA75LzIHDzZZZkPX36lhhlvRe6SYYuflb4WNRJxPTfgKI
         f41wvFFcBBnuzya7kEzss6UJoYIys1uXzX+ZPKJwngSIjbo1Uelsl/xYMFnImBn6fZqV
         QFcGsyNUynZ2Me/zT+iFcDYy7TZ1a6lP0GVKdcQ7ZCZMmCysnU/xkqLPuPeOUxhEq4hk
         /ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788324659; x=1788929459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gL9gEW7ayUvR98UbsWW5JS05cT2CnhJ1qoyjKu7J0AI=;
        b=oljewSt6Gs1tRVin+wsBbHVpefPrBdN5Ypofs39gO/vwyudDfxdB73wAnnaak49gF5
         RMtKUCZuRpI+pr8t8Ck/R0RJPbXpkyXp+GYdENXivM+GyP/xkyvB4Fp7nBixjnRoFCaE
         XGQYhoICbXTArWVnjeFgNwmZJn936V1m/zZAhIAPgNJ5TOR5p8t7TKMhOVbEdqS2sOrx
         gKFwfn8b0qXOcGjiFqOs+GCFcWq2s2kfhe7DbYpdHct3Kc4qu45YhNSYj2LOXMlBdsEJ
         x0lQbjOsda17niPhBeA2719psAJhBChlHH2h5j57i16EadlU+0XsP0ObtSQ0/pTCKf4M
         ZcWg==
X-Forwarded-Encrypted: i=1; AKwUvBwbf4xANCV3IK4DteovgMepGhv6oYpWgZGFD7tKz+1uQk7uktpiDa4HzngEtYpZL+u1ADu0aJQYHMEAoA==@vger.kernel.org
X-Gm-Message-State: AFuF++luXy3puTpjKgBVB4vOmlFONFGyTyqsXARu06Jnecpp9x4RMx1h
	+kf9X7Kri/Ul57uS8Fcd+6Y3L13plli+bB8PBWCTUsLU6HWf+XIYcp+E
X-Gm-Gg: AYBFou0liRtUXinSWZ97otSxNBjD4F4ybG/z7FeQOeRI10U/dWUiY8JAxtHR5CmiKFu
	PwGWVjVAjv7vWf3ZrRt+Swp/GeOKv8wjynhE9x+17f3YyTdfB1Sv3kzwpk/2ZW1qa0lP72Zp2Bb
	zXryHzcS6woAvvWv82zRnRDWFOT4TGDBpz707zBtwAuNfUzIOZJZjCNyFai+ZYohsYhAhU8ABbh
	umDqHRTVkKBYYo1OekwN9tbnX9mvMyItJzrDrCJjwFs959u6AbrVQsXTHSZjUCBNqOQDqUxrFU3
	6ja0zJGOJB/lb9Q5cBJpPSxKmVcuZKwiHz71Qdo9HeP/ARHzX+kDEGFfR0Azog5QUbc6TGBEWSL
	ZVnxfuZdg96+MarNdJfFKMPZDWA5/7AYz4WvFOwachSetgCGlfJqlVMYJV6W0JJwJVXOrALBt/U
	SUjWPj8aOfXYDeReP88M0RnFjaKlu11SSVgtZknHK9iXIf7akHL9RKvpsCJn1BoHTMSF6Uz3+9t
	1ITuc4J
X-Received: by 2002:a05:6a00:148e:b0:847:893f:2d0c with SMTP id d2e1a72fcca58-85ed1d0414dmr4031929b3a.5.1788324659284;
        Tue, 01 Sep 2026 21:50:59 -0700 (PDT)
Received: from Kalpna.localdomain ([106.194.26.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc11f44a8sm709997b3a.56.2026.09.01.21.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 21:50:58 -0700 (PDT)
From: Anshika Jain <anshikajain196872@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	sashiko-bot@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Anshika Jain <anshikajain196872@gmail.com>
Subject: [PATCH] staging: fbtft: fix len<=0 buffer overflow in define_fbtft_write_reg()
Date: Wed,  2 Sep 2026 10:20:26 +0530
Message-Id: <20260902045026.7442-1-anshikajain196872@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If len is 0 or negative when a define_fbtft_write_reg()-generated
function is called, len-- underflows to -1, causing the subsequent
while (i--) loop to run approximately 2^31 times and write far past
the end of buf.

This is a latent bug: nothing in the current code prevents two
adjacent negative values in an init_sequence from producing len=0,
and there is no guarantee future or out-of-tree panel definitions
won't do so.

Add an early return for len <= 0, matching the existing guard already
present in the sibling function fbtft_write_reg8_bus9().

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260830161529.14500-1-anshikajain196872@gmail.com?part=1

Signed-off-by: Anshika Jain <anshikajain196872@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index e03aa251c..7d7135571 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -20,6 +20,9 @@ void func(struct fbtft_par *par, int len, ...)                                \
 	int offset = 0;                                                       \
 	buffer_type *buf = (buffer_type *)par->buf;                           \
 									      \
+	if (len <= 0)                                                         \
+		return;                                                       \
+									      \
 	if (unlikely(par->debug & DEBUG_WRITE_REGISTER)) {                    \
 		va_start(args, len);                                          \
 		for (i = 0; i < len; i++) {                                   \
-- 
2.34.1


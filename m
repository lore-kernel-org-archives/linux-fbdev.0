Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266070;
	b=5UlRoIvVg1UNLp7SySeMR+M4wqBsDugE84dhe03fI1hQ5rgfaprh6IUW04ClSMuYZq75
	 lnpwhkMlTuMxMJi1dCU3qKGiKE+gQVQWwq/dHiAgm/uZL7p1r9ESf9UFoICjtVAkw0Mha
	 8TF2piZyAJfpMU/+QDZLMsXnTiOTkpqBcXnLIezZwZxpkQBUe8ryp1iTMWuXqYvnNPiAJ
	 gN3uBr+FW14t60DvVitSewKnE1JHDfnKyApU8oss3vcWWQGG7ZZH7dZu3MVsed5KZWWsq
	 jW0ibMQ3fsoRkjhtTFA8YthPpC2JVXM1BfOgQa7eym/1QvFJ7Ms+qUu8PQltYs1vUcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ttzRCCZmtIduqcI0NA53dxcz7nQK0XuXfcj2kfCcu58=;
	b=5SpZnsa8aOUaZtG8v3OO2C2BH7epK7K7yvTELG/FDCDj3QiASQvDsDlXCIl9hdvoyE/S
	 DOHW2nxuvuuLBe6Paq/wIjgG8d/1I2GhV/g4ozUGi9ACdfrQVKIFVF0A7TKhp22MTAt0T
	 79z/8EaKIqlsEk4E1JNHWVoOE7ZbxRVNgDM3lwViGXsXyahPpaelKMJ1Rcy+gvg3zosGk
	 iu3AnD+XUrLbCqT0CEiraFgc12oNpy7r28oiM7YYwr+jq8jqXqwCJJupEbZF+xAFQMshI
	 i4Gx6jAaqdJdVFGi/bZ2nxBd4OOwrD33bTZSnOK8xjJps+crF3VwZ4OYF00ue9waIoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aP5Js25w;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D262606A321
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Nov 2026 23:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D262606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aP5Js25w
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b429f71dbeso1555947a12.1
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Nov 2026 15:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794266069; x=1794870869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ttzRCCZmtIduqcI0NA53dxcz7nQK0XuXfcj2kfCcu58=;
        b=aP5Js25wSRQzgwagC3EEb5dMAyIC0OwMCUoUJuDNkCIUG40YoqoPPRJgJkK3Y8e7Yb
         eOtWoaVhvWDnUhlZUzIn9ru+h53ztm9Wd+lMNdyJADBOjku3XQTfjgYxZ4G2o8vjukbK
         pXEzoLgQjlli3x8CVINd89lZ/6ZAJK9juLFfuba1a8SMUVaI95DiYWFNH9qMkOIm9OgK
         AEF/CRTcsHfBlQSV6CG+Pzp6bPnrtQIIrsVWQpOmunOl3ThilkHKn3rOncUr0slg660x
         v36a6RNC8/tNGvTw/i3ihYl9SbCbSkjszcstdO5LvEFCqKNXJpHtHhy/6OsP11bDm4lb
         7ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794266069; x=1794870869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ttzRCCZmtIduqcI0NA53dxcz7nQK0XuXfcj2kfCcu58=;
        b=oAD8Au9HWHT/2dONW6vbg332xYxDh7a+eXjIkspStXcbFN1z2gLcZq9mU0+tFFvmy8
         12XhBiwKASxsvOS2SHbvbA2oSVnD73l9gZv/OhPCmwmIb5E2bZ6I2Inw6t4MfUrR+KxO
         tRc0IwXPSE5YAVVnBdC9GmSAlYrCYg0+mxKlYM/xLwcAeLUh7T65PhJf1tvqkFbedGCn
         UHo19kj3kPoxrW5wDX4+5X0IdVAjWxIWm4srRZfYEu6LjzIUhw5v8g2okiHfBQi7BUCX
         is+EUNF3eEF5G0p9sfWsWdIsMdAlS2joGUW21muLlBuBKoFMZVdRCut8wG3zQqeVWQFT
         lWTw==
X-Gm-Message-State: APuU4Z+Mk36NobhQ4OW6yUQ+sMNBSm90hQuyW08SkHv/xodZrkoV1ijP
	Gzw9MQYJpVf6ntsnY3IEjW3gdlbJTin0E5oKATLr91XdJNpeFYVcTcFG
X-Gm-Gg: AYBFou2qcaaTIS+kW++qB8Dqef9hIe76hCePcTNUG/Wu0aXpNLYxqxRj1HCXHFTGnWO
	6KwzTHfle+CMy+ZrHpWno9ydU82q4QtTG0dMwpHXD2mZm5JrPHs0glMsrm8hj82w7fgEiX2Fzif
	dAE85AfNCr0lb2Gv6vqLQUbUJgyU73FsOoOR0ZotM79Jo3QVcV4T7QU/Q2jo1lyI39yK7gMOcUL
	t+ASPNfoFxPo0QdSGwxooLQrlscGgt5bedoxsjwoS+x0iu5rbLPhjeJs162rQvxzclWcMICe7rF
	PtwK7pN4RIiBmKE2Nux8AUJy05RvhKEeKPtE8UvBKoyEWSq7UZP+Qhus0aOc/ti5v0lmyAau80i
	aWSKqFrLwTLIO0CgrOxMfoGJ/4jtYikn67JEq3J/Ud08lYwdqFkk8WU/mUWSZSA8/4IuxsABKEt
	GcVNxVmEAZtmylgHeYylDdD21qVP2E6gcCCn0pkwLzEo+jZR+/RaOqUsIo8YmRmBJ061xhxZxhp
	6naSyTpEBW0WvieHsqkJRPzT9iTB4pkHRlCWtAVsLtv/0F1Wc/qfiHepviSA+8GDaxBbohI8TIB
	JWtvyMVDmcn3t/2yWPKMSLQO+rwy3A1n1Bb95uFiwu4eCQaWWbL/e95JRqPY7g9qB7Sbt+7gOWd
	05du67XK96zo0TSOKxY20Nd68DWdDJSnsQ0k=
X-Received: by 2002:a05:6402:a6c6:10b0:6b5:6a24:6cf9 with SMTP id 4fb4d7f45d1cf-6b756ae3a73mr532912a12.45.1794266068494;
        Mon, 09 Nov 2026 15:14:28 -0800 (PST)
Received: from fedora.tailb87685.ts.net (ip-194.15.124.140.laito.net.pl. [194.15.124.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b75790caffsm273785a12.32.2026.11.09.15.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:14:27 -0800 (PST)
From: Platon Miller <platon.ksenzenkokk@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Platon Miller <platon.ksenzenkokk@gmail.com>
Subject: [PATCH] staging: sm750fb: remove unused macros in sm750_cursor.c
Date: Tue, 10 Nov 2026 00:14:14 +0100
Message-ID: <20261109231414.25021-1-platon.ksenzenkokk@gmail.com>
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

The macros HWC_ADDRESS_EXT, HWC_ADDRESS_CS, HWC_LOCATION_TOP, and
HWC_LOCATION_LEFT are defined in sm750_cursor.c but are never used
anywhere in the driver. Remove them to clean up unused code as
specified in drivers/staging/sm750fb/TODO.

Signed-off-by: Platon Miller <platon.ksenzenkokk@gmail.com>
---
 drivers/staging/sm750fb/sm750_cursor.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index f822d147e..571cf86fd 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -10,15 +10,11 @@ writel((data), cursor->mmio + (addr))
 /* cursor control for voyager and 718/750*/
 #define HWC_ADDRESS                         0x0
 #define HWC_ADDRESS_ENABLE                  BIT(31)
-#define HWC_ADDRESS_EXT                     BIT(27)
-#define HWC_ADDRESS_CS                      BIT(26)
 #define HWC_ADDRESS_ADDRESS_MASK            0x3ffffff
 
 #define HWC_LOCATION                        0x4
-#define HWC_LOCATION_TOP                    BIT(27)
 #define HWC_LOCATION_Y_SHIFT                16
 #define HWC_LOCATION_Y_MASK                 (0x7ff << 16)
-#define HWC_LOCATION_LEFT                   BIT(11)
 #define HWC_LOCATION_X_MASK                 0x7ff
 
 #define HWC_COLOR_12                        0x8
-- 
2.56.0


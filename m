Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791638;
	b=5tjRYeb9P/5igh3uagU9R9QnADza0Fzgti05GQZS8zVVbsk5+PCRGsZHkW3NRleNSzyx
	 DsMgF6SrCHaxdrxYwvghfw6qGy4c4n/2IjLoRs0mQ/vL3eFRGGXjNrPXMwzDoODRKGBXR
	 fh2oauzGfx8DQz7zcBNxi1K+wY9PLp3+/L/omLwEwFBYi+R5a4n2yTnXOYCImBt5SKmKA
	 KATi16dEXM7Zu2bbWXOBA5+QnfTX4EU1+xFD81TZ6IelNxV3+ynrEtKjDB5DIDdKkHwE4
	 4WwucEXCY0EDFlTPi2hIeBzh8LUDlmA+0cj/O6o2b0CTa7iq7nQQWZBCi/xHJ/KPMgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4q1WGi9vPIf9vHoF8r8SkjERKMefi2tjXdzTAcwJSz0=;
	b=GdgVG/pg8zX0a6dosGTEmeTynFp5SSYEhQH3xkTZc4TQ+wYmjmpBQk2PXVjT4SpbtSGL
	 NDSRqM29eRgRGFGuk82L5FRYvdsMrb1Ytw/Gtjc22ww7jZmK9EKt/mq7KLhCSSatpJSTT
	 f98AUK4K4+/SWcjRa2VRXIgBT6lwB122jAuE/fn8+42YYhAKWwcwUtoGzXpAKDUAVCMUX
	 ALl4uckN71lBlIXlojxh632Lh/vGQoLmGzr/kqjQcqEhi5CYCr/jodFfFIicrwU7kfgqC
	 CELcugesalwQ6b0nSTYd8cXzbEGi/9OandY6MFKBZqFM3uWBHBWD8DISmAxUXrz/f1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fXDU/XhV";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87542606D805
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Nov 2026 11:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87542606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fXDU/XhV
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36a18fc7a38so1246009eec.1
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Nov 2026 03:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793791638; x=1794396438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4q1WGi9vPIf9vHoF8r8SkjERKMefi2tjXdzTAcwJSz0=;
        b=fXDU/XhVj47pukSIzfP3AeWhUd+/e2R266iAZttUesRoZqDYjqb0FjghuZ8i9ivii8
         T2IuCbLsJWIjZM2tDiC+330Ej3k08+Q8e5hDJHAcRWsCDDJaSb4pVb732uux83pe6UF7
         NUTznmJGT50qUFB/FEp0AF+t1hv9t0mFlX/nmyiKNY2yOy8zOdazMa4Acwh4WKu0MCl1
         b5iPs5JNJLODOTfyNc+hZmee41eY7q9c6h91xkmFy2K7+32pbLFNJYjg6TrsQp7lnG4p
         OmPhvn6X03kdMbF10iYxxuNq5WzPn3z19g5hgQ/stbaOOMqAiOUBQp4Rm+KtZj76MTGN
         Hevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793791638; x=1794396438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4q1WGi9vPIf9vHoF8r8SkjERKMefi2tjXdzTAcwJSz0=;
        b=d24qwuYUaPK/G87rKNwMC9aDa8bqqCaXrjbe0Pg9KFHREU+NpBxzGh0rxuLWi4rYjm
         B4TAhhnpJTaCwktGPWd8u7BvhviSaIyYZZI0Xz+ruwc/oUcmgmxYNJckbnfgOh11Yxtr
         Wuixgq56XLdXlS2VPXX4JGddJAXeJ9NlaHz9Cjdh+v0hj28SdhoyFqk0spi0tsiKWRqP
         ty7ByuISKkLz4jZLaW6d5mIRplH0FExO87/wdLwhOxd2yySy+p4Mx1bC15yFF6OLtJ8x
         BW1UYfm28o4akoUF14MVMkjQNJRvDJKCEE+WRwXY2L/FLombIaSegtR6kq4VbcckA1Wz
         cPow==
X-Forwarded-Encrypted: i=1; AKwUvBy3Q9bddbidlKMuUBRMZogPAvX6tWn1d4mGe+VXCpIH4uWa6QYUFwsXIPJY/loGuQwAouhNOV8exdXodw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8+RWEAuUa8mM1Jl2sL/5O6qZIqQ/VE27BToGclQ0ZdSQOCR2bl
	saFIU3Ef1+PwBJO9QDdQzBAc+0/iHtm4oNXWZo46KBYFD4feOQqWgisc
X-Gm-Gg: AYBFou12tCN4wRE4mLxm5paOjWckxH/0T41PG7j5j77G87PxkLIAFS1GGxlTf62q08R
	uG4LDlHkZUDzQuAArlsXqEZjc0tgDCvmuq6yDRX7pAkSbPdp56k1A0OOpTDa0QSTtnmcrII1WvS
	RRf4jU/BdQSYHea89FZhmb3vmNzU1/aJHMXJ3Hj3t/awa0NSxwXVqqOmniNPCBOVld5kQDmE9nG
	pJtS2GWj+x8pA1ea3DmjVvXdszqL97Ylp+0Y70kptF+dHqAbqDsjSHdU5Udj753tgKdufTkXLX1
	ugBppvehwCKMj1reG3SRAXuMcBPx3/cuTEAUCAmxsuS6I1oZ2SjCpcOfbw83o6zrxtFeJy/iu9S
	ZEKG8Arg+RI++sO2nSfLA58aw8CrR52UaLd8Bprt/jU9SXP2OMskxRxue5zvn05ALWW7zAB/osu
	fvHKf41WeSDjyiv4XYLkPgf1DQFrP8qnDCswaG0ReG2IorFeD1V8Y8uHhbV7FCpZh2LO7hEE0l0
	e15Hy1dBRpHRcJ3jKpjwGM+hlil7im5SgiN+R2hhP0qxAmMvGJzQoxrBLsFg9buYVIghkaRxOQh
	zmxPVXXc8HP984O2x+5LdSLO2LvjjQo2XuE4S9IrxA3VrPH3Bok=
X-Received: by 2002:a05:693c:41dc:10b0:351:2958:1740 with SMTP id 5a478bee46e88-36a42445a8amr24062847eec.37.1793791637656;
        Wed, 04 Nov 2026 03:27:17 -0800 (PST)
Received: from Anonymous.localdomain ([223.181.62.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d36besm11119601eec.11.2026.11.04.03.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:27:17 -0800 (PST)
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Subject: [PATCH] staging: sm750fb: fix spelling mistakes in readme
Date: Wed,  4 Nov 2026 11:26:29 +0000
Message-ID: <20261104112629.180890-1-husainsitamuwala21@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Fix two spelling mistakes found with codespell:

"defaulty use" -> "default to using"
"althernative" -> "alternative"

Signed-off-by: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
---
 drivers/staging/sm750fb/readme | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/readme b/drivers/staging/sm750fb/readme
index cfa45958b9d2..a000f833d8ce 100644
--- a/drivers/staging/sm750fb/readme
+++ b/drivers/staging/sm750fb/readme
@@ -30,9 +30,9 @@ About the kernel module parameter of driver:
 		insmod ./sm750fb.ko g_option="noaccel:1280x1024@60:otherparm:etc..."
 
 	2) if you put 800x600 into the parameter without bpp and
-		refresh rate, kernel driver will defaulty use 16bpp and 60hz
+		refresh rate, kernel driver will default to using 16bpp and 60hz
 
 Important:
 	if you have vesafb enabled in your config then /dev/fb0 will be created by vesafb
 	and this driver will use fb1, fb2. In that case, you need to configure your X-server
-	to use fb1. Another simple althernative is to disable vesafb from your config.
+	to use fb1. Another simple alternative is to disable vesafb from your config.
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415145;
	b=ar9QFnHQeEGxqsu5UMQtVTXasA/pZ+8bIJXFl3hfnr+WPycQZK8L6lwDlKfJuZl9OveF
	 fAx2LBkOwHqMo2kxaSfgAlKtYmYa9Bff8K8jFjfX5stYuhMcBGaY2nB/B293J1+Qslc4K
	 98KyG9ANbI3AmrfGnxJ9BMYQt6sgpnuj0irCB2QAR26QcsUcYeg9EXi39C7Q7AghB410G
	 ya8ed8p8cP3j/DSuBwO/7GE2Hbb3tztumBXFRDOXoxQx9WO9Ez3dTCJU2TgI/qI3QJhEC
	 RXUKh/ykG+EEIUppadFj2IqfzpBBZuje/5gexGAGEk/nT2wdKTxUp4q211mYme9uoHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+GAFVM+nLFUYlbY24SmfVdNvtcwr0CEHKsDIq3Mqz6E=;
	b=WgUGy5UFr9y7Ak49+/WtgFdzUj26rWiaGZ01JDf74V4tylQKU+tPzqVvA7TWMHIxw7aq
	 kAXuuxhpM7cs/5ZYl4HUS8NHWm0DkkInZataxOCifg8tBKW2oulcci05UI3csnjsb2GG+
	 B1t0oVvjwFpkiexJbNPdiILexbc8iTBl1iwespNEJ+syzMDaw8LbeWt4DKxyuezqRfbGn
	 Kq4VTZF3d3BOP1TBkrkbj+IwE731Cwov2THxwnKaNhAfh9aY+klCnWrkAVHnu2vbJBmmM
	 ffC3hD36b4UyzzdBM4XvbpQbaE7L8WcFjEfI4Sr9Q0ZdkYhRDxpkIj9ShUlPcbt26gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0PZz5x5e;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA1D606A324
	for <linux-fbdev@vger.kernel.org>; Wed, 11 Nov 2026 16:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEA1D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0PZz5x5e
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36f8cdd30beso5918014eec.1
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Nov 2026 08:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415144; x=1795019944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+GAFVM+nLFUYlbY24SmfVdNvtcwr0CEHKsDIq3Mqz6E=;
        b=0PZz5x5eHBw3K6mpcni11E/lTzj1+7m5+R/krepWhFnAMPn5mR3q6fhN6hiu1a3Vf8
         Yojr9XbefGUzWKhq4QF16opBq077iq/a/eg/FAVEC352b46kPXxc0hf9Dh/3ex7NVhPf
         lvf2ku778b5L7LWaOXq2EkR9/w/9NpB9aMkudukVJJkz6iR1pBTWcz5yCRV2Z4yrCE+p
         pIrkOyky+ZCd4vbpzqMR60C2igOFsBmynVJiCs0EyWwOmQjdNY5Zg545fl9KhLwuPfYL
         kM/MhiuWLt7N7zjcOBXl+AY7ff/zWtrY/IJlgpBnMSXlvuQkGlK3iqVwdYSutd5Ja5UR
         lGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415144; x=1795019944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+GAFVM+nLFUYlbY24SmfVdNvtcwr0CEHKsDIq3Mqz6E=;
        b=d4tyfLjoi9m2QO6jzC8risYutjY1gB6cCFnMh5XkM8fHNeqRz40LbBXBgpvCfOzTj+
         /w8JBw3qXWvUSG04yf9vDdQGv1YA61/78OUALhueHo6vTiCNeiNQu4sRqkj+CGNAhobf
         xLJU+wy0/2Oi847YuTq+1jp14pvsn6MZMKPp48zRPzeDxGHX5MA7SPy85n5qXbK0vPQt
         wE3R2W6xWZluprnKTYYniFwsKrqzYhzeC9XcbclTlm1S+cUMSzVrbouX3+7wbyAyOcsy
         6sEU7q2024TyMyvIJrtbJCNcDZmtja5vx+ZfemWUZjEmOaNGQ2d38VOJQ7hgakhyFB2s
         whgg==
X-Forwarded-Encrypted: i=1; AL+hErG6OOV9Ydjm7WHvfbxXdYbMm5pifHWaXTJFXIkerFBgH48sfScLiCXPKXw5HOmbIFvBqdYcV0NeJ5LcRg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8daci4Psj3SFfZyEsQ+tWQigVGGMjww9YX4g/cgd9UA137PzY5
	UExpygvDFTcNSbjSrtYiVcDAdsaFu2dZsUaBK87kULzd6lMOoeY6hgOg
X-Gm-Gg: AYBFou1yLEUSsz7q274RQwAY5NV58FYBCx2IIJ7AVBM8s/3jG77G2b8Qbul+v0Uw//k
	e19o+9ApV6363/fQM4dHZWIwFOxOVP8X7kIiP0EB7yhRHD9kLGuv0YjuEPNVEu7hYFuIvcaMT7U
	Zhr9Xrmov5aSIKKynqQJWaxJ0n7YAHk1yH7+9jVa19tf5GELBildH0Q5sKDje9qoe+jPoxgGh2T
	ra7pHM/8RtGuJKOVIX/pilDJl2KI/lMEe+mzAuGEFeqKj8jHXW9H36kf+7w8lcWY6ErznY6hQ0j
	nd9rVwalrjgW5taIBQk8RBOfth6bJAAcN9MiGuUVvNLIJ2TM96VEqdh1hHXpRVAWP3NEGlUuT/i
	g0Q4+2z9+E0f3qt0dl8GQKzLFEJOFR1/MJAv+EdxXoGPPWxk1KEVfoZrDvz83vR/cxIW8USQT6W
	k0pLpafSJ7sjuNaiZVNukUh12jb1nizBbA5hH4BqaTBggZoW+/qDZjfl4kmufPA5Xb61fBUSsBh
	oBre8RJTxzzDy/4U/d2NqSpQx0Cchjbun2bWxKcoyB0Y9/d8Yi5a9KG2JsBey5w6QCu429LM1KD
	LoAECZIs+B22ARNXlo1Ftqb8B2DIFP1JVimQZbHRR43QQYk=
X-Received: by 2002:a05:693c:8201:b0:376:98e7:eeb0 with SMTP id 5a478bee46e88-37698e7ef92mr3137525eec.7.1794415143641;
        Wed, 11 Nov 2026 08:39:03 -0800 (PST)
Received: from himanshubakshi ([2401:4900:1c2d:8feb:6d7e:ed5:ad5f:62ed])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm35046496eec.16.2026.11.11.08.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:39:03 -0800 (PST)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: gregkh@linuxfoundation.org
Cc: andy@kernel.org,
	error27@gmail.com,
	cenzhang@linux.microsoft.com,
	dennylin0707@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Himanshu Bakshi <himanshu.bakshi478@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4] staging: fbtft: remove unused fbtft_init_dbg()
Date: Wed, 11 Nov 2026 22:08:19 +0530
Message-ID: <20261111163819.143147-1-himanshu.bakshi478@gmail.com>
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

From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>

The fbtft_init_dbg() macro is not being used, so delete it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
---
Changes in v4:
- Add Reviewed-by from Andy Shevchenko.

Changes in v3:
- Fix tag formatting as requested by Andy Shevchenko.
- Add revision history and testing details following review feedback.

Testing:
- Built the fbtft driver successfully.
- Verified that fbtft_init_dbg() has no call sites in the kernel tree.
---
 drivers/staging/fbtft/fbtft.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 40a7567df1eb..16459e4e0ba0 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -420,13 +420,6 @@ module_spi_driver(fbtft_driver_spi_driver);
 #define DEBUG_REQUEST_GPIOS_MATCH   BIT(30)
 #define DEBUG_VERIFY_GPIOS          BIT(31)
 
-#define fbtft_init_dbg(dev, format, arg...)                  \
-do {                                                         \
-	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
-		dev_info(dev, format, ##arg);                \
-} while (0)
-
 #define fbtft_par_dbg(level, par, format, arg...)            \
 do {                                                         \
 	if (unlikely((par)->debug & (level)))                    \
-- 
2.56.0


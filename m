Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793002731;
	b=e+1+gW1a3N2L2jYL6h3qRxvHxFJ507jVv80WuZ/OFjgCYEyKh+4mZSp9UlfVaVftUtqt
	 FCGqNneQn3AKHEKFukeEo8GdfrIv05Tkqc5dog7TCFCRg+dRRsztLc5K7XYJlVum3jHQ2
	 kn1zCwRepZcPXJa3+UtWknBIuQCxb+CI0x56m2Hi8VRsg8QsuxMEaNzLF7gA2JFqSWAG6
	 gQmZX9KrZFlLf/dDe002b+MEXaiQal8C8GduReMbsFBc9aMUEdATvNNdl6Rd/bMcAk4kx
	 doy9ePksokqah9K64WCttP8ksF1UKGZGqMnMNpHuBi1iELINnAlNEDk8E5eXD+tXZ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E6zA7UN4800aROAky49ikegUFLsqpLG7wSuvYuvN3r8=;
	b=NjgD+bzCpl9vHVQUC+zoIhPRUqcVpEx2q9atk1CoxEV7Ozccaypz6pFU4+pwl+Y4yHxI
	 8Lq/PjCX1oGrhZhwYtqStuP52z7xC4+wIEHOKOSZW1n6kTt0eRkTaXGa/z11sdiXSAxxN
	 2B/HRs+mZMOg0BXzGnuSgG/KBk800/o6kQYHpAFN0mvlxRNSwmeR3vaQmcRn9FX+TwQ70
	 qN+GmdrMZsckQUaD6Ugv/gv0jSf0iVHXQvHYI3DIurMAxS77m8G5Bq9UynaDaTCB3b5sE
	 SqPg0lP3h6JR0STZHbAitnt2ywjxoyvJxe0q2NW+zt3Xxbpl3aZQ+q9QOx0wt1bZCtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jmUx5Z36;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AFE606A31B
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 08:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5AFE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jmUx5Z36
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so4661116c88.0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 01:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793002730; x=1793607530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E6zA7UN4800aROAky49ikegUFLsqpLG7wSuvYuvN3r8=;
        b=jmUx5Z36CjBsOtktD8QEtKJbCNVk0kURGGGr2ey4/b5gt/gYuSenOFTb4OXuIYjw0N
         skQIa+dn08YlsBymAFXtgjH6Ro9DK8y2nuqyah6auruVw8asJzPheR/bRog7JgOioPzA
         SsJtU2T+e0L3KWMLVh9YqPlhBonbXOPsPwOJFdy4OxJ8tqj2pdJYJxuoaiW2attsatGU
         nwpQ45Z4PEiPCNJJ00jikpYFb7uuWF35HV29wrfZaFkPdsyBNXrSmfb8L5MYTU73f8LY
         6udnIbn5p42+IWm8t+kNrPQxqaKnTjTmEulUaywm8ypq3ymZBYEN29HOeYEHjYVpIr3Z
         VCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793002730; x=1793607530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E6zA7UN4800aROAky49ikegUFLsqpLG7wSuvYuvN3r8=;
        b=o2cY37e7oQbBpCKL/cec47J+4oTB8PB7scba0rX3G6n++ZoWfApGOdWeN1BGyqitMF
         dSbthBLGXvqayjBCTrk+bpD4t0rasUbr3sUgO5CLAatHPQ5r7ztAPEdq4Dyn3MLV8p3y
         GIA3PLv5a6P1K5+iSf4h99s3gzRkfTCWLxOpQ/8rjHn8CmSgrzS49CPVJg3AD6BZWR+c
         H8ps7mEgIP8Q1NBNQzIae5batbDgRSDeNflSd+taiL4phZgXy1Y3tCPk6foKwA1f8E6R
         C9wRp6RCfEJLXuJ1y1iSdKTxfY0Mr8SClJ/WLYDtcHPoZtEUI3LaTzBltpS/G27B5EDK
         k7Dw==
X-Forwarded-Encrypted: i=1; AKwUvBx89UUEXa4cG5VudcduUW0uvFu815sMia2x47zJJIEnn3HBf68rzJG5gvljt1b6BaB7AGoOmO2Lm5JXxA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL8XaRAU5Ik2Q8IcecO8LQgND6UkeAM3MZtWJ7qD+i0GdgbFJO4
	Qf+ro+ES8vBDrxyid4J8522781ntS0gIiXjDCWubfWxlnlbl0MDqlUSa
X-Gm-Gg: AYBFou37cgV2H7wLI7sYMUrBBwYIp1rWaYrh8+tRXn8epHxoEeol/kUsCvlBGXORviW
	4GWKm28MSBvWYZXUWTmScQDYdu6a+UJk5JJecqDeEQanStTSTfUyFt1rdKz6kjBRQs29gBAyzc2
	SyO+5grYw1pKp3Kshgtuzo36rWaijAiDlnAJA7JpDdIz9E9afde4TwdLfFdmENIzga9Z86/ZMpS
	3CxqPLm1zlTE9dVu3wWr92wF8TlUDepoktRBytMKNPYE0etEcBCarTGLdUkCe1pb9q3b5ypVHGr
	bQvRJoVRLnKS8PwHV0RJuwUjPwPf6kbTW1PrFpqMavJ1Lwvnoi1HWlwRe92k6HdPkRte2qTEK9T
	wW0YnBR6CESFWwfHA+54jktV6OEKt/n2YPsb700eyg7tMvYdL44rQW6oiLjIwIDcbVua4jvhOVS
	QkknA1IPRWOVb9oqeJ7DjKe5QPXWH++57MGU5zp+eGmhfZTQCikjNGkcxZKHUASiZiDs0WmYZEI
	xqy6N3Ia/r64wHvz/hYfrlyOIKAMP8O0V44mt0O+6FiiGC1Gqerys19LB8zaA4ejVZ/rXGZuzw=
X-Received: by 2002:a05:7022:7e0a:b0:195:9228:50a0 with SMTP id a92af1059eb24-1993686f4a1mr10019388c88.42.1793002729532;
        Mon, 26 Oct 2026 01:18:49 -0700 (PDT)
Received: from himanshubakshi ([2401:4900:1c9b:1c1b:d646:355d:1105:8655])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec865esm21698270eec.26.2026.10.26.01.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:18:48 -0700 (PDT)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dennylin0707@gmail.com,
	cenzhang@linux.microsoft.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Subject: [PATCH] staging: fbtft: Remove unused macro
Date: Mon, 26 Oct 2026 13:48:32 +0530
Message-ID: <20261026081832.60570-1-himanshu.bakshi478@gmail.com>
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

fbtft_init_dbg is not used in drivers/staging/fbtft directory and
since dev_dbg messages are good enough, fbtft_init_dbg should be
removed. After compiling the driver, there are no undefined macro
issues.

Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
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


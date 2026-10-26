Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009912;
	b=VktYpf60eIukoMYCvkCfmUOt4CNPgHyBz6y2h1DTlpFUGypVoIy3BeVrK0hEW9X03blE
	 696mIG8beVKAZo1+Tta05+kkKo4QFgaR2zFrcSNTzs122MD4JOSHCQfg70oLgmK87Sy6G
	 bHyBNImAdjIrxd6CFZENZqhzB+B1Sy0NRDsGqSSBytRid61N8hc7Ac6NhwcLj/BflZTyq
	 UfcXN1MxKNaQ/BwdhKSZtKo+kR1gJ0HWTGnIu62JlA3G40Fu+rcSz2Brg/oQhbmdQMDTt
	 enxph5DMRBNnKAk24nad41JKT2Q7JC13srFu9TgEylOry1j/UvJmVeEVe+iA9vYBE7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uMe2OrBlQbkfT3wcvRtHcAjQdCdPt+EgXnOa1muqk1Y=;
	b=dXoXMkbFrY8jCo7Rz1X6/c/Mz2g7KXLdwf9B2/qQ0lZSDTktyuJrkFjOxvNk5lwlcv8M
	 V6zO9Z2gZXq1nmAysEwfKcEFvulGdvHSLZ86RLm9pnNCzIyoOZpy1mhpZE8brfdedmYvw
	 xr6frh/sRfLoMfr1F7qXhaUWxzlmEJCkSXBF9ogyuYzQn3so7BLMzqmAzESe0wvKFcKv3
	 c8VobiHUA7yqvugE6YcSF0mf/zCjLkTyKKAX5FGqoqM2/jXkCBzIPdHMdq2PvD9r19b7+
	 YTkuV7Bh2STBu+hzwSPJJpnb24q6OBDjGWqh8yrmh0hq+54xNvjEmCpfAIEs5e31Kgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DDaufxmI;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F2606A322
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 10:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 327F2606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DDaufxmI
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-369f33df08eso2516069eec.0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793009911; x=1793614711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uMe2OrBlQbkfT3wcvRtHcAjQdCdPt+EgXnOa1muqk1Y=;
        b=DDaufxmIVVO7pEUlYjncmUG+iyj3BLa/cJ0q8f6t/B7t21Y/liZ00gjvp8ZbYlBMbk
         vcGGt2vFSWLE1M1rAwdmk9mtJEp61K/4Gsbf9uX2CdrUuWQ12xBb2ldrdJa+cQzyxvdw
         qb0RHhGWJc60S8Z1fLctIOBWpBLMU4TBw99WwwzZC5hotDZhhvEAG50lm7G0DKPfRvmj
         LtnZlnyboBh/LIQr3OHgv7lY4X7EWy9elK+9+y2WYhet0JTpKaQcKMHYYLul30OLHCgz
         ZPa+aJhfs2RGoAbznC5P1Rk7skuWOIQvVZp+pKtkf0Yk8WNXsy0K44ZpFvy84xhR8xVM
         bjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009911; x=1793614711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uMe2OrBlQbkfT3wcvRtHcAjQdCdPt+EgXnOa1muqk1Y=;
        b=Dzt1PdTdzhR9UdtE5Etd2OgrqmwZFDBYhAFWviNpOpKg59RVPfu7Wjel/xmnH12lvX
         eDecAG0cOJUDI4BaxkjIoNH5eLpMk5alFL8Dikda+E8XiCyZ/62UTbGYqyLd07r2hDkf
         +hUzWye4fHP1DTOxJc5Svi2zHjXNdhOsquyl2v8XYnt1mhStweo0wrbuB425WRvUMRLE
         WGcWyL/fKFoq4+ic18Y4LNwGs7q4eYjHJ4xr/BdrkKh8RAiug6owr6FIndIGFsgBjjlN
         sUzEnB245XOQueeAF05iTB6GRknZ3Kv+LDo/3z/8FbK4t2Jf0Cvd4ZzWMyqrfeahVxG6
         Du0A==
X-Forwarded-Encrypted: i=1; AKwUvBz7UmXOaOaS84lyfgayNrUwS55M73xpJgsSJR/bZ+r1FsJvz2pQ5UiCSJ5QQMBu1dBXC8tgaxn9uSZP9g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIsC92JXtIP8W3PEefUI+3ugVXGR9IR+m3COoyQb/fyx9nMvCDF
	vAC1QfEOvO2znw/a93ziqeujKC7rU5ERcZJhIUCx1pPOwIdsT1bXdk2WqwVQOQVB
X-Gm-Gg: AYBFou0mnpPpVYWRFMhAYJnmwK5RtuoGl6DE9p7E7E8mxnip395IWFAdaYxlyOFrbHI
	l/vb8o1oI5PFD1kob7EqgxAZ/6kj9+r1FP7jGCI0uJv2TFj5yfRKASntlwRjN7fik4sqaB//MIu
	sAX39U3o1LsUPL9nAFkBcJVQYw803wTXP7biy1KZ1pQxXyRyJbjwVhMYw6zHnNVATvUvMHiNNpz
	cPti//3ZudOiL2y6ZpBGPErIBZQGLVSuD1ZcvfhQiu/JEK/5gLm0SpWwUFGyxU0yBywZdrPxd2w
	VrbMgVSNxHesOSdneIjF2/sE+LZajCqE4RfPFN0xDNgQy+zmWP/IDUGwu1N1j6j/DqSIBkAcLdP
	MHUv/vpUOkuvIVkhKv2NXTZwm0KU1ymi1erTtnMxlMD3GxMB3/8/2s8NvV1VROxLsB/J0MKfJ3U
	Z0pAEPwRGlqI/KVr4QG6SN0Te8a3FO5CUMa+d2mC8NjLzO854Tnco7zdB2GrfEeS1MHZAiElUTA
	fcx6RN063LzzrDE6pm+VBaarxkgeX06X7fPcSoULqevEAcohHjGz5AD6unCfZfX+TQX5XhoiHo=
X-Received: by 2002:a05:693c:8214:b0:351:31c7:ab1d with SMTP id 5a478bee46e88-369e8613376mr10271627eec.16.1793009910967;
        Mon, 26 Oct 2026 03:18:30 -0700 (PDT)
Received: from himanshubakshi ([2401:4900:1c9b:1c1b:d646:355d:1105:8655])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec865esm22437475eec.26.2026.10.26.03.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:18:30 -0700 (PDT)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dennylin0707@gmail.com,
	cenzhang@linux.microsoft.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Subject: [PATCH v3] staging: fbtft: remove unused fbtft_init_dbg()
Date: Mon, 26 Oct 2026 15:48:15 +0530
Message-ID: <20261026101815.73722-1-himanshu.bakshi478@gmail.com>
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

Reviewed-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
---
Changes in v3:
- Fix tag formatting as requested by Andy Shevchenko.
- Add revision history and testing details following review feedback.

Testing:
- Built the fbtft driver successfully.
- Verified that fbtft_init_dbg() has no call sites in the kernel
   tree.
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


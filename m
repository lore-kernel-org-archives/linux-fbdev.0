Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029C22FB63F
	for <linux-fbdev@vger.kernel.org>; Fri, 24 Oct 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298659; cv=none; b=sJnwfeqJofon8i3p3DFNlpUoiIguq9idKy1VT5LG+2b0j9IHcWy2UH/q+6QUkTsmxSR1Jsbj8+0Ip1SXiWqRlEeoIVoWjnBtHY4lIz6JqGvJrlfQIKoyr4sWIKv3rhoB5PE041l4ZvBAHCaVAmwp/gBxbYWlwDJJTEh/tTaKVTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298659; c=relaxed/simple;
	bh=/Cbl4n0yrdtsgnDtQir6yB7F4/rJakM2sUOcZ9UhiFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqYHQoieWyy9NRJQqTnG8D56Lh3hkWfh+nYFBiBDvg24jnLiTHj7h+RTArNWSfweDY5Iaei+eTjjhkQRrKXkhoeYVWFh8n+DLa8Ix38LLi8dSPudNC8NlhJjE0JEzqyuhpriZnopf1CGq5TWFLdMAOAtLUhnQjk/48mBNChA17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=dWr3lOSs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="dWr3lOSs"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290c2b6a6c2so20636575ad.1
        for <linux-fbdev@vger.kernel.org>; Fri, 24 Oct 2025 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1761298656; x=1761903456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TluK3MF0nWIoJUSNiEPuReJVhgVvccO24FAbWBod7M8=;
        b=dWr3lOSsaSdXQ/ArkM4UvzvcF3Og4kvW910aqfBu/ZcvAzIXDPSOaRUXJqchCtH9Uj
         YHvEcwFkx8cAtoBMmTzklwVAKlU9RkGc/OqW0lmjXxyhEoZAeGNZ5P1XIS4YPPZBhk7q
         8+do2MfqSfs+XQ9J/fc0IdBRWJL0omSngtfNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298656; x=1761903456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TluK3MF0nWIoJUSNiEPuReJVhgVvccO24FAbWBod7M8=;
        b=E1vfykhCRyxSf+mJBLobwSvkwQko5D+4lcUAzPqJ+J83w57K2NZS9s5fTMsdnOWnUn
         4ktn41OONMX2ZxkxD/CPiZ4fDI0tg1H+2ltn0h+kDVf0dzXH1M4Cx8I07oKXaJaM0SDR
         qR2cRtpd/goZF4x1G0Swpn2lkHOVezeXWCdS/4S4Gz0sN3A7ooiZw0tI30d30pVgbe4Z
         +na6AWK97wotKYvnkheO38s3e4EUYx7hH5Shoyid7CydErnqOuBVAYcUzCGSeHx1KvZa
         katuBbnIDnU2h3Wi6cSyPnPc7DPuG38LylMKEMB1vWddiK9ikwyfvlUNHkQ3EssaA/BR
         3/oA==
X-Forwarded-Encrypted: i=1; AJvYcCXYQldkaZnxc5Y9bKcDbqXNiKYY2u+R0Rgnj1pELEXgKGKiBoeuyejM3cogpAXkG4jgsTvK0Fmuz6ENhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhCULjZC5nfTal7wExeuO5nU1WNUNRvPvMsr2Kcl/kwZp5zjT3
	F+iWyLI0uU6JCj2z/Uxux+7b2kAPt0QADZGYJNlmckUhUCT2GxNN7TW3Fo/N0TsqzgGSuY5UwmX
	dFup8
X-Gm-Gg: ASbGncuY4+WCTj8yhX7PR6J5Cl6VkvwM9TT98SpKlb4umz/YYPDHIg8m4y74cSFb5hO
	mO5/ynWv240SYxsurf2wgwdZFFgFMVkRV3dtUFIwzrVmq8Hgn9tny0KfDKZIAD9+52l1K3kp65P
	H7ViJjvpKpz7cX25XYyxLa/DH39s/53UDibOCloJksDGJwhgXXN5TMkpiM3Uc8i/WMMJLFiyuwW
	FHLxZpEt2UuG8mPr6gGExEgvjjK/0TQ5P+sAC7ZnwjUazLRFZMuHA6kqAtp0rEHfuZ47ozSQcog
	n9QvcgBf5BGUUFfx6fBqFG1an8z/V9HXqfgLjgxP633UAnxSIA/2t4Tf1O8PK4XdP172EyM/suY
	SjJ3Ng2xoFrONhyYSn+0rhzM5Q9TcJTFhN9Vy1VbOhkaNvLnLRsbB1iT5VLEdgmu25DPzlEkjMh
	hED5C7PZgsbvjcUv9ODncWuWmfp76oik2tMCQBRoo2u0IMEbCkk2d/7H7KK+wUqg==
X-Google-Smtp-Source: AGHT+IEKtLA3XRvvshIlIg79q8hd8Y4gzZ4mZdxItUorXlFdB2qoWeLIZZW4BUstYBazD2NVXVoh/g==
X-Received: by 2002:a17:903:1a4c:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-290c9cbb12bmr378539265ad.18.1761298656100;
        Fri, 24 Oct 2025 02:37:36 -0700 (PDT)
Received: from shiro (p1391188-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.222.3.188])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2946dda72d0sm49975485ad.16.2025.10.24.02.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:37:35 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de,
	linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] fbdev: atyfb: Check if pll_ops->init_pll failed
Date: Fri, 24 Oct 2025 18:37:15 +0900
Message-ID: <20251024093715.4012119-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Actually check the return value from pll_ops->init_pll()
as it can return an error.

If the card's BIOS didn't run because it's not the primary VGA card
the fact that the xclk source is unsupported is printed as shown
below but the driver continues on regardless and on my machine causes
a hard lock up.

[   61.470088] atyfb 0000:03:05.0: enabling device (0080 -> 0083)
[   61.476191] atyfb: using auxiliary register aperture
[   61.481239] atyfb: 3D RAGE XL (Mach64 GR, PCI-33) [0x4752 rev 0x27]
[   61.487569] atyfb: 512K SGRAM (1:1), 14.31818 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63 MHz XCLK
[   61.496112] atyfb: Unsupported xclk source:  5.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/aty/atyfb_base.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 210fd3ac18a4..56ef1d88e003 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2614,8 +2614,12 @@ static int aty_init(struct fb_info *info)
 		pr_cont("\n");
 	}
 #endif
-	if (par->pll_ops->init_pll)
-		par->pll_ops->init_pll(info, &par->pll);
+	if (par->pll_ops->init_pll) {
+		ret = par->pll_ops->init_pll(info, &par->pll);
+		if (ret)
+			return ret;
+	}
+
 	if (par->pll_ops->resume_pll)
 		par->pll_ops->resume_pll(info, &par->pll);
 
-- 
2.51.0


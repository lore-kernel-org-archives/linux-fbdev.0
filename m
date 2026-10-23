Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742183;
	b=rpQ86CodQ6MN/BzsSz13quAbLl5KYhu+lUe+hTOIoLHRoM8aOCmH/iy9lbXf8drgC76/
	 73ze0Qsffqct/tA2GyQBl8oLxAXo9tUVbJ145FQBIuesKkeBVVSgZ/FpiTsFADvR7HQ6t
	 KF4A3FPIIl6pzqzuW5rgpSgGVwvb4DvRI92quiED1FoHg69JsU3WyPscC79VSo/lJcS3/
	 LKHd4FrBtyCpIP1B46tdjwOJErtgpiDoQz8sFszFC7XLKoMUgXXSBBsTMOEEv3vldotxU
	 tuzdulcZEPAAm232eKA8RPEqqEIqSJXv3L9fHSD1aKQ3V3Ryz8b497Iyg846Mg2eLhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=d5nwKFsZvE5L1iVkiN9qlakuwuo5b+7GgbmdUMjeiGo=;
	b=k4ob//I78bM2Ah8AeDclBzW5S49VKR17FgpCZAjKlHGUt81RUIUER1MkTjmH3EB4so56
	 GyITHLeBGT2zPAdnLMUMAtCGi9Y8SviE22k4xIJBSA+/wjSze4kO94ZLtjuH7Hm/g4+g+
	 TYDBgtgLZCwc0jf24I8Fnkw80fqz6KxpKZLKZajhrYZYNfhmueZ+ciAeWD8P72UXXa1SJ
	 0x+8cu8Ye3QVZXXO2/8AYSHsoeslLo3qVRPDzYDISEHJXPY4s4CuZrlRC9oEHVdsXY+8t
	 Q5nXYIhEwLuZCQCv/7+KhQWa6ydt+K5EsJSozry+jZHcqhCraY4h7QXZJQrLNfLLSlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UybKkBI3;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23AC606A31D
	for <linux-fbdev@vger.kernel.org>; Fri, 23 Oct 2026 07:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E23AC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UybKkBI3
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-89d6bd67045so275478b3a.0
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Oct 2026 00:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792742182; x=1793346982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d5nwKFsZvE5L1iVkiN9qlakuwuo5b+7GgbmdUMjeiGo=;
        b=UybKkBI3GOa5r0eXQ1Yja8255ZrqEiqmnAyTSJsjPqwu5JWSnRwG1HO3wPuH31yTiO
         iMl+UeWXpCUnZ75q5rIUqvO0LGr6mKG/b25tK0Cn1td09FZg381GD0ozMhcTsHDh6/09
         apT6hODBL8Urv6E6KjRyCNoWPYAB2eLL6YynlR8o/oySkIOPu6m6sfFdu7fPt3KLxjlP
         q3iZB/87zztATkrxcGVPW8P0r/aysUFOwmMzIzNil5RzKh8S1qbDdsXBEsu1+MTD/t8f
         RAl4IQ7oVWKTj3L3dCQU12VnPjlsmHAw2koBGahgq2VFyPlNt8mJtbA9H8/sqSO6j4FB
         sE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792742182; x=1793346982;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d5nwKFsZvE5L1iVkiN9qlakuwuo5b+7GgbmdUMjeiGo=;
        b=B1UdQA8KwEMH7Htz6f5hhd5EVhRqNDejZ30WV6SbMVi5qJAXIQKApyZn/PpbzLHiJp
         PGLESX56SjTMZi4W2/WvUxU142UBDqriN96HZgs2tAyDwUC0/1x2fmfB3i+Z0yu/n7RI
         nfPzk8+IDUPL6hQ8kAUx7r6KF2B7O2xfFYf2+n7EmB2LLjsLo7DJOK4n0rNr33iYjeR+
         Ci6U5SfjMZ0LE3Y3E1a0h/kM+ZTFFG7BUgsdZb89TDm6x37+b+UlD8XZIKmgnyspAmWQ
         0QgMYbcePBtpFbk7Is7x2qEm8VbPL+0BusuWWwKViqd5b/cjdYPu9RmsNH32s6YcWUNR
         J0AA==
X-Gm-Message-State: AFq9FYKJ4AjOzJHjKU+kGGttacqS6Z5GXpM6it/VEwjRlvYINpl9tc1M
	u3GMFVkftd0hXsix3zWhbqgq6S5BNPknsB5E7CXvyVYCweMQJ9eoK8V2
X-Gm-Gg: AYBFou2Zd1eE4jfxV5r4lTbySma6E38ywjrPVjzn0y7b5VX4Gh51LLpNOA4fP0TMhLr
	ohQYd5FGezibcjPyCB/HL+zwFx69rLhTQfoQ8asdeX6xojYDqpzC35JSWk3Y+E7aSV3Bb0Ix59o
	eYUP9ZIeauLe/5qKXyZ62krVW6Y9mbOi+S5mAJwiM3WJcoGbJ2KFXe/iqgM0/k7NNDsl8UbL5/Y
	OrDY/mb5Z5xA2P3pB7uYUQelg58FbOOp4LpVHj+uPxJTWOomZS70gjeH/2DKaJmGYuNIJw6JpyR
	qGAB0Z4PpADirfprtMbWcS5CV7XgUO4mXMuAc1iVS3bzO6DWLPWJbxUpcf+j2h5RNXjQJScpOwl
	Lv4sDLcA/ylzNmocb1+dmizldhbp6tA6FR8PbJ1ge0yPSYt4PmOEQLPDOwRqCTAGzy6w8wCmPXn
	xbN43ka3/kRW9ZQsxGkUirEfNR3n67hbZUdvjoYorFDbe2O+m67mU/5mW5Mfw49lSX2wvG2w3oK
	X6Ij3i8NK8+GiaIq1LZP79z+Nro2Hbxnw0UHxFcvnXTVxnq1RiUF79SZaJM5bkmtIWNShGS1I0x
	hRXeHJRBC1dyxTc3D+eSagCy93o=
X-Received: by 2002:a05:6a00:bd88:b0:89e:7bfa:f87b with SMTP id d2e1a72fcca58-8a2c472e08dmr1075229b3a.3.1792742182084;
        Fri, 23 Oct 2026 00:56:22 -0700 (PDT)
Received: from spiderman.taila3fd8c.ts.net ([202.112.47.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a2c8ffc99bsm430968b3a.43.2026.10.23.00.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:56:21 -0700 (PDT)
From: Li Ximo <lixicaicai@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Helge Deller <deller@gmx.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wang Haoran <haoranwangsec@gmail.com>,
	Li Ximo <lixicaicai@gmail.com>
Subject: [PATCH] video: fbdev: atmel_lcdfb: fix list_first_entry() on possibly empty modelist in probe
Date: Fri, 23 Oct 2026 15:56:11 +0800
Message-Id: <20261023075611.3559095-1-lixicaicai@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wang Haoran <haoranwangsec@gmail.com>

list_first_entry() does not return NULL on an empty list; it returns a
bogus pointer computed by container_of() from the list head.
atmel_lcdfb_probe() initializes info->modelist with INIT_LIST_HEAD()
and later takes its first entry with list_first_entry(), assuming
atmel_lcdfb_of_init() populated it. However, atmel_lcdfb_of_init()
drops the return value of fb_add_videomode() — unlike every other
fallible call in the same function — so if fb_add_videomode() fails
(its internal kmalloc can return -ENOMEM under memory pressure or
fault injection), the list stays empty while of_init() reports
success. The probe path then dereferences the bogus pointer in
fb_videomode_to_var(&info->var, &modelist->mode). Because the bogus
pointer lands inside the contiguous fb_info allocation, this may not
fault immediately; instead it silently reads adjacent memory as a
struct fb_videomode and programs garbage timing parameters into the
LCD controller. This was found by code audit; we do not have Atmel
hardware to reproduce it.

Fix this on two levels: check the return value of fb_add_videomode()
in atmel_lcdfb_of_init() so the failure is propagated (root cause),
and use list_first_entry_or_null() in atmel_lcdfb_probe() with a NULL
check that fails probe gracefully with -EINVAL (defense in depth),
consistent with the surrounding error handling which bails out to
stop_clk.

Reported-by: Wang Haoran <haoranwangsec@gmail.com>
Reported-by: Li Ximo <lixicaicai@gmail.com>
Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 53f015699..6820a2400 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1007,7 +1007,9 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	if (ret < 0)
 		goto put_display_node;
 
-	fb_add_videomode(&fb_vm, &info->modelist);
+	ret = fb_add_videomode(&fb_vm, &info->modelist);
+	if (ret < 0)
+		goto put_display_node;
 
 put_display_node:
 	of_node_put(display_np);
@@ -1075,8 +1077,13 @@ static int atmel_lcdfb_probe(struct platform_device *pdev)
 	}
 	atmel_lcdfb_start_clock(sinfo);
 
-	modelist = list_first_entry(&info->modelist,
-			struct fb_modelist, list);
+	modelist = list_first_entry_or_null(&info->modelist,
+					    struct fb_modelist, list);
+	if (!modelist) {
+		dev_err(dev, "no video mode available\n");
+		ret = -EINVAL;
+		goto stop_clk;
+	}
 	fb_videomode_to_var(&info->var, &modelist->mode);
 
 	atmel_lcdfb_check_var(&info->var, info);
-- 
2.30.2


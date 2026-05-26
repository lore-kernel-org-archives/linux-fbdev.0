Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB13FFAB1
	for <linux-fbdev@vger.kernel.org>; Tue, 26 May 2026 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805087; cv=none; b=oiyJ6Kg6rG79f8240KY2mR59zrgubkUHMVv0crGbXvO2pQ8lxaTujLgz6VMi3Sai83lDAR9d550+SOS7CCCHJNwCKONBx0uv+MtqZQmt6zR0pv0c3KfCyogoRZmkoJPewBgZm9P8OAVTjvpujB3OStCaqHAGtsADNlC9xJ6IC+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805087; c=relaxed/simple;
	bh=vLYhva7TFPlfvxBS6GmaWUTUrenc6YRKtxASZZ8jZAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoKOTX3TS4A56eHSZDglA08njxi/WV1dgKH3Lu9GxcqB6P2nhH6U8BoVZiS4JG9qJVVec91KjqJOzLLjcbEkhSuy5T0aa3izxqMGPTtOENGzWf0Hx0fjb/kf3leI34tbh/nEcm3zIBRzModpgWzS2RRfckzZJD4RnKLPb07EncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=CUCW2NgG; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="CUCW2NgG"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45e8a834cc2so6026987f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 26 May 2026 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779805084; x=1780409884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcGq1XrISl74r5Iag0hCS2Wz/dm0EE2zh+iieQwt2tE=;
        b=CUCW2NgGBgzP3kkvHa1V4GFLHx80UTkLGSN0k+8p+Xtn/1vNfeK/qhcHuhyTUXJEKF
         3fQQ+qOELTrFh70NT88K7oYEFY4N3csPa0/lmJt9BcmvcgHTuEz8HEJeFaH/HXd7rayc
         gFpnZ/ZPqvsgRjQ0S/GYSyAVpFTFetFHzdqtZjBCY9LkgMfwSNE0Uzxw/ySMgU98GX6V
         sCGnAQwqI84Q8hcoAstCidgyCAUYrc3XyDsjCMHZoRtkgFDftzsf/PEA1dg3MBAi63b1
         KLLPIG0Jq1YyVxc0gO9D3A+8MqCR1/eInYoHkoXRGN4x/aqUFxRKQHXMjJgBHUSqQMsI
         k3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805084; x=1780409884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcGq1XrISl74r5Iag0hCS2Wz/dm0EE2zh+iieQwt2tE=;
        b=ADj25x21mg73lm0pfzHLX7c8L5aegoA2231vEYtRmm3x29ALYIygzCiah3XdMmbw37
         Wlwy2VoA2GQM63Rd7Xfu7/xRwVr0BjvFf13z9tWrZqFuiw3R9CAWlBY7GxQiCOFjh/1U
         Nf2nfUYdzYNng4wiHKYRm7hbWPXuRn4BrRB2sjjty5skjtmWn+EyUuBc5egalVuxqyoI
         hFl9PR1VcpTvfY6jv/VMV1y00IJ7isKm+lKDXtespeZERV3/ECPvWqMYi9Via/3Psqmx
         ETLclgyKWOETpBryPo34IAQIWxSJz0M/osS0BpqvTpsyJCnonV2/JvNOt+ORa4MaAdTR
         XeCA==
X-Gm-Message-State: AOJu0Yy87Bz2GunXcnV1x6e1hqNTzjRw994xw317EUkGBNX0pyW2cwD0
	hw1Ac7rWRhYXn1sEUigx8J5Xlra7fNyWfNq459GKzD7CH++x6Pr84hyGRFijOxpsSGg=
X-Gm-Gg: Acq92OGKYWq4929NCNYMAFJKYT0CFz9Kg/+yi31oXk8nMiQXKBCwuhfq0JdCCrQA/64
	OW4z0MrOfvkYrGIuYW5iUNFtMgfFBnEH1pa5TGPUhUIRyqarYCP3DDHPgiT+aDvEpQQzGX3S+dp
	/qDS1IunNR2p/D57L/DTxZfIM1/3R8+rgw8K/G9odXUNZ1xffnNr79H9wHGwSOl6uCVlONQgbSZ
	DtmrzV5Q/uXRKrQCavBZQ7S1iX9bbCDkSuwEYqyof1rCG69KDvLZGSILgoLbNPZcgUgzh5zyhJS
	UGdvtglglr6KYTY4f4VC9QSW9a7W3DknqH7NR3xc0x2RlvmJma2wJJDgcCsbd2cmfblqviw8hdy
	PjqJs9fZferGAX/4Y+xmWjNor9ySSnEroJAJB/VtpPj8KEmTPM8sT8Z5l2nvCcGFvpgBMnjh8YJ
	bIO65w/qZG+BPr1TK0wCSisH0TjmV9zELQK3FOxysSZ5bH/1QcDjrrKlTEtW+kvW05XBL0JldRD
	Uivml81S3Z7MPE=
X-Received: by 2002:a5d:588d:0:b0:43d:a37f:8d5c with SMTP id ffacd0b85a97d-45eb36a860amr35484418f8f.17.1779805083801;
        Tue, 26 May 2026 07:18:03 -0700 (PDT)
Received: from localhost (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de. [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45eb6cce0a4sm35446032f8f.12.2026.05.26.07.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:18:03 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 5/8] video: fm2fb: Use named initializer for zorro_device_id array
Date: Tue, 26 May 2026 16:17:31 +0200
Message-ID:  <12911d2a1dfc4e482bbc0a417df73748283d04ee.1779803053.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=vLYhva7TFPlfvxBS6GmaWUTUrenc6YRKtxASZZ8jZAs=; b=owGbwMvMwMXY3/A7olbonx/jabUkhizR1U3u1mK5E3TLryob8TbMXBf7Meys0fYbv3Zb72143 3vnx1XHTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmIn2Yg2FmQtmKN5sOa66d rJ39ZNfE2ot/OA2maOQlfn6hfan1i8Mb4SIfoZq/cUIZGvkL54m+vZ7BXv+uMskjeJbmFLOL0ge i121P2PLYp/i5QtlVhXVqG52cctz7l9vnZS38pPBF91FWn9T5+RVBSk62Nu9Dklb/T7DRamzO05 Ws7ZzWfPdGfHXDwb73Nx04dA3T4rvVFhXvkzGM97/dY/gncmbLuv/qzy+5NTMns0fkBx5iyGj59 ujvn7LK/lfNL5l53ikZMQTw3+D4s/H93QKxqaUlit7rQ9amBjunr++0kjj7/1d7xiy7L9K+UnEF nCeFvxe0nPmySbTYOCDD7DST1Ns1rbkRO5akO9YE8W8DAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Using named initializers is more explicit and thus easier to parse for a
human.

While touching this array, drop the explicit zero from the list terminator.

This change doesn't introduce changes to the compiled zorro_device_id
array.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/fm2fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/fm2fb.c b/drivers/video/fbdev/fm2fb.c
index 25d2e716edf2..a62c8d86bf69 100644
--- a/drivers/video/fbdev/fm2fb.c
+++ b/drivers/video/fbdev/fm2fb.c
@@ -212,9 +212,9 @@ static int fm2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 static int fm2fb_probe(struct zorro_dev *z, const struct zorro_device_id *id);
 
 static const struct zorro_device_id fm2fb_devices[] = {
-	{ ZORRO_PROD_BSC_FRAMEMASTER_II },
-	{ ZORRO_PROD_HELFRICH_RAINBOW_II },
-	{ 0 }
+	{ .id = ZORRO_PROD_BSC_FRAMEMASTER_II },
+	{ .id = ZORRO_PROD_HELFRICH_RAINBOW_II },
+	{ }
 };
 MODULE_DEVICE_TABLE(zorro, fm2fb_devices);
 
-- 
2.47.3


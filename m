Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE773402439
	for <linux-fbdev@vger.kernel.org>; Tue, 26 May 2026 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805091; cv=none; b=AxYGRo4gJEERQSBx3hoU9FGwNNsOWml2DUmh06oEQ5iGBmTG4oy+Yzk3vakPVgxlQDHOhH4jN4/Fv6I9Y8bh125XY3zUe9E0QbBOkN4AjE93L6E6Zs4c3cry9CEylxNwPbt5bY/BbM/kMy7+VkCF1CulsUEnNRTV0c/+nyQJmUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805091; c=relaxed/simple;
	bh=K/rLWEjDKkHsJ9bxXPZI9DKSp87tpARRFywudt2h+mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TqkqHroJQRWqPoicPqjYNxSqAXeIO+HEA1xE7vUCw2j4iKuG6oXqvExvp7JuKDQFK6cPO4LDBkoao9VLr8K7j0KsU9iQk1CmtvQ58wpVjEY6MBdQaa1mve+iJ+4TenjDspg6ddif0upKdz/ZuJ4LPtEfrKKMPrFLwdSX0ioOMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=A0ve1CZ4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="A0ve1CZ4"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ea19f412aso3129611f8f.3
        for <linux-fbdev@vger.kernel.org>; Tue, 26 May 2026 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779805088; x=1780409888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l0tXTe0JtsE6kljkXV/yKiUveLQAvzo0OxqjuzKVB0=;
        b=A0ve1CZ4jaWuO8xcusGXNMNBA8d42OWSykl4/E6IwkelKM+VKtAzjkDU12GjSD+1Jb
         5q/JMMyspYGwN0dmf60lTnxKCWglUbJXmQ0Sf79syIzGHlzSQz654qhqqoEtx58/27Ls
         j0KnelJs0llTw20KlZmMw9F258h/iEHdNQS4nUyUtNuCsb4vbozI4szw4TIJ+gYLJLBQ
         /jUDaiXKopkYUoI/oasNEUP5aaNAnbwIpVHXwb/LpcOwvg0YqYbpfymevUfEELVbDm9E
         GBaZ+amJPKbhQxCroDn5ap1vKpoGkEjarQAwBYc6NOhUHl8f4XNo9iMB2/CNpXny0QMr
         cbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805088; x=1780409888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+l0tXTe0JtsE6kljkXV/yKiUveLQAvzo0OxqjuzKVB0=;
        b=N2LcOp2Dz/+q8d39KD56NkzqzzYKTNag6jrzzFJav8TDOhqy0VvmGHsuKf7OjUwQMS
         5RKtLveSagwPMHqyMDd3h5G+SGh29FRBrmTTVObk4Ikkm57xvUd3IjUGTpfHeAf6rdsj
         FWtm/gdSjuwv1T8HqX8bbWjXo8zbqb1AB2FJrgzbg+GGvC9QLFB+f/j24Zvzt+P17qx8
         eGnR3dXTMbQGbFy7TmJ59ERjmN7+RBU6n26QQZg5zEixqq9v2gjhXehE3EWTDKENQ5zy
         F3Hf9DzvlurZ7Wy1rwtFMYLpb50ZpvfuszmqwsqOo206Zzz5VyaYp79zgv/YV9urEwxZ
         h47w==
X-Gm-Message-State: AOJu0Ywn8anplmfnsq9vhc4Ik3C/te4k6mwHm4S9q32/Arre02fs8sJ0
	4WvNBxTdQa7zNnHAxPiQCowMNcw5j3OA4OGza7q1iMoOmkff52inWoyKMR3CN5ncxMs=
X-Gm-Gg: Acq92OHi5jWvr46TRk23pvx+mFNbhWiOI+yl5nIQwWrlRc1Gu29oi5OvsCSwCTLpWHv
	+uRmHogCFcH5wZZpFmT7dAuxHpOtesnBinq6UXw4hBGXexcZkZMy+ZcxBkOdUvp+viC3n9uwI93
	1hOle3mw2KizGg171Nwb0KnJABcH3rWWYZlWpVdgMpcMvZ9VA5Qth7JmSb/RufS9ZaNAwvfHWUs
	bIpgNMxz/Osys44Sfx0sNNO20/KRbXIdAI3KX1ZzyFck2L6YBTDEIM6iH4y+qEbMJpnQaEUzTkZ
	L3yTr9ZRXncwdXCdBQ+JlTmEvSp/FNxsuOq9Aw5LrsBgHeNGiPBE9FzjdginUSl2EnLZdBu9NN0
	xzU+8o1+bzgh8BTARUAPMyU162Mv7P+xp6HFfolgLLG4t7kExzOQdarBQYPsng3tf4gjD+ND6la
	Kny3k0CJK8UAcZdn1dWSeJYUrJwe8xxTMoshRgTofJC3cuPG3qcuu9vjS2VofySm5VN3Pi8I84a
	xMyiR842FiljR8=
X-Received: by 2002:a05:6000:2003:b0:43b:4136:1e6f with SMTP id ffacd0b85a97d-45eb38e4b46mr32569170f8f.38.1779805088108;
        Tue, 26 May 2026 07:18:08 -0700 (PDT)
Received: from localhost (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de. [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45ec7fcd7f9sm22348657f8f.37.2026.05.26.07.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:18:07 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 8/8] video: cirrusfb: Make use of struct zorro_device_id::driver_data_ptr
Date: Tue, 26 May 2026 16:17:34 +0200
Message-ID:  <72b515651ab8df2f464deb620fd7b24370d6fb1a.1779803053.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=K/rLWEjDKkHsJ9bxXPZI9DKSp87tpARRFywudt2h+mw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqFauKEYSHWUZfQM/7o+z0zP1g8ExpBrH3mhgHl +PAjlqxotOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahWrigAKCRCPgPtYfRL+ TiO5B/9L+NQiEbboLQhnRBDWb9kWCznt9081jTJD52DjSXIbOimq9lDExC1+m0zHI2vR23OtAz5 rYKvMs5BII8C3sPjydO9HflKm+0HGBoxNHyFcBRx7nMD9YMRu0oEL1KgUF5aYOJDw3EZHWDojMB lD0vp9qtN/T5HfKs2Sh/ySwqhx90V07yB8/WO6csBHNoZKyJ5crGE/3+EXpuwm9iLdG7ro9/WqW 252nXum67dBmt2ECelLNWuOkHKOPjUDQ82WHUAqobOpqwWWtT8BqDC/PsBofb8nn9ZBDxydS9Eu V55nk2HDzDn0IRAJmoktE3+whV9/arrbjN0Wx39DREREqzRp
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Usage of .driver_data_ptr allows to drop several casts and so make the
driver a bit more type safe.

While touching the zorro_device_id array, drop an unneeded explicit zero
in the list terminator.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/cirrusfb.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index 2693b5cc053f..7e07e775b393 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -321,25 +321,25 @@ static const struct zorrocl zcl_picasso4_z2 = {
 
 static const struct zorro_device_id cirrusfb_zorro_table[] = {
 	{
-		.id		= ZORRO_PROD_HELFRICH_SD64_REG,
-		.driver_data	= (unsigned long)&zcl_sd64,
+		.id = ZORRO_PROD_HELFRICH_SD64_REG,
+		.driver_data_ptr = &zcl_sd64,
 	}, {
-		.id		= ZORRO_PROD_HELFRICH_PICCOLO_REG,
-		.driver_data	= (unsigned long)&zcl_piccolo,
+		.id = ZORRO_PROD_HELFRICH_PICCOLO_REG,
+		.driver_data_ptr = &zcl_piccolo,
 	}, {
-		.id	= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_REG,
-		.driver_data	= (unsigned long)&zcl_picasso,
+		.id = ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_REG,
+		.driver_data_ptr = &zcl_picasso,
 	}, {
-		.id		= ZORRO_PROD_GVP_EGS_28_24_SPECTRUM_REG,
-		.driver_data	= (unsigned long)&zcl_spectrum,
+		.id = ZORRO_PROD_GVP_EGS_28_24_SPECTRUM_REG,
+		.driver_data_ptr = &zcl_spectrum,
 	}, {
-		.id		= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z3,
-		.driver_data	= (unsigned long)&zcl_picasso4_z3,
+		.id = ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z3,
+		.driver_data_ptr = &zcl_picasso4_z3,
 	}, {
-		.id		= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_REG,
-		.driver_data	= (unsigned long)&zcl_picasso4_z2,
+		.id = ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_REG,
+		.driver_data_ptr = &zcl_picasso4_z2,
 	},
-	{ 0 }
+	{ }
 };
 MODULE_DEVICE_TABLE(zorro, cirrusfb_zorro_table);
 #endif /* CONFIG_ZORRO */
@@ -2208,7 +2208,7 @@ static int cirrusfb_zorro_register(struct zorro_dev *z,
 	if (!info)
 		return -ENOMEM;
 
-	zcl = (const struct zorrocl *)ent->driver_data;
+	zcl = ent->driver_data_ptr;
 	btype = zcl->type;
 	regbase = zorro_resource_start(z) + zcl->regoffset;
 	ramsize = zcl->ramsize;
-- 
2.47.3


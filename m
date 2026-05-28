Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15463285CB6
	for <linux-fbdev@vger.kernel.org>; Thu, 28 May 2026 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976317; cv=none; b=tvuYlh/oaNd+4+c1u3gKbsNuSlCRkfmrvKwMgO0yZ/PJZ2GsCaV/w3C5BdzH2FVQPuKUMlXfFtMsBUr4bTSWxXVa3DweDdB+7ZaITM1+gFk8A1sBohNOIdDcUoVxuFcFcLtQ47i4uUhFadG3JyyDciP1Qtp2fs68IzNDo10IdtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976317; c=relaxed/simple;
	bh=GVDB20doAR1K3eUlSf2alRlQ5pVPpRgTdHeEwbkCl1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcEFUEft5Uq1p5AXjT5c8K3gQaUao5t2/bXyJvt3d1+XVaYOzX9QC0HDGUOqwlPBJrhJvzFCT5CtMlRp2M50rVTgmKd6YD6sgoc9n++qZ8qadrdws6WE3FHmNFPuvUdGETTXU9245815x9NP/FdvjS+mamQFLIJqf/2whw+CoXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM0NCWkf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM0NCWkf"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bce57c132b2so2287787266b.0
        for <linux-fbdev@vger.kernel.org>; Thu, 28 May 2026 06:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779976313; x=1780581113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RF2xk6t5S9a3BXZ1svw/IWrQWbafQA9obLcpKPhSUU=;
        b=WM0NCWkfxxhAP1fs+Vo6mRLqj6NIobz/HNMMMFa+sRnSMxYkv/45NnT4Smn4bmOIVK
         KO+Qpf4eTYFykEuHrLoKOpIqvv11vwJBmKUnX77F9J9UC2x8b+ulhQLf3xdCsy6GMHke
         T1qZTr8x40LTNP3rixwb5g9MQzcMwrrBc1XRv/8DCe57fPbgTH0r+lz48UnUKGNDjknB
         /lNNdYQ3Z1/XyKGFvL8Ms2xg88uTaKaN9pyFuk01JIELKWVVmWgPQkwcHXPRbuxqNPeM
         Ls3k5okZp2MAEviLQbi+G1VIeL9umYlji8BxGasjL94HP5QCOl1qMVIPNzliRQkOZqAE
         wB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976313; x=1780581113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8RF2xk6t5S9a3BXZ1svw/IWrQWbafQA9obLcpKPhSUU=;
        b=I36w7inRd9wKLgbTMOJlGnmDYZkGKGcfXpoTCA0Oknku4lJtCXKOEQID+CeGmVDGKW
         EE0n1jdTqh714+p0mqIiF6ifsGRtcuE0KWfP+PqCs/9FiBiFTvObP5y038aoAz/SdQoC
         F7gbP5WPPJPGKnmOrrsel2ntMDfZCFnaiQluQvPERPr+oR20WqCOQcXasqL5h1iO7w2V
         aS9RuRVBGI/UQREfzdo51lMdbaLie4VC9GFyJ5jxlMKF/hm4KurLAO0UC3TxUJZ776Km
         EjtG3p1csIXqr1O7Mwbgn0FEJ6qBEIw8V9jj/OsGTjb2QkdvMSqV4qxXPKjOTefFf+CC
         drOg==
X-Forwarded-Encrypted: i=1; AFNElJ8LnAbcZ/dy/GwlqIxue8ExqI0Q53PeP2nAoHvD/1fPnte6fBrPTFreLhRwUXeAb5dy2asDXafjQ/4G0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAcCkJ5AQ7l7iO7byMAApOix0Zf1+KzJVU6KvycTpxg6GFo8Ed
	Bdp0EkIWULDJbyAPi/ZOKWomlE142Jxp9hIsxnZ6mZ+Cnyr8opVdl6iw
X-Gm-Gg: Acq92OHRxnXQbRp0jC5U3lIPBpeoPmaVdFZfqZCQpHpiz9W8b3nApmlnosrvQmrSgCh
	mLuE4qDhUu6Qsu/AB3OVQEGWhI1Db8OS0mYztAadEuGG/g6gcTrGON4UqWOngSComva35vDTYSF
	nLqbD+9s4P5uTnPhQ1LZWbI3jCrRqArza2sj7NXiAV+1C690u3mKrWc4Bo+f/8/Jo4d9njNUCGI
	5q2jVMUBjbEcZIO1u6C6hYGhButNl1sD4Uc4ntjAMz9RplmC9/XP1z0tdRpcnDc/9B1FnlaC9Zb
	50kyqXMu4FH7k3q2e1nhiW4vlDxbxPlNvug70ub5U9f+0kXEO5ecngCc7qumsvwcVRhR0kAnWnx
	kH557oBggoGfYASPgcveQ2NUp9dBs0R0Ii/p5xOt9q/7Y6e+FaIq/g+hX3QedMTWf6tlBe5QF2W
	uwcg9dEqh9HO3hbDDLaljfXVUnQGiOPqgq9g==
X-Received: by 2002:a17:907:1b06:b0:bd5:b27:c02e with SMTP id a640c23a62f3a-be86d71c01amr114017466b.6.1779976313029;
        Thu, 28 May 2026 06:51:53 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc65da3bbsm723636566b.52.2026.05.28.06.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:51:52 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v2 3/6] mfd: lm3533: Add support for VIN power supply
Date: Thu, 28 May 2026 16:51:20 +0300
Message-ID: <20260528135123.103745-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528135123.103745-1-clamor95@gmail.com>
References: <20260528135123.103745-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for 2.7V-5.5V VIN power supply.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c  | 23 +++++++++++++++++++++--
 include/linux/mfd/lm3533.h |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 8495e9119871..519f8c16a3f3 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -17,6 +17,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -164,14 +165,25 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
 	return ret;
 }
 
-static void lm3533_enable(struct lm3533 *lm3533)
+static int lm3533_enable(struct lm3533 *lm3533)
 {
+	int ret;
+
+	ret = regulator_enable(lm3533->vin_supply);
+	if (ret) {
+		dev_err(lm3533->dev, "failed to enable vin power supply\n");
+		return ret;
+	}
+
 	gpiod_set_value(lm3533->hwen, 1);
+
+	return 0;
 }
 
 static void lm3533_disable(struct lm3533 *lm3533)
 {
 	gpiod_set_value(lm3533->hwen, 0);
+	regulator_disable(lm3533->vin_supply);
 }
 
 enum lm3533_attribute_type {
@@ -324,7 +336,9 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 	u32 count = 0, reg;
 	int ret;
 
-	lm3533_enable(lm3533);
+	ret = lm3533_enable(lm3533);
+	if (ret)
+		return ret;
 
 	device_for_each_child_node_scoped(lm3533->dev, child) {
 		if (!fwnode_device_is_available(child))
@@ -493,6 +507,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen),
 				     "failed to get HWEN GPIO\n");
 
+	lm3533->vin_supply = devm_regulator_get(lm3533->dev, "vin");
+	if (IS_ERR(lm3533->vin_supply))
+		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->vin_supply),
+				     "failed to get vin-supply\n");
+
 	device_property_read_u32(lm3533->dev, "ti,boost-ovp-microvolt",
 				 &lm3533->boost_ovp);
 
diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index 3aa962d4c747..d751773fc92d 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -21,6 +21,7 @@
 struct device;
 struct gpio_desc;
 struct regmap;
+struct regulator;
 
 struct lm3533 {
 	struct device *dev;
@@ -28,6 +29,7 @@ struct lm3533 {
 	struct regmap *regmap;
 
 	struct gpio_desc *hwen;
+	struct regulator *vin_supply;
 
 	u32 boost_ovp;
 	u32 boost_freq;
-- 
2.51.0


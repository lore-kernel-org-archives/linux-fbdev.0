Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413AB311C11
	for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779003821; cv=none; b=U5Ga4vSG9TY6JOOS5GO4Rin2o64GUyqI56zArz/W41WOxzrVIPKNWy3/hEtITEWR09nSJaL3i5BJim9WfJPcGR//owfLWhJ5ayMJLKA2PDEB+nTr5hogzP4tWO34xCMtOj9RDsk49gSxOiOuG2tZCWrelK80BiItCssm/kJPdBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779003821; c=relaxed/simple;
	bh=SomMXQMUuqQ9puJg/elt7woziBoLt88xB52B85k+sEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEUoXBzrUMGUnGVTZGJnJVe9KzmVNRRopstchbpsgJ9bD+BZErldaKzi5DZY6g+dKnLMjfUOQLeDI7Hbdn1NF1JkPOgwDITXvYQzGxmayyOmuxn0MHg5teuc2Wm6rRPZcy8QpjC3TYRk4k+asYJGxcwRqfy3Vxkib4qP/tEMhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoDyHsT4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoDyHsT4"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-459bf19e87bso598532f8f.1
        for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779003818; x=1779608618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKwCpCIE3pQrKMIlzgxzd9zVO2yq7zSfHES0U3paVng=;
        b=UoDyHsT4a7UV/Gb0gAlXcvRfHdo7Ew1to8uN5nhoK3wkNKvSpuXcN8ybuPKGgXJ5Gq
         F5FygrKjTfVoDpq0gMCEVUmzZLn0myik+tK05B1huvBePkSSaObfbuATBKElDZrJaCuV
         NzwPrDcB69NMYJ1VWPT457YAtcvRlfgRwhdzwcw1Nuq/DpcA2P526bSHLcfrwwaNhUgt
         QykMeA1sE9/zo/OeBe85N4uHmvc3evI0S/biiXAiQGSgsb7YVEnsILf3K+garNYvX1MY
         jw2tJgVpZQYHmrnNrRhADBjE7Kj9EsakvKDWiH/HDzf6Zymy4fT91NbNn2VEUVN3p8j0
         5zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779003818; x=1779608618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PKwCpCIE3pQrKMIlzgxzd9zVO2yq7zSfHES0U3paVng=;
        b=kBmqFgUtSIImHDfhQglRRdgZvchlq2q4bGSCJ8D5fhCX2WiARR0e0TCt3CusToJB2H
         HDyI1yRlAfx1NOFXMrhD7HIESkO2T90vDuHicfFFA6k71LtRh1o/7UugruGMLHOY1AcE
         7XYWPgvgWarMcyXr54noX3/7SlWk6mqzcRw5oOY9s6ggQPwqg1BHB2JzCP/8lCXIrJrv
         gDMHYnoReZmqZvaNZL64bqKWUmr01sb2I4Zx8MbOmofIkdZt1kRb8BNaqlU/g0Usunjf
         sEKBYmZjy/9d0BEVwJlc0IGrAX2KsTSc8FiV6b7Mrmdxsfk6NTs/NzY17hVuLKSPyy9h
         LJxw==
X-Forwarded-Encrypted: i=1; AFNElJ9Sx39nrFW+OAYA9sWdewMemPtGZwviKipkTStzHBIBRmJWdIXFGwNNJLZAVETqXoylDpchnlVTh1n7Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4RS+9QR7jIqXhy6G1DdgfsbIqUsJG4tdkcS/5mXXQsHrT1e5
	I+mozj8kTnGRJnJjbclk2IaUaUTpCbtvZaPorfACMBS6qO5Hf8YthpY2
X-Gm-Gg: Acq92OG39NqVOUSC1rdIm+kVGeg9rCGKJD7RSpvGn0VBCj8z6ZAb/lzoZKDBTLSzo2D
	FpLwHzlwjnpq0zrrW0yPkhHoNc3RKSPLlh7UlgH2UsF1hljioTCyCDGW5Gt9h/JnaidlwpRyC66
	NJqk5P9koWRYAKOz5GXq5eLgvOX0D2s/6yjUtaZXsgRtj2vc9kje/m+gNbzu9eup/xlOc0Gi/aZ
	uFDk4pb5kEtcKlxoTpf8glHyP+6ZT+5gUCkS70G90AJ3sfmFHmWwxkAW1DpTQeOd+HT2l28VKYM
	QSC0jlQmAicnsJESokwzC2KH6/ocLscttVZc0ZobQ/WqHtdGgwQqvM7mk00ibwPdL97133LPIkP
	QGFTqbo2u3EeHxyWPD0xlfvy3pqsuGbpIof/fx8UYDoEdhAc0O9CAT3f4GBMuWmkCAE6NguiS8c
	Dlri6nqCZeEpWH
X-Received: by 2002:a05:6000:2508:b0:454:9655:43af with SMTP id ffacd0b85a97d-45e5c30d598mr14636187f8f.0.1779003817436;
        Sun, 17 May 2026 00:43:37 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm27512864f8f.30.2026.05.17.00.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:43:36 -0700 (PDT)
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
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v1 4/6] mfd: lm3533: set DMA mask
Date: Sun, 17 May 2026 10:43:04 +0300
Message-ID: <20260517074306.30937-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260517074306.30937-1-clamor95@gmail.com>
References: <20260517074306.30937-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Missing coherent_dma_mask assigning triggers the following warning in
dmesg:

[    3.287872] platform lm3533-backlight.0: DMA mask not set

Since this warning might be elevated to an error in the future, set
coherent_dma_mask to zero because both the core and cells do not utilize
DMA.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 131eb1a1c8eb..c7914afd564c 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -499,6 +499,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 			lm3533->have_leds = true;
 	}
 
+	/* Parent I2C controller uses DMA, LM3533 and child devices do not */
+	i2c->dev.coherent_dma_mask = 0;
+	i2c->dev.dma_mask = &i2c->dev.coherent_dma_mask;
+
 	return lm3533_device_init(lm3533);
 }
 
-- 
2.51.0


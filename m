Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE7184544
	for <linux-fbdev@vger.kernel.org>; Fri, 20 Sep 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853614; cv=none; b=kfLWYZhde/V79sGDfHoB1Y3qwUX75vW3LbrImtBi+zPUH2penHHchzROAhTqXqCfn44/zfBx1BU+tOZq2tjy8uHZ1vOUba/tOZUgLAm1PLoJEKekiK5tCmb3+qLSDp7I/TkWNGRqvI/Ur5h/qLJysT+mMHF7qUJCri4CrxLMRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853614; c=relaxed/simple;
	bh=MT8c2AhQeYsYs8cmaeLRhGYDwFnuTuG5PMmK88lsU/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NsjvXQWSMquAXEiJ3+WKPSySJOjFmF2AFpkVgxyLORs5jTbHElrzaoSwRbLFe1c/PBIRvD3J2Cxk0vRFP5LnH2biXHyUDaBI5mjSG8ZXptFhH+kMGRu1UOdh5+NItCWLLeriAJYQGjcLuCxz4gmxGz7XdwJ4WGUSZ/H4o2rxYi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aQkYC+x3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aQkYC+x3"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-378f600e090so1372714f8f.3
        for <linux-fbdev@vger.kernel.org>; Fri, 20 Sep 2024 10:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726853611; x=1727458411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvmqOfkNyg3mbwnmFu/TPFnKJdY4EPfohFTJPCL4F8Y=;
        b=aQkYC+x3nmYkQiwfkLLlrAY9myG48sneyTRn7dc8Vlb+2yhglq7xGY+jPiyVvA9AG2
         Bxwvhe/gt5rnLT6F5fELA+/KKT7yM3ZBnVK2xr+bzXrSpd6Ry6SqVEwEAeSIAW38LMNv
         LkDENwkjdNTrmsMahz1Y6CF6i1bqnBwSUiWecje5190/JTP+LrzXKX52DmSb0yGNn8MR
         Y+YnbmjxW9EhaH/jYyUPAQ2Dp93f7zMsOG8F1NmVwFYt7yu2kuCr260XTd6lXa76XXUD
         T90eNh23Xs58zGtIWJO5E+cdBPVFW1sHPGhDbDg0vC2ql0BibVWoBvLoX8tl7QRg40tC
         MYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726853611; x=1727458411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvmqOfkNyg3mbwnmFu/TPFnKJdY4EPfohFTJPCL4F8Y=;
        b=q4CM4Pn8jDIqkirAfys7FZF9Uz4aqKKVrWPyvI87RYi2diEKKZsMdKlBditjHzbLkC
         /BbwXTPID2gWRjdInJcJIcvbMGCsJVfO+ytK59M6JddpwSCESVtId7VRZf4td3YjlYJ6
         wgF5yKOcyeW+oSBeUdVIVW30QJsXRqMPuqbV8COunq0rIi8i3ikPB6IikbVeyPc3m8A5
         fHI4yomrO1c6HwG8i94QhM2mMskP92sOdXL2HXRkxpa6qdWi0O1rDiKN0EDabCcYI2D2
         mOf7U7B8aO0OF5obU8tdy4kxbNytTbEXOHglsWB0oSZgAnhh/qOoV7t+siifOxZQRxe/
         zGhw==
X-Forwarded-Encrypted: i=1; AJvYcCUsZsvIGNzm4xSqkofGarSSQfFLNsMr/JH5V6ehSXnaO4eZZOgSK1yxQ9i436cp3cqSTNQt7Rern4bWIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09gURIpWYefWwBBB5b6dZw7IiUmJLYZ9JvltuuiQKzrlVlCb6
	h5muzuKbsuvo7eU1uWCgO90eVFx1yOmnNLjV5P7U/ksR1F+NFSl06miaUl+7+UyNGGG/sQR/mfl
	V
X-Google-Smtp-Source: AGHT+IGelVRMsQTQSU+xPNgg15Ho2GXpbX1Ln0t5hXane5n5dnYSSMSr6M1qKp+vzCMN00YqqNJH7A==
X-Received: by 2002:a5d:64c1:0:b0:374:c3e4:d6c5 with SMTP id ffacd0b85a97d-37a431a7142mr2209005f8f.57.1726853610516;
        Fri, 20 Sep 2024 10:33:30 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e029sm18111177f8f.116.2024.09.20.10.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:33:29 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 20 Sep 2024 17:33:25 +0000
Subject: [PATCH v2 05/10] iio: adc: ad7606: Sort includes in alphabetical
 order
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-ad7606_add_iio_backend_support-v2-5-0e78782ae7d0@baylibre.com>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Michal Marek <mmarek@suse.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 aardelean@baylibre.com, dlechner@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726853604; l=1335;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=MT8c2AhQeYsYs8cmaeLRhGYDwFnuTuG5PMmK88lsU/w=;
 b=RzKFmBn040UGa7yTM6JsY9KvnbH6tbRt6zQy0B5hwTYpOEClvNSZL5i5J1VqCH8LtQie0TnTj
 KJNP6vwN65QAQSfYhmEy1TLwWy0uoRdjGXz0EvvNOQOcvsKe8ZRPfaM
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Some of the includes were not in alphabetical order, this commit fixes
it.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606_par.c | 6 +++---
 drivers/iio/adc/ad7606_spi.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index 02d8c309304e..d651639c45eb 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -5,13 +5,13 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
-#include <linux/err.h>
-#include <linux/io.h>
 
 #include <linux/iio/iio.h>
 #include "ad7606.h"
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 62ec12195307..d3fbc7c7a823 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -5,10 +5,10 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
-#include <linux/err.h>
 
 #include <linux/iio/iio.h>
 #include "ad7606.h"

-- 
2.34.1


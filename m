Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793D7C25B06
	for <linux-fbdev@archiver.kernel.org>; Mon,  8 Aug 2022 10:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242809AbiHHKsI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 8 Aug 2022 06:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242708AbiHHKrw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 8 Aug 2022 06:47:52 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5902726DF
        for <linux-fbdev@vger.kernel.org>; Mon,  8 Aug 2022 03:47:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id w15so9394351ljw.1
        for <linux-fbdev@vger.kernel.org>; Mon, 08 Aug 2022 03:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wtlxEtiRF9lqCy5R1k9yAeU8U13bw6nu384fYfSEqBw=;
        b=jv07OtZt2pyX0cJM44iITqxyodBbbHPDRiX71FoCVjTJ9XCj3HKpzDLaprbvsELIsH
         8GL8/jtjYb35pkZPiQn9Lrw8gkvIPe6INQik7whWlNe3P5KQeRDPb4WaK57tNa3zLaCA
         ncJc/TMltNRL+gsmrkJzoK5WLoL6MMGMjq05iKT5IFN8IPyzgHo+sJ9MUEu/A59RWVAm
         Ws2EiUwUDHptJP9HHb5q1V/fpZXAm6yqLaT3F4zsviTvFNol6Q5gHyV9mt4RpzFMB0AX
         NdBK/lBDAvz5fQnS2Yac3mIUt+j1+m3t3jp1W5c1zky+9sdQlLU2sKwrN2W4I76YbhVn
         l+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtlxEtiRF9lqCy5R1k9yAeU8U13bw6nu384fYfSEqBw=;
        b=lmSKM+qPBjQye6clZaITXjD+P5XVNhsxSGsAqeP9q6pagsIkWQSsxUT7iNDoDs3zRL
         Yas8qQIMbkSWvUTcS1CK/rIA5eMt9i0WTQY2FnCxfi/+NPZFgVHxaQeXaI34vKWbYFt+
         YN7O3QD3yyDp/7O1o2zUGwBDXkPscs0gikx3Pw8bYoXtE/fslP1Ct0U9DFR7rtAYDYVJ
         xBp9PVz5S00fCDSJqIw7cUnrWM+JH69rdv4+KJ5pCaqVkcWpClvfUXDQddwCdbzJnpAY
         8C4A/oNni6hMxXfazvRB/9BqOJ2q3wy604wOKLRFt3iaINJDimJ4bLigL4HYEXRxC+pw
         1dtw==
X-Gm-Message-State: ACgBeo06XEr8hIMfS484+qGElAjtdjiLp/LfV3fkI0yzL8cyqqNBXM/l
        Xt5X1cbGYnHPR4cqijRErbCdTA==
X-Google-Smtp-Source: AA6agR6t9xJZKEAAv4TIEwAFqoquIJFksglsomLyRD3HG8nsDWNUsnErUldbfkSXaP31ifRT7EPZcQ==
X-Received: by 2002:a2e:9b42:0:b0:25e:59a7:6734 with SMTP id o2-20020a2e9b42000000b0025e59a76734mr5299134ljj.346.1659955667663;
        Mon, 08 Aug 2022 03:47:47 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id l18-20020a2ea312000000b0025e040510e7sm1314321lje.74.2022.08.08.03.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:47:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Pavel Machek <pavel@ucw.cz>,
        Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Lee Jones <lee@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] dt-bindings: iio: Drop Bogdan Pricop
Date:   Mon,  8 Aug 2022 13:47:09 +0300
Message-Id: <20220808104712.54315-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220808104712.54315-1-krzysztof.kozlowski@linaro.org>
References: <20220808104712.54315-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Emails to Bogdan Pricop bounce ("550 5.4.1 Recipient address rejected:
Access denied. AS(201806281)").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml
index 54955f03df93..ae5ce60987fe 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Texas Instruments ADC108S102 and ADC128S102
 
 maintainers:
-  - Bogdan Pricop <bogdan.pricop@emutex.com>
+  - Jonathan Cameron <jic23@kernel.org>
 
 description: |
   Family of 8 channel, 10/12 bit, SPI, single ended ADCs.
-- 
2.34.1


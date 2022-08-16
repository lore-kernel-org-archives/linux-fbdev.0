Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9444FC25B0E
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Aug 2022 12:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiHPMpC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 16 Aug 2022 08:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiHPMoa (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 16 Aug 2022 08:44:30 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C9F1EAD5
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Aug 2022 05:43:50 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id by6so10378584ljb.11
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Aug 2022 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=G58v43xma03waMnam16LPp6PjErsC4YB3W0kFW2yXEw=;
        b=wKykd0jfLa6ln6qzngmN0KmyKxnB3mosydffrjPYx9Dc42pwXbyrKrPJ5f+2viL/uN
         V8DhsuhKnyFH2c171npQA8uT6gJ424HduMl6o3VWiHjaxTBKz7BB+//h3IodFxA1IIj1
         qcs8aExwYFZzC4pvkmXXX5TltdPDSTX/zR2BWQaXzrIPJWkSwc0jiUKHfQtwTSOhOKHo
         snKWosUECw4alp46ZG1TW0k+Mn2b6yI+2CLfOscs30sff+KFgbKEZNa7Vw/gr/0h7neC
         uiMV/LfYiotjKBC2fvQnRmjTYr3ITLaAx8Q3boWs5n4zBB4XGQnJiQxndtwSf77gSOhd
         D6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=G58v43xma03waMnam16LPp6PjErsC4YB3W0kFW2yXEw=;
        b=sFxCnJwz3d91lGmY+YrNEVbKP48Z9JpVLkXwrNr/uVgRL02JIUNG+Y9rMkQH4ItEYX
         ytyKmH3F7JCLHY7Mjr7ue2tPGOlOJrAx81HosBY4lhEJy7jnS+6TcGhWiKWvrma/3hPm
         WzOk8XjFeP0Y4305hBKcXLGegN4YE92rrg8UgzYedSiMCFV0b4aIR48bflWikop3cvyq
         8lu3J6U2N8CIqr2VG9+K6MEHGxGiNs8+DJM92Mpyh9+4E0trpupeRyj0C2msoo1UiDd6
         Q0Zp6zPtssCU3tsyC+++WE0pO5TDrqniTzOE8VJfwCOFadAUxQjkhb9+37mV26ms/7t3
         ITUg==
X-Gm-Message-State: ACgBeo13tqJXJYGz2fMqAwzpgr8C90ZLHKathfCReV8B9GUdNVYYznPe
        81SDTWbxVmLIjzfyHrXakzRZsA==
X-Google-Smtp-Source: AA6agR5tb5v0bJLxFO8Z9+DLbjoeqY7kklBphXZZiqNll+gANwlDrXqM6VyVQQ1ArfEiVkuFcaLicQ==
X-Received: by 2002:a2e:b88c:0:b0:25f:eae4:74ff with SMTP id r12-20020a2eb88c000000b0025feae474ffmr6817912ljp.48.1660653830207;
        Tue, 16 Aug 2022 05:43:50 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b0048ae4cf8a2csm1374331lfo.258.2022.08.16.05.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:43:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andrew Davis <afd@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 06/10] dt-bindings: iio: health: ti,afe4403: use spi-peripheral-props.yaml
Date:   Tue, 16 Aug 2022 15:43:17 +0300
Message-Id: <20220816124321.67817-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220816124321.67817-1-krzysztof.kozlowski@linaro.org>
References: <20220816124321.67817-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Instead of listing directly properties typical for SPI peripherals,
reference the spi-peripheral-props.yaml schema.  This allows using all
properties typical for SPI-connected devices, even these which device
bindings author did not tried yet.

Remove the spi-* properties which now come via spi-peripheral-props.yaml
schema, except for the cases when device schema adds some constraints
like maximum frequency.

While changing additionalProperties->unevaluatedProperties, put it in
typical place, just before example DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/health/ti,afe4403.yaml       | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
index d861526c5c42..6c5ad426a016 100644
--- a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
+++ b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
@@ -25,14 +25,15 @@ properties:
 
   reset-gpios: true
 
-  spi-max-frequency: true
-
-additionalProperties: false
-
 required:
   - compatible
   - reg
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
-- 
2.34.1


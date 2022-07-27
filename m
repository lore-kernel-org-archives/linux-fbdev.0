Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3065C19F28
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jul 2022 17:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242228AbiG0R26 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jul 2022 13:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbiG0R1l (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jul 2022 13:27:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBCD7F525
        for <linux-fbdev@vger.kernel.org>; Wed, 27 Jul 2022 09:47:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t22so21550324lfg.1
        for <linux-fbdev@vger.kernel.org>; Wed, 27 Jul 2022 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZf4OdbV43HHtgf1qVIKge/GbJKtAf7d2TC+uXlE1iw=;
        b=unFrdwkByedm1Cx4IG8Ku7mviSYROrujqG4UjXQkiG0xYgsmJHR0xO4a+bYbYW/PwS
         +BpCE5BwASL4enlWpSc5ChcanRPNkec78zKAkoqgkfIfM9juO9yFiudCpM2kK2iiVUUN
         vcX/bOW82bpl3sEJt8lJ4P7UjpNpPGtSmZmxIhjeBtOY/lI5Pyef+zmEyrN7JnZwOT2v
         5ornAJUjWzhOFUJ2FsEA+6X3NuHvsDNA0boK2iaiU45J721qkxkd0KE7vpsaUxk9VfAE
         jbFm7EwWypt894KHqZaTBTjDRfbDhf2/nLsKWfjp3UDMIHwCK+Coy4qvG59UqItR52XE
         A4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZf4OdbV43HHtgf1qVIKge/GbJKtAf7d2TC+uXlE1iw=;
        b=yanpKHu5Kx0fu/MznR06f9MBQ2PyyiwzBMgHV5nMGykMXbUIE3xr5cRl22xoy1ggU0
         9DvSjcqHLleM/6nhPqRsvn1C+cTOQJnJjUhYBJ01OJ9Ah4iDpTpT+i1Q8ppQxdofEO3m
         s1LOpcTuhZF6YZ/jgpF8Y6FeKWKigtr5ivPzNKVoyI0x3CGMFIHyztMSX9ox5bG8EKt4
         YeApSKzHaQqFqzPKsz/Lr/m3whLt83CexQFTe4bpepqY5o0VrkwBDlJdEUkPFXaBCLPI
         2qnWTOapm8oaHuA5Kir2bwKj2tF+btkAY2fUWJXGmlzR1sueOC6+aoFxcfT5YNMfKKKM
         ji1Q==
X-Gm-Message-State: AJIora+8m1wvy75CJE5dwlqvzSc+3lr/B2jnzMeBnevDGhUuf/c7j0mp
        y/tL4uqXy9tm9T6SdYiDVvlgnA==
X-Google-Smtp-Source: AGRyM1vk2lUU2rIgm+Qs7fiV5lfej9Y3jJ3qYGukgFmUOo3/tcHiuWVrQUOzvf2yUdGjOtEdYb/yTw==
X-Received: by 2002:a05:6512:1287:b0:489:e488:950f with SMTP id u7-20020a056512128700b00489e488950fmr8402948lfs.440.1658940436717;
        Wed, 27 Jul 2022 09:47:16 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048910301774sm3375149lfz.307.2022.07.27.09.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:47:16 -0700 (PDT)
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
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
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
        Bogdan Pricop <bogdan.pricop@emutex.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Dan Murphy <dmurphy@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Lukas Wunner <lukas@wunner.de>,
        Robert Jones <rjones@gateworks.com>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 05/10] dt-bindings: iio: frequency: adf4371: use spi-peripheral-props.yaml
Date:   Wed, 27 Jul 2022 18:46:41 +0200
Message-Id: <20220727164646.387541-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
References: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/iio/frequency/adf4371.yaml         | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index 6b3a611e1cf1..0144f74a4768 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -40,15 +40,16 @@ properties:
       output stage will shut down until the ADF4371/ADF4372 achieves lock as
       measured by the digital lock detect circuitry.
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
   - clocks
   - clock-names
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1


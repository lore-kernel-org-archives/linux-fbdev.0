Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC0CC71131
	for <linux-fbdev@archiver.kernel.org>; Wed, 18 Jan 2023 18:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjARSpP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjARSow (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 18 Jan 2023 13:44:52 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32F2144A3
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Jan 2023 10:44:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b7so8906101wrt.3
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Jan 2023 10:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBLmBnkzTzMlrNoUUtLpd8YSr91NAA0vKXbUP+pU1cE=;
        b=rVmsHtANIVjhani7hCmj3Czh3dpTThTYKA0a/Wa2waiKwX4dquskrLyf+/EgWTNxV2
         /pggI4f6nfbzxb0eGs85evqI3NRrBWUrcLNB5EV7EUBQBT8TBinEb7cLLUXbeV0JB5Sv
         WfgFAW05ApjDiXV6rVfMX/6nUxeI2IFGXB3FjI+rCwnwoD/Wt8B1SffF9NmwrcBXPVYa
         PoIUtaEeVPuj8QVsrWzf9Q0EJ28Wyn5COWEorfXtxuNsiOlFNM4BlpY6p33tTu4Q2Bej
         Jix8P9OaX6E8VQe5QsSOXw7KMMAMp20IHpk5swLgUl1f2UMT3F1ZVD7xHppGuuHoQH+/
         Tsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBLmBnkzTzMlrNoUUtLpd8YSr91NAA0vKXbUP+pU1cE=;
        b=Bc1Bju+6Py3BxbclHwQgN3ghsfYp0Ldl7ezTbIQREDxX/7HXiuSSqQO2zZqgKzzck3
         eb5AlBe881SL+fNrF1X+kzUA7R3r9RuhFgzMYkDFEULZhgZL2oroW1CFMXj+fHbs3Ihb
         FnZDxfBIVO9FBuIQOyDtufWxcgZjqYzo/EksKOgbp78pQMf0MkYTfzbxh/qhlhjaJzad
         IVk8YHsdryN89ZW8SiOa2yN8B3PGxNb/n1Ip+lsrnNdHBD3lOHocF/53uF8XjqB5qF2Q
         d1IQ/qx6Mv7TvX8LLJbNreRO5SIvxnexNz/hXSj0nta4/sC4g6wOqPgztTtBR7cMpxjt
         fOsQ==
X-Gm-Message-State: AFqh2kr2BB7pnc1wa9R/ke8sFv3di7wskigeQfrxaEHOrG9N4Ei3io3O
        wD3ZqCX+ApjsVM5lUiwuEUhMXQ==
X-Google-Smtp-Source: AMrXdXtBsC5D6pQvN8wndvGkEYTgqdGhtTbNREYy3v9NkM+3ifBMW0cexDgFB36rZBrhM7rL1qg9rQ==
X-Received: by 2002:a5d:60c1:0:b0:298:879c:6d01 with SMTP id x1-20020a5d60c1000000b00298879c6d01mr13259200wrt.23.1674067491384;
        Wed, 18 Jan 2023 10:44:51 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g1-20020a5d46c1000000b00241cfe6e286sm31640325wrs.98.2023.01.18.10.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:44:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Robert Yang <decatf@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Alexandru Lazar <alazar@startmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Stefan Agner <stefan@agner.ch>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Harald Geyer <harald@ccbib.org>,
        Eugene Zaikonnikov <ez@norophonic.com>,
        Phil Reid <preid@electromag.com.au>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        chrome-platform@lists.linux.dev
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] dt-bindings: iio: minor whitespace cleanups
Date:   Wed, 18 Jan 2023 19:44:10 +0100
Message-Id: <20230118184413.395820-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
References: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Drop redundant blank lines and add such when needed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml        | 1 +
 .../bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml    | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
index ff50c72c62b5..9eb9928500e2 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
@@ -12,6 +12,7 @@ maintainers:
 
 description: |
   DAC devices supporting both SPI and I2C interfaces.
+
 properties:
   compatible:
     enum:
diff --git a/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
index 00e3b59641d2..d4e09d2dcd21 100644
--- a/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/iio/proximity/google,cros-ec-mkbp-proximity.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-- 
2.34.1


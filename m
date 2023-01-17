Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A699FC678D4
	for <linux-fbdev@archiver.kernel.org>; Tue, 17 Jan 2023 14:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjAQOYi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 17 Jan 2023 09:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjAQOXt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 17 Jan 2023 09:23:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6E440BEB
        for <linux-fbdev@vger.kernel.org>; Tue, 17 Jan 2023 06:22:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t5so26333300wrq.1
        for <linux-fbdev@vger.kernel.org>; Tue, 17 Jan 2023 06:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ybMp4yf1vi88OQah/2tawVPx6umiUGABzCImHyfek9Y=;
        b=hAktI9Hg4DyrxZHcvy3fynCOTVjETjt/zk2FifC5B7sAmkDT4FXNVTJXaFvRyg9+PW
         h2sMPFQ3W1yRaGT+aBC9EA0ARv2xmIhucPJiBWrU2xSjTtShNUjlexnybjRGdA1isVqL
         i23k3jz9FjVvxSxty27+XaeI7X8woahLuf+6fQbOTZInjmiJ0UjpN090asX9M0ecXQ9i
         3ffHvbT74wxs69cCzxFWaTu3U/6ey3kBofZUWIWhvtO5Vy+cVusZ+rglU33M+0CI+pus
         k8P6d0RU0qQMnP19IimHEO0Brxy9Os4KagSi7/61CSOyIpa5focrveqSs7afG0riRx4i
         afoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybMp4yf1vi88OQah/2tawVPx6umiUGABzCImHyfek9Y=;
        b=krWuT1YATOkiXVRno7OW7T8aLGJFpk5a/tWD8JuTlLQpJ0cdd2r4BHd1Q4ypwkspZr
         RYc584iZwnK4SRVYYxKpkZIxh+NeLLg9r7Mnfei4limeqLN8TFSl70/31qdV7AjE67ui
         EX3S0Vm7HxrY6/qmFvfxDWaptP8g1A6w0Fu4Mw/LR5DbZ9Kbpf/XQqCZzwAcu5g4PZ5q
         g7sKQ8dwVRUmpf/mM7xwmKUI6OcGBNcrd33RGxIBRtWt58ahADEu4UGDhyJMQSJ35Uft
         dlLN+36Zt0cQchduaf/k4RgGgoU6H0twXvvKVgQpkLMrk87ZwnR4nlj1AAtkShVaiTD1
         IcIg==
X-Gm-Message-State: AFqh2kqio7gX0NkajJ1EktwYSQHsHqyzBzCgZ9Qqxt+4KgSzOHDWZP9w
        uUQZP/TF01shfIEAgKqz4ZKSMQ==
X-Google-Smtp-Source: AMrXdXtMv3z609fCfMMcn1lyVfLqtlv2kX3RFEiFg4rXFi4hUXOF/Cfb7gNI0fQ2luv3PkbTOGN4Vw==
X-Received: by 2002:adf:cc8c:0:b0:293:1868:3a14 with SMTP id p12-20020adfcc8c000000b0029318683a14mr11101982wrj.0.1673965327363;
        Tue, 17 Jan 2023 06:22:07 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d4882000000b00286ad197346sm28891037wrq.70.2023.01.17.06.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 06:22:06 -0800 (PST)
Date:   Tue, 17 Jan 2023 14:22:04 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866
 backlight
Message-ID: <Y8avDJj5PCy8OVWV@aspen.lan>
References: <20230117134742.23238-1-lujianhua000@gmail.com>
 <20230117134742.23238-2-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117134742.23238-2-lujianhua000@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jan 17, 2023 at 09:47:42PM +0800, Jianhua Lu wrote:
> Add Kinetic KTZ8866 backlight binding documentation.
>
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>

Might be a good idea to take a look at this bit of the docs because
the patchset is not in the right order (I.5):
https://docs.kernel.org/devicetree/bindings/submitting-patches.html


> ---
> Changes in v2:
>   - Remove "items" between "compatible" and "const: kinetic,ktz8866"
>   - Change "additionalProperties" to "unevaluatedProperties"
>
> Changes in v3:
>   - Add Krzysztof's R-b
>
> Changes in v4:
>   - Drop Krzysztof's R-b
>   - Add some new properties
>
>  .../leds/backlight/kinetic,ktz8866.yaml       | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> new file mode 100644
> index 000000000000..18571d69accb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktz8866.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kinetic Technologies KTZ8866 backlight
> +
> +maintainers:
> +  - Jianhua Lu <lujianhua000@gmail.com>
> +
> +description: |
> +  The Kinetic Technologies KTZ8866 is a high efficiency 6-sinks led backlight
> +  with dual lcd bias power.
> +  https://www.kinet-ic.com/ktz8866/
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: kinetic,ktz8866
> +
> +  current-num-sinks:
> +    description: Number of LED current sinks.
> +
> +  current-ramping-time:
> +    description: LED current ramping time.

Needs to document know what units this value is expressed in. IIRC
this should be expressed in SI units and included the property name.
Something like:

  current-ramping-time-us:
    description: LED current ramping time in microseconds.


> +
> +  led-ramping-time:
> +    description: LED on/off ramping time.

+1


Daniel.

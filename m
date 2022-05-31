Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E1C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 31 May 2022 20:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347824AbiEaUkV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 31 May 2022 16:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347813AbiEaUkV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 31 May 2022 16:40:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BAB5FB0
        for <linux-fbdev@vger.kernel.org>; Tue, 31 May 2022 13:40:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z7so8274060edm.13
        for <linux-fbdev@vger.kernel.org>; Tue, 31 May 2022 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Alpwe54um/pAMi391V2OXK5ebcRXESWz/C1BKY6Vx2U=;
        b=bpXiaXVheIuoXS4qYPJJkBRiRLc0xdm8fJsiezzNxaSbqbM0HnHijdjFweVTNkO5Bt
         OZqNy/x48s3aknETcJSY51qRmtTvaefEriEEJgQKisgFjaP183xCgKHWGQMMuAEHM6iq
         Tc3YKXQYkPZ94qbC96FiM34BqIpNNbIw3S8bJFm37gUnEIpXhZlKzpuEHXf1T8hzTbUW
         Du1P41pKola5rfLIqjTtayOOX87K1DlGcQtFT+ikof7IHHBi0DGNf1t+EUD7xcGMBNpZ
         EvT5U5w/Mdqm9rktSC9cQ0mZie8pKoeXyPlTqMEFXnEeubuvBemuKrU2SexCdF1YgbDO
         BdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Alpwe54um/pAMi391V2OXK5ebcRXESWz/C1BKY6Vx2U=;
        b=dCB+dugn9HNXaUIh9uyEcjdN638HU0UQ3IFiFxPGDCtXaz6TzIQKTwBsGxmhXuCOrU
         /I7jy86baUy6+U+W6uYC2ze+WsXrQnsRkF7cTUoNeXmD4B5guSzNhIikTPB8QQrBtMr2
         fu09SLHLElLeTBzEdWLA67t2d3j5UpZMrfXQGyO3TdlA+ONkSFoh9/GYNtqOBt9riPIj
         C4oPu2E8hFznfdXbTIGoYutQoC3EFyC3Y5DHmdF3WKBZIw7yIRGhfdysPSVp498svCH0
         iQtne0oJIT8HgpWWPxQQfLapH92P8BUfYDjuYYk/5gNUJdYMsM0YjBQUhF4rWEDZSjCo
         mbQw==
X-Gm-Message-State: AOAM532LMyAVppW08HMPzl8OyCD0FnxIlUO5SVqqb6LcRolAiGTy3cfp
        7PQD5WcyvbtlW7GqeG7wcB6uUQ==
X-Google-Smtp-Source: ABdhPJzdZx04tPobjk6aL2VQPYwY9rAKwfMAkoP+ACgtkB/OwGTdsTuE3oT/JNLygYdZnn9MWjUmsw==
X-Received: by 2002:a05:6402:c1:b0:42a:b8a5:8d5e with SMTP id i1-20020a05640200c100b0042ab8a58d5emr67401586edu.266.1654029614622;
        Tue, 31 May 2022 13:40:14 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gt2-20020a170906f20200b006ff01fbb7ccsm5299610ejb.40.2022.05.31.13.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 13:40:14 -0700 (PDT)
Message-ID: <3ab7892e-cee0-f5d6-7b58-1a9bfc803ea9@linaro.org>
Date:   Tue, 31 May 2022 22:40:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 12/14] dt-bindings: leds: Add Mediatek MT6370 flashlight
 binding documentation
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20220531104211.17106-1-peterwu.pub@gmail.com>
 <20220531104211.17106-4-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531104211.17106-4-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 31/05/2022 12:42, ChiaEn Wu wrote:
> From: Alice Chen <alice_chen@richtek.com>
> 

Subject - same comment as previous #10 patch.

> Add Mediatek MT6370 flashlight binding documentation
> 
> Signed-off-by: Alice Chen <alice_chen@richtek.com>
> ---
>  .../leds/mediatek,mt6370-flashlight.yaml      | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
> new file mode 100644
> index 000000000000..b1b11bd3d410
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-mt6370-flashlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Flash LED driver for MT6370 PMIC from MediaTek Integrated.
> +
> +maintainers:
> +  - Alice Chen <alice_chen@richtek.com>
> +
> +description: |
> +  This module is part of the MT6370 MFD device.
> +  see Documentation/devicetree/bindings/mfd/mt6370.yaml
> +  Add MT6370 flash LED driver include 2-channel flash LED support Torch/Strobe Mode.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6370-flashlight
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^led@[0-1]$":
> +    type: object
> +    $ref: common.yaml#
> +    description:
> +      Properties for a single flash LED.

Same as patch #11.

> +
> +    properties:
> +      reg:
> +        description: Index of the flash LED.

As well.

> +        enum:
> +          - 0 #Address of LED1
> +          - 1 #Address of LED2

'#' starts a comment, so there is always a space after '#'

> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false


Best regards,
Krzysztof

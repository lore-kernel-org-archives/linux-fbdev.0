Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391D6CCA47F
	for <linux-fbdev@archiver.kernel.org>; Fri, 24 Jun 2022 10:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiFXKff (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 24 Jun 2022 06:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiFXKfc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 24 Jun 2022 06:35:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325D37C844
        for <linux-fbdev@vger.kernel.org>; Fri, 24 Jun 2022 03:35:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lw20so3834433ejb.4
        for <linux-fbdev@vger.kernel.org>; Fri, 24 Jun 2022 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GeySHEpfB0/asXQLszsfiLjDcMnpUMVH0jqVoWkX/7o=;
        b=uZ1wC8VHxURHrghX2//skAqQ30um2Rme3cIPNULf/p3DBJwzdeGZCHn64BbW1bwOoh
         MK7I4FRm4lPVfnOutTChG+9M+lYc4y4yEjHQmcsNNibkepmTc5kqbxTtx/VHfIwqpSFA
         A7a2fOZ7cvl48zaPYnFMhKsgQgSk6uKOAABQ6m5HcNHn+pYfMPqsOfrhh43gWvLbEKIG
         AMwez5zF4oib8KlCHUoPbdzUVBf2Mmj6iqKOZO4I2HmkzMfM5iXV86deY5+S7vEL+BT9
         wv3F9Puov/5GuHxXic5VvIIGs7RASkq12ilmGiKxF+k5qkfHOarvRWT8G3ev/yK3xUvF
         FD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GeySHEpfB0/asXQLszsfiLjDcMnpUMVH0jqVoWkX/7o=;
        b=U82n0tlpeCgg5TvJL/sffft1cyh38G0wUAKqX+qFTsiycfiOmkV6N33769ahPPbZi0
         dGEhf3cEsjbtRg+jjJ/mytdC2Tlntousoj1rFuzXpzI3aY/amnWQUI86C6x1djgEWIuM
         PBqPqX4KhZaBo11BucxAL2fjBK+queS7ZkAJAkYCi662aNd0hYybj9AYbTD1DDCBEBxh
         Kl4BYDh4koFAW+aaUe7Dswp8IsEODIbZYJDc5cO7evZGxrMYbH1D0bW7R6y4AnhIL+j7
         R8W2ooACBeNDBn37DQsG73EjkGDuly5XWycB0jkGXbq30Wpm9jVROIfEiRJuLdhRFrJs
         lx0A==
X-Gm-Message-State: AJIora+2lwln9Q0gxuw2220a+Cv79ckChBk3VQgF/kn7QEn8RZH+4aaI
        0njo0hfkIOa1gV2dmywc3GcP/w==
X-Google-Smtp-Source: AGRyM1sqyv+H/bBGuPYg4PIFRLo9cOE04f0nH/20g7zmKiDRIOyqtdjIViwQXday1ZlmdpGjP7k8OA==
X-Received: by 2002:a17:907:1694:b0:716:14a4:fba with SMTP id hc20-20020a170907169400b0071614a40fbamr13073900ejc.290.1656066926720;
        Fri, 24 Jun 2022 03:35:26 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b0042617ba638esm1683916edt.24.2022.06.24.03.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 03:35:25 -0700 (PDT)
Message-ID: <aec8ecdb-7c76-1261-216b-b40e450d1bf8@linaro.org>
Date:   Fri, 24 Jun 2022 12:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 03/14] dt-bindings: leds: mt6370: Add Mediatek mt6370
 current sink type LED indicator
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
References: <20220623115631.22209-1-peterwu.pub@gmail.com>
 <20220623115631.22209-4-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220623115631.22209-4-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 23/06/2022 13:56, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Mediatek mt6370 current sink type LED indicator binding documentation.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> 
> v3
> - Use leds-class-multicolor.yaml instead of common.yaml.
> - Split multi-led and led node.
> - Add subdevice "led" in "multi-led".
> ---
>  .../bindings/leds/mediatek,mt6370-indicator.yaml   | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
> new file mode 100644
> index 0000000..45030f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/mediatek,mt6370-indicator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LED driver for MT6370 PMIC from MediaTek Integrated.
> +
> +maintainers:
> +  - Alice Chen <alice_chen@richtek.com>
> +
> +description: |
> +  This module is part of the MT6370 MFD device.
> +  Add MT6370 LED driver include 4-channel RGB LED support Register/PWM/Breath Mode
> +
> +allOf:
> +  - $ref: leds-class-multicolor.yaml#
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6370-indicator
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^multi-led@[0-3]$":
> +    type: object

Here as well unevaluatedProperties:false (on the type level)

> +
> +    properties:
> +      reg:
> +        enum: [0, 1, 2, 3]
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^led@[0-2]$":
> +        type: object
> +        $ref: common.yaml#
> +        unevaluatedProperties: false
> +
> +        required:
> +          - reg
> +          - color
> +
> +    required:
> +      - reg
> +      - color
> +      - "#address-cells"
> +      - "#size-cells"
> +
> +  "^led@[0-3]$":
> +    type: object
> +    $ref: common.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        enum: [0, 1, 2, 3]
> +
> +    required:
> +      - reg
> +      - color
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false


Best regards,
Krzysztof

Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E90DC4167B
	for <linux-fbdev@archiver.kernel.org>; Fri, 25 Mar 2022 19:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiCYTtI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiCYTsh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 25 Mar 2022 15:48:37 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F38B223840;
        Fri, 25 Mar 2022 12:32:07 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id m3so14989808lfj.11;
        Fri, 25 Mar 2022 12:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fRup0HhTI1fItvOnWgW1apl6hJ+hovK5wDJd4/CJEws=;
        b=m12DW7F/KxegR9D+RbcCP/FsyoJqn1Q7vDwxkuPbGaUo5off6jkMbcu78TeXgKUBvc
         nvUePxxPS8Nk1bTnvF5NkmnugZI4gK6EzQhqq9PltfE8PaEA5gZeJTKD39t/bN3qtV3E
         kAfqnHxiJB69bcbAbwa6JjiSTvA19v/qbggObr+ZPb/qHJp1WsGRp5EGD/KP1vtLNvZS
         b7VqPKfNVqIrcI7H7s9mPujpfNwUD0d9fsRdBzgJHVHtIjWarnyBePlfcCILlSdIQo0M
         8Tx1YUiJQX7y8xlWcyg8ke+ssl0B2SbUC5fewGcW2U/cjElpqLs00ljkZPm/FaKmfaX6
         o3PA==
X-Gm-Message-State: AOAM530Ka7v6Y+qBNa95EqZ6u1qT273UFhi6g7prrflumBp1YtMB4e9y
        5UiMyZ9STRGPB1w9hZ8Mp3X9t5l+gdOeDw==
X-Google-Smtp-Source: ABdhPJxBJl5W6RwFQAyh8otMltwQxLkSdlG8+OGsciwzNPCea5FQXhEojfuAMY1CBRj+1zzaCrkF1w==
X-Received: by 2002:a50:d84c:0:b0:418:f176:79df with SMTP id v12-20020a50d84c000000b00418f17679dfmr14200983edj.353.1648229500341;
        Fri, 25 Mar 2022 10:31:40 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id c12-20020a05640227cc00b004192114e521sm3209328ede.60.2022.03.25.10.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 10:31:39 -0700 (PDT)
Message-ID: <8baedbe6-eb60-02b4-a6b8-fe3abc566335@kernel.org>
Date:   Fri, 25 Mar 2022 18:31:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 01/22] dt-bindings: mediatek,dpi: Add DP_INTF compatible
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        angelogioacchino.delregno@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        markyacoub@google.com,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh@kernel.org>
References: <20220325171511.23493-1-granquet@baylibre.com>
 <20220325171511.23493-2-granquet@baylibre.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220325171511.23493-2-granquet@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 25/03/2022 18:14, Guillaume Ranquet wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> DP_INTF is similar to DPI but does not have the exact same feature set
> or register layouts.
> 
> DP_INTF is the sink of the display pipeline that is connected to the
> DisplayPort controller and encoder unit. It takes the same clocks as
> DPI.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

This is v1, how did you get Rob's review already?

> ---
>  .../bindings/display/mediatek/mediatek,dpi.yaml       | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> index dd2896a40ff0..53acf9a84f7f 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> @@ -4,16 +4,16 @@
>  $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: mediatek DPI Controller Device Tree Bindings
> +title: mediatek DPI/DP_INTF Controller Device Tree Bindings

While at it, remove "Device Tree Bindings". It's about hardware.


Please also rebase your tree as you use my old email address.

Best regards,
Krzysztof

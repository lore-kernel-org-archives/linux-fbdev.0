Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E02CCA480
	for <linux-fbdev@archiver.kernel.org>; Mon, 27 Jun 2022 14:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiF0OHl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 27 Jun 2022 10:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbiF0OH1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 27 Jun 2022 10:07:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A212AE9
        for <linux-fbdev@vger.kernel.org>; Mon, 27 Jun 2022 07:07:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n1so13214329wrg.12
        for <linux-fbdev@vger.kernel.org>; Mon, 27 Jun 2022 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gsgc6DIOzArZPsUhaJm6TQBUqT+cOuEtKePYXM55dn8=;
        b=RwHx2DUc+zQdZoM/fppv9uMqeCAsq+OTGc/uLrz+5I2GWcjSb+HNw7JV4svTtEhUy7
         vIFfvyGeQMDZyn3ImibEdKS/PIZ63/tO5OCzlNTZhFo1Vfo96vu2exkNVAVWPKeof0N8
         0Xu3lAWYFac0xwHZL5TSyegckajoASkwSSjl2HAGRLtOx4jZ3SS/gGt1JuEYfTGfE5r7
         CfAeuR2t91wZvVhojT3UVBbHVMkvmi5uytl/EmCfOYw1azGp9xArgKPoVQwAZNtbZAqs
         TYIFnFm/FWbbSQPZTSwobvd1SzOXoFJxmGpy6ujesCML//e9Al0NiJzMqwlc60Uz/OOc
         G1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gsgc6DIOzArZPsUhaJm6TQBUqT+cOuEtKePYXM55dn8=;
        b=4j5FotCo71rq18jtMYAORH+aarIxxNBl13xZ28+LmKi5xMMuZbOCArl4ZwH5dk6AUF
         kkzhRIX71ahu9WUmFw6ICcg5fW4O9z1Apsp0PRSCTDhrjRYRWhF15e6qLzoug5E/FXux
         q7OC4+GL7kgVX7giGnQCWnk2G3gTpPbcOUrrbEYhGUPIouEP+lfK4IzOruVfUrJfiDGZ
         wfP+KuEoJkAA9DIHzUZAzTG23FibyHFaVPduw1yxlkniaPrn2q2WTwAYXK7/pB/v1cCq
         9YdCZTGQzR18JO0khN9A4qibWM9+z4HQ6XVjyuRDBIEfijM20lx87/duky1KmGGQ+p9d
         ezJA==
X-Gm-Message-State: AJIora/gE0WyVud5x3uNe+ipwDHgJsD5T8fsIlTYowNmFsMRVt9XK2ua
        TYTLlY2SISSlD6cUJLD10MZMug==
X-Google-Smtp-Source: AGRyM1tqOffr5P69k2JXSjDJ26X0SHzGuAeWDAQMALNpO6JuPQMieD2zfhpuXvwpbHW0niVy/fmg2g==
X-Received: by 2002:a05:6000:80f:b0:21b:927a:16b1 with SMTP id bt15-20020a056000080f00b0021b927a16b1mr12143982wrb.440.1656338843969;
        Mon, 27 Jun 2022 07:07:23 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bcd11000000b0039c811077d3sm13142680wmj.22.2022.06.27.07.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 07:07:23 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:07:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        deller@gmx.de, cy_huang@richtek.com, lucas_tsai@richtek.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: backlight: rt4831: Add the new ocp
 level property
Message-ID: <Yrm5mRvVm2yl7zKc@google.com>
References: <1655807788-24511-1-git-send-email-u0084500@gmail.com>
 <1655807788-24511-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1655807788-24511-2-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 21 Jun 2022, cy_huang wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add 'richtek,bled-ocp-microamp' property to make it chooseable.
> 
> The wrong backlight ocp level may affect the backlight channel output
> current smaller than configured.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Since v3:
> - Refine the description for backlight ocp property.
> - Use the enum to list the supported value.
> 
> Since v2:
> - Change the property name from 'richtek,bled-ocp-sel' to 'richtek,bled-ocp-microamp'.
> 
> ---
>  .../devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

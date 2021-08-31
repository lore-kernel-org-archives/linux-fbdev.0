Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971A3C4320E
	for <linux-fbdev@archiver.kernel.org>; Tue, 31 Aug 2021 21:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7012861056
	for <linux-fbdev@archiver.kernel.org>; Tue, 31 Aug 2021 21:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbhHaVbP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 31 Aug 2021 17:31:15 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38464 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239708AbhHaVbM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 31 Aug 2021 17:31:12 -0400
Received: by mail-ot1-f49.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso950667ots.5;
        Tue, 31 Aug 2021 14:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lv/ljHshSZK3RFgD2a8g0MVknlEMt9i5zUtkABsa3c0=;
        b=QbRpDfRY+/x1atbFO5/WMv28jcwGZEFYMzrZhCyFNV2hlVI/fZPuFu1RsdLG3giDBL
         lMq7reipv1KB5cIjzYbgs5ytUCdabjJsiWL4ZujIkiJ2ZGVF4ElD7L4qLfjDIQGG8lpF
         XfaMWKRsKm06bPGoUYSAA5OCly466G40egn0tYTHf3ojx9ED0v6zR1P3G9APsy+OwbZL
         1XHdbSIcG9VpzfHugG5CprcQ3v1W9DGwa3a1Fg55orR0SkLzeqidGEm5LokEixw0j8b9
         GIGTiUHko7x+0KNMV8m6G+YnNvI/jJ/9iTx5JHBcU6T4mjOsCGtCHKWwAmwNiC8fiXjn
         O6mw==
X-Gm-Message-State: AOAM5312vOXvkVdDOYLPAKJ/0fWq+F9+85ZD24KC7AP78aOMGK2S2Pw+
        YXrRL+PsrMfyF3xbtj/WZA==
X-Google-Smtp-Source: ABdhPJzCoKKVloeON0/InoVfsSGtFPejEa6c0Hy6uFnCKvcn2QG3UG5aK/HzG37HQA69/+Y37NLGSQ==
X-Received: by 2002:a9d:74c5:: with SMTP id a5mr25815380otl.205.1630445416795;
        Tue, 31 Aug 2021 14:30:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n130sm3841778oif.32.2021.08.31.14.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 14:30:16 -0700 (PDT)
Received: (nullmailer pid 678569 invoked by uid 1000);
        Tue, 31 Aug 2021 21:30:15 -0000
Date:   Tue, 31 Aug 2021 16:30:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-fbdev@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: add missing simple-framebuffer
 formats
Message-ID: <YS6fZ4nFgic1DYhR@robh.at.kernel.org>
References: <20210828110206.142899-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828110206.142899-1-luca@z3ntu.xyz>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Aug 28, 2021 at 01:02:05PM +0200, Luca Weiss wrote:
> Document all formats currently present in include/linux/platform_data/
> simplefb.h
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../bindings/display/simple-framebuffer.yaml         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> index c2499a7906f5..c1acd2859ae8 100644
> --- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> +++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> @@ -83,13 +83,25 @@ properties:
>    format:
>      description: >
>        Format of the framebuffer:
> +        * `a1r5g5b5` - 16-bit pixels, d[15]=a, d[14:10]=r, d[9:5]=g, d[4:0]=b
> +        * `a2r10g10b10` - 32-bit pixels, d[31:30]=a, d[29:20]=r, d[19:10]=g, d[9:0]=b

Not a new problem, but are these 32-bit big or little endian words? That 
should be figured out before we add more.

>          * `a8b8g8r8` - 32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r
> +        * `a8r8g8b8` - 32-bit pixels, d[31:24]=a, d[23:16]=r, d[15:8]=g, d[7:0]=b
>          * `r5g6b5` - 16-bit pixels, d[15:11]=r, d[10:5]=g, d[4:0]=b
> +        * `r5g5b5a1` - 16-bit pixels, d[15:11]=r, d[10:6]=g, d[5:1]=b, d[0]=a
> +        * `r8g8b8` - 24-bit pixels, d[23:16]=r, d[15:8]=g, d[7:0]=b
> +        * `x1r5g5b5` - 16-bit pixels, d[14:10]=r, d[9:5]=g, d[4:0]=b
>          * `x2r10g10b10` - 32-bit pixels, d[29:20]=r, d[19:10]=g, d[9:0]=b
>          * `x8r8g8b8` - 32-bit pixels, d[23:16]=r, d[15:8]=g, d[7:0]=b
>      enum:
> +      - a1r5g5b5
> +      - a2r10g10b10
>        - a8b8g8r8
> +      - a8r8g8b8
>        - r5g6b5
> +      - r5g5b5a1
> +      - r8g8b8
> +      - x1r5g5b5
>        - x2r10g10b10
>        - x8r8g8b8
>  
> -- 
> 2.33.0
> 
> 

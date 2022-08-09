Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EE3C3F6B0
	for <linux-fbdev@archiver.kernel.org>; Tue,  9 Aug 2022 20:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbiHIUUB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 9 Aug 2022 16:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245607AbiHIUUA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 9 Aug 2022 16:20:00 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CFC2559F;
        Tue,  9 Aug 2022 13:19:59 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id cr9so6422204qtb.13;
        Tue, 09 Aug 2022 13:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Zskxu9RM9shgea48JfI0eSWUYjVUqMyTAyaPDWwmlU0=;
        b=DirQGtP7fdYlZSVxrfAt9rAizedg9vnBjhEOGH1I3Wd9kv9d3SvBZ+L1qwCBHzcJfq
         e31pSNMdr0cmDTfBYMdlgLZds9WJ03orXMcvsFtlJSU9KT2I5zxhuNSyfGnagcl4YZ2T
         z9XbD4KOFHlcZ5u8oKoXzS/pcV8plSdeqw+mcrhEVn+SgnDHjigoY2VeskkHf6ikvEn1
         p4/Yha68OtdJKrN8RgTBrzATADqELlgZfyq1idRrHXmG6IVRaKrr9bPSRhIwQ6hR47oU
         GXo3jKSpD1TsBomcI9IpzBIqOtVZquGEVa/FqQjWxxnccvHwRpOvjLQlAs1+1T1lutql
         giMg==
X-Gm-Message-State: ACgBeo0r30uGp2r8KZQJbSD+nZ0ZD2oelTOU1afm2BkTYk4P9shexVAg
        CCiIoZGFOY2H5Qjee9F48KEeKKilnA==
X-Google-Smtp-Source: AA6agR7JlRVRwfkkAMUq/uYFIjTvCyOZ3vlkrOzYv/HhQul/99ZRx/tch/zjFCjHPfvagIqDVoDy8w==
X-Received: by 2002:a05:6638:14d5:b0:33f:8a96:c59c with SMTP id l21-20020a05663814d500b0033f8a96c59cmr11480702jak.254.1660076387557;
        Tue, 09 Aug 2022 13:19:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a23-20020a5d9ed7000000b00684a65f0c36sm1525213ioe.45.2022.08.09.13.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:19:47 -0700 (PDT)
Received: (nullmailer pid 2326180 invoked by uid 1000);
        Tue, 09 Aug 2022 20:19:45 -0000
Date:   Tue, 9 Aug 2022 14:19:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Lee Jones <lee@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-fbdev@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 3/3] dt-bindings: display: simple-framebuffer: Drop
 Bartlomiej Zolnierkiewicz
Message-ID: <20220809201945.GA2326091-robh@kernel.org>
References: <20220808101526.46556-1-krzysztof.kozlowski@linaro.org>
 <20220808101526.46556-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808101526.46556-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 08 Aug 2022 13:15:26 +0300, Krzysztof Kozlowski wrote:
> Bartlomiej's Samsung email address is not working since around last
> year and there was no follow up patch take over of the drivers, so drop
> the email from maintainers.
> 
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> I assume that if other change was preferred, there was quite enough of
> time to send a patch for this. :)
> ---
>  .../devicetree/bindings/display/simple-framebuffer.yaml          | 1 -
>  1 file changed, 1 deletion(-)
> 

Applied, thanks!

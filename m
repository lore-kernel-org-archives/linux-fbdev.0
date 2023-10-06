Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E42FE81DED
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 Oct 2023 12:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjJFMa3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 6 Oct 2023 08:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjJFMa1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 6 Oct 2023 08:30:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982D311D
        for <linux-fbdev@vger.kernel.org>; Fri,  6 Oct 2023 05:30:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-533d6a8d6b6so3799056a12.2
        for <linux-fbdev@vger.kernel.org>; Fri, 06 Oct 2023 05:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696595417; x=1697200217; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sYSZgor/RBGjf4wuXsOz+ucEbF12Vj/yAHNRuHZ3l+Q=;
        b=i2mlEtJrA7fE5xNLnVS42Kxq7T87YxagT0s9Bdw76j2ejWhNdyBX3+3j3NLxrVP8wV
         +FRzwA37aXtuiSKsOxqgS0Tj81X6C8JnZaJkrbfD50KwyeafelCUedU9+ogwmiCOZ/tO
         gojugn+AEy/C5/E/1kHQ2paOQcU748fZtErmhCEEzrBFFbGDOJYopfKtL4/9RG0kYQvR
         45+PR/bvWAHlCprhCaMR+FMGYgr4oe743UmWA4OcrYPvZtTvR9n83IY7trakfPe9sHdA
         CQHRc1g6ZHgIh4FUdJK0tiq5n0nmN17zh3XlseHWoV548/asSm2fLvsBZk1PJ00NRv7c
         Mlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696595417; x=1697200217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYSZgor/RBGjf4wuXsOz+ucEbF12Vj/yAHNRuHZ3l+Q=;
        b=X75+zm85YmazW7Zhs0mN9JgvPViny9geOzgOk0k0DENRrzn8v7RLebmC9RdgAf/vmk
         sP+F9DT/GJbH86swe01G+94YK5ZkUycitqegZFNVzFwFU2WWzbcgUIMfz4juFyEuYr40
         qcSX1jCk3YirG3g3f+0Id+y62L2wjDfZPsXpBDKoRb8kMP6gqfqCgFQYgrQ0YJy7eujh
         +jkguu6PB1OsyuRTL/T+0FiRED160jj1D56kWd5BsTpfdkxP/Yqj8yUT6/GRWJ2+RRcQ
         J8RAocHCkSH9m3tRrINa6VaE2g3e/r3Y+7jkNGL1cIt4VlISYfYNUWclALFre2moxpqt
         MP5Q==
X-Gm-Message-State: AOJu0Yxm6eW499dPoleAfQ6lsPugbvN4JOIP7ET4KuiCV275gneXhHMh
        PPx+vlWn8YJVE5tGb5N70RJIDg==
X-Google-Smtp-Source: AGHT+IHTOw/VY6TBFq65jsChMS223mo3Uv9ez720nz2z/rFj0PF94m9QIFEGrTuIdcUQuzYKV9Ty9Q==
X-Received: by 2002:a50:ee91:0:b0:51e:53eb:88a3 with SMTP id f17-20020a50ee91000000b0051e53eb88a3mr6699147edr.25.1696595417011;
        Fri, 06 Oct 2023 05:30:17 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d9c4000000b0052284228e3bsm2511897eds.8.2023.10.06.05.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 05:30:16 -0700 (PDT)
Date:   Fri, 6 Oct 2023 13:30:14 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Helge Deller <deller@gmx.de>, Karel Balej <balejk@matfyz.cz>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/2] dt-bindings: backlight: add Kinetic KTD2801 binding
Message-ID: <20231006123014.GA96854@aspen.lan>
References: <20231005-ktd2801-v1-0-43cd85b0629a@skole.hr>
 <20231005-ktd2801-v1-1-43cd85b0629a@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231005-ktd2801-v1-1-43cd85b0629a@skole.hr>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Oct 05, 2023 at 08:49:08PM +0200, Duje Mihanović wrote:
> Add the dt binding for the Kinetic KTD2801 backlight driver.
>
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>  .../bindings/leds/backlight/kinetic,ktd2801.yaml   | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2801.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2801.yaml
> new file mode 100644
> index 000000000000..970d54bac18e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2801.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktd2801.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kinetic Technologies KTD2801 one-wire backlight
> +
> +maintainers:
> +  - Duje Mihanović <duje.mihanovic@skole.hr>
> +
> +description: |
> +  The Kinetic Technologies KTD2801 is a LED backlight driver controlled
> +  by a single GPIO line. The driver can be controlled with a PWM signal
> +  or by pulsing the GPIO line to set the backlight level. This is called
> +  "ExpressWire".
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: kinetic,ktd2801
> +
> +  enable-gpios:
> +    maxItems: 1

Why "enable"? This is the line we are going to us to bitbang the
ExpressWire protocol. Doesn't that make it a control or data pin?


Daniel.

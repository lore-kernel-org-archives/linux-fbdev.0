Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B89C25B06
	for <linux-fbdev@archiver.kernel.org>; Wed, 10 Aug 2022 11:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiHJLW0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 10 Aug 2022 07:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHJLW0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 10 Aug 2022 07:22:26 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC5A74CF9
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Aug 2022 04:22:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a9so20745910lfm.12
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Aug 2022 04:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=KJVvJs/hdcnNTEwCF+Y2HOBUXT3s0+UCv0dsySn/kTc=;
        b=Wc6xwPj14r6834HGH06kBOKr+qJOUEjLLLFWPKNrfoTPN8zWQS2+uRj1SPdiGIof0z
         s64Fqt86/H8ud+6jATOixEykMP5zx4babwJaLYHxvxOjOz1pGnMiVFuAUwdrNsvWIPoI
         tlerqScsK+OTQy52wmGf6Zp48yDF29XG4dCPb4zUOEt0/L+Z9lfN4x2x0K1+36JCe6/M
         qlVFDwlPllTgTSxO8ft/gctYqGJ2xJeiktkCEliPjW2O+5WYwHsP4SUS6qqxv2fB2oiM
         rqjFES6VXDuYcgTmSafmFIX8ovwakhhEAlic102vVpYtp6bFSbgpFLjf5IJ1kX5pB2uw
         DiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KJVvJs/hdcnNTEwCF+Y2HOBUXT3s0+UCv0dsySn/kTc=;
        b=yENTfh3xi0gpwQNvwqYcEXwfT3fORA5U+XKiIvdt4XNzcoE4PRlvamFb4Q/DN5YQem
         AMOHN4P1KiW05qLNtH1Sbw5yE1ko1dups4Uxke9jBQlgKS8bOeb2pIysMRmXd8aObrSm
         XaMs9xh2MAyHQ2WPCqwT0o/uWwjp0zz4lFnl1nTRqv5t/Svkcf0+6MWNQVMp2jO4+t+e
         5YfFak2X0Jm63RAMSY86fpzHKoqtk1h3BaljyR64hhXkVdxG2+0u72y5lN9xrlKPucTk
         GDDDegXijcwN4nwUdlGQ97iplJdfx/Zn/J137lzMxtwVpD3a/2Mhz0PdmuyC7Qw5Uc6k
         WJRw==
X-Gm-Message-State: ACgBeo2cF7Da23yEE1+ACauePHz0ouE05GCipyk6Xsp9Pv6cMHq3IhjI
        65RvbkriilbioJo4FOd39YpDpw==
X-Google-Smtp-Source: AA6agR5sBpeeQBdFjzS2wtiHcwYuXfYhIEICyKLtIACFba5DjV5ePna+qqSY3kuQDsfF0uLZsjdGdg==
X-Received: by 2002:a05:6512:c13:b0:48b:3b30:637d with SMTP id z19-20020a0565120c1300b0048b3b30637dmr8195257lfu.447.1660130543208;
        Wed, 10 Aug 2022 04:22:23 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id u18-20020ac258d2000000b0048af464559esm299979lfo.293.2022.08.10.04.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 04:22:22 -0700 (PDT)
Message-ID: <f69bf678-0188-7178-7542-9773c15c1463@linaro.org>
Date:   Wed, 10 Aug 2022 14:22:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 4/5] dt-bindings: Drop Robert Jones
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Pavel Machek <pavel@ucw.cz>,
        Tim Harvey <tharvey@gateworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Andrew Davis <afd@ti.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220809162752.10186-1-krzysztof.kozlowski@linaro.org>
 <20220809162752.10186-5-krzysztof.kozlowski@linaro.org>
 <YvOP9qr2CR9n1FCe@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YvOP9qr2CR9n1FCe@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 10/08/2022 14:01, Lee Jones wrote:
> On Tue, 09 Aug 2022, Krzysztof Kozlowski wrote:
> 
>> Emails to Robert Jones bounce ("550 5.2.1 The email account that you
>> tried to reach is disabled").
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> ---
>>
>> For maintainers entry see:
>> https://lore.kernel.org/all/20220808111113.71890-1-krzysztof.kozlowski@linaro.org/
>> ---
>>  Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml | 2 +-
>>  Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml    | 1 -
> 
> Any reason to submit these as one patch?

Less work for me, less work for maintainer applying and sending fixes. I
think this could go via Rob's tree as fixes for current cycle.

Best regards,
Krzysztof

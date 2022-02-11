Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA48C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Feb 2022 08:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348106AbiBKIqB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Feb 2022 03:46:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbiBKIqA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Feb 2022 03:46:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6434BE68
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 00:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644569157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhiejNdZNc9V7Q57Z4FGfEE9W4EtgIkRByXMCdx4jhQ=;
        b=jMniQzghdCSnuvlxHcu49FP/Obyx5NWFaPwcyzzfZdjxyooE8BajYvjCf1xUbnQO8F8ju5
        pcksNg21DA5dsfClrrEk6z6jgEmqdInXVwNh66SXER1+m99CNDJ/6SfYrSzCW5EaaIe6L4
        OpEEFD18jFoE4lIPWJk3cvN/ondEI+Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-ctRb1SqEP9qIcER4DA0Kiw-1; Fri, 11 Feb 2022 03:45:55 -0500
X-MC-Unique: ctRb1SqEP9qIcER4DA0Kiw-1
Received: by mail-wr1-f69.google.com with SMTP id v9-20020adfa1c9000000b001e33e5dbd5fso3600907wrv.17
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 00:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=yhiejNdZNc9V7Q57Z4FGfEE9W4EtgIkRByXMCdx4jhQ=;
        b=MmtUvMWqsm6fRI2px6OGB1N4cfKiVIpdMDmuqSI2AeJJZ6lrBhVuaOwQfBT1mql+qS
         6Ripsd4TErEV5z5rKTJUf6G/Y5MwrqttVVVpLsmggwVukgJc4LqoLtpJKzzQsgEvV7aW
         CQjl7bmsqt7N/itArwKomVxX0D5Lb9LCSFjb5CNCF36YKso+i+xAucGztaE2fn+c5Si1
         6NLqst4sLMZMPL5PkGHrW4zuT02Vo/Se1RH3aWVCaKiGJD24D3OdSNJkl4Q/gvC4LUpD
         pLPa1Aca9mzDW0BdUUtc7aRDyK99w0Y0zPLi+5M8pGDqUCZn8pCrUaU6bKCBDYiRUdRQ
         wCdw==
X-Gm-Message-State: AOAM530cLU7fYM13Dp612AShKIt/Oat5AubDeFeopSU0ppWOF46zKcg1
        TSuWIR4H03xylTB3DLzI+r7k4ijKUMwrql60nqoF0wmY13nXcWWMcxbZ1p/roOMvcWSHNDcQIez
        NZDo+vEv4qVMkC1v9RJunbr4=
X-Received: by 2002:adf:edc9:: with SMTP id v9mr470914wro.135.1644569154549;
        Fri, 11 Feb 2022 00:45:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydD7roXdtXZjQWp72Wo5fcJQ6eNKNYHlSPNx2dupK8zLBlB9eyylPxhSvKDBOJgfjPqx/X3w==
X-Received: by 2002:adf:edc9:: with SMTP id v9mr470898wro.135.1644569154333;
        Fri, 11 Feb 2022 00:45:54 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id az21sm3460772wmb.11.2022.02.11.00.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 00:45:53 -0800 (PST)
Message-ID: <9ee28446-2dda-7015-1a0a-44dc8385002e@redhat.com>
Date:   Fri, 11 Feb 2022 09:45:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/7] drm: Add driver for Solomon SSD130X OLED displays
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <CAMuHMdVs750iE=kP1vabwgsGOb8sHc8aC5k=HwCU32CURnYktw@mail.gmail.com>
 <58ebacd2-d44d-c7e9-e752-de7815dd4cc1@redhat.com>
In-Reply-To: <58ebacd2-d44d-c7e9-e752-de7815dd4cc1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/9/22 13:37, Javier Martinez Canillas wrote:

[snip]

> 
>> There is still an issue with the cursor, though.
>> After doing "echo hello > /dev/tty0", the text appears, but the cursor
>> is gone. "clear > /dev/tty0" brings it back.
>>
> 
> Hmm, I was able to reproduce this too. Thanks for pointing it out,
> I'll investigate what the problem is.
>

I still didn't have time to dig on this for v4. But I think that the
driver works well enough to be merged and we can then fix the issues
that are still present in the fbdev emulation and fbcon interaction
as a follow-up.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


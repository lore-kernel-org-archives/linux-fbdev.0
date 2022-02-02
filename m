Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E43C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Feb 2022 08:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245025AbiBBIi5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Feb 2022 03:38:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245046AbiBBIi4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 2 Feb 2022 03:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643791135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQ96plJnExVz4IofZgZgy11FIOo1veP7nuoBU4KJMcA=;
        b=BQmHESqj7So+lESTgNlrXx12KcqJ3SGlSnqbUdeIlnOt3tKjzBvXxDV41RnR54R0yfUfJu
        06JSlQkc7butqaeEC/TdQ5eYG6XMhfZ5Ywga6YikkPbmvlchYrs9qMwMh2bDRLSn21JkoT
        /d9U9GsE9K1hS1tBz4jgxYb70LQz5Vc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-5bnYXYQKMLWrnNi4RE7JQA-1; Wed, 02 Feb 2022 03:38:54 -0500
X-MC-Unique: 5bnYXYQKMLWrnNi4RE7JQA-1
Received: by mail-wm1-f69.google.com with SMTP id r9-20020a1c4409000000b00352cf8b74dcso2672248wma.0
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Feb 2022 00:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IQ96plJnExVz4IofZgZgy11FIOo1veP7nuoBU4KJMcA=;
        b=XpfztP6B8PJuKXRYrVTdaWcQBgxQZqLOEf2ZWw4LPNu3t7ocS/y90pLAnpKNuPklNf
         cXNetc7LzBuBb1gsuWyGvqcZatoYIYDgb24XZh1dv4PvsGnq/Wo7fMNIvswEUyLvwY0B
         Cpx4F9mVFyL020rMI/fJpzb2mPW+zB0eFbvENaqJc1GzcKb9nxatybjhVdYudKV7NGqr
         uCF0Wa9rXuAN8+qqqz9k7LvUTCDGokin/G0kSUYFM7E7oWdAdruw3LPy+N8k+JgIyBIp
         ZZfABvej9YSdXD3QOWDUFf/z5BmPTrajpdsrjTHK2Zd0j/BjgypNfZzvt5U/56N2IpUb
         kTZw==
X-Gm-Message-State: AOAM531urebnkiOjAUXA6BAdhBQlBt9XcHso/H4eQuy1cK6OUoovjhbJ
        Tro6tUTVbuZ+ZnkvN78yN6bGgSMHeuGVwDDSgR2P+IC8FXGbXu0hgtIZIXR3opfJsrxs9ubMkn3
        U0yhX1BRzvPQIbN+X9bZzUKs=
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr5150575wmj.59.1643791133577;
        Wed, 02 Feb 2022 00:38:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxC9orog6Z8LfxDGH06ODz7grjUoMzfg+w2FlDgm3DeIkMP38HoKyw95IAqRi1WUhNTRJi28Q==
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr5150546wmj.59.1643791133371;
        Wed, 02 Feb 2022 00:38:53 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z17sm3963598wmf.47.2022.02.02.00.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 00:38:52 -0800 (PST)
Message-ID: <e552caec-5136-f4b2-12dc-23b182ab8af6@redhat.com>
Date:   Wed, 2 Feb 2022 09:38:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Robinson <pbrobinson@gmail.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <YfhM97cVH3+lJKg0@ravnborg.org> <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
 <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
 <CAMuHMdVP6ER119r2KAegjZes1a=KWZ47z6j=kgQ0oNx1oeUJ+w@mail.gmail.com>
 <51f54519-bb8b-f108-1c1e-4fed101ca5ef@redhat.com>
 <CAMuHMdVwUfv7pXhPazsgG6t=X=aVtDQkFUk_=mUuFH8Fscx8wg@mail.gmail.com>
 <abf63995-a529-1e80-18c3-df473a3e7a9c@redhat.com>
 <YfmaqUBqCrgp0QdO@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfmaqUBqCrgp0QdO@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Sam,

On 2/1/22 21:40, Sam Ravnborg wrote:

[snip]

> 
> I took a look at the datasheets - and all ssd1305, ssd1306 and ssd1307
> are the same. They have timing constrains on the Vcc.
> The random schematic I found on the net showed me that a PWM was used to
> control the Vcc voltage - which again is used to control the brightness.
> 
> All the above has nothing to do with backlight - I had this mixed up in
> my head.
>

Yes, same here. I was leaning towards fixing the DT binding but then due
Geert comment and after reading the datasheets for ssd130{5,6,7} like you
I had the same understanding.

Glad that you agree.

[snip] 

> 
> Last I recommend to drop the fbdev variant - if the drm driver has any
> regressions we can fix them. And I do not see any other way to move
> users over. Unless their setup breaks then they do not change.
>

As I mentioned in this thread I wouldn't propose to drop the fbdev variant.
I prefer to use the carrot and not the stick. Peter Robinson suggested to
make the driver mutually exclusive and add !FB_SSD1307 in the config symbol.

I think that makes sense and will do it in v2.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


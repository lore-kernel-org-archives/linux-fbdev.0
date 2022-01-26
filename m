Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766AEC28CF5
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Jan 2022 12:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbiAZMhG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Jan 2022 07:37:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241388AbiAZMhG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Jan 2022 07:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643200625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4TS0TGM1vcAom1pyqONn2J8siKmdxKUcGnkktOHArQk=;
        b=Pj6r588LXzcVpW9mIhT/S65C6shHD+GNcMEZpfXBFPbqT4YY4AizPdYwAHFcjpfecXmTQC
        jvbiVdA7WAFMhPqK+t24v9OxGv9C5DVWd9qImhXlght8wE/EL6404sre+BoEPqOY+MP86P
        Yy4eCW3WTELwOCPcfNiIHjnMIl0lRUc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-z41dwP9iNPu1orKZ915Y7A-1; Wed, 26 Jan 2022 07:37:03 -0500
X-MC-Unique: z41dwP9iNPu1orKZ915Y7A-1
Received: by mail-wr1-f70.google.com with SMTP id s25-20020adfa299000000b001d8d032255fso4223428wra.14
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 04:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4TS0TGM1vcAom1pyqONn2J8siKmdxKUcGnkktOHArQk=;
        b=V75hn9f2eDxoNrF6P81t3GG3YHFDqSj0CbJ7qH2DzuGIwk+IGvHIb0e4FckAmJMm60
         Ix+96hTPIISAREWgcMVF5COOC4NRRl2WiazCbR113qVPpQM5fXNzJ8IAi8UHrX3+5Ajf
         P47DsvOeunCysEge2BKfDkN2yAmZAQdydDfwMWD9RhHhCPl2lZ9ABSThK1LN5BhDAJ7S
         4q0F5BmIz74ffZ4uMRApOtJ2GjXKsyRLweXKp9DTXDdaoDAojzC/pKKNH7s2K/7CekR3
         Wv6hMEAcGUxQxrI8+kxBAwuUKGJ0ulcxyU10Y57D+oFRXm2gct96KBkbuDZKP/nO46fx
         abaA==
X-Gm-Message-State: AOAM532WJxcbnF0Oi3aBW81O+lIBnQrY+TBVnKKyBjQUUy/GGABLgKPY
        jB5qGVoGFDv5/RAvsPhaqePdT7hfke5zAE9+seHmCI3pTx6yZO4mCAywIGaCut1IZaMxPQzYTsQ
        UAyjwhgmYIshtAWHI91rE8tA=
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr7129438wmk.100.1643200622738;
        Wed, 26 Jan 2022 04:37:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFeRqcMR4sp5TihDa0aCwBpHf/6PAChPHR3bf/s902hBLlOchViJcHCwGI8NoHTi6Uqd/TdQ==
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr7129411wmk.100.1643200622473;
        Wed, 26 Jan 2022 04:37:02 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i6sm3207248wma.22.2022.01.26.04.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 04:37:01 -0800 (PST)
Message-ID: <1b665bb8-7acb-519b-0a02-ef0f2dd4b524@redhat.com>
Date:   Wed, 26 Jan 2022 13:37:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Carlis <zhangxuezhi1@yulong.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <CAHp75Vd7oaYPKx6bxjCqNnm6fieeQFrtq5K4YYrxYbXoXFy=+Q@mail.gmail.com>
 <20220126102858.GX1951@kadam>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220126102858.GX1951@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/26/22 11:28, Dan Carpenter wrote:
> On Wed, Jan 26, 2022 at 12:04:26PM +0200, Andy Shevchenko wrote:
>> On Wed, Jan 26, 2022 at 12:02 PM Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Wed, Jan 26, 2022 at 10:52 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>> Am 25.01.22 um 21:21 schrieb Andy Shevchenko:
>>
>> ...
>>
>>>> But why? We already have DRM drivers for some of these devices.
>>>
>>> No, we do not (only a few are available).
>>
>> Sorry, I missed your word 'some'. Some == almost none from the list (I
>> don't remember exact numbers but something like 2 out of 10 are
>> supported by tiny DRM and see about interfaces).
> 
> Could we get an exact list?
> 

The list AFAICT is the following. I'm not familiar with these so please
feel free to correct anything I got wrong here.

I've marked with '?' if found references to the device supported by the
fbdev driver in a DRM driver, but it's not clear if support the same HW.

Drivers in drivers/staging/fbtft:

   fb_agm1264k-fl.c
   fb_bd663474.c
   fb_hx8340bn.c
   fb_hx8347d.c (DRM driver in drivers/gpu/drm/tiny/hx8357d.c)
   fb_hx8353d.c
   fb_hx8357d.c (DRM driver in drivers/gpu/drm/tiny/hx8357d.c)
   fb_ili9163.c (DRM driver in drivers/gpu/drm/tiny/ili9163.c)
   fb_ili9320.c
   fb_ili9325.c
   fb_ili9340.c (DRM driver in drivers/gpu/drm/tiny/mi0283qt.c ?)
   fb_ili9341.c (DRM driver in drivers/gpu/drm/tiny/mi0283qt.c ?)
   fb_ili9481.c
   fb_ili9486.c (DRM driver in drivers/gpu/drm/tiny/ili9486.c)
   fb_pcd8544.c
   fb_ra8875.c
   fb_s6d02a1.c
   fb_s6d1121.c
   fb_seps525.c
   fb_sh1106.c
   fb_ssd1289.c
   fb_ssd1305.c
   fb_ssd1306.c
   fb_ssd1325.c
   fb_ssd1331.c
   fb_ssd1351.c
   fb_st7735r.c (DRM driver in drivers/gpu/drm/tiny/st7735r.c)
   fb_st7789v.c (DRM driver in drivers/gpu/drm/panel/panel-sitronix-st7789v.c)
   fb_tinylcd.c
   fb_tls8204.c
   fb_uc1611.c
   fb_uc1701.c
   fb_upd161704.c
   fb_watterott.c


Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


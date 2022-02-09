Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ED2C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Feb 2022 13:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiBINEU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Feb 2022 08:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiBINET (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Feb 2022 08:04:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26E79C0613CA
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Feb 2022 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644411862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUzAJD5kbTchlL+gjCOgw4eKuUNlJh2PUtfBXKNWAAo=;
        b=LSf+gKgA7gtQ1lgEhEeSvAq2yZFo2vgTmCw6pMn1MaSO7YsUu2+AFK+82Pdz1Xqwm5w2F0
        NwpzaQEYZIJ7QJXQImAsyA+OcMLCu8Eug+dWWPbRhyyyBQyi7Y79uus+t6R+pgN0ae6Bnv
        FEOb2SrEnUZb7dXU2DCMm8SJEmz979o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-1bD1Z2JvMryYXaphcklNJg-1; Wed, 09 Feb 2022 08:04:21 -0500
X-MC-Unique: 1bD1Z2JvMryYXaphcklNJg-1
Received: by mail-wm1-f71.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so2618726wmb.7
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Feb 2022 05:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aUzAJD5kbTchlL+gjCOgw4eKuUNlJh2PUtfBXKNWAAo=;
        b=c5pJQqY/bm1JocTYEtAoghd/Hbq2rqV1znpaNu4v/fa2AE0/DDQ8tezhTS9YpZASy3
         5LlhKrvSvumAlCW2f+de8zDCBYbz9hqbdpk8YsrwPdCzE9Q1vm2rZgKwvkfyn4GVTDlm
         gu8mTXIPdX1F1w1K7uIXYinAZUp3ZvtY4mOk0H2eHcB+azcTUB098P5mFGRAy7284u6q
         QqcrdfygRvrmWM9S+wN6lAffwEVO9ADLaeanEg2IIWBriXdAIIJW8A43pzcg+jU7B6m8
         fJjl6y45a1hm5gM8W9Phm1JxEiIreDbcDNuBgZC/U+fpMTjNrzBAnQ4d7gaYhp8tN3e/
         9kdg==
X-Gm-Message-State: AOAM532ouH645GNhPno3LQKonYlfo4gujgg0Ru0Xe4FGg85mvlJBNHec
        m3jL7k3BKbzTRKitTBHJ0D6wK4asUgGVpqwAcOFHQWolIg0t5/WW/mV4+7VCML6NsWRny3Oo1K4
        Dogbju+6OBeaFv5CYSZ8lViA=
X-Received: by 2002:adf:f384:: with SMTP id m4mr2089458wro.619.1644411859861;
        Wed, 09 Feb 2022 05:04:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiO4EFMylBV1d9vxTXEoIqL6kXbZmHBfOW0Qxtx/E3aYbo8p+lRqr/HlGnFxDb8si5vo3ofg==
X-Received: by 2002:adf:f384:: with SMTP id m4mr2089432wro.619.1644411859577;
        Wed, 09 Feb 2022 05:04:19 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s26sm1994270wmh.47.2022.02.09.05.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 05:04:19 -0800 (PST)
Message-ID: <e6efb2fd-300e-5282-1f2e-a68130d0b45a@redhat.com>
Date:   Wed, 9 Feb 2022 14:04:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/7] (WIP) drm/solomon: Add SSD130X OLED displays SPI
 support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209091204.2513437-1-javierm@redhat.com>
 <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/9/22 13:25, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Wed, Feb 9, 2022 at 10:12 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> The ssd130x driver only provides the core support for these devices but it
>> does not have any bus transport logic. Add a driver to interface over SPI.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Thanks for your patch!
> 
>> --- /dev/null
>> +++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
> 
>> +static const struct of_device_id ssd130x_of_match[] = {
>> +       {
>> +               .compatible = "solomon,ssd1305fb-spi",
> 
> This needs an update to the DT bindings.

Yes, I know. Didn't feel like it, because the patch is a WIP anyways
(I haven't tested it but was included just for illustration purposes).

If someone confirms that works then I will include a proper DT binding
in the next revision.

> Hence this may be a good time to deprecate the existing
> "solomon,ssd130*fb-i2c" compatible values, and switch to
> "solomon,ssd130*fb" instead, for both I2C and SPI.

Is this the preferred approach ? Asking because most of the drivers I
know use this -$bus suffix. From a device <--> driver matching point
of view, shouldn't be an issue to have two different drivers to use
the same compatible strings, as long as these are for different buses.

Since AFAIK the match only happens within the same struct bus_type. But
I wonder if this could cause issues in other places, for example the
module loading. IIRC the OF modaliases don't include the device type.

If instead the drivers were old platform drivers and have an i2c_device_id
and spi_device_id tables, then using the same device name would not be an
issue due the modalias having a i2c: and spi: prefix to make a distinction.

What I think we should do is drop the "fb" part, since that seemed to me
that was included because it was an fbdev driver. And not really hardware
description.

> Of course the I2C subdriver still has to bind against the old values,
> too, for backwards compatibility.
>

Yes, agreed.
 
>> +               .data = (void *)&ssd130x_ssd1305_deviceinfo,
> 
> The casts are not needed.
>

Ok.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat


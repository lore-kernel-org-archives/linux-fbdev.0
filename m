Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53CAC433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 13:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379204AbiAaNz3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 08:55:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379224AbiAaNz0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 08:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643637326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxP5Mrjf+1xZ7KSuCYa0gMdIvljGy5EAdecrXW+Lf8k=;
        b=RrE7kz0SThT16pWVOGYXKc77m/5/S1qVl3zgZSS9y5Sm9iSdzb7VKZKe1sBLIhwEzvUChN
        MeC5ExAYwNN9umMGj4jb7ee1pcVleElRnDDnR5KyjvtgxX53YzfohYVuj4taQ6274WzxdT
        /hD4SV0XIOgQQwStPcswzUHhKCRqwV8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-NbSZ1z_9MOOIeZHvjgG1RQ-1; Mon, 31 Jan 2022 08:55:24 -0500
X-MC-Unique: NbSZ1z_9MOOIeZHvjgG1RQ-1
Received: by mail-wr1-f71.google.com with SMTP id z1-20020adfbbc1000000b001df54394cebso4024235wrg.20
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 05:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uxP5Mrjf+1xZ7KSuCYa0gMdIvljGy5EAdecrXW+Lf8k=;
        b=FX88sWI6Wo2BdF8Y4gdKGWq+3/cIKc9eJ3CNBjQil14i0rdvFbMFatRDpwhipRZPdr
         VVY+LD80mOvwwY+xa1LKcP4PWUpCX80Kc8rm396tvVAjhK43fnzGK7kLwZsJXCKZMtJe
         FtPvdtgxZsYLda/TMPmhv+Sdgld2/4eVlttERnWof/clZV/DSowb8VAXP53924/44fYe
         BEwemqIy56JOF4R5BCyVG+TCwVG2EFCFbzwYzdjr71jKC3tyCs9zlcArILGA0an08rFk
         HsbHmM0reBzK3CBWtN6pOsA14FiBMWD1e3xjyaKg3T275K3pplODlGEM8V+2ow8X+kDR
         duxA==
X-Gm-Message-State: AOAM530C8qQlFnIsWtzeTGSYtHD3HNN48eP7M73TRpbzdgsopWPF5/nD
        zftK2biViidK6Uvl2JtHiHj7mvG1/byaHErYrukFQgxV0mq/f/n8owTey60pIgzcksb2+tYBgnq
        ZtjoKmxQuAMfTTg8qYSSqutc=
X-Received: by 2002:a05:6000:1d90:: with SMTP id bk16mr8433814wrb.217.1643637323522;
        Mon, 31 Jan 2022 05:55:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxykLOKK2CGVGLz0uBfgClNQCdlGlX3BmOFsL6O11/UOpozm0OsthMj4NcXtotxC6SFW7L++A==
X-Received: by 2002:a05:6000:1d90:: with SMTP id bk16mr8433808wrb.217.1643637323330;
        Mon, 31 Jan 2022 05:55:23 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h11sm8471273wmb.12.2022.01.31.05.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 05:55:22 -0800 (PST)
Message-ID: <29ab99fb-d906-907b-e922-251ac72b25ef@redhat.com>
Date:   Mon, 31 Jan 2022 14:55:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <f671a112-880d-1526-a395-360947b40c5a@gmx.de>
 <YfEv7OQs98O9wJdJ@kroah.com> <YfFIpBb7lL4ukWjm@smile.fi.intel.com>
 <b8eb7111-43aa-cc8a-a1bc-f08e0f2987ed@redhat.com>
 <YfFV4EJosayH+e6C@smile.fi.intel.com> <YfFWPmG2D093gz4N@smile.fi.intel.com>
 <6e74d4cc-655a-e38e-0856-a59e4e6deb36@redhat.com>
 <c423a2f0-e7be-3884-3568-7629c7e9104e@redhat.com>
 <YffJujbpUGUqpIk/@smile.fi.intel.com>
 <5a3fffc8-b2d8-6ac3-809e-e8e71b66a8ea@redhat.com>
 <YffiwCiFnqF1X1pD@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YffiwCiFnqF1X1pD@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/31/22 14:23, Andy Shevchenko wrote:
> On Mon, Jan 31, 2022 at 01:08:32PM +0100, Javier Martinez Canillas wrote:
>> On 1/31/22 12:36, Andy Shevchenko wrote:
> 
> ...
> 
>>>> +config TINYDRM_SSD130X
>>>> +	tristate "DRM support for Solomon SSD130X OLED displays"
>>>> +	depends on DRM && OF && I2C
>>>
>>> Please, make sure that it does NOT dependent on OF.
>>>
>>
>> I actually added this dependency deliberative. It's true that the driver is using
>> the device properties API and so there isn't anything from the properties parsing
>> point of view that depends on OF. And the original driver didn't depend on OF.
>>
>> But the original driver also only would had worked with Device Trees since the
>> of_device_id table is the only one that contains the device specific data info.
>>
>> The i2c_device_id table only listed the devices supported to match, but then it
>> would only had worked with the default values that are set by the driver.
>>
>> So in practice it *does* depend on OF. I'll be happy to drop that dependency if
>> you provide an acpi_device_id table to match.
> 
> The code is deceptive and you become to a wrong conclusion. No, the driver
> does NOT depend on OF as a matter of fact. The tricky part is the PRP0001
> ACPI PNP ID that allows to reuse it on ACPI-based platforms.
>

Oh, I wasn't aware about PRP0001. I've read about it at:

https://www.kernel.org/doc/Documentation/acpi/enumeration.txt

> That said, please drop OF dependency.
>

Yes, got your point now and will drop the dep. Thanks for the explanation.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


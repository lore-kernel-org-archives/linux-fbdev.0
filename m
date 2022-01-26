Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068F1C2BA4C
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Jan 2022 13:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiAZNqN (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:46:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235339AbiAZNqM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Jan 2022 08:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643204772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nMApqNt1ZgI6jKrx8919Fwq96Y3BR80tJUMXs42hsh8=;
        b=B6HgCI8nroL78duOOFi7iAlArldQR3QdXZEKPcZTehvEeGzWp5J9McfxIYK/t6VxAnW+9T
        c3Sv6FEFR77RfWKN3KnKx1DI14sRgr5JxNCDcRmEYUz+kD+U+UyhW+W82G6TL4svTtTTtO
        fE/AwyaT2AU1qRdCOOJeeANipeRWcAc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-UThEGWT3OQeuWubo1kbdlQ-1; Wed, 26 Jan 2022 08:46:10 -0500
X-MC-Unique: UThEGWT3OQeuWubo1kbdlQ-1
Received: by mail-wr1-f69.google.com with SMTP id v28-20020adfa1dc000000b001dd1cb24081so1897318wrv.10
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 05:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nMApqNt1ZgI6jKrx8919Fwq96Y3BR80tJUMXs42hsh8=;
        b=UwqaNmADEiTM+LX5tIWVZd6Wqc/934x5btIRdZRLKffjf9VBWFCg1reA69o0osdStr
         gHwqK0POpudix0aoR8wiWrzI98GZTRxIpXN4B+tbq42qeenYML+aci0RRygM25QvB98c
         HOvIZtGXJ3sgyOpgTxVTxFZAUh2MIf6szTsXfptG7Rh9ImEDoMJ6jFfy7+0KXuCtCu8/
         KIW3Qh5KjHzZUmkap+oP1HO4z02DvJMT0svpJAvZ62ah+9cZcGLMFIYKNBbeyW66ljOD
         AXuiKSE/7FprBNCaH/vFIC31CPRBer62ICpUbjVoypZBQUqeysg0zEV+DOWyc87+LsbE
         vhkA==
X-Gm-Message-State: AOAM531hrxm9R1pfgZ6KcKDHpKgMD1BKmQesAlCAPcv0WkbAQNfnPR9x
        kviYuiReLmvbU12PYSPisiFek6yk+/q3IMT/TsYftx168ght7lGiZw1yz/j94aIHZuLkwnCjLH8
        H6bpYtYX2YpFToDo7qW0dpJs=
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr7603338wmj.135.1643204769716;
        Wed, 26 Jan 2022 05:46:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzD39jP25QuHyT/d3Ps5v4zM6D8JIYamRlR6NsTAlxrtt8yJfueUZCTKAbWmscHo0FL1EDqYg==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr7603318wmj.135.1643204769510;
        Wed, 26 Jan 2022 05:46:09 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f13sm1652132wry.77.2022.01.26.05.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 05:46:09 -0800 (PST)
Message-ID: <b8eb7111-43aa-cc8a-a1bc-f08e0f2987ed@redhat.com>
Date:   Wed, 26 Jan 2022 14:46:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
 <YfEG2qVO9K9G+g1d@kroah.com>
 <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
 <f671a112-880d-1526-a395-360947b40c5a@gmx.de> <YfEv7OQs98O9wJdJ@kroah.com>
 <YfFIpBb7lL4ukWjm@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfFIpBb7lL4ukWjm@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/26/22 14:12, Andy Shevchenko wrote:
> On Wed, Jan 26, 2022 at 12:26:36PM +0100, Greg Kroah-Hartman wrote:
>> On Wed, Jan 26, 2022 at 12:17:08PM +0100, Helge Deller wrote:
>>> On 1/26/22 11:31, Daniel Vetter wrote:
> 
> ...
> 
>>> You are describing a transitioning over to DRM - which is Ok.
>>> But on that way there is no need to ignore, deny or even kill usage scenarios
>>> which are different compared to your usage scenarios (e.g. embedded devices,
>>> old platforms, slow devices, slow busses, no 3D hardware features,
>>> low-color devices, ...).
>>
>> All of those should be handled by the drm layer, as Daniel keeps
>> pointing out.  If not, then the tinydrm layer needs to be enhanced to do
>> so.
>>
>> Anyone have a pointer to hardware I can buy that is one of these fbtft
>> drivers that I could do a port to drm to see just how much work is
>> really needed here?
> 
> I have bought myself (for other purposes, I mean not to convert the driver(s))
> SSD1306 based display (SPI), SSD1331 (SPI), HX88347d (parallel).
>

I've just bought a SSD1306 (I2C) based one and will attempt to write a DRM
driver using drivers/staging/fbtft/fb_ssd1306.c as a reference.

I didn't find one with a SPI interface but we can later add a transport for
that if I succeed.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


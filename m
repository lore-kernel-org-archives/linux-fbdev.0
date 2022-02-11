Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4D0C4332F
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Feb 2022 12:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbiBKM10 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Feb 2022 07:27:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350076AbiBKM1Y (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Feb 2022 07:27:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C580F75
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 04:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644582436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1jepOygsJ0wYycqVUlKRQbdzNQ74bbTHpehDmycDkk=;
        b=EAhFS3IgC2BMRH9zRewutnPBEsrinK0oh0rBMk4F+rpLgBHpn656Lddz2uBsfsPSmWehlp
        9p+dDp8HLB7QtYp8KQ+/pj4/IQwmnC3rx1ue5b3vAEPqu0z8pyqQHWn3J5qTMqcl1fA+U6
        sZCRnKRn/wVnhRpssyA26o/qJ2YQASA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-BVXHIen6NKuN9-u80Z3l7w-1; Fri, 11 Feb 2022 07:27:15 -0500
X-MC-Unique: BVXHIen6NKuN9-u80Z3l7w-1
Received: by mail-wm1-f69.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so5846269wme.1
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 04:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r1jepOygsJ0wYycqVUlKRQbdzNQ74bbTHpehDmycDkk=;
        b=kLCbpVlQEpzKpOsbDp07MewVi8CpRUpWx6+cmbPkDX42WX7Z4/2hTy1VAPXE7BT8ey
         Bj5v48Bv9uTsC0lx7sonsjEod+RnkmmomYPX1xz3uyUfUplKbI2Igmden7QPnC2EQe8W
         vhE6O+R3cCobj9SdfwLa84EaLcS+ElNYuAkCgOKorDCaJGa6zJqWrCeoSsGTwFNNNwNd
         P5JWx5ngH9HrQjjTvTqDQFueF5dj1z12LeTNnJQHfTxGVZMykcMkj7U0mKtT27dtep3h
         5cCR4UMprGBT0hHM7dl/C6ECXA+XQjxT+xOfluW75hTsvay32PGFV4QRnqVRdZziGgb9
         xnNQ==
X-Gm-Message-State: AOAM531nl6DTva1yPoqpZz0oiq95Kx6dVcgf0FRY7MAgYzw+o1jH2V2H
        9HoaY5jIV6cGFrx0rS6QQSijFg/QfFWv1N4f+/l02YUIVgN2eC5rV6GtXlnnp/K4JBa9CWpsocz
        pcRdIbhYcpJLAvImg98FdAZc=
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr123156wmq.44.1644582434718;
        Fri, 11 Feb 2022 04:27:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaaXjuAalsbgKE6EbrXu5SqtOSmJENkbXZFXygd5mgtIEYu0s5C8pQoelvrRAkNY3tZZipuA==
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr123141wmq.44.1644582434492;
        Fri, 11 Feb 2022 04:27:14 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t18sm22645638wri.34.2022.02.11.04.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 04:27:14 -0800 (PST)
Message-ID: <5b451266-0217-fc4c-794b-453c4e6439f6@redhat.com>
Date:   Fri, 11 Feb 2022 13:27:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/6] drm: Add driver for Solomon SSD130x OLED displays
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-4-javierm@redhat.com>
 <YgZJpi4llqr93U9Y@smile.fi.intel.com>
 <eed8200c-7716-ce4f-dac5-bd6f0345b631@redhat.com>
 <CAMuHMdVLmUwgCWui4OiZqvqpVWzA-d9QhjZLa_idgC19XeEEjA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdVLmUwgCWui4OiZqvqpVWzA-d9QhjZLa_idgC19XeEEjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Geert,

On 2/11/22 13:23, Geert Uytterhoeven wrote:

[snip]

>>>> +    if (IS_ERR(bl)) {
>>>
>>>> +            ret = PTR_ERR(bl);
>>>> +            dev_err_probe(dev, ret, "Unable to register backlight device\n");
>>>> +            return ERR_PTR(ret);
>>>
>>>               dev_err_probe(dev, PTR_ERR(bl), "Unable to register backlight device\n");
>>>               return bl;
>>>
>>> ?
>>
>> No, because this function's return value is a struct ssd130x_device pointer,
>> not a struct backlight_device pointer.
> 
> Hence
> 
>     return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
>                                  "Unable to register backlight device\n"));
> 
> ?
> 

Thanks, that would work.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


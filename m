Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CA3C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Feb 2022 14:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiBIOuR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Feb 2022 09:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbiBIOuQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Feb 2022 09:50:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DEC2C06157B
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Feb 2022 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644418218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCdwEoIBITb866ZII/MklMSrfR+LqGATKN4cy7oWV0k=;
        b=Tz80JRVgzCJt1iWSVO0+IbvqfpexTrcYTsejKkYlUKToOOunUbAn/WbdvtU0jv+x1AC7mQ
        JlJkLr/cA5aP1QdpsP+y/MpLUBrSy15Zj8sDVMplJbbY8OtuCOH9XpcCKmFQLxCwMQewpP
        ifNPczo5aZm/pwGkbw5NCnrMCofW688=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-nR4GF9K9OLS7_hi1gUPjHw-1; Wed, 09 Feb 2022 09:50:17 -0500
X-MC-Unique: nR4GF9K9OLS7_hi1gUPjHw-1
Received: by mail-wr1-f70.google.com with SMTP id e11-20020adf9bcb000000b001e316b01456so1177504wrc.21
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Feb 2022 06:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GCdwEoIBITb866ZII/MklMSrfR+LqGATKN4cy7oWV0k=;
        b=R/zM7tCvJh9hRuKPP+07Ug+Utb4M8dYs6+Tf/6QAbPMGIyPt6speVX5P3ZkQEtI5Hl
         Lrs64H0GArQRKOtPavAAvIYXD+ggWh3vUPqq9Z1XfIc8Agjrlkec8tX/Ur5r1WMPnGn3
         GC6JaNk8wFTxzjo5mpaH2bjF4eKp7nIqd0yplYsks5BMs2pCh01HVm2Ea4vHwdSPvZe9
         z0N6USdLLXFlvSBuMzjyJ4HK/jjn8D7hT4cPQ8RWZifm80iWrAIEjQn6PXTuE5JcrCh0
         g6iT4B5Ov9LKhHg0WtCk91IAasd/TxR+abcLUZ8kseWtCb/5ZoHvZO5kZgXzfewzYUQP
         IbPg==
X-Gm-Message-State: AOAM530JyybE0UV514iy8I7JDo+ANYsi1OqB8a71MUhZ1EukMgnX4XKw
        vv61Csb0MwfSt0RS/eq1Avn7sZ9ac5h3a7Adn34+YHpZAkpKkGL5WY2nTkKQBA2u5Le/jZuM8Ai
        vKD9fZWS8l312nZOPJQk8u2k=
X-Received: by 2002:adf:c74f:: with SMTP id b15mr2468807wrh.307.1644418216021;
        Wed, 09 Feb 2022 06:50:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ+aCmdyVfsqG8nX2yK7Vow4vj4dB6fQbmE3flM8O2RH71KLJgArlRFmLkg6F73kXfRljWzw==
X-Received: by 2002:adf:c74f:: with SMTP id b15mr2468781wrh.307.1644418215812;
        Wed, 09 Feb 2022 06:50:15 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t4sm15470023wro.71.2022.02.09.06.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 06:50:15 -0800 (PST)
Message-ID: <561e1f22-2741-b414-0267-14587d59d5de@redhat.com>
Date:   Wed, 9 Feb 2022 15:50:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/7] drm: Add driver for Solomon SSD130X OLED displays
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-4-javierm@redhat.com>
 <YgPE8Z7HxU2wv7J/@sirena.org.uk>
 <d1025530-90e1-fbc5-c06b-f62ed83f2f19@redhat.com>
 <YgPOKf1QcOCtTisx@sirena.org.uk>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgPOKf1QcOCtTisx@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/9/22 15:22, Mark Brown wrote:
> On Wed, Feb 09, 2022 at 03:17:06PM +0100, Javier Martinez Canillas wrote:
>> On 2/9/22 14:43, Mark Brown wrote:
> 
>>> Unless the device supports power being physically omitted regulator
>>> usage should not be optional, it's just more code and a recipie for poor
>>> error handling.
> 
>> The device has a VCC pin but in most cases this is just connected to a
>> power provided by the board in its pinout header. For example, I've it
>> connected to a rpi4 3.3v pin.
> 
> That sounds like a very common configuration.
>

Yep.
 
>> I guess in that case what we should do then is to just have a regulator
>> fixed as the vbat-supply in the Device Tree, that's regulator-always-on.
> 
> Generally I'd suggest labelling things with whatever the supply is
> called in the board's schematics/documentation, that tends to make
> things clearer and easier to follow.
> 

The display controller datasheet and schematics mention VBAT as the power
supply but the documentation says that it's just connected to VCC and the
label in the display says VCC.

But I understand why the Device Tree binding and fbdev driver used VBAT
since that's what the documentation mentions.

>> The old ssd1307fb fbdev driver also had this as optional and I wanted to
>> keep the new driver as backward compatible. But I understand now that is
>> not describing the hardware properly by making this regulator optional.
> 
> It is depressingly common to see broken code here, unfortunately
> graphics drivers seem like one of the most common offendors.

I'll include a patch for the existing DT binding and mark the vbat-supply
property as required. Probably we won't be able to change the fbdev driver
without causing regressions, and I'm not interested in that driver anyways.

Best regards,
--
Javier Martinez Canillas
Linux Engineering
Red Hat


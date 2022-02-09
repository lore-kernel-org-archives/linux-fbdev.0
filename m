Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9980DC4332F
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Feb 2022 15:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbiBIPRE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Feb 2022 10:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiBIPRD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Feb 2022 10:17:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFB20C06157B
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Feb 2022 07:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644419825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZD9dCqlbkWPQFIsrIeQChrUtyGkYhsH8g7u08/+oBc=;
        b=aiDfb9LSX2OpigVgFbQBkga+Fl1j5JJW1QSsAxd554Sp1wCxKlYf5Qs0PN9H9hkVa4F3Is
        fFMXcsE95+lq+NdVrZ4Xyt97arskmaEHPU4pnIQtqcx11oqVuF7DUqTkAj9ZF7qWUtYoyO
        rbhvrxI3Uf5mlNXdqWhK+e1aUVvj9Io=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-TsQwRo2gOYmKCZ5yFn3zag-1; Wed, 09 Feb 2022 10:17:04 -0500
X-MC-Unique: TsQwRo2gOYmKCZ5yFn3zag-1
Received: by mail-wm1-f72.google.com with SMTP id 22-20020a05600c229600b0037be079ebf6so226518wmf.9
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Feb 2022 07:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JZD9dCqlbkWPQFIsrIeQChrUtyGkYhsH8g7u08/+oBc=;
        b=17zNkyggdbLDZ/DPERivr7LYFVZ+napc9yBxwns9AtnRq3Ghb9uxG6UZRpph2/g30L
         j9FkRiqsEX6CD3cz46i0zoIxtbYs9PA0Fgy1P5L1cxfkT64KuUmxDCfouFvcOhgKWQ5K
         B5qGr3/MjJmXyzwUvi61BqaJsgJO4fFNgzTiQS7A08aoejUeq9Yubx9wGgcXPcxY4J/S
         obhNj1uExGKznvWNKmY/s47jXlE+hhi2IbKwCFwVJuDo+CeV+qos2ab4z9uTOJyDZGEz
         1ONSEkk//1kq/nUE0Fdlg1Jco0alf8uKG8oXNdo1JUQWACOmNm0FA9N0Tcvwi4akBgXM
         QgSA==
X-Gm-Message-State: AOAM530FHaXy4RKrNkpqOdXVLJZHiInYcbie+XGjRLPbGlIbSCK+rgsA
        l0gYNOGh9Pv83jCpUi5CqkIo64sX2iSarG4MMbxQK2acnLAsHTV5ul9fux0Ux95AIPxweJewcd8
        39G74CsEcSWpCCMb877Eiz8s=
X-Received: by 2002:a5d:400a:: with SMTP id n10mr2558443wrp.603.1644419823607;
        Wed, 09 Feb 2022 07:17:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwBI5JHyrlxNbjKeheaShrdmdoiXX+Yt+7r3vslDt7sGcUMaDwOeXIfrlF8TXqbtzjMD2TuQ==
X-Received: by 2002:a5d:400a:: with SMTP id n10mr2558428wrp.603.1644419823415;
        Wed, 09 Feb 2022 07:17:03 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p8sm18149378wrr.16.2022.02.09.07.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 07:17:03 -0800 (PST)
Message-ID: <600f0f72-4af8-1c43-33a5-a0b5ef97c3c7@redhat.com>
Date:   Wed, 9 Feb 2022 16:17:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/7] drm: Add driver for Solomon SSD130X OLED displays
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-4-javierm@redhat.com>
 <YgPE8Z7HxU2wv7J/@sirena.org.uk>
 <d1025530-90e1-fbc5-c06b-f62ed83f2f19@redhat.com>
 <YgPOKf1QcOCtTisx@sirena.org.uk>
 <561e1f22-2741-b414-0267-14587d59d5de@redhat.com>
 <YgPX3WZRvnWBuV18@sirena.org.uk>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgPX3WZRvnWBuV18@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/9/22 16:03, Mark Brown wrote:
> On Wed, Feb 09, 2022 at 03:50:13PM +0100, Javier Martinez Canillas wrote:

[snip]

> 
>> But I understand why the Device Tree binding and fbdev driver used VBAT
>> since that's what the documentation mentions.
> 
> What is "the documentation" in this context and how is that distinct
> from the datasheet for the display controller?  In general the consumer
> driver should be using the name from the datasheet and the regulator
> itself should get a regulator-name reflecting the name in the schematic.
>

For "documentation" I meant the datasheet that mentions VBAT but I got
what you mean and will also propose a change to the binding to rename
the property to vcc-supply instead to match the pin name in the device.

>>> It is depressingly common to see broken code here, unfortunately
>>> graphics drivers seem like one of the most common offendors.
> 
>> I'll include a patch for the existing DT binding and mark the vbat-supply
>> property as required. Probably we won't be able to change the fbdev driver
>> without causing regressions, and I'm not interested in that driver anyways.
> 
> There should be little danger of causing regressions given that a dummy
> regualtor will be provided when one is missing.

Right, I forgot that a dummy regulator is provided in that case. Perfect.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


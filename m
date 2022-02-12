Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B7DC433EF
	for <linux-fbdev@archiver.kernel.org>; Sat, 12 Feb 2022 12:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiBLMAH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 12 Feb 2022 07:00:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiBLMAG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 12 Feb 2022 07:00:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E70E72657A
        for <linux-fbdev@vger.kernel.org>; Sat, 12 Feb 2022 04:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644667202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jK813oefzdJ0/6NSnx2Rn+uJkfooQvk/5JjGhJEhjG4=;
        b=M5cSn+lbzAwUUNA3X6M13PUh/jnYhepGRkA+ttNY2lxgINVLH3yg8r2U1KUP5SwVTiqR8i
        zL+GZdyLUpvidUzgtq+Gi93FZOgOI6qrLiUs4LHAN8HkxxXrt0nwXmXgl5ZK5Bg4z3tke6
        V6L5+LqTQLj0LN0HN3LVnmehDhoQeCM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-dpbtpJBzNHiFwYaxb-fR2Q-1; Sat, 12 Feb 2022 07:00:00 -0500
X-MC-Unique: dpbtpJBzNHiFwYaxb-fR2Q-1
Received: by mail-wm1-f71.google.com with SMTP id ay41-20020a05600c1e2900b0037c5168b3c4so981040wmb.7
        for <linux-fbdev@vger.kernel.org>; Sat, 12 Feb 2022 04:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=jK813oefzdJ0/6NSnx2Rn+uJkfooQvk/5JjGhJEhjG4=;
        b=0r4wJO+oxu5fjKo65o/XsIzYrFRr+D1Cyfx5MzVX8zTUXrxL+0Pi4CmG7hSfMPsVR7
         JtOx92V6Qobw1k6Sb73m9hqdrO8OO8jvkT//P0gwBwZiMPjyx47xkYNRWeClGUD5xKzw
         FRfSHbe3h94MZFpmmpk7iqOU5d88DohOrndhiyDgBrrHhnLO62xEM8j/phEhpgQ/kUtu
         d7PStkO68Z7wTyYOGgH9d0yw8s9QPsH/Iz0z9/g/GHi4Qgr2AFYpzU5rJa27IkXbZnwO
         8E8RyaM7vt4szb2YpGLAqxysnweIfZAjZOK+6pbRsZ4Z72vRmeMVWAq92NeucoOwxCWU
         MHAA==
X-Gm-Message-State: AOAM531+5cTgy4gpbUwOYuZvtw70HogZDkenphvO+avqe7s7dSNDS+Rj
        OfaWjwsfGLIXoh6FwYt+pQ4mZuxg8kIN6tQJY/mb1EGjyvYSUvKx+xvELkcF6rRex27ipuhjBUF
        ayjZVScItC29W0BYeRlJHrhs=
X-Received: by 2002:a1c:f719:: with SMTP id v25mr4009108wmh.76.1644667199564;
        Sat, 12 Feb 2022 03:59:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqcd4dGlKYOI049Do/ZHhERD6/7Hy1dVWu5MU99kNymZnm7xY+hxKOCJB2SsFLPO7HLwF65A==
X-Received: by 2002:a1c:f719:: with SMTP id v25mr4009079wmh.76.1644667199249;
        Sat, 12 Feb 2022 03:59:59 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m6sm27501060wrw.54.2022.02.12.03.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Feb 2022 03:59:58 -0800 (PST)
Message-ID: <3e749d3b-a307-2c9e-be0a-2d2fc4647dd5@redhat.com>
Date:   Sat, 12 Feb 2022 12:59:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 3/6] drm: Add driver for Solomon SSD130x OLED displays
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
References: <20220211143358.3112958-1-javierm@redhat.com>
 <20220211143358.3112958-4-javierm@redhat.com>
 <YgaLGDVscXlANxcZ@smile.fi.intel.com>
 <001ee392-d457-31e5-0087-272ef82afd12@redhat.com>
In-Reply-To: <001ee392-d457-31e5-0087-272ef82afd12@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/11/22 20:19, Javier Martinez Canillas wrote:

[snip]

>> I would put GENMASK() directly into FIELD(), but it's up to you
>> (and I haven't checked the use of *_MASK anyway).
>>
> 
> Same. I also considered just using GENMASK() directly, but since I was
> already reworking these, I thought that having the _MASK constant macros
> would make the code more explicit about these being masks and what for.
>

Just to make clear, I prefer to keep the GENMASK(n, n) and *_MASK here.

[snip]

>>
>>> +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
>>> +					    &ssd130xfb_bl_ops, NULL);
>>> +	if (IS_ERR(bl))
>>> +		return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
>>> +					     "Unable to register backlight device\n"));
>>
>> Can be consistent with this then.
>>
> 
> Yes. I meant to change it everywhere but seems that one slipped it through.
> 
> It's not worth to send a v6 just for the changes you mentioned but I can do
> them before pushing the patches to drm-misc (once I get ack for this patch).
> 

Another option is to post a v6 only for patch 3/6 instead of all the patch-set.
Let me know what you prefer.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


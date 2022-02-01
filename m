Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE17C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Feb 2022 13:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiBANzx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Feb 2022 08:55:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235148AbiBANzx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 1 Feb 2022 08:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643723752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fiDgurBW1NwAiqY2GLiQR5aJEIehzQmgOw53j3Z2hSA=;
        b=EKGUZtDSrQ5uDy7Ds7FTLb9ZRY5FpT9aBjk1yygwYkROtI8n2iATiKY9p5EFY2rKBCbhtH
        4eLsRhBJVQU3cGMHLT7HQHG97/obydURx1rUvDa+9JgdQ5r08dst020ttoponhjSQCbfaQ
        +Iow6dN3/VeDGBPtpwWE7yUGlOPu7m4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-1OSJNlshOXWJoV11_Z_gSQ-1; Tue, 01 Feb 2022 08:55:51 -0500
X-MC-Unique: 1OSJNlshOXWJoV11_Z_gSQ-1
Received: by mail-wr1-f70.google.com with SMTP id x4-20020adfbb44000000b001d83e815683so6012853wrg.8
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Feb 2022 05:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fiDgurBW1NwAiqY2GLiQR5aJEIehzQmgOw53j3Z2hSA=;
        b=cIKPO9lUxpu0Kk50aigruwErlmNLwjNgrSawBGNzV/E5/8WEfJsk5OnXf9I7vwr5dz
         Yazkdw9GfzeO7SkPBW6WL7ii9NR4LN6VBSK5a5b40dEhZygsGp64Jae5Ns6vY6iE2mZy
         OgHKVwrfEKwAjU+FZt8SDX6DKA3g4LZS5nDntr0qXJDVi8EbU0s7C5ZOdb2vcXA0Bgfi
         CT4FjV4tz45igz19TaetU6W+k+pgABecZhShQiWagOUPZZcb/bfUyf1nFd0tOYsWaPey
         bl90yEJuAe2z8WCzUzyQ+CYOlR2i1W52/a+fQY9u3oZikLqqMTQuObuv0Y5LihaJDc+/
         KZjA==
X-Gm-Message-State: AOAM533pgUMrDxJK3cpGbNA0QQkCNE2jNYcgq9xF8D3Q4a5oQyNWrWTr
        dTG8WL9hLIdviNRKHXXtkUfpGTz0VqJ04o+Rzby0kR6k8ZtsbrN/QsFmHBe7220k8GIoDp1QFC+
        0i6wXoHtqFapuTn7RV7kThbY=
X-Received: by 2002:a05:600c:308:: with SMTP id q8mr1920547wmd.118.1643723750415;
        Tue, 01 Feb 2022 05:55:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiMcaMwXhPvSvseRwur0kl1vzm4WxKS+ITQZ4fi35QJL+D2oLFM2CJItTZMN0+Csgh1HP6Iw==
X-Received: by 2002:a05:600c:308:: with SMTP id q8mr1920525wmd.118.1643723750213;
        Tue, 01 Feb 2022 05:55:50 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y14sm16638445wrd.91.2022.02.01.05.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 05:55:49 -0800 (PST)
Message-ID: <f1c3557a-a24b-9764-ff3f-9df352e37188@redhat.com>
Date:   Tue, 1 Feb 2022 14:55:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] drm: Add I2C connector type
Content-Language: en-US
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <20220131201225.2324984-2-javierm@redhat.com> <YfhMESTylI1NTKDg@ravnborg.org>
 <4d9a56a7-da25-b411-61cc-372c6fa9011d@tronnes.org>
 <4322f58b-dbeb-b90f-2770-d6881f8005b4@redhat.com>
 <a6f267ea-7617-7d0e-06cd-7ec9c88576c3@tronnes.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <a6f267ea-7617-7d0e-06cd-7ec9c88576c3@tronnes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/1/22 14:20, Noralf Trønnes wrote:
> 
> 
> Den 01.02.2022 14.06, skrev Javier Martinez Canillas:
>> Hello Noralf,
>>
>> On 2/1/22 13:58, Noralf Trønnes wrote:
>>>
>>>
>>> Den 31.01.2022 21.52, skrev Sam Ravnborg:
>>>> On Mon, Jan 31, 2022 at 09:12:21PM +0100, Javier Martinez Canillas wrote:
>>>>> There isn't a connector type for display controllers accesed through I2C,
>>>>> most drivers use DRM_MODE_CONNECTOR_Unknown or DRM_MODE_CONNECTOR_VIRTUAL.
>>>>>
>>>>> Add an I2C connector type to match the actual connector.
>>>>>
>>>>> As Noralf Trønnes mentions in commit fc06bf1d76d6 ("drm: Add SPI connector
>>>>> type"), user-space should be able to cope with a connector type that does
>>>>> not yet understand.
>>>>>
>>>
>>> It turned out that I wasn't entirely correct here, mpv didn't cope with
>>> unknown types. In the PR to add support Emil Velikov wondered if libdrm
>>> should handle these connector names:
>>> https://github.com/mpv-player/mpv/pull/8989#issuecomment-879187711
>>>
>>
>> I see, thanks for the information. What should we do then, just use the type
>> DRM_MODE_CONNECTOR_Unknown then ?
>>
> 
> Not really, I just wanted to point out that it could be that not all
> userspace will handle an unknown connector type (I just checked the DE's
> at the time). I haven't seen any issues after adding the SPI type so it
> can't be that many apps that has problems. Adding to that a tiny
> monochrome display is limited in which applications it will encounter I
> guess :) It was after adding the USB type that I discovered that mpv
> didn't work.
> 

Anything we do for this rather obscure hardware certainly won't be an
issue for most applications :)

But I wasn't sure if your previous comment meant that you were nacking
$subject. Glad that we can go ahead and describe the correct type then.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


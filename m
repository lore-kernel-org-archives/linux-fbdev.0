Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E72C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 10:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347886AbiEDKNj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 06:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347765AbiEDKNh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 06:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F22025EAF
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651659001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h0lQ4WsgFPJsp1ulb+JMYEc+kaUBtSccCtW0azhOPgQ=;
        b=hASSJG8Vl1SLsGjbcX3AeOesUCw0tdam+uEdvPX2byo8Fz7N7KC9M4Amr5eFS+HqEVaGHp
        8JdKja9tdqesgo8DXdE1O95wUyg3tgDe57hYaSloSjHpeTbdbUrMfi8kjKmYTq6QV2+EBQ
        WBA+NsjbOE1y4uaQzV59yUSWJJGi5Xk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-JwDZEyeUOieL63iHvsYpRw-1; Wed, 04 May 2022 06:10:00 -0400
X-MC-Unique: JwDZEyeUOieL63iHvsYpRw-1
Received: by mail-wr1-f69.google.com with SMTP id w11-20020adf8bcb000000b0020c550ba8d7so223596wra.1
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 03:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h0lQ4WsgFPJsp1ulb+JMYEc+kaUBtSccCtW0azhOPgQ=;
        b=mdENvvX1yUZiymaBccNNbWJb2vIm+uF5boLcBfLUq6pK3nrXQETV+wCNsFlQJU997R
         4sGKwMy4xdezev8N5qSzo4h9/UZ7TBHmsRmTAqjnp4XlDOgJL060AAyaaXD2KAbIZ/Gh
         y3pg2TCzakOuGeJnAs8xKjEPf091DRMB7GZ42k5gQUAC4Yk24xOqEmBchP4FuG7sbr0v
         vStBS+V9c6LOzqhReC/0p1P/e/E94xNGf4y1juCWzM13JD90y+u2KtF/k57YXpaP/VbZ
         Bit0MyDcU7leH90xwj+F3xe0NlXHJ2N1I7tfPRlqwsGSNQdTkuVlkwKzMCSoGc9JdXiX
         rI1w==
X-Gm-Message-State: AOAM53018/xVMBQ0wL/Yc16jn52fzn/5kdybxUsB4N2a0FUzJv6+Q+gB
        d7QTjLM70Ej6hmFIAWCJl9rDvf+jkekOcMXfKaX8NsWWH3vuyhXmUvbWhbPpKTOo5PIFvbir2cw
        bghAUdd8BqUTnrG/FtPnC7Gc=
X-Received: by 2002:a05:6000:223:b0:20a:db3a:e761 with SMTP id l3-20020a056000022300b0020adb3ae761mr15696818wrz.43.1651658998709;
        Wed, 04 May 2022 03:09:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9+/TJm9nPuMdJXDM+zbHxG24AuYQigyhiwepT1ww6i3gxv0mmZGOpaYHxRVA7W1CP9TiF/g==
X-Received: by 2002:a05:6000:223:b0:20a:db3a:e761 with SMTP id l3-20020a056000022300b0020adb3ae761mr15696802wrz.43.1651658998486;
        Wed, 04 May 2022 03:09:58 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l20-20020adfc794000000b0020c5253d8dfsm12191902wrg.43.2022.05.04.03.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 03:09:58 -0700 (PDT)
Message-ID: <8a4d6469-d3c0-833d-40c8-3a786d04eba4@redhat.com>
Date:   Wed, 4 May 2022 12:09:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] fbdev: Make fb_release() return -ENODEV if fbdev was
 unregistered
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220502130944.363776-1-javierm@redhat.com>
 <20220502130944.363776-3-javierm@redhat.com>
 <YnJLzY7Yiax/AwMx@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnJLzY7Yiax/AwMx@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Daniel,

On 5/4/22 11:47, Daniel Vetter wrote:
> On Mon, May 02, 2022 at 03:09:44PM +0200, Javier Martinez Canillas wrote:
>> A reference to the framebuffer device struct fb_info is stored in the file
>> private data, but this reference could no longer be valid and must not be
>> accessed directly. Instead, the file_fb_info() accessor function must be
>> used since it does sanity checking to make sure that the fb_info is valid.
>>
>> This can happen for example if the fbdev driver was one that is using a
>> framebuffer provided by the system firmware. In that case, the fbdev core
>> could unregister the framebuffer device if a real video driver is probed.
>>
>> Reported-by: Maxime Ripard <maxime@cerno.tech>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Doesn't this mean we just leak the references? Also anything the driver
> might refcount in fb_open would be leaked too.
>

It maybe result in leaks, that's true. But I don't think we can do anything
at this point since the fb_info just went away and the file->private_data
reference is no longer valid...
 
> I'm not sure what exactly you're trying to fix here, but this looks a bit
> wrong.
>

This is fixing a NULL pointer deref that at least 3 people reported, i.e:

https://github.com/raspberrypi/linux/issues/5011

Because if a real DRM driver is probed, then the registered framebuffer
is unregistered and the fb_info just freed. But user-space has no way to
know and on close the kernel will try to dereference a NULL pointer.
 
> Maybe stepping back what fbdev would need, but doesn't have (see the
> commit reference I dropped on the previous version) is drm_dev_enter/exit
> around hw access. the file_fb_info check essentially provides that, but
> with races and everything.
>

Yes, but I don't know how that could work since user-space can just open
the fbdev, mmap it, write to the mmap'ed memory and then close it. The
only way that this could be done safely AFAICT is if we prevent the real
video drivers to be registered if the fbdev is currently mmap'ed.

Otherwise, the firmware initialized framebuffer will go away anyways and
things will break for the user-space process that's currently using it.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


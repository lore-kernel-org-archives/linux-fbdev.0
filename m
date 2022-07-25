Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07670C43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Jul 2022 15:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiGYPRu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 25 Jul 2022 11:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbiGYPRf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Jul 2022 11:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF8DC1CB24
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Jul 2022 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658762026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qIjBp600Z2DVdMwt/gjvKJmffQT0bObTcC/1zEfoAm8=;
        b=bZaRs4B2ym+2QOPFQjOAbfg71goEbHjlcp08UHOqvYc5iy6dIrZJiAqlJi3wB6ZyViaI5S
        4i4qKNfiVSfYqopxk9bQri1zz3vMiXoYzr2pmweBZw8jCynY4qxw4J7fv9lEAneDk/xJxs
        TzL/sL8GNvxZZ+JQwLH4aACEDNB+u6k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-JDiX-08PPU-8EtBWSXHxBQ-1; Mon, 25 Jul 2022 11:13:45 -0400
X-MC-Unique: JDiX-08PPU-8EtBWSXHxBQ-1
Received: by mail-wr1-f69.google.com with SMTP id q9-20020adfb189000000b0021e3e7d3242so1658616wra.19
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Jul 2022 08:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qIjBp600Z2DVdMwt/gjvKJmffQT0bObTcC/1zEfoAm8=;
        b=m0dwhMQl4K5lWH/87nB31SasINsWqLfj6FGjE2N3K2MYpTTaMLOXFFffZJAUvLYBvM
         shO+I0By85RuEUpzdu8Se/0uiAtUpfnMsczUAt5AHv8D8QruPDdGmU9fwNH3hhGKVoz0
         FhPnAfStFnFxRAepOsDF5u0VJGCTk8S3VVMKLcb1/zrwhY8aiohvCdgrdxZbJ2zQA5Z7
         b796bZCRC/vfcnMNn7nkypMvzQWSsyhiarC40zWuyXPkTEtIW9PrtU45FzbAYr0bPL+h
         ax+XPukj5HazuBCd1YZ0wOli7xM7Aad9vmE0c6SzsO41QJCPeW36TR93Ue0TtSpi0WM+
         XFaw==
X-Gm-Message-State: AJIora/D02z5rUxA3ZdokCAxPH39ew6qGq9Xfxc73+dmc5Lng6pE0CbJ
        GpQv3OSX28rlEg3mSS+J+nZUy/rs3fikJuFoskJfI6yNW+x/Qps7lyXQSelOjm6+2fMcjZLs1Ug
        TLnij4RVLfyGT2SN/e1Ou3do=
X-Received: by 2002:a05:6000:1e04:b0:21d:7ec3:fe5a with SMTP id bj4-20020a0560001e0400b0021d7ec3fe5amr8403048wrb.116.1658762023281;
        Mon, 25 Jul 2022 08:13:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sg48NwSZslMMuiqCHHVdPEPWZQ5xtRMvOi0g+wQFzFzNZnoLqP7GO9eKmHlB+7GyvtZqAIGQ==
X-Received: by 2002:a05:6000:1e04:b0:21d:7ec3:fe5a with SMTP id bj4-20020a0560001e0400b0021d7ec3fe5amr8403017wrb.116.1658762022953;
        Mon, 25 Jul 2022 08:13:42 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c510200b003a2d6f26babsm15568434wms.3.2022.07.25.08.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 08:13:42 -0700 (PDT)
Message-ID: <4a7c2c1d-2bf9-84e7-9257-41fcfd66ab9d@redhat.com>
Date:   Mon, 25 Jul 2022 17:13:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 04/10] drm/simpledrm: Compute framebuffer stride if not
 set
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <20220720142732.32041-5-tzimmermann@suse.de>
 <CAMuHMdWEah62Ho4C8NQr-qwz62pKQiJiTi8Fa4KcXNRzo7ySJA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWEah62Ho4C8NQr-qwz62pKQiJiTi8Fa4KcXNRzo7ySJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Geert,

On 7/21/22 16:46, Geert Uytterhoeven wrote:
> Hi Thomas,
> 
> On Wed, Jul 20, 2022 at 4:27 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Compute the framebuffer's scanline stride length if not given by
>> the simplefb data.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Thanks for your patch!
> 
>> --- a/drivers/gpu/drm/tiny/simpledrm.c
>> +++ b/drivers/gpu/drm/tiny/simpledrm.c
>> @@ -743,6 +743,9 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>>                 drm_err(dev, "no simplefb configuration found\n");
>>                 return ERR_PTR(-ENODEV);
>>         }
>> +       if (!stride)
>> +               stride = format->cpp[0] * width;
> 
> DIV_ROUND_UP(drm_format_info_bpp(format) * width, 8)
>

I think you meant here:

DIV_ROUND_UP(drm_format_info_bpp(format, 0) * width, 8) ?
 
With that change,

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C608AC433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Feb 2022 12:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiBIMlT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Feb 2022 07:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiBIMlT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Feb 2022 07:41:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA8E2C05CB96
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Feb 2022 04:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644410482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2T/ZX315dLjrEaKbTpQjrwkLEmj/39CedeR+myw2pnM=;
        b=TKFMDoOM9aKBd4xApx2XssVsggMt/8CQAFxj9otRZOITcutpgqeRTCnTCDZFjm5cPNj+SU
        c+9rU3BYuUgw5YZUPDgytnuWWIx+C5jY3eU/g/Ue6uKo6OyWOZONC8cIGvHvSZH7IjYfNs
        hogfAFo2zkx9FXvzjfAErU/xqbgxFdg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-KU3nEjM_PUeaSCx8SIW8Iw-1; Wed, 09 Feb 2022 07:41:20 -0500
X-MC-Unique: KU3nEjM_PUeaSCx8SIW8Iw-1
Received: by mail-wr1-f72.google.com with SMTP id r2-20020adfa142000000b001e176ac1ec3so1069882wrr.3
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Feb 2022 04:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2T/ZX315dLjrEaKbTpQjrwkLEmj/39CedeR+myw2pnM=;
        b=Ik0zOcKHo9AmsDvYoOxBJP636gd2Y1quAYc16VZWNuOhE0JZEdtXIjEbFglepJI7eG
         PrCRZvYzdl1wrZFCufTX21NnWJg87clAiDVP7CLqAwV8FM1OD8PfIVxhFM+pDaQqOFsy
         Kc/2e+8eIDMsyUnq9+JJ2mPPJl11SZV9GeWo/AAMvtrKG3rX3sq0QN59VqqpS3Q48kTR
         2ajmfpG+VFFd4yaZApLBPITNxJ2wfOCW83r+NgU2/qW9tst8ud1Al8uP4AwjPxD5dFut
         e5S4CI7BGAI2KdxHWlb67ad2fFjJolpmzBotsP840I9SPANhiK4DVmIdcHqUoHLPPWdF
         qU3g==
X-Gm-Message-State: AOAM530IDe8pW0x75gowZZRsAS4lYPSXTtgG66INnjYcl/dRQx0y7q9u
        oGubLvNflJJFRIsFScYDtKXk8t8NowK5hxmZukHcLmSA8mNrXGuBUtwD44/yTzLNDM+xZ/z1mYg
        nq1RgZmDHRkmMEm9OmAUZbpM=
X-Received: by 2002:a5d:64af:: with SMTP id m15mr1973595wrp.478.1644410479717;
        Wed, 09 Feb 2022 04:41:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPYKui1CF0MIpN4jnFuKlY7TO7NxCK4qlra0MJS9GiBFjcirpTBRptBCzbYbNupz5K+sxp5g==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr1973587wrp.478.1644410479500;
        Wed, 09 Feb 2022 04:41:19 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p3sm5299211wmq.40.2022.02.09.04.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 04:41:19 -0800 (PST)
Message-ID: <29312c12-5684-b134-3e0f-e02240c574c6@redhat.com>
Date:   Wed, 9 Feb 2022 13:41:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/7] drm/solomon: Add SSD130X OLED displays I2C support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-5-javierm@redhat.com>
 <CAMuHMdXOfz94gD+SpGRS7HazxA_PN3n2D=Q04CPm-eEMb_CkEw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdXOfz94gD+SpGRS7HazxA_PN3n2D=Q04CPm-eEMb_CkEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Geert,

Thanks for your feedback.

On 2/9/22 13:21, Geert Uytterhoeven wrote:

[snip]

> 
>> +static const struct of_device_id ssd130x_of_match[] = {
>> +       {
>> +               .compatible = "solomon,ssd1305fb-i2c",
>> +               .data = (void *)&ssd130x_ssd1305_deviceinfo,
> 
> The casts are not needed.
> 

Right. I copied the table from the ssd1307fb driver verbatim. I'll clean it up.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


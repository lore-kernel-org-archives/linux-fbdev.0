Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6CAC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Apr 2022 17:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381051AbiDTRWK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 20 Apr 2022 13:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381015AbiDTRWI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 20 Apr 2022 13:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E897B46150
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Apr 2022 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650475161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8WE22VxbN1gg12dVEBct61VeLxa0U0wVvS6fYCbCOo0=;
        b=iOdpV1rS2tjTYFEy7GxQXPVN4UkqyCqd721S+Q6pNlU3+WlfUPIVCfppc6FfX43shMVoqR
        7yLu7kyR64XbVuTt3Bfz3JFHJdFQm75o9yS36Ha7zNEXy9IEQpV/Evj+8PkO3s1BZxQCB4
        myZ4D4b0WlJpsKYEwwN4xFTXI8DKyBo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-jF2AeY5VO8CWN28F2Kedpw-1; Wed, 20 Apr 2022 13:19:18 -0400
X-MC-Unique: jF2AeY5VO8CWN28F2Kedpw-1
Received: by mail-wm1-f72.google.com with SMTP id q188-20020a1c43c5000000b003928f679c42so1153460wma.5
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Apr 2022 10:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=8WE22VxbN1gg12dVEBct61VeLxa0U0wVvS6fYCbCOo0=;
        b=1jti0bPc2Et0mPtHZsXhystNOqVSHwewpDCnBkpgZac7vmW4MsvD1ADUWM+nVw55T+
         arPtLYsTTTayFfHSi0f5SLt6PWGJs9ToCWhfFmDvAkwcJHgwDx8ch1riqDRAW6q6pYGS
         JT23nuAdhGWCRyl3W4IM+YQ9MNKQG/x1XtAUh+OfcqFrOPB8p1VsRN7b9XIgzJ27MEDm
         +L39TJMzJUDH/x+NBZ58GmznJN2Bhh6uwrRXdYaF1Q3mEwgopJjYZrq9BSXrWIRh+r1F
         tWXrInq4i1Lj6VNpnszekWmLpdKWQREXPfpWf4BaRilUzxPQBH2sl7P45rksuTkzgUAe
         TQDw==
X-Gm-Message-State: AOAM5308DDVUmBCnjtEa09bhDThIE3Qk3Yh/bCHIEL3reVbXc69zuofC
        WchYohXWWXmUtybtZnnHXLWqZ+5FBLWiAAtqmx7B0GtzLmmy16Do2KA/Y1iO/TSM1kSHcZkNwhH
        h8CMA/MldE9BXS6ajJPGLBxo=
X-Received: by 2002:a1c:f605:0:b0:37b:b5de:89a0 with SMTP id w5-20020a1cf605000000b0037bb5de89a0mr4631147wmc.88.1650475155375;
        Wed, 20 Apr 2022 10:19:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxl5ctt7vDZBEVXVTgasUErK1Xu3KASfnJV+d0id411WCB95qt2LS8YqIMFqmRv7QhA0TQDFg==
X-Received: by 2002:a1c:f605:0:b0:37b:b5de:89a0 with SMTP id w5-20020a1cf605000000b0037bb5de89a0mr4631125wmc.88.1650475155130;
        Wed, 20 Apr 2022 10:19:15 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm305270wmq.46.2022.04.20.10.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 10:19:14 -0700 (PDT)
Message-ID: <10561c08-c021-74be-b07b-a3489502e38f@redhat.com>
Date:   Wed, 20 Apr 2022 19:19:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] Staging: fbtft: Fix style problem in header
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Ian Cowan <ian@linux.cowan.aero>
Cc:     gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20220419192128.445023-1-ian@linux.cowan.aero>
 <20220420064711.xuhuyhtgcrs3avhk@pengutronix.de> <YmARR6+XQeVqlusK@fedora>
 <20220420143608.yuxleiffs234dfog@pengutronix.de>
 <e4f56999-cf58-abff-edf5-ae11d024012b@redhat.com>
In-Reply-To: <e4f56999-cf58-abff-edf5-ae11d024012b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 4/20/22 17:47, Javier Martinez Canillas wrote:

[snip]

>>
>>> When I built this, it appeared to succeed. I used the command "make
>>> M=/drivers/staging/fbtft modules". Is this incorrect? For reference this
>>> is my first patch so it's highly likely I did this incorrectly.
>>
> 
> You are just changing a header file though, did you also enable one of the
> fbtft drivers as a module to see if those build? But as said, by looking at
> the code it seems that should build correctly.
> 

It seems that this is the problem with Ian's build test. If I enabled both
CONFIG_FB_TFT=y and CONFIG_FB_TFT_AGM1264K_FL=m, I get the following build
error (as Uwe pointed out before):

$ make M=drivers/staging/fbtft/
  CC [M]  drivers/staging/fbtft/fb_agm1264k-fl.o
In file included from drivers/staging/fbtft/fb_agm1264k-fl.c:15:
drivers/staging/fbtft/fbtft.h:284:1: error: expected ‘,’ or ‘;’ before ‘static’
  284 | static int fbtft_driver_probe_spi(struct spi_device *spi)                       \
      | ^~~~~~
drivers/staging/fbtft/fbtft.h:323:1: note: in expansion of macro ‘FBTFT_SPI_DRIVER’
  323 | FBTFT_SPI_DRIVER(_name, _compatible, _display, NULL)                       \
      | ^~~~~~~~~~~~~~~~
drivers/staging/fbtft/fb_agm1264k-fl.c:435:1: note: in expansion of macro ‘FBTFT_REGISTER_DRIVER’
  435 | FBTFT_REGISTER_DRIVER(DRVNAME, "displaytronic,fb_agm1264k-fl", &display);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/staging/fbtft/fbtft.h:302:18: error: ‘fbtft_driver_probe_spi’ undeclared here (not in a function); did you mean ‘fbtft_driver_remove_spi’?
  302 |         .probe = fbtft_driver_probe_spi,                                        \
      |                  ^~~~~~~~~~~~~~~~~~~~~~
drivers/staging/fbtft/fbtft.h:323:1: note: in expansion of macro ‘FBTFT_SPI_DRIVER’
  323 | FBTFT_SPI_DRIVER(_name, _compatible, _display, NULL)                       \
      | ^~~~~~~~~~~~~~~~
drivers/staging/fbtft/fb_agm1264k-fl.c:435:1: note: in expansion of macro ‘FBTFT_REGISTER_DRIVER’
  435 | FBTFT_REGISTER_DRIVER(DRVNAME, "displaytronic,fb_agm1264k-fl", &display);
      | ^~~~~~~~~~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:288: drivers/staging/fbtft/fb_agm1264k-fl.o] Error 1
make: *** [Makefile:1834: drivers/staging/fbtft] Error 2

while without removing the semicolon like this patch does, it builds correctly:

$ make M=drivers/staging/fbtft/
  CC [M]  drivers/staging/fbtft/fb_agm1264k-fl.o
  MODPOST drivers/staging/fbtft/Module.symvers
  LD [M]  drivers/staging/fbtft/fb_agm1264k-fl.ko

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


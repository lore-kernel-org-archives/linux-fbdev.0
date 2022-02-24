Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70041C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 24 Feb 2022 09:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiBXJDn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiBXJDf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 24 Feb 2022 04:03:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F0CA16E7E3
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Feb 2022 01:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645693384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zu3JRAMZmyMFpfpAyWAwf1dFrNwpiFycwdVqnbkI0FA=;
        b=DIeywNb80+hm5wadloGax7yBqHxDcK8IX7uCzBS0ceKXdQcBEBc6PAC4IHr7KWRFOUSSFs
        8oVuazjaeF8FUNJLzu+fG3XfIygsDWP7s+5Q619HsQCbCDJO2s6tVjaMrQqluKR5kuEgdj
        QrbhckZOHTp764pdezUMj045gpfFiVY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-JCHn4FVLPkKjSmhNixIVrQ-1; Thu, 24 Feb 2022 04:03:03 -0500
X-MC-Unique: JCHn4FVLPkKjSmhNixIVrQ-1
Received: by mail-wm1-f70.google.com with SMTP id w3-20020a7bc743000000b0037c5168b3c4so2409363wmk.7
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Feb 2022 01:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Zu3JRAMZmyMFpfpAyWAwf1dFrNwpiFycwdVqnbkI0FA=;
        b=e3S/98FMmiJwCGFIQPYA2YFrNCQzvfjBP1uUz2xUqmQypBZBB76SNNvQFm0Ba9kaCi
         zM/UKje3dss0i3sWAo2o8NThnSFu52OQ6EOJPvogWTtuhZLE7jP1LyX29HruCAziinG7
         0BiKsiRPh40w31yyqLSWAGKmNw1jYvDJo49tMFUj++3vUeHnYHBUTLxOj2cIwY8PzOfx
         Uwyz+kFfgrvx2Ac0f7XvVOhjB9hK38rVQGdhy/1vO50ygdZwgCUwcscRNiaF5vmhsxOG
         WrV4VnoVkGr19/g7r2uW3xgxNCRzKT9INqZ4MiwfDjVWVyS+lgZcDDRGZgxjDA7PBczE
         Lewg==
X-Gm-Message-State: AOAM531KUNSHDlhd+4vVNQgtIugxd5Adl7/3niV0YcKcxmih5ch+W4sr
        DXeSkpXyqZGldZurT0tMEHLyknHf8DIWCkxLH03u2opVhnyVL7X1aD5togP9+8lxkLIK5f0mKfo
        nHItsEZLHr/wVaXCIk1VrLFA=
X-Received: by 2002:a1c:a942:0:b0:380:ead5:c4e2 with SMTP id s63-20020a1ca942000000b00380ead5c4e2mr1475276wme.100.1645693382156;
        Thu, 24 Feb 2022 01:03:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvPLEamBMKxD9kbBLEaOvjdkKui9AlNYY9UPg0V5ThbDzBY/IU9FVgaj6lagofSWiVoX0PUw==
X-Received: by 2002:a1c:a942:0:b0:380:ead5:c4e2 with SMTP id s63-20020a1ca942000000b00380ead5c4e2mr1475259wme.100.1645693381945;
        Thu, 24 Feb 2022 01:03:01 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y6sm2770787wrd.30.2022.02.24.01.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 01:03:01 -0800 (PST)
Message-ID: <02cd3c81-d937-eb2a-ebe1-3eb9d83f6adc@redhat.com>
Date:   Thu, 24 Feb 2022 10:02:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/5] fbdev: Improve performance of cfb_imageblit()
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, deller@gmx.de, geert@linux-m68k.org,
        kraxel@redhat.com, ppaalanen@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220223193804.18636-1-tzimmermann@suse.de>
 <20220223193804.18636-5-tzimmermann@suse.de> <YhaYSeyYIwqur2hy@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YhaYSeyYIwqur2hy@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Sam,

On 2/23/22 21:25, Sam Ravnborg wrote:

[snip]

> 
> Question: What is cfb an abbreviation for anyway?
> Not related to the patch - but if I have known the memory is lost..
> 

I was curious so I dug on this. It seems CFB stands for Color Frame Buffer.
Doing a `git grep "(CFB)"` in the linux history repo [0], I get this:

  Documentation/isdn/README.diversion:   (CFB). 
  drivers/video/pmag-ba-fb.c: *   PMAG-BA TURBOchannel Color Frame Buffer (CFB) card support,
  include/video/pmag-ba-fb.h: *   TURBOchannel PMAG-BA Color Frame Buffer (CFB) card support,

Probably the helpers are called like this because they were for any fbdev
driver but assumed that the framebuffer was always in I/O memory. Later some
drivers were allocating the framebuffer in system memory and still using the
helpers, that were using I/O memory accessors and it's ilegal on some arches.

So the sys_* variants where introduced by commit 68648ed1f58d ("fbdev: add
drawing functions for framebuffers in system RAM") to fix this. The old
ones just kept their name, but probably it should had been renamed to io_*
for the naming to be consistent with the sys_* functions.

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112A1C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Feb 2022 11:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbiBBLjg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Feb 2022 06:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233813AbiBBLjf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 2 Feb 2022 06:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643801974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=udGfbFsD3WjS9bv8IIFrQcIv1RwbGFk7ab6Qa1eMKEE=;
        b=Bg6r97C51QpJwbqu7TlwIIR815gx4ev2ec39cX9RhT7lTnH2QbPUklB9gCpDszLU/c3tl8
        Q+AFwMrDmzM525W9buVa3TXUMB+7g6pt9ab2ZexshMwH1c7Q/C/PGkUEoIwHH3qflU51dx
        oLgLTrWwFaWkl/Yb93+EqdCGKbpLAnM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-Jaex9qBlO7WNNuyqM41bEw-1; Wed, 02 Feb 2022 06:39:33 -0500
X-MC-Unique: Jaex9qBlO7WNNuyqM41bEw-1
Received: by mail-wm1-f70.google.com with SMTP id z2-20020a05600c220200b0034d2eb95f27so2374695wml.1
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Feb 2022 03:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=udGfbFsD3WjS9bv8IIFrQcIv1RwbGFk7ab6Qa1eMKEE=;
        b=NYqLfhXGsSPOABwxo4nKApJk5vfiEGK/PTBJP3kfVYhrv4ys0EZbu1FhfZvbRIyZd1
         uVMzv0ornDZCXCZGfC1WJstqyIRjrnAwPlGE/GxQeu0G76sEgprkPd1vbKt2m/t/G5VN
         UGNy864uhYQrH/olVnx0+CFA04/weS7PKX3IO9t2y//+wOPGv2wI2H+2stj2prwZPZHf
         H4mAdyNO4wKxU2Xi2hcCqH7sUbtI1w/uNayx4qbmdfU4xywb7hw00ghdY80L+IpjpOkB
         02bRzqi6CGKJaFnAMv7SLdfcnAzcgGpG1KEMko2z/f5GE4Ce/vwxqq1d9E3/WG5Csa9T
         ulnQ==
X-Gm-Message-State: AOAM532PtXmnSthel4URlyBzXL2Ibv9H5bXR9rG7MXh3l775LX/t+jxN
        ZsnrlY9pQFxnJ0vaQ1B4ynyjWpMQhODl450qfwjYxBZAVWIsMBUbWINGal7afe9JcxinOySlMpV
        THSgJrZjhikR48tym2lOx1oA=
X-Received: by 2002:a05:6000:1707:: with SMTP id n7mr25289508wrc.234.1643801972289;
        Wed, 02 Feb 2022 03:39:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIYnUCCInjr37c9/22HdQPcKzX7C106buTPKlsAaiTOOtU5+XcopMUfetRz5oizfbknnWbWw==
X-Received: by 2002:a05:6000:1707:: with SMTP id n7mr25289493wrc.234.1643801972038;
        Wed, 02 Feb 2022 03:39:32 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m11sm4097810wmi.16.2022.02.02.03.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 03:39:31 -0800 (PST)
Message-ID: <2f149fef-b991-9e34-98cb-426e561192ff@redhat.com>
Date:   Wed, 2 Feb 2022 12:39:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Robinson <pbrobinson@gmail.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <YfhM97cVH3+lJKg0@ravnborg.org> <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
 <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
 <CAMuHMdVP6ER119r2KAegjZes1a=KWZ47z6j=kgQ0oNx1oeUJ+w@mail.gmail.com>
 <51f54519-bb8b-f108-1c1e-4fed101ca5ef@redhat.com>
 <CAMuHMdVwUfv7pXhPazsgG6t=X=aVtDQkFUk_=mUuFH8Fscx8wg@mail.gmail.com>
 <abf63995-a529-1e80-18c3-df473a3e7a9c@redhat.com>
 <YfmaqUBqCrgp0QdO@ravnborg.org>
 <e552caec-5136-f4b2-12dc-23b182ab8af6@redhat.com>
 <YfploeCM6C5y3Imj@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfploeCM6C5y3Imj@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Andy,

On 2/2/22 12:06, Andy Shevchenko wrote:
> On Wed, Feb 02, 2022 at 09:38:51AM +0100, Javier Martinez Canillas wrote:
>> On 2/1/22 21:40, Sam Ravnborg wrote:
> 
> ...
> 
>> Peter Robinson suggested to
>> make the driver mutually exclusive and add !FB_SSD1307 in the config symbol.
> 
> And how will distros choose "the right" option in this case?

It depends on the distro. In Fedora we are disabling *all* the fbdev drivers.

> What to do when I wan to see a regression and I want to change drivers w/o
> recompilation?
>

If you want to have the two drivers without recompilation (and same compatible
to match) then how would kmod / udev choose which one to load ? It becomes a
race condition between the two drivers which one probes first.
 
> NAK from me to that proposal.
> 

What's your suggestion then to solve the issue mentioned above ? With my distro
maintainer hat I don't care that much, since the fbdev drivers will be disabled.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


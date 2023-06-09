Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894A6C7EE25
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Jun 2023 10:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbjFIKdR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 9 Jun 2023 06:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbjFIKcs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 9 Jun 2023 06:32:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC96468B
        for <linux-fbdev@vger.kernel.org>; Fri,  9 Jun 2023 03:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686306280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mMg53JOrE7LdjfO2Cif2xn5d4s7Q5BrveDabIgOUiSQ=;
        b=gdRy1DbMh/dkWMrEuGnXxjFvvC17t200P9NUQY4QQkjDn0pf7kR7d/fWNu4MCT4ek8LWrt
        E7GoGUsIhYicAF3X/Jx/bzETSnnw7hti9S3B6lBc6pPBXC5JfnPpBXxlFyH0yZXT7Pk5kB
        SEyODphYfGAI5Lqrx6Yv7QNboOsQI8Q=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-zZ9UzTIfPIq5t02DgBTi4w-1; Fri, 09 Jun 2023 06:24:39 -0400
X-MC-Unique: zZ9UzTIfPIq5t02DgBTi4w-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b20220c67bso12949151fa.1
        for <linux-fbdev@vger.kernel.org>; Fri, 09 Jun 2023 03:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686306277; x=1688898277;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMg53JOrE7LdjfO2Cif2xn5d4s7Q5BrveDabIgOUiSQ=;
        b=ZK+3+akUaC+xuy9t3yE0jKZmfavCXv0hpCEAfR+3ey+KtGy018ECPIfuspcFPZ8mml
         vwIUdA44WnIVbZGg2dkeBT9xxVkZcnYs76XeKCfQV4n8Ct8x7Y56OA3cx6nwzDgrleX8
         PtTQWmsD/MKw8cLgDunMfiXkJ7gYOVMNbYZvUG0MjqTlxxH2lt3CPcmoF2YedDX1SDGM
         yf8heMKGtk8BRjc2Sr4Js97e6RfzRuir613tG0a/PogSuuTzd1yc/HdYiaTFZu50k1yT
         aPaXQYpHUmTphnD8pmE85utMsS9nVMtekTJL5xNfg+kwCjr0oPIajmhosuinR2vDPha5
         F1bA==
X-Gm-Message-State: AC+VfDxI1+s6xQriye6q7A7ZnCb61J7IoFPG04jxe75E5o0UmN5HbE8p
        7oo3TQ29/Lcl1vI4+N/V7BwB7mlZRnd0AUNk+sUUB92hLpZ6YL1pBDmkj4ERJ8bQJbqPM6PyS0v
        rTyM0lZj08rlp7HFIgnPDcEw=
X-Received: by 2002:a19:914f:0:b0:4f3:a483:557 with SMTP id y15-20020a19914f000000b004f3a4830557mr619113lfj.5.1686306277832;
        Fri, 09 Jun 2023 03:24:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6S3RszxExiKf60rjrxsF2OLyJFkoRpusOuEfLcjyVkibfQrgNaGV/G0ODH5bqwWreayNq8WQ==
X-Received: by 2002:a19:914f:0:b0:4f3:a483:557 with SMTP id y15-20020a19914f000000b004f3a4830557mr619101lfj.5.1686306277475;
        Fri, 09 Jun 2023 03:24:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y14-20020adfdf0e000000b003063772a55bsm4046255wrl.61.2023.06.09.03.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 03:24:37 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        daniel.thompson@linaro.org, linux-staging@lists.linux.dev,
        linux-sh@vger.kernel.org, jingoohan1@gmail.com, deller@gmx.de,
        lee@kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        sam@ravnborg.org
Subject: Re: [PATCH 30/30] fbdev: Make support for userspace interfaces
 configurable
In-Reply-To: <CAMuHMdU27OK1=B6Qgwd+tyda=MmN0EiC8taUpvAJJOYUFcm88A@mail.gmail.com>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-31-tzimmermann@suse.de>
 <CAMuHMdVP2hrgXaZvASnHJ4M+VXaTCtfbeVXrq2dsEJqcs3G6ZA@mail.gmail.com>
 <e5d88ca8-66fe-b5ee-cb6b-2dc8f3a3fb26@suse.de>
 <CAMuHMdWBUKTgfCD9VLDFh_Tm1J-NJQHpxODs-TuYM7V-dtmGjA@mail.gmail.com>
 <873532eurg.fsf@minerva.mail-host-address-is-not-set>
 <77252bc9-e08e-fcee-d140-2b78ab768b42@suse.de>
 <CAMuHMdWUkZDcYfndf1A+cgcN5Fz1hmst4LrpA7iYCFqWSRTNDA@mail.gmail.com>
 <4df23439-462f-47da-890d-2dd2092eea35@suse.de>
 <87h6rh552q.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdU27OK1=B6Qgwd+tyda=MmN0EiC8taUpvAJJOYUFcm88A@mail.gmail.com>
Date:   Fri, 09 Jun 2023 12:24:36 +0200
Message-ID: <87edml53x7.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:


>> * fbdev drivers + DRM fbdev emulation + fbdev user-space
>
> "fbdev drivers + fbdev user-space", I assume?
>

Right, I meant to also include "only fbdev drivers + fbdev user-space"
but forgot :)

>> * only DRM drivers without fbdev emulation nor fbdev user-space (your series)
>
> Thomas' series includes fbdev emulation here, for the text console.
>

Yes, I meant fbdev emulation for user-space. Probably should had included
fbcon in the options too...

But what I tried to say is that we need all combination of DRM drivers,
fbdev drivers, DRM emulation for fbcon and emulation for fbdev user-space.

And I think that Thomas' series + a FB_CORE as you suggested and done in
my old series should be enough to have that.

--
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


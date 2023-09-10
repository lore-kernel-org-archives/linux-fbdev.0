Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE14EE7FF4
	for <linux-fbdev@archiver.kernel.org>; Sun, 10 Sep 2023 06:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346298AbjIJG7Y (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 10 Sep 2023 02:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbjIJG7Y (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 10 Sep 2023 02:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C976C1B8
        for <linux-fbdev@vger.kernel.org>; Sat,  9 Sep 2023 23:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694329112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EF+mREtObA6if9r8T28Dzw3gPzt9UPJWLv6e0kWaOFM=;
        b=JzvS8dFiBqgGZI0/Hf+cYG+gEPmB7oZSdQsFHipOytxE0J9FGv/QBO806RNIZPHyRVa2oX
        943/x4ipNJk0Vc1aOo/13/YogMEGsqSnRcBZfVNBgXp0jRFbGcvA0jcwSTGlEWfXO3VGF5
        NELfAOtmrf7U0/GRpY/vjimo09qwAc0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-bf3PW4dMNxuAj6Zk2v64PQ-1; Sun, 10 Sep 2023 02:58:31 -0400
X-MC-Unique: bf3PW4dMNxuAj6Zk2v64PQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-401d9abf21cso27992005e9.0
        for <linux-fbdev@vger.kernel.org>; Sat, 09 Sep 2023 23:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694329109; x=1694933909;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF+mREtObA6if9r8T28Dzw3gPzt9UPJWLv6e0kWaOFM=;
        b=NMmgkCCn5y+4LmcuHYpXOHaPcSvC/WlF4wAr68uqm7fNVCdZ/WwWhnXq+l+PHTNL3p
         esjow5A+JGhkcmYJyTNnnSp0zKjWSszQmn2c8vltNMp5RZ5LXh5qJb1H2PuY7OhQrsL9
         YECgSxOMqgurrMrsw/fD38dVBayyG8sE4ay8u6A3jzgXyAdY31sATw6YzJ9pGdZOYJuu
         gZeQUIHmhREAuOKvZYbI5wAjopViZEXFFheSH1/JqAxpo+u844Il07o5HfXmmR9Rf3lJ
         kEFCqEudTgZVnt4XWAMP/X17/CtokMebv1jMXNRaT4OKJA+SXY9WtWy+4s4f0U4W67Rs
         9Ugw==
X-Gm-Message-State: AOJu0Yx89f68kPxnj5rZi36Xk8y54ETsjiPnsC0RnAxpJaWvYquHnsAq
        lH/bQbYHF57TCWLs2u3zd8iT6QDna3FAmC7yaTdd5yw8KMEJQSK6r43r4rva4BWpfGHrnk8kDvt
        YJG2uy2/hdcuMJSSxsQI7ebcQl9oeSwbq/A==
X-Received: by 2002:a5d:6b06:0:b0:319:6e74:1637 with SMTP id v6-20020a5d6b06000000b003196e741637mr4428767wrw.27.1694329109787;
        Sat, 09 Sep 2023 23:58:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSx+L2ni7dhd9xEaYUSqtrodGiDpQly/+lPBox6GKopSYayzZ75i6DkIouMBEt+4EzGlCrUg==
X-Received: by 2002:a5d:6b06:0:b0:319:6e74:1637 with SMTP id v6-20020a5d6b06000000b003196e741637mr4428761wrw.27.1694329109475;
        Sat, 09 Sep 2023 23:58:29 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5589000000b003141e629cb6sm6502547wrv.101.2023.09.09.23.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 23:58:29 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jilin Yuan <yuanjilin@cdjrlc.com>, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] video: fbdev: ssd1307fb: Print the PWM's label
 instead of its number
In-Reply-To: <20230909202110.bcz5qvb7bfrzco73@pengutronix.de>
References: <20230728145824.616687-1-u.kleine-koenig@pengutronix.de>
 <20230728145824.616687-3-u.kleine-koenig@pengutronix.de>
 <87lef0xcw4.fsf@minerva.mail-host-address-is-not-set>
 <87zg1vif8b.fsf@minerva.mail-host-address-is-not-set>
 <20230909202110.bcz5qvb7bfrzco73@pengutronix.de>
Date:   Sun, 10 Sep 2023 08:58:27 +0200
Message-ID: <87v8ciikfg.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

Hello Uwe,

> Hello,
>
> On Sat, Sep 09, 2023 at 04:38:28PM +0200, Javier Martinez Canillas wrote:
>> Javier Martinez Canillas <javierm@redhat.com> writes:
>>=20
>> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
>> >
>> >> struct pwm_device::pwm is a write-only variable in the pwm core and u=
sed
>> >> nowhere apart from this and another dev_dbg. So it isn't useful to
>> >> identify the used PWM. Emit the PWM's label instead in the debug
>> >> message.
>> >>
>> >> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>> >> ---
>> >
>> > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>> >
>>=20
>> Pushed to drm-misc (drm-misc-next). Thanks!
>
> JFTR: This patch is already in linus/master. And Javier pushed
> "drm/ssd130x: Print the PWM's label instead of its number" to
> drm-misc-next which is great. So the "Pushed to ..." mail is just in
> reply to the wrong patch in this thread and in git everything is fine.
>

Ups, that's correct. Thanks a lot for pointing that out!

> Thanks
> Uwe
>


--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


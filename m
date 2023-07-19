Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EAAC0015E
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 Jul 2023 08:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjGSIAs (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 Jul 2023 04:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGSIAr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 Jul 2023 04:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27F7BE
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jul 2023 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689753602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=speJPG1ycW/BkN4uS1NK3jR/omXFRRfNvkd75pwFmqw=;
        b=SO9CuQvKFtQ4DcxlS4H4HDihSQ9jLvgmd3xJl3kmvfSMdM7+YkQriEeOsSsMLT/AKyiwzZ
        WGYpxFUVoxepfaZ5Oi6WQeog9jsV+o7vDYF21jRvh7Bel3/h6oe6/n/EKYDjU1FRnLFj38
        iBzAzX1mdTs3EG5TY3APSC6bCaf6bZw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-j5wh4o6cOxSwMDW7g0gOzA-1; Wed, 19 Jul 2023 04:00:01 -0400
X-MC-Unique: j5wh4o6cOxSwMDW7g0gOzA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-315a03cae87so205099f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jul 2023 01:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689753600; x=1690358400;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=speJPG1ycW/BkN4uS1NK3jR/omXFRRfNvkd75pwFmqw=;
        b=NxDDC8sCqJ+fqkXL7ghb7MQRwM+ORcrL9QxJCwW0MhNaQTOov1mXZrv3JX1eBcRQ1T
         uRAK9lWneCSRisZeQlniJw1BZnCjlNKFM+43J0H1qILAJKSazX7aLhgQyZSQeWI2KzfE
         9oaeDg7jsdNKQ21SWgirbWvnOYRw5AbHmCL0vBYIvi4CiY0jBFfMqZm6tKaBQ4hJ1Taq
         wy9J2IYyB9aLcbdOcN/HG/jp0D+PFEHOTVl+fIIcMrgKgvwW2dXpQExzaMPqdnpS42tF
         8H26y0wlEEBJOZB5kan5zc4wOJ0JAAfHvzd9A/GeeIc0luvlCUV4cZPs8LYLvUL+nnO3
         J1fg==
X-Gm-Message-State: ABy/qLY3vwhI5WVDQKcem8+3EUHZe7StgGRtcCQ0sMbfdNe1ge8QEdC3
        hOgsNMn75OpAq3J4D89X1hMhTP+BDuzMOHSCh00lNlroGQn0AgsqTIbd8Pu33tPQq1dwFuda5AC
        yR5Bxn++oJ6P7pSkZfFEoMOw=
X-Received: by 2002:adf:f183:0:b0:315:a235:8aa8 with SMTP id h3-20020adff183000000b00315a2358aa8mr1151882wro.2.1689753600520;
        Wed, 19 Jul 2023 01:00:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGbErd5rOGWg9sKl7p9YbHezYUElnKB4HQRHgHvdWvGr5xTLlQhBGuXUlUSr7TY0UzQpwLZSQ==
X-Received: by 2002:adf:f183:0:b0:315:a235:8aa8 with SMTP id h3-20020adff183000000b00315a2358aa8mr1151868wro.2.1689753600230;
        Wed, 19 Jul 2023 01:00:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i3-20020adfe483000000b00313f61889ecsm4551037wrm.66.2023.07.19.00.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:00:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 2/4] fbdev: Move core fbdev symbols to a separate
 Kconfig file
In-Reply-To: <f925fa1c-a6db-4032-8adc-d6aba8cd2ef8@app.fastmail.com>
References: <20230714171642.91185-1-javierm@redhat.com>
 <20230714171642.91185-3-javierm@redhat.com>
 <f925fa1c-a6db-4032-8adc-d6aba8cd2ef8@app.fastmail.com>
Date:   Wed, 19 Jul 2023 09:59:59 +0200
Message-ID: <87lefcib5s.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Fri, Jul 14, 2023, at 19:16, Javier Martinez Canillas wrote:
>> The drivers/video/fbdev/Kconfig defines both symbols for fbdev drivers and
>> core fbdev symbols, that can be enabled independently of the fbdev drivers.
>>
>> Split the Kconfig in two, one that only has the symbols for fbdev drivers
>> and another one that contains the fbdev core symbols.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>
> While testing this patch series, I noticed a conflict against
> Thomas Zimmermann's series for FB_SYS_HELPERS_DEFERRED, so you'll
> have to adapt the patches in order to apply them on top.
>

Indeed. That was my bad when doing the conflict resolution on rebase.

>> +
>> +config FB_HECUBA
>> +	tristate
>> +	depends on FB
>> +	depends on FB_DEFERRED_IO
>> +
>> +config FB_SVGALIB
>> +	tristate
>> +	depends on FB
>> +	help
>> +	  Common utility functions useful to fbdev drivers of VGA-based
>> +	  cards.
>> +
>> +config FB_MACMODES
>> +	tristate
>> +	depends on FB
>> +
>
> The FB_HECUBA now needs 'FB_SYS_HELPERS_DEFERRED' instead
> of 'FB_DEFERRED_IO', which is the change done in the other
> patch. I think the best way of doing that would be to just
> not move the three symbols above to core/Kconfig but leave them
> in place, as they are all just helper modules for some other
> drivers, rather than core code.
>

Agreed. I'll change that in v6 as well.

>       Arnd
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


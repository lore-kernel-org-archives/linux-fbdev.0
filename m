Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76815EB64DD
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 Jul 2023 07:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGDH6v (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 Jul 2023 03:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjGDH6u (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 Jul 2023 03:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5BFE4F
        for <linux-fbdev@vger.kernel.org>; Tue,  4 Jul 2023 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688457485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+z65LvmorUornhZW4Ei6pDZqxls4YGQhYkabgi/Fgo=;
        b=Y4f2GAfnvMkn4r8cEcGelxmr1lAXgK0hMGYxuSXpjWlMyLT65XXneqe7TOOk+NRbTyNmFT
        pDHvRr4PgXkdAnpvcHRgNNt/iApZP0+T1n3lni1iXNZ4ZVL9FVa2QX0V1vfi9KwtOxcEIe
        g+M58nla3+AyS56g/pbRAGh6RR29hmI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-UH6z7zMYPoy8ASaS76s2pQ-1; Tue, 04 Jul 2023 03:58:04 -0400
X-MC-Unique: UH6z7zMYPoy8ASaS76s2pQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b6a6cb42f1so48193851fa.0
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Jul 2023 00:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457482; x=1691049482;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+z65LvmorUornhZW4Ei6pDZqxls4YGQhYkabgi/Fgo=;
        b=NU3BpQzsQBu2n0Eb+08l1IL2oZuYWWoTfIoRRUXSsG9J+mr7/0zwnVt15O1GHlho3Y
         qvwvQuzlin4CvY+w2VeX7SXnZhKLcZlRWtjWeLpue3Hxre8/bFt/RQLsI9NvKFFfLUsb
         uMQuN8Qff4hnRTfC51autJRlKtvicYBTe48pJvGnrMz3FmA5gRzkm3qHMaS6Hm8CZ84W
         Ur37yNdRV2FoBbFN/+VwA6QVuXv5K/EVvR4yvGzI2Vl79LiI2ZRl7yXebupY0UMzdeHQ
         TbtZjC2SUJYWWMtCu5AcDuQv+yBB/ujOn/yGmjOya2W1oZtBYKCM6Jplwztc28jEwGoQ
         jt3w==
X-Gm-Message-State: ABy/qLasVT0aMsmYW/4QiCieQ0MRHAnmBvRcNN34TB+TikMYebLeNtPV
        IcYRmW+eniSWG6IbJjotSBy3tHQSoLqQaUxhilxVAWddsxMUVL57C/Ff4Jss8AD5B/N6Y+pLdQM
        bQCu0Resf77tTzcf76IgyE1s=
X-Received: by 2002:a2e:9159:0:b0:2b4:78f6:d335 with SMTP id q25-20020a2e9159000000b002b478f6d335mr9686700ljg.8.1688457482307;
        Tue, 04 Jul 2023 00:58:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGP5ieUAuoHkl1LDfFH6zWVviU5R2QJOtqbelgfD+Ggwr/XJ6o+iJfxnnHrp7TPWS1RTCoQZA==
X-Received: by 2002:a2e:9159:0:b0:2b4:78f6:d335 with SMTP id q25-20020a2e9159000000b002b478f6d335mr9686681ljg.8.1688457482001;
        Tue, 04 Jul 2023 00:58:02 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003fb225d414fsm22874960wma.21.2023.07.04.00.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:58:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 2/5] fbdev: Move core fbdev symbols to a separate
 Kconfig file
In-Reply-To: <ZKPHmJDsUtG7nROo@smile.fi.intel.com>
References: <20230703230534.997525-1-javierm@redhat.com>
 <20230703230534.997525-3-javierm@redhat.com>
 <ZKPHmJDsUtG7nROo@smile.fi.intel.com>
Date:   Tue, 04 Jul 2023 09:58:00 +0200
Message-ID: <87bkgsyupj.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Tue, Jul 04, 2023 at 01:05:26AM +0200, Javier Martinez Canillas wrote:
>> The drivers/video/fbdev/Kconfig defines both symbols for fbdev drivers and
>> core fbdev symbols, that can be enabled independently of the fbdev drivers.
>> 
>> Split the Kconfig in two, one that only has the symbols for fbdev drivers
>> and another one that contains the fbdev core symbols.
>
> ...
>
>>  source "drivers/video/fbdev/omap/Kconfig"
>>  source "drivers/video/fbdev/omap2/Kconfig"
>>  source "drivers/video/fbdev/mmp/Kconfig"
>> +
>> +source "drivers/video/fbdev/core/Kconfig"
>
> Hmm... Shan't we start Kconfig from core options?
>

I added after the drivers because Geert said that preferred that way
(unless I misunderstood him from our conversations in IRC).

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


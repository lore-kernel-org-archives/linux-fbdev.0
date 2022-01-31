Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFDEC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 23:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiAaXiF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 18:38:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229626AbiAaXiE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 18:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643672284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C3CTm7Bs/ix/5LXGiIgLCJVvM0GoznV6Mmk0dN1zWSQ=;
        b=SW47u5qHU4hHVvCqDnwNl/HjsK2T7+dO/efjQ7pXGyt6ROVViNalbFD9N4vRbsm+qSHy1K
        NIDLunq3XYtzgfSNnLCAvk/JJ7kYz8JQSnrwW9HHtJIfOwC05rvcntgTDFI9a8UPdI6sAA
        ihHvWupobdx9ypQ/fUKSMfby4Fbp05A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-mfnzPDE3Ph6fi3th5wWxfQ-1; Mon, 31 Jan 2022 18:38:02 -0500
X-MC-Unique: mfnzPDE3Ph6fi3th5wWxfQ-1
Received: by mail-wm1-f69.google.com with SMTP id l16-20020a1c7910000000b0034e4206ecb7so290093wme.7
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 15:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C3CTm7Bs/ix/5LXGiIgLCJVvM0GoznV6Mmk0dN1zWSQ=;
        b=FKanNjvkdjx1cHHS4HgQ/xsSAS/F9AjaJQ51v3r4G8JYcQoAeAQTngej8NELXy2Hm3
         cx7mufSALTCSlp7PDjRNp/wSRiSIQOpT8WLYyCLxU3+NRlffYnZSWtxLKsAanv+hY7lD
         mqn0okfbbH+RUcRQq1m+8FH9qZsUvpfc7GIk1EQgdMVZczLP3ZSdcAGSA318bVhebK4X
         n06dEA9KzHINdFflZFpBDArRZwAh9IOs5LB/+C1goN/BqPwg/Exo2Wo+0tRJjiaQwn70
         x6lqcW6cV9LE+IjVMFdzYZASgU27Y4/lQZ58LC0UzX+IuGw21N5WmbqoXykGO21jXsBO
         lZPw==
X-Gm-Message-State: AOAM530Tof6JkggD+rO+oVtOPdC2hHMvq49u5aUqigl3kh5fAxTYAcoM
        w4CZH5muGF295/1gFvD3yMmaJetU0nSdxNTFPt0XB6KCOmo4j+tJ4XENSZuszPTBvT5EtznPbBB
        s2eEtf+0jTX2k7X26dkLHGfQ=
X-Received: by 2002:a05:6000:15c5:: with SMTP id y5mr19192578wry.94.1643672281301;
        Mon, 31 Jan 2022 15:38:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVQSH23aLGjRqSo4FwmBefiCFx1sZwod/Bbj1r+ksyBNqib6t/bplSkWRXeqqfzdh6Ym8gbQ==
X-Received: by 2002:a05:6000:15c5:: with SMTP id y5mr19192561wry.94.1643672281120;
        Mon, 31 Jan 2022 15:38:01 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 8sm603298wmg.0.2022.01.31.15.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 15:38:00 -0800 (PST)
Message-ID: <0924dfdc-a8c3-5e0f-9362-6c27811b4bd6@redhat.com>
Date:   Tue, 1 Feb 2022 00:37:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <YfhM97cVH3+lJKg0@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfhM97cVH3+lJKg0@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/31/22 21:56, Sam Ravnborg wrote:
> Hi Javier,
> On Mon, Jan 31, 2022 at 09:12:20PM +0100, Javier Martinez Canillas wrote:
>> This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
>> SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.
>>
>> Using the DRM fb emulation, all the tests from Geert Uytterhoeven's fbtest
>> (https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git) passes:
> 
> Impressed how fast you did this!
> Saw the picture you posted a link to on irc - nice.
>

Thanks :)

What's impressive is how many helper functions the DRM core has, so typing a
new DRM driver is something that could be achieved in a few hours. Which was
one of my goals with this experiment, to understand how much effort would be
for a developer with no prior experience with DRM to port a fbdev driver.
 
>> Patch #3 adds the driver. The name ssd1307 was used instead of ssd130x
>> (which would be more accurate) to avoid confusion for users who want to
>> migrate from the existing ssd1307fb fbdev driver.
> Looking forward the name ssd130x would make more sense. There is only so
> many existing users and a potential of much more new users.
> So in my color of the world the naming that benefits the most users
> wins.
>

Agreed. That's also what Andy suggested and makes a lot of sense to me.
 
> 	Sam
> 

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


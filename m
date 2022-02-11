Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E221BC433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Feb 2022 10:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349299AbiBKKlB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Feb 2022 05:41:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349304AbiBKKkv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Feb 2022 05:40:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0E58FDC
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 02:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644576018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rr2p39qO1PszvSAuu6FevETTuy4phR00cC1/L7uwXE4=;
        b=G7PwqOYUy/ZmJ6LnfmMFbhU6dIuKBhMwvczlIfzQ6/Sialw3HqerfC3uP7eg/Lropg3RwI
        J5mlwJoidAjy3L3RIjsPGYb9Vib6+dVURYwahO28HuYo4CGZ+Byvf7dR6Z+CCJqvraksk0
        WrCZ2b6aKvpHXhubVa7vXOIYp5SefCA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-gt-qJiqhOa6nEdK2kRZPUQ-1; Fri, 11 Feb 2022 05:40:16 -0500
X-MC-Unique: gt-qJiqhOa6nEdK2kRZPUQ-1
Received: by mail-wm1-f71.google.com with SMTP id m3-20020a7bcb83000000b0034f75d92f27so2353215wmi.2
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 02:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rr2p39qO1PszvSAuu6FevETTuy4phR00cC1/L7uwXE4=;
        b=Ls5AYerAqtzGki/ZXPrpIS455rDfhtp/E0EuYanH9lOYkF3B48ZeXUw7NtfUe+rDuZ
         i+cSDWxBawd8LFoR0ZRBo/jqaic0ItS7ldqS03kXweNdxEbnTG8wJGbai9BYy3ond8pg
         627z0pO9z4H8KfaJ0SVuI2J19FDl5Cngdo+ATzXygnIjfq50RAFSrl/RgOUOEFV0DjqP
         B9LPBQxEeBqA8/3qqgjvVAm7Fb66Pqtkxcy3ECQ09xLA55ICRgALo4yTF+gTncHrwUgA
         CIgaB4FZxlzOfHNWztpJvN+KOlUuJt9OBtgY83i0WXLDsGE9KKDsah8RUQiZv8dNj47T
         J9dQ==
X-Gm-Message-State: AOAM5329Z9baL4uSVEgeEtbBghrIQ3O1PXcsOQzfnKDyPMYhDohuDbwO
        XILmbQ2lUyIqenxklwtXhKfowXUr09Y7CbmWIc3hmgbvMzVvLjWvoJtGUxZocoVnJL/jz1p2SUU
        nMlo8ophq/FJoS2ylA4nwDZ0=
X-Received: by 2002:adf:dd8b:: with SMTP id x11mr849161wrl.599.1644576014928;
        Fri, 11 Feb 2022 02:40:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFwUlqoA2Q/hc1lootDkLF4/JkL1kUKbH/6LwiUXn6iAC9iHdzV840Do6ORLJXrajVa5H83A==
X-Received: by 2002:adf:dd8b:: with SMTP id x11mr849134wrl.599.1644576014664;
        Fri, 11 Feb 2022 02:40:14 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m6sm24340579wrw.54.2022.02.11.02.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 02:40:14 -0800 (PST)
Message-ID: <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
Date:   Fri, 11 Feb 2022 11:40:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgY6OqN+guBlt/ED@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Andy,

On 2/11/22 11:28, Andy Shevchenko wrote:
> On Fri, Feb 11, 2022 at 10:19:22AM +0100, Javier Martinez Canillas wrote:
>> Pull the per-line conversion logic into a separate helper function.
>>
>> This will allow to do line-by-line conversion in other helpers that
>> convert to a gray8 format.
> 
> ...
> 
>> +static void drm_fb_xrgb8888_to_gray8_line(u8 *dst, const u32 *src, unsigned int pixels)
>> +{
>> +	unsigned int x;
>> +
>> +	for (x = 0; x < pixels; x++) {
>> +		u8 r = (*src & 0x00ff0000) >> 16;
>> +		u8 g = (*src & 0x0000ff00) >> 8;
>> +		u8 b =  *src & 0x000000ff;
>> +
>> +		/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
>> +		*dst++ = (3 * r + 6 * g + b) / 10;
>> +		src++;
>> +	}
> 
> Can be done as
> 
> 	while (pixels--) {
> 		...
> 	}
> 
> or
> 
> 	do {
> 		...
> 	} while (--pixels);
> 

I don't see why a while loop would be an improvement here TBH.

In any case, I just pulled the line conversion logic as a separate
function with minimal code changes since doing that should be in a
separate patch.

Feel free to post a patch if you want to change that while loop.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


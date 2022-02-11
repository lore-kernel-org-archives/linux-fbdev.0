Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBA9C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Feb 2022 12:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349852AbiBKMLc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Feb 2022 07:11:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349830AbiBKMLb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Feb 2022 07:11:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E249BD5A
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 04:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644581490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbeS5Q0QdhSeqbBe2L7Sp2F6l+GpdK7iWbNe2W3yu0w=;
        b=Jkk5JIUtiTJQ91JlidV11G+xGEvtzGNzpGHKfueu9qRFskfvcuBwAYnP7K2ULgYJsBiAtQ
        yClh4gzwRfWiv4DgZZzGLEMNjDxSwRxC6CcM+p82FEql4cKpAVOpTSEy/D/+tMDWSSy5cO
        5AMhE7pVIuzVp2L/7iT1VFn0FPWmOdw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-3vLr4AzFNlqnD5fqnVmLyA-1; Fri, 11 Feb 2022 07:11:28 -0500
X-MC-Unique: 3vLr4AzFNlqnD5fqnVmLyA-1
Received: by mail-wm1-f70.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so2429527wmj.5
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 04:11:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rbeS5Q0QdhSeqbBe2L7Sp2F6l+GpdK7iWbNe2W3yu0w=;
        b=MnY9nwVadaABSP/C28n+Sye/I3GuZhndIFa+W22MFoFbzCLoegTTQljhz6ywMhXGLf
         w3nlA9wcUfNXeD+5H6o+qxvqf5JpJSipYXPG5y2mZxhieFIA2Gh/ZYuRRtrJdZrJ6td1
         3wJEOOnJtdmcYXuRWWr0Jewxq/bRTX/ri0n3rA8Kl+QUe62FRqu92sWGlBL91FvdKCCr
         KwSt1fNwUtojeZ3diUDl1Yf4QyCHM+DP7AcP5VUirvXHHMcdy0niOOAxrRZ5y3ezAypQ
         6WLoGiNgdSWHmCD4QqCoSdjrx7TXyNs0Sxrp4ULiyodfHPynS6hOzmzPoNpJtdLBEHLU
         D6Lw==
X-Gm-Message-State: AOAM532QICw/uBT/myUjvHCvwbgz2IiNnFJZNbgZmhjr0HNxQdaq1Q02
        a5kxWbzNP3hOLE5JAt/0OUlwlZhsZ/HKIB4c+3SeC/RH/Ji9eNzVCCD3dupjDSrhK1UUKTl4TQs
        l+WQ8ElbYMM+1BZJsOvpktlY=
X-Received: by 2002:a5d:6d09:: with SMTP id e9mr1244669wrq.2.1644581487725;
        Fri, 11 Feb 2022 04:11:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySb3y5ME4crlsH+b8xOVBwDu7OcH0jhhdufGAdmsHfpAHWgWr7LCf0VAonkSs7ThGU8Oo4sg==
X-Received: by 2002:a5d:6d09:: with SMTP id e9mr1244650wrq.2.1644581487542;
        Fri, 11 Feb 2022 04:11:27 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v9sm9980052wrw.84.2022.02.11.04.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 04:11:27 -0800 (PST)
Message-ID: <431f26fb-5943-eb58-9ad5-eda787966ad2@redhat.com>
Date:   Fri, 11 Feb 2022 13:11:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
 <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
 <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de> <87pmnt7gm3.fsf@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87pmnt7gm3.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Jani,

On 2/11/22 13:05, Jani Nikula wrote:

[snip]

>>>> I don't see why a while loop would be an improvement here TBH.
>>>
>>> Less letters to parse when reading the code.
>>
>> It's a simple refactoring of code that has worked well so far. Let's 
>> leave it as-is for now.
> 
> IMO *always* prefer a for loop over while or do-while.
> 
> The for (i = 0; i < N; i++) is such a strong paradigm in C. You
> instantly know how many times you're going to loop, at a glance. Not so
> with with the alternatives, which should be used sparingly.
> 
> And yes, the do-while suggested above is buggy, and you actually need to
> stop and think to see why.
>

Absolutely agree.

These format conversion helpers are not trivial to read and understand (at
least for me). In my opinion the code should be written in a way that ease
readability and make as robust and less error prone as possible.
 
> 
> BR,
> Jani.
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


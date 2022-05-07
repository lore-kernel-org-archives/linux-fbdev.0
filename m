Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B883C433EF
	for <linux-fbdev@archiver.kernel.org>; Sat,  7 May 2022 16:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446630AbiEGQoJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 7 May 2022 12:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446655AbiEGQoJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 7 May 2022 12:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08A2C26EC
        for <linux-fbdev@vger.kernel.org>; Sat,  7 May 2022 09:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651941620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=inhGipBUDTXnB2qKEYfxvYqIWIZ4u692zATmOyojLEY=;
        b=DGn71tS+FTNn/jiB0hJwTlqvs9YOZI8QMMY1QOVJNj4fotIs7SLOf5GdbYTrb3dW5eGedF
        BSojKAUMzEQBoplguA7fb1XOvrU2U+xqAdWYTkCPufXJV2VbzR1Gs89K6IKq5MnLANV5tV
        Dz1WyURenHTzXLFWgoybeG1ehnq4P8o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-lJ05bExkPcCp68d3SH3VdQ-1; Sat, 07 May 2022 12:40:19 -0400
X-MC-Unique: lJ05bExkPcCp68d3SH3VdQ-1
Received: by mail-wm1-f72.google.com with SMTP id bi5-20020a05600c3d8500b0039489e1d18dso11298wmb.5
        for <linux-fbdev@vger.kernel.org>; Sat, 07 May 2022 09:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=inhGipBUDTXnB2qKEYfxvYqIWIZ4u692zATmOyojLEY=;
        b=Wc3b254PB/f7O2eM1/Ubqf/PiAnnjZCmwkyQwYhXMCRnifIzcjtLtP/9VIa2ncIBrY
         9e2lJtZ5XD8h0/4L7SeUdVJY5V5vexVwY+KEiWj3nB0S7uHAU+rVfncTzKucAmRS6Hyp
         loS/KATnUGZ0z9C1W8Tzvx7HMBIjjD1Nw40+XcVEjlRTNgLM/YYX2Qvb7mjmsBzCf9S1
         NcoEB3CindD/HrzBgtR5B72b+XpPNYYDQ5EgI63YOhpcgL5XSqDq1pRSj1MT9ty3nS3b
         D3VrRHA102xnm6eQW1z5y/XBXMhAmDhbtAb9QWeXJtgcLN4A9+VBdjv4XBVe2Rk1AwU/
         HuTw==
X-Gm-Message-State: AOAM530e/Pu9MzhxVocUPPRxKVbz6ZfL5prcPc6F4vuWOyPOcmpNpDAh
        lds2QnuUZYLJNmx364OfPcZPG1Ytto4AKCA1MV2BU+JyhkS1sP6PynOp5oyjq/Z2qGfygk1iOhT
        fZNNspPKeSHgUaYbl/aXPhO0=
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr15431643wmh.21.1651941618486;
        Sat, 07 May 2022 09:40:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykhasS4dK4eppFGtBqCb2g0PaleaocuXsAQca/dvV5qInWX6ynRAZXrO0TJxqEd2vidA73gA==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr15431630wmh.21.1651941618195;
        Sat, 07 May 2022 09:40:18 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d5942000000b0020c5253d8e1sm7951521wri.45.2022.05.07.09.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 09:40:17 -0700 (PDT)
Message-ID: <981d7ed4-8554-73ca-bfd1-2d89e4e91af3@redhat.com>
Date:   Sat, 7 May 2022 18:40:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fbdev: efifb: Fix a use-after-free due early fb_info
 cleanup
Content-Language: en-US
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-fbdev@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Peter Jones <pjones@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>
References: <20220506132225.588379-1-javierm@redhat.com>
 <20220507162053.auo2idd5twvnxatj@ldmartin-desk2>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220507162053.auo2idd5twvnxatj@ldmartin-desk2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Lucas,

On 5/7/22 18:20, Lucas De Marchi wrote:
> On Fri, May 06, 2022 at 03:22:25PM +0200, Javier Martinez Canillas wrote:
>> Commit d258d00fb9c7 ("fbdev: efifb: Cleanup fb_info in .fb_destroy rather
>> than .remove") attempted to fix a use-after-free error due driver freeing
>> the fb_info in the .remove handler instead of doing it in .fb_destroy.
>>
>> But ironically that change introduced yet another use-after-free since the
>> fb_info was still used after the free.
>>
>> This should fix for good by freeing the fb_info at the end of the handler.
>>
>> Fixes: d258d00fb9c7 ("fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove")
> 
> are these patches going through any CI before being applied? Maybe would
> be a good idea to cc intel-gfx mailing list on these fixes to have Intel
> CI to pick them up for some tests?
>

I Cc'ed intel-gfx for this particular patch. I should had done it for the
previous patches too, but I wasn't aware that Cc'ing that list would make
it run on your CI.

I tested locally the offending patch on an EFI platform before applying it
and I don't know why it didn't fail there. Sorry all for the inconvenience.
 
> pushed to drm-misc-fixes where the previous patch was applied.
> 

Thanks.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


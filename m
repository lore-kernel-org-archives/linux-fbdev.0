Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063A5C433E6
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Jan 2021 12:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0A423359
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Jan 2021 12:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbhATMkg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 20 Jan 2021 07:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbhATLRl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 20 Jan 2021 06:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611141374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SH3cllGy47s4uG7KKFq5cbuIDOd88jk3S+0uW2/kAA=;
        b=O/rdABI4nug1bUxneT3Ec/xRuK9fIVbLfQmGzn3aJAyxMa3fGh7BDlhtIVy7Iyb0MSCQSJ
        4ct+2tVV4JMD25MDM16JvTbh03H8exLrX2n2Ej1zOtX5KU5ckFXRiHoA6ytAi5H6SMuMXC
        L2ago3BYqjWuyH7Qj8ANOmRQJkf5YAI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-0OxIlTREMH-AmQja9ty0eQ-1; Wed, 20 Jan 2021 06:16:06 -0500
X-MC-Unique: 0OxIlTREMH-AmQja9ty0eQ-1
Received: by mail-ed1-f70.google.com with SMTP id n8so8945507edo.19
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Jan 2021 03:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0SH3cllGy47s4uG7KKFq5cbuIDOd88jk3S+0uW2/kAA=;
        b=Xxa9o87i4rP8d0QWL/zsq5XWBfqOyfNneYdb5f+Z6aEQU6rHTI0HsMm3qaQNGYlvsm
         TH+3QcnkDzS9ewhIcpvrZ+YNGhksEUimLfzW/oWYEqCIjP1KQi/lwRlMvCWlHBvxbEJw
         A6VqCBSIPsDwMKUuhESQEctq9sBP/ZzuOoLFfX7KeKpnNvvQ1Kp2k+wEg/kCycMLMxL3
         lREu+Sx9PEsrgoPd7SPfA11Q0K2j7h6paIO+T8oFoPNtKnwbD0peTKWizt/y9qT0k5Gq
         G23Gg7Glvfg1vrp+PlgJIx7l1tUI3kdPrx9PEuOKy4KEJLJw/YYZuvSMJ160hxjiVo6B
         Naxg==
X-Gm-Message-State: AOAM533rjnWRakH4LILObcy+LgQj/1mKqpOMuckS8aw4RFr/CaetZ7bS
        P4RXJsvv1AdNusxxLejp+J1Pfk8fU0Ukduz/stI9ne3NwmG9decjm3Ic8fPFXaUye+DObL+i8C4
        FaM6786kMcIBrlxw5que5V/E=
X-Received: by 2002:a05:6402:b6f:: with SMTP id cb15mr6813588edb.277.1611141365200;
        Wed, 20 Jan 2021 03:16:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwF2jPpquEnV42x9rBfnay/MufY16FX0dQBH+/yFA2JSgaTGzzyq/yUsEFfmDEcT9RdGF+T3w==
X-Received: by 2002:a05:6402:b6f:: with SMTP id cb15mr6813578edb.277.1611141365064;
        Wed, 20 Jan 2021 03:16:05 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id k16sm747754ejd.78.2021.01.20.03.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 03:16:03 -0800 (PST)
Subject: Re: [PATCH] video: fbdev: simplefb: Fix info message during probe
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Peter Robinson <pbrobinson@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20201228183934.1117012-1-pbrobinson@gmail.com>
 <b00bd27c-70b5-9ef1-85a1-11e733af78da@redhat.com>
 <X/c/OwqdMtmqzOZq@phenom.ffwll.local>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1acc822f-b7a5-b0be-5533-32528080850a@redhat.com>
Date:   Wed, 20 Jan 2021 12:16:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X/c/OwqdMtmqzOZq@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On 1/7/21 6:04 PM, Daniel Vetter wrote:
> Hi Hans,
> 
> On Tue, Dec 29, 2020 at 02:02:30PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 12/28/20 7:39 PM, Peter Robinson wrote:
>>> The info message was showing the mapped address for the framebuffer. To avoid
>>> security problems, all virtual addresses are converted to __ptrval__, so
>>> the message has pointless information:
>>>
>>> simple-framebuffer 3ea9b000.framebuffer: framebuffer at 0x3ea9b000, 0x12c000 bytes, mapped to 0x(____ptrval____)
>>>
>>> Drop the extraneous bits to clean up the message:
>>>
>>> simple-framebuffer 3ea9b000.framebuffer: framebuffer at 0x3ea9b000, 0x12c000 bytes
>>>
>>> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
>>
>> Thanks, patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Since you have commit rights for drm-misc I'm assuming you're also going
> to push this one?

I knew there was some discussion about using drm-misc for drivers/video/fbdev stuff
but I missed that it was decided to go ahead with that.

Good to know that this is handled through drm-misc now.

I've pushed this patch to drm-misc-next.

Regards,

Hans



>>> ---
>>>  drivers/video/fbdev/simplefb.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
>>> index 533a047d07a2..62f0ded70681 100644
>>> --- a/drivers/video/fbdev/simplefb.c
>>> +++ b/drivers/video/fbdev/simplefb.c
>>> @@ -477,9 +477,8 @@ static int simplefb_probe(struct platform_device *pdev)
>>>  	simplefb_clocks_enable(par, pdev);
>>>  	simplefb_regulators_enable(par, pdev);
>>>  
>>> -	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%p\n",
>>> -			     info->fix.smem_start, info->fix.smem_len,
>>> -			     info->screen_base);
>>> +	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes\n",
>>> +			     info->fix.smem_start, info->fix.smem_len);
>>>  	dev_info(&pdev->dev, "format=%s, mode=%dx%dx%d, linelength=%d\n",
>>>  			     params.format->name,
>>>  			     info->var.xres, info->var.yres,
>>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 


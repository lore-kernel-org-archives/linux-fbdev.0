Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E6CC05027
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Feb 2023 11:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjBQLYd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Feb 2023 06:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjBQLYc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Feb 2023 06:24:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20AE627E6
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 03:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676633022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=seb+UnT6fXFwECQkziBuKI673IsXhXzJa3B+Rdcr3n8=;
        b=D2CJIZGXp8ohHiV17PZaxvN+DDgNmqgPizx+e31NNY0wtDq1a/xld7GlH1NHJ3FRFA22Qi
        Xywmw0gLKim3UQtQYqA+Iw1bC4i4yyKDg0GLLxgLui3FziV3l/xJB1m/+DNgQZj4D8Uq0r
        EX7kOfN1lv/d5kbTNFYh4jhlFARI+/8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-190-Hs12ZteyPNG13wrwvfnRSg-1; Fri, 17 Feb 2023 06:23:41 -0500
X-MC-Unique: Hs12ZteyPNG13wrwvfnRSg-1
Received: by mail-wm1-f71.google.com with SMTP id n6-20020a05600c500600b003e2036a1516so533337wmr.7
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 03:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seb+UnT6fXFwECQkziBuKI673IsXhXzJa3B+Rdcr3n8=;
        b=PPQgHd4mb2XvE7GaWlxN89GtxV3s/N+QG/ISUJF9NImafo/5LU2X+FVf75Vd5gl7ay
         uuaEHEHSVVOp4rt5G8fY897yDbAnVREs2qaG5iZ5k/UvW9t8r0EO+n6XELpDtOIMt4Dg
         fo0TbKcMbFBkok8MFvfQu2gCoFPt+dCToLwA2dq3N6wwx03LGHjCFW7x431Rptttx/GI
         WwgH982rNP18ShRFnmOsxF43drdwJSuFfePxbfMHJgPvW9/sq5rOEsw4COK2KdsMhssn
         3Itwzk/KjtxOXjBJ9aeXsE3GpdIP1pmFcQxPsuD5TMkr2cMcQxXY6mAerqJm/5Zr5jYW
         uZYQ==
X-Gm-Message-State: AO0yUKXH/SOlIKywtQIHh2FdCgG3RBabqiQnZIlsryUKmNbRznUngZl4
        9H+lwpbR+odMAm3bDgaXBUeQQ38/ewPdXoTYSoke4auuPn4Hho38wmS53o1w5b5qJl6AX9RbLiQ
        tJPM79eSzLRV1v5Pcw96lt3A=
X-Received: by 2002:a5d:49c4:0:b0:2c5:5f95:7746 with SMTP id t4-20020a5d49c4000000b002c55f957746mr7312221wrs.56.1676633019925;
        Fri, 17 Feb 2023 03:23:39 -0800 (PST)
X-Google-Smtp-Source: AK7set9EFBEl4WDoRU8Iwut2hV1mfRRFMcd1jJye0+8k8u1HqbEZwr9yUu/4Qf4uxNyoSAl+SsFhNg==
X-Received: by 2002:a5d:49c4:0:b0:2c5:5f95:7746 with SMTP id t4-20020a5d49c4000000b002c55f957746mr7312210wrs.56.1676633019651;
        Fri, 17 Feb 2023 03:23:39 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d6612000000b002c551f7d452sm3893041wru.98.2023.02.17.03.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:23:39 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        geoff@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/11] fbdev: Transfer video= option strings to caller;
 clarify ownership
In-Reply-To: <2c589464-bc37-4138-d9a6-b38cd05e5f99@suse.de>
References: <20230209135509.7786-1-tzimmermann@suse.de>
 <20230209135509.7786-3-tzimmermann@suse.de>
 <87a61cy9et.fsf@minerva.mail-host-address-is-not-set>
 <2c589464-bc37-4138-d9a6-b38cd05e5f99@suse.de>
Date:   Fri, 17 Feb 2023 12:23:37 +0100
Message-ID: <87y1ow4jt2.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 17.02.23 um 09:37 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> 
>>> In fb_get_options(), always duplicate the returned option string and
>>> transfer ownership of the memory to the function's caller.
>>>
>>> Until now, only the global option string got duplicated and transferred
>>> to the caller; the per-driver options were owned by fb_get_options().
>>> In the end, it was impossible for the function's caller to detect if
>>> it had to release the string's memory buffer. Hence, all calling drivers
>>> leak the memory buffer. The leaks have existed ever since, but drivers
>>> only call fb_get_option() once as part of module initialization. So the
>>> amount of leaked memory is not significant.
>>>
>>> Fix the semantics of fb_get_option() by unconditionally transferring
>>> ownership of the memory buffer to the caller. Later patches can resolve
>>> the memory leaks in the fbdev drivers.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> ---
>> 
>> [...]
>> 
>>> +	if (option) {
>>> +		if (options)
>>> +			*option = kstrdup(options, GFP_KERNEL);
>>> +		else
>>> +			*option = NULL;
>>> +	}
>>>
>> 
>> I know the old code wasn't checking if kstrdup() succeeded, but you should
>
> Kstrdup uses kmalloc, which already warns about failed allocations. I 
> think it's discouraged to warn again. (Wasn't there a warning in sparse 
> or checkpatch?)  So I'd rather leave it as is.
>

I didn't mean to warn but to return an error code.

>> do it here and let the caller know. And same if (!options). So I guess the
>> following check can be added (to be consistent with the rest of the code):
>> 
>> 	if (!*option)
>> 		retval = 1;
>
> Why is that needed for consistency?
>
> Retval is the state of the output: enabled or not. If there are no 
> options, retval should be 0(=enabled). 1(=disabled) is only set by 
> video=off or that ofonly thing.
>

Ah, I see. I misundertood what retval was about. Forget this comment then.

Maybe while you are there could have another patch to document the return
value in the fb_get_options() kernel-doc?

And this patch looks good to me too after your explanations.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier


Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0FCC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 Jan 2022 10:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbiAQKT4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 17 Jan 2022 05:19:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237389AbiAQKTz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 17 Jan 2022 05:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642414795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M2Jwh6X9L+KjOaA4kG9lgML07Ljz7RAuTmgyF2gmzTk=;
        b=hDeQUcPeAJOXBs5atH6HAwl9kQExo2ca5HPbaHMSH3nF/EvVU55mqz1weiSGpITOj1Xyl9
        29KEDwYi5rMJCXjSI6aLP+sCudDF/z5h7nCveMHQFYXlgmT9Ue6Sua8LIjExy8MCb2vYna
        YFoYOiHyXuEqbBSTKreQrYKjP+Sgklw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-rk5ahMAOMRGSXRrko6WMNg-1; Mon, 17 Jan 2022 05:19:53 -0500
X-MC-Unique: rk5ahMAOMRGSXRrko6WMNg-1
Received: by mail-wm1-f70.google.com with SMTP id k41-20020a05600c1ca900b0034aea0b9948so8459268wms.3
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Jan 2022 02:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M2Jwh6X9L+KjOaA4kG9lgML07Ljz7RAuTmgyF2gmzTk=;
        b=jgPjZL3V97agg+4vPyZVXmxw1gDGPLSW518xOTX07oE1y5qlxibHNHxqWbyqKZhfJH
         7ebE6AkxHuEQjD7tRX+YHiao0i3WJfg1F4bbatDkNRU0MG9SEn2sO2Fop0z+vMXqNN8r
         tyoSR5vXJgXrWnDwG9pCLStipTWriGp2lNN0224YdYpzD+ji12O9WindmFDvv1pPDIui
         70tFuWLe5gQZDd3McJB0ldwI4FWekSu+77j40B1YiW22Mur3oN33wrAbYhBMFyx4b68I
         sv/jHiG9CMw4GXPAawJFYMExVw6iLArJ01246B+HP38KnlyRvoABwdYcDH0VA9TBTjtr
         TSQw==
X-Gm-Message-State: AOAM530Q83dlndqaOKbetfLfHX0hIi9Xa0Z5b2NtR/hBjDo1wsnhNQso
        HKFKrCx3L+SWPqtumWeoU0OL0935d826rpKQEPL1tZPjOrXmvZUiFUgZwizHKy0Ce1JtYzdmeAW
        cdsiki3gBPdRZCgNWy7jlwFM=
X-Received: by 2002:adf:b60d:: with SMTP id f13mr8447984wre.225.1642414791822;
        Mon, 17 Jan 2022 02:19:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjvQUUb/H0EZLSZ3Ie0h6oeM1z//4qUyAexcNH+Hmg6QGgAM53E0ZxOy6w07KCaNZAYcAt7Q==
X-Received: by 2002:adf:b60d:: with SMTP id f13mr8447972wre.225.1642414791578;
        Mon, 17 Jan 2022 02:19:51 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z7sm15283605wrm.117.2022.01.17.02.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 02:19:51 -0800 (PST)
Message-ID: <fa7d7b0e-50bf-dc1b-a708-408de47b1e66@redhat.com>
Date:   Mon, 17 Jan 2022 11:19:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
Content-Language: en-US
To:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "airlied@gmail.com" <airlied@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <YeG8ydoJNWWkGrTb@ls3530>
 <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/17/22 11:02, Daniel Vetter wrote:

[snip]

>>  FRAMEBUFFER LAYER
>> -L:     dri-devel@lists.freedesktop.org
>> +M:     Helge Deller <deller@gmx.de>
>>  L:     linux-fbdev@vger.kernel.org
>> -S:     Orphan
> 
> Maybe don't rush maintainer changes in over the w/e without even bothering
> to get any input from the people who've been maintaining it before.
> 
> Because the status isn't entirely correct, fbdev core code and fbcon and
> all that has been maintained, but in bugfixes only mode. And there's very
> solid&important reasons to keep merging these patches through a drm tree,
> because that's where all the driver development happens, and hence also
> all the testing (e.g. the drm test suite has some fbdev tests - the only
> automated ones that exist to my knowledge - and we run them in CI). So
> moving that into an obscure new tree which isn't even in linux-next yet is
> no good at all.
> 
> Now fbdev driver bugfixes is indeed practically orphaned and I very much
> welcome anyone stepping up for that, but the simplest approach there would
> be to just get drm-misc commit rights and push the oddball bugfix in there
> directly. But also if you want to do your own pull requests to Linus for
> that I don't care and there's really no interference I think, so
> whatever floats.
>

I second that getting commit rights in drm-misc and pushing the changes
there makes much more sense than keeping a separate tree for fbdev.

Not only for the fbdev core and fbcon but also for fbdev drivers. There
is common for fbdev drivers bugs to be exposed after DRM changes, so it
is more convenient to push fixes for these through the same tree as well.

As an example, just last week I had to fix issues in the vga16fb driver
that started to occur after a change to support simpledrm in aarch64:

https://lore.kernel.org/all/20220111131601.u36j6grsvnir5gvp@houat/T/

If there is a separate tree for fbdev, then this would require to do
some coordination, share and merge immutable branches, etc for no
clear benefit.

Best regards,-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


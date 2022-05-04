Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B24C43217
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 11:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348952AbiEDLjT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 07:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349056AbiEDLjS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 07:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 911C5222A4
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 04:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651664141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34VZxVT7BZbb571VsASnxn7VWsmyBHWuoREbYnuFRqA=;
        b=bAF+GusD+zUbuKQHwGyPQ18r5QpYfiwMs9cjrazuUueGWamLU01FLpC6b5pI1YfPES1/Bc
        m7F/V9uHp2I2AhykAqyH0EMisQQ++g21Qgeko0US7aBlbanHFOH9uRg00QaoxnO1fWpcS0
        v89ed/lszdCuXXmN78mgpRTHYqUzdY8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-KXhj5SChO5-UTAerqEh-Ug-1; Wed, 04 May 2022 07:35:40 -0400
X-MC-Unique: KXhj5SChO5-UTAerqEh-Ug-1
Received: by mail-wm1-f69.google.com with SMTP id g14-20020a1c4e0e000000b0039425ef54d6so529266wmh.9
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 04:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=34VZxVT7BZbb571VsASnxn7VWsmyBHWuoREbYnuFRqA=;
        b=Tl5CImo0kZ8Tky/18bY9r9cHoEdaq/Ctr1e4rL7easdQ7lClAx6x37TcqbS/D/9uVA
         vJBotZ4QAyCOuXFJklbIYvZQhOQqSnS/hVo8i5Oj1zyRACxAQnkg5czAeAQuD7tV7kKS
         2S5oW7Zk8GagS7b3M4cGe9T+m0fue5upmVwTEnFawlRmFLehS3rNv0flw0ld9TZ54qof
         Foogjoo+KDyttQhJVY/qbTaa61hWsXw7ezaIY76CP50ddBdi5OSzKZNeuPnJQC75xuUX
         i3rrI7r8DqdVbId2ve/eM8i45PYTE46A4qwPk9Af02RLklZcQ5bfpEce7b24eVq4RIzy
         iiZA==
X-Gm-Message-State: AOAM530ugU/PFV7fZkuA8NfQdHo6O6/A1FQkkkX72QoE+QP61RtEsEHx
        aaEgv7BSnBsrhZHj5C0f4qK7WI+xWN0aGDtFpjksBBTUO5lIn48piNNqi1gB5JHlO84X6Z87lv4
        zLCasV/CCKQZBCIHCBG7K81s=
X-Received: by 2002:a7b:ce0a:0:b0:394:41e:2517 with SMTP id m10-20020a7bce0a000000b00394041e2517mr7303641wmc.135.1651664139534;
        Wed, 04 May 2022 04:35:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkqdX7HCGB2EekG/+HnmQTPbLcK1+rCPyta5s7F5sneyoQz8GhIv8xGVqmVaPz6xc7p4OmlA==
X-Received: by 2002:a7b:ce0a:0:b0:394:41e:2517 with SMTP id m10-20020a7bce0a000000b00394041e2517mr7303627wmc.135.1651664139274;
        Wed, 04 May 2022 04:35:39 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e11-20020a05600c4e4b00b003942a244f36sm3780628wmq.15.2022.05.04.04.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 04:35:38 -0700 (PDT)
Message-ID: <da8874d4-66f1-d14e-c0ef-c3557e189cf4@redhat.com>
Date:   Wed, 4 May 2022 13:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] fbdev: Use helper to get fb_info in all file
 operations
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Junxiao Chang <junxiao.chang@intel.com>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220503201934.681276-1-javierm@redhat.com>
 <YnJBGpvlViLV+0/a@phenom.ffwll.local>
 <038f8365-b23b-9d81-f7b2-8f8c6eb3a065@redhat.com>
 <YnJbvb5TlHs4ckPM@phenom.ffwll.local>
 <d47a3cab-4f21-3b8b-2834-030663677070@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <d47a3cab-4f21-3b8b-2834-030663677070@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 5/4/22 13:08, Thomas Zimmermann wrote:

[snip]

>>> So something similar to fb_file_fb_info() is needed to check if
>>> the vm_private_data is still valid. I guess that could be done
>>> by using the vmf->vma->vm_file and attempting the same trick that
>>> fb_file_fb_info() does ?
>>
>> Yeah should work, except if the ptes are set up already there's kinda not
>> much that this will prevent. We'd need to tear down mappings and SIGBUS or
>> alternatively have something else in place there so userspace doesn't blow
>> up in funny ways (which is what we're doing on the drm side, or at least
>> trying to).
>>
>> I'm also not sure how much we should care, since ideally for drm drivers
>> this is all taken care of by drm_dev_enter in the right places. It does
>> mean though that fbdev mmap either needs to have it's own memory or be
>> fully redirected to the drm gem mmap.
>>
>> And then we can afford to just not care to fix fbdev itself.
> 
> While the problem has been there ever since, the bug didn't happen until 
> we fixed hot-unplugging for fbdev. Not doing anything is probably not 
> the right thing.
>

Actually, this issue shouldn't happen if the fbdev drivers are not buggy
and do the proper cleanup at .fb_release() time rather than at .remove().

I'll post patches for simplefb and efifb which are the drivers that we
mostly care at this point. So we should be good and not need more fixes.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


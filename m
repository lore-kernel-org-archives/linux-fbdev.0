Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB977C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 May 2022 13:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiEENXW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 May 2022 09:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379156AbiEENXQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 May 2022 09:23:16 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43C745674F
        for <linux-fbdev@vger.kernel.org>; Thu,  5 May 2022 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651756776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IW6fOs7e5307KfibthmglvTovnRowFL+yzU/9f+OYUE=;
        b=YgJ/BFwjvBupcsfb99lKXjZQA9Y2XNH154XY/HB7S5K5hJdwIgmbPqzJtkf2/7viCuFGDi
        sFFjUlFvpJSVXPxg/EXLnG0e3FtoX3nADRzj298mm2AC86LklSOsDwLEVVTvQAwclmfpq1
        /kfB/PIdg6iwhSxc/XS9+bFDb4RRQCE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-e_F2w-KIOVKK7ePmMf0z-A-1; Thu, 05 May 2022 09:19:33 -0400
X-MC-Unique: e_F2w-KIOVKK7ePmMf0z-A-1
Received: by mail-wm1-f72.google.com with SMTP id s14-20020a05600c29ce00b00394611a8059so1752640wmd.4
        for <linux-fbdev@vger.kernel.org>; Thu, 05 May 2022 06:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IW6fOs7e5307KfibthmglvTovnRowFL+yzU/9f+OYUE=;
        b=HP5ZYS0UlmHYNQCLz+pI5n6N0WgpR4pf8sZirhhb2dcF6oeliHN7dDaQyJ5CKZdIXr
         fjslgwG+IjP6YLTESxRCwgPWfrBh7NbOcKIikxsM+J8x3ljVWCvpE/LCMXPiL/2Vsefj
         egV/tEuCb53FnKQ3qIKa0pvT97fw0Yu/xJhKE6CDcig/CBsPlPSWrwvVzC8ecAWECZ9i
         +nNTpPQscDyb7wn4Ij6inQ2P20CbzjmFydGVTpe5AaLMpdhBxH/6ZqlSKK7GC1fRCbYQ
         X8ZyEfdazJTGLbj2QGYGInCC8P8OYLsO3mshgtgX2N87mz8A0tI6bIicNz3382O7YN5/
         kLpQ==
X-Gm-Message-State: AOAM532SzmUlrPAXE+8SdVM+ufSW0IT/edokNaXM8d+so9LOjtaUhByJ
        uD0n+DYNnuy6zJffFrmYQrR7RGWuvaruKjErmY7ZQD66GQjPicD0CrpolyfaInvNiKlTrf0G+/M
        Mec4snoECDUoSLSLseE7AxXY=
X-Received: by 2002:a05:600c:1d18:b0:394:6469:abec with SMTP id l24-20020a05600c1d1800b003946469abecmr4767698wms.89.1651756771916;
        Thu, 05 May 2022 06:19:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznOboZJQssf1bkI3Rw7a6NAaieRAgtKHnzU4znuTG9Om0VUyJQMtC9zyn0YmSBtfpe6zPe9g==
X-Received: by 2002:a05:600c:1d18:b0:394:6469:abec with SMTP id l24-20020a05600c1d1800b003946469abecmr4767666wms.89.1651756771561;
        Thu, 05 May 2022 06:19:31 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c17-20020a7bc011000000b003942a244f40sm6395959wmb.25.2022.05.05.06.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 06:19:31 -0700 (PDT)
Message-ID: <d53319d8-acaf-7b57-20cf-f35cc5969895@redhat.com>
Date:   Thu, 5 May 2022 15:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 4/4] fbdev: vesafb: Cleanup fb_info in .fb_destroy
 rather than .remove
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220505113128.264963-1-javierm@redhat.com>
 <20220505113128.264963-5-javierm@redhat.com>
 <YnPK3RLPdtvFze+8@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnPK3RLPdtvFze+8@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Daniel,

On 5/5/22 15:02, Daniel Vetter wrote:

[snip]

>>  static void vesafb_destroy(struct fb_info *info)
>>  {
>>  	struct vesafb_par *par = info->par;
>> @@ -187,7 +191,13 @@ static void vesafb_destroy(struct fb_info *info)
>>  	arch_phys_wc_del(par->wc_cookie);
>>  	if (info->screen_base)
>>  		iounmap(info->screen_base);
>> +
>> +	if (((struct vesafb_par *)(info->par))->region)
>> +		release_region(0x3c0, 32);
> 
> This move seems rather iffy, so maybe justify it with "makes the code
> exactly as busted before 27599aacbaef ("fbdev: Hot-unplug firmware fb
> devices on forced removal")"
>

I think that will just drop this change. While being here I wanted the release
order to be the inverse of the order in which the driver acquires them. But I
will only move the framebuffer_release() that is the problematic bit.

Someone if care enough could fix the rest of the driver.
 
> Also same comments as on v1 about adding more details about what/how this
> fixes, with that: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>

Yes, I'll do that too. Thanks again for your comments and feedback.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


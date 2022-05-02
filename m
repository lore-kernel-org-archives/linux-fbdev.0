Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55916C4332F
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 May 2022 13:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351549AbiEBNkI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 May 2022 09:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385377AbiEBNkF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 May 2022 09:40:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27D1CDEE7
        for <linux-fbdev@vger.kernel.org>; Mon,  2 May 2022 06:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651498591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wk6mLWRRViFXWkx+VvGzbw9fqjF1MLHsTTjWqUZV74g=;
        b=CfOBCafeEBpQdW25O+ESwidCGBaCnh7/DoQED53OViJ87DdtXnOT1pLS6kMMLvjQSSmWbC
        GCGBDdcZ6aBkIg8aTcebyVh/iQVED01/FK0qa0Qb01HXE376ctFn6waTbJV/sIvv2Gzi57
        VVFJhCfT9au3vjo2rlrQpsmw98d2rqI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-42NcLK_jPDiAOnjtBF0Hyw-1; Mon, 02 May 2022 09:36:23 -0400
X-MC-Unique: 42NcLK_jPDiAOnjtBF0Hyw-1
Received: by mail-wm1-f69.google.com with SMTP id n186-20020a1c27c3000000b00392ae974ca1so8957wmn.0
        for <linux-fbdev@vger.kernel.org>; Mon, 02 May 2022 06:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wk6mLWRRViFXWkx+VvGzbw9fqjF1MLHsTTjWqUZV74g=;
        b=4pGq6Hm+L026R6uM0mDh9X174gcLLHmb+ieOFyQPACQ8b5I/QweY0OEWfKc1fu4duy
         nFhU8ytt4gLYU1A1chB6PBhfo5YT5hZGkPqFmOUGwOKg7/Bw8fuO1dHP6mchrPds529q
         oDUhLHmwX3XZyz5I2yzYCY8qXlce8AN6xb3wuhhRgOS4eDq4EL4vxxn7F73ziKMjBUuo
         K66iT/tpR0ysyCSNVW9WnlmFYugJ/RdvqP8Lhe1W41FW4b7Hq4yZaKg/kavmcxggBfSF
         qU1bUrMYo21AqgNR7MnEDLAt4T2prVoo7Z6jefrF1bti5xvkfTrxg0kf1xbomrZ+PV04
         FRiw==
X-Gm-Message-State: AOAM530Gqof5lkCTnk5Uiurp13ISjPVM4Nkcd2ORZwKPPTWEK7BnYzqF
        q1/TTde6JfJ6veX0ZBtFwvt8UHObyYy36p4lRajQ2Qtwm7FjCfXLeFBr3AVuwlvsj8HtIcfMPIk
        nokE44LrcJOsLNwYPGWVhwwY=
X-Received: by 2002:a05:600c:3b14:b0:394:1f06:37eb with SMTP id m20-20020a05600c3b1400b003941f0637ebmr10884560wms.193.1651498582008;
        Mon, 02 May 2022 06:36:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEwL5W5ENYx/Gaa49NDx4yx3cjiPFzGsI/Mcnz7WEwp1islY54iqn0IFPIaaasmsyn0xwuUA==
X-Received: by 2002:a05:600c:3b14:b0:394:1f06:37eb with SMTP id m20-20020a05600c3b1400b003941f0637ebmr10884551wms.193.1651498581801;
        Mon, 02 May 2022 06:36:21 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v22-20020adf8b56000000b0020c5253d8d4sm7047386wra.32.2022.05.02.06.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 06:36:21 -0700 (PDT)
Message-ID: <c556b0f7-b3b9-17fd-7349-45cfb2dfe1d8@redhat.com>
Date:   Mon, 2 May 2022 15:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] fbdev: Check in file_fb_info() if the fb_info was
 already been freed
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Helge Deller <deller@gmx.de>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220502130944.363776-1-javierm@redhat.com>
 <20220502130944.363776-2-javierm@redhat.com>
 <fa010244-b250-ea6d-275e-bfbe1bd8f212@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <fa010244-b250-ea6d-275e-bfbe1bd8f212@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 5/2/22 15:26, Thomas Zimmermann wrote:
> Hi
> 
> Am 02.05.22 um 15:09 schrieb Javier Martinez Canillas:
>> If real driver probes, the fbdev core kicks out all drivers that are using
>> a framebuffer that were provided by the system firmware. But it could be a
>> user-space process still has a file descriptor for the fbdev device node.
>>
>> This can lead to a NULL pointer dereference, if the framebuffer device is
>> unregistered and associated data freed, but later in the .release callback
>> is attempted to access its struct fb_info.
>>
>> To prevent this, make file_fb_info() to also check the fb_info reference
>> counter and just return NULL if this equals zero. Since that means it has
>> already been freed.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>   drivers/video/fbdev/core/fbmem.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
>> index 84427470367b..20d8929df79f 100644
>> --- a/drivers/video/fbdev/core/fbmem.c
>> +++ b/drivers/video/fbdev/core/fbmem.c
>> @@ -751,8 +751,13 @@ static struct fb_info *file_fb_info(struct file *file)
>>   	int fbidx = iminor(inode);
>>   	struct fb_info *info = registered_fb[fbidx];
>>   
>> -	if (info != file->private_data)
>> -		info = NULL;
>> +	if (!info)
>> +		return NULL;
>> +
>> +	/* check that the fb_info has not changed or was already freed */
>> +	if (info != file->private_data || refcount_read(&info->count) == 0)
>> +		return NULL;
>> +
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> However, I'm having problems with the semantics of these variables: if 
> we have an info from registered_fb[fbinx] and the refcount in 
> info->count is still 0, isn't that a consistency problem? If so, we 
> should print a WARN_ON().
>

That's a good point. Maybe we are being too paranoid here? If the fb_info
was set to NULL then the existing if (info != file->private_data) check
will already catch that issue.

In other words, now that fb_release() is getting the fb_info with the
file_fb_info() function instead of file->private_data directly, the NULL
pointer dereference should not happen anymore.

I think that will just drop this patch, the less we touch the fbdev code
the better IMO.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


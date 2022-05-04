Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D24C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 08:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbiEDIaQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 04:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbiEDIaP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 04:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 501E21E3DF
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651652799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+C/4yoNKEEGV6PoJ/pGUW0PpRiFTb33UcshUyLm1xTM=;
        b=FnRkSyyCmfkjpNDoA6KyG/2XPKhmFIWViaLdlRCXuO4i1xoOmyh/wT3a61N2nKSRbcLJmu
        2i0Fno5JMVeTHF5lLZkPhz+uHHLPQKuT2qhLjL9FsYpy+JZNal+2gJyvnQOdkOqzjzA8MC
        IPWLTmcWjmDCiXHecfZ7TxkGXpGCDZU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-3O8CI3l_Mxmsh7w5m-UyUA-1; Wed, 04 May 2022 04:26:32 -0400
X-MC-Unique: 3O8CI3l_Mxmsh7w5m-UyUA-1
Received: by mail-wm1-f69.google.com with SMTP id g14-20020a1c4e0e000000b0039425ef54d6so339825wmh.9
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 01:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+C/4yoNKEEGV6PoJ/pGUW0PpRiFTb33UcshUyLm1xTM=;
        b=72y9g/x6lHbnJroGB9wXETG9BL0Gx367POXMX3fPfRbQNL1c/PtuXvjEUuMq2S85XD
         HIhbJeem8Tl9E5gOXAvy6MdydPEpVXyUp9t6siiTqpzksMx1CNRjvrYdrrDHcSs1M2ws
         7SapeYmfYTMORe/zqOYWDpwvbji26Rsdr/cPEvinVPjPg9jOoCGFKFPJZfXg1r/jA89H
         2ELkt4HDiNYybYz3h8FaKJenOUDltl7juICtoC5/UWdQn59dcqAf1VEmi2c8hwCh2Cjf
         E1diZnyFenqFdiY/ZyggS4mqDb+jWAUE4QFEHOx4f6bnoNPYtVZYkzlI9+GPSmkRGtEp
         GV0g==
X-Gm-Message-State: AOAM531zXpbGqZxMnuj92ApLcJltT89e0fXhscwtDtoDORBBdTMtJ+IO
        DD/9V9MS6UUwcURBeRoHpfXLOZUagb0z8kJTRHYgH8Qkt9h9BKQKU0BMkBOHFiX/Q0tspOIFczX
        vNs5YdDxpjF3aF6zHj2AdmUU=
X-Received: by 2002:a1c:2942:0:b0:392:3aff:4fcd with SMTP id p63-20020a1c2942000000b003923aff4fcdmr6702215wmp.0.1651652791572;
        Wed, 04 May 2022 01:26:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwf5liG5UOSbg9cbpMtmv/D9VHVe+DIqeuq8o0WbDy3DvVW1qvmg350Q24IdSh6Jmk4iyNgg==
X-Received: by 2002:a1c:2942:0:b0:392:3aff:4fcd with SMTP id p63-20020a1c2942000000b003923aff4fcdmr6702197wmp.0.1651652791294;
        Wed, 04 May 2022 01:26:31 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id be13-20020a05600c1e8d00b003942a244ee6sm3856611wmb.43.2022.05.04.01.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 01:26:30 -0700 (PDT)
Message-ID: <3f8f697f-7b85-cb8c-445a-8d7c40a062f8@redhat.com>
Date:   Wed, 4 May 2022 10:26:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] fbdev: Use helper to get fb_info in all file
 operations
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, Maxime Ripard <maxime@cerno.tech>,
        Junxiao Chang <junxiao.chang@intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220503201934.681276-1-javierm@redhat.com>
 <d0555181-6e36-044c-b747-c08dbeb3a89e@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <d0555181-6e36-044c-b747-c08dbeb3a89e@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 5/4/22 10:15, Thomas Zimmermann wrote:
> Hi
> 
> Am 03.05.22 um 22:19 schrieb Javier Martinez Canillas:
>> A reference to the framebuffer device struct fb_info is stored in the file
>> private data, but this reference could no longer be valid and must not be
>> accessed directly. Instead, the file_fb_info() accessor function must be
>> used since it does sanity checking to make sure that the fb_info is valid.
>>
>> This can happen for example if the registered framebuffer device is for a
>> driver that just uses a framebuffer provided by the system firmware. In
>> that case, the fbdev core would unregister the framebuffer device when a
>> real video driver is probed and ask to remove conflicting framebuffers.
>>
>> Most fbdev file operations already use the helper to get the fb_info but
>> get_fb_unmapped_area() and fb_deferred_io_fsync() don't. Fix those two.
>>
>> Since fb_deferred_io_fsync() is not in fbmem.o, the helper has to be
>> exported. Rename it and add a fb_ prefix to denote that is public now.
>>
>> Reported-by: Junxiao Chang <junxiao.chang@intel.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Thanks.
 
> Please see my comment below.

[snip]

>>   
>> +	if (!info)
>> +		return -ENODEV;
>> +
> 
> This is consistent with other functions, but it's probably not the 
> correct errno code. It means that a device is not available for opening.
> 
> But the situation here is rather as with close() on a 
> disconnected-network file. The call to close() returns EIO in this case. 
> Maybe we should consider changing this in a separate patch.
>

Indeed. Agree that -EIO makes more sense here.
 
> Best regards
> Thomas
> 
-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


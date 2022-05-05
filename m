Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B49FC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 May 2022 07:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242440AbiEEHoG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 May 2022 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345451AbiEEHoA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 May 2022 03:44:00 -0400
X-Greylist: delayed 87 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 00:40:21 PDT
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C787813D35
        for <linux-fbdev@vger.kernel.org>; Thu,  5 May 2022 00:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651736420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhRL0x5JxNjh9559awUlQzavmJp0VQ+2PFdUhFoZcIo=;
        b=F1AgejY4wrjKBf9UMIDAryUzKMNaJOFPQ0R12Q2So2304nms1Zm3bpJ5NgXwwV52XS7KqU
        7EnLu/rRpak8Q8saG01pyLAiCDYq8/wCx0z8+1+LOjRimdyqe+u99uqeLLKjsGdfDj3XjS
        CLygG14qV2uBfBDTsVSy5biXD5RT3sw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-OHAfaOXoNr6CnhpUBEPcLg-1; Thu, 05 May 2022 03:38:52 -0400
X-MC-Unique: OHAfaOXoNr6CnhpUBEPcLg-1
Received: by mail-wm1-f69.google.com with SMTP id v184-20020a1cacc1000000b00393e492a398so4130746wme.5
        for <linux-fbdev@vger.kernel.org>; Thu, 05 May 2022 00:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NhRL0x5JxNjh9559awUlQzavmJp0VQ+2PFdUhFoZcIo=;
        b=oUP42F0R8nXypCd4kCXxQ3wubGrGut91hPfAkXL5oK+2AyEQA1y5p1Nopt9jHc+uLD
         DPzoypaTRWLae3iSueJlA/Am6ZC/Axo4KXOtWY/kty/hh/6V5/SlkztvqOQTqw0grlpC
         iZP3xrSLMUPqnYhnfTvRLxFoECRi81ksdVSCGoGZJr/GPn/vM5iGClnFlQPrr9pU/4wz
         6OR9H5Icd3yDHg5t8ex3+IWYB/mRRfq0HOUJ5Ls9cJo+wlcmkMCVMV/iFJ8EdZUhG+tY
         GC/aORdriCqVaES9TwVrT6cFfHVdDEGhMQ6YnDzvmzoglh9Pbg/BtnVg/oqqMb1j3MZr
         /J3g==
X-Gm-Message-State: AOAM532jbc+UOW8hoigZEadPxGAPfwk3w/I3W7gdh1Yx/C1OwWo4XscO
        kq1YwOJJMNcYM0Y/1tJajblsW5lISRJy6jlYVexVh7gYQCLnxcWTFxtN+P+FG5vM9OrfV4xkQTQ
        FO/HOjw64GiAZmiBvaGenF+k=
X-Received: by 2002:a5d:4585:0:b0:20a:da03:7131 with SMTP id p5-20020a5d4585000000b0020ada037131mr19047528wrq.693.1651736331458;
        Thu, 05 May 2022 00:38:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOiVrqfx6icK3c6hK4kQWSA8M7R4dWtYNn2w4VZryyBpTxL+R3XPp9/Z57KoRlU/8Sy+vNog==
X-Received: by 2002:a5d:4585:0:b0:20a:da03:7131 with SMTP id p5-20020a5d4585000000b0020ada037131mr19047508wrq.693.1651736331173;
        Thu, 05 May 2022 00:38:51 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x8-20020a7bc768000000b003942a244f2fsm5546131wmk.8.2022.05.05.00.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 00:38:50 -0700 (PDT)
Message-ID: <d9a5cb30-2d9b-50b5-d287-0ead0fe252f3@redhat.com>
Date:   Thu, 5 May 2022 09:38:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/3] fbdev/simplefb: Cleanup fb_info in .fb_destroy rather
 than .remove
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>
References: <20220504215151.55082-1-javierm@redhat.com>
 <20220504215722.56970-1-javierm@redhat.com>
 <974f4d00-89bc-a2da-6d65-ca4207300794@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <974f4d00-89bc-a2da-6d65-ca4207300794@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 5/5/22 09:29, Thomas Zimmermann wrote:

[snip]

>>   static void simplefb_destroy(struct fb_info *info)
>>   {
>>   	struct simplefb_par *par = info->par;
>> @@ -94,6 +98,8 @@ static void simplefb_destroy(struct fb_info *info)
>>   	if (info->screen_base)
>>   		iounmap(info->screen_base);
>>   
>> +	framebuffer_release(info);
>> +
>>   	if (mem)
>>   		release_mem_region(mem->start, resource_size(mem));
> 
> The original problem with fbdev hot-unplug was that vmwgfx needed the 
> framebuffer region to be released. If we release it only after userspace 
> closed it's final file descriptor, vmwgfx could have already failed.
> 
> I still don't fully get why this code apparently works or at least 
> doesn't blow up occasionally. Any ideas?
>

I believe that vmwgfx doesn't fail to probe (or any other DRM driver)
only when there are not user-space processes with a fbdev node opened
since otherwise as you said the memory wouldn't be released yet.

unregister_framebuffer() is called from the driver's .remove handler
and that decrement the fb_info refcount, so if reaches zero it will
call to the fb fops .destroy() handler and release the I/O memory.

In other words, in most cases (i.e: only fbcon bound to the fbdev)
the driver's removal/ device unbind and the memory release will be
at the same time.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


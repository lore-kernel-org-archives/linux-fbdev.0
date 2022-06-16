Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60D2C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Jun 2022 22:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378717AbiFPWSY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Jun 2022 18:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378901AbiFPWSX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Jun 2022 18:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5871160A8C
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Jun 2022 15:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655417899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9DWpHhljjMLBCYm+B5HqD4SLrNJSN/X7QHRnWVk9iss=;
        b=GceitrHIFDD5iUA/8ivy9MCo+HVZlX1ADGJ/2dboqK01VcB8IFiUFg131tAHx/HmlMgCHO
        Ls20sXernssCz/KtYUQ6SCfFM9QCdbhsHNfXQMRkzTrPT3xrRIaYjiH4N2njlBZ5NCmiNn
        bkltKINlILgHM591eaKy/IfNcg7RLKU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-7If8F7BoM72yYDds9TZfTA-1; Thu, 16 Jun 2022 18:18:10 -0400
X-MC-Unique: 7If8F7BoM72yYDds9TZfTA-1
Received: by mail-wm1-f72.google.com with SMTP id k15-20020a7bc40f000000b0039c4b7f7d09so1402225wmi.8
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Jun 2022 15:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9DWpHhljjMLBCYm+B5HqD4SLrNJSN/X7QHRnWVk9iss=;
        b=WvzutCljWhQ2Ewi6Na7Fd25otOO/Gefa0TQlQ7UFIEE3vB5PRry3LeTr0Wk/aijeS1
         nAfw7xwdKi6VU2gSjRPomMUHnTSaIWgHubiqW9sjo3r+xpb/bsMQRoRrXYm0AutkWkCs
         gk7PxjvnFczgMM38IV6I8UFofW71cFkETTIC6ez/szemafeOrGLeIsUgPFTTd7q6gnq7
         58vJB4QJxDkJ+gB3+GgsVHJCvZZx4JyP6dzCqCzIdEo6IA7xJ5puQjTJ1lOcudC+RTUc
         X8z8TDHvXMckcFTVJXa/i784xiljnuqIbNepmQd0JTDGcB7NyY63jOcY6tZO5SQJMTXb
         7yBA==
X-Gm-Message-State: AJIora9C4HX5CARCGy/XqBPWsr+XZxsdfwVrMMuI5Sn8Y3U8iRSvM6Xm
        /MlkosJlF8oRJmQpHmKGelrmLWtjHFojrk/PNk4l59F20gaBHaKIDbqr9ReSO9PoaMbxczODyeH
        7A2X8u0PAOWlv/o1HXoNByWo=
X-Received: by 2002:adf:e181:0:b0:213:bbe1:ba66 with SMTP id az1-20020adfe181000000b00213bbe1ba66mr6215468wrb.325.1655417887925;
        Thu, 16 Jun 2022 15:18:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uO1cJJMNUcHhX2JKlWJowzj7WQI64QGyPrnUyRc32kSMp0t+NjedvVfCVD7/vwLeNG3ZUpmw==
X-Received: by 2002:adf:e181:0:b0:213:bbe1:ba66 with SMTP id az1-20020adfe181000000b00213bbe1ba66mr6215452wrb.325.1655417887629;
        Thu, 16 Jun 2022 15:18:07 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c2ccf00b003974a00697esm7435615wmc.38.2022.06.16.15.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 15:18:07 -0700 (PDT)
Message-ID: <a633d605-4cb3-2e04-1818-85892cf6f7b0@redhat.com>
Date:   Fri, 17 Jun 2022 00:18:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 3/5] fbdev: Disable sysfb device registration when
 removing conflicting FBs
Content-Language: en-US
To:     Zack Rusin <zackr@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "lersek@redhat.com" <lersek@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "deller@gmx.de" <deller@gmx.de>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>
References: <20220607182338.344270-1-javierm@redhat.com>
 <20220607182338.344270-4-javierm@redhat.com>
 <de83ae8cb6de7ee7c88aa2121513e91bb0a74608.camel@vmware.com>
 <38473dcd-0666-67b9-28bd-afa2d0ce434a@redhat.com>
 <603e3613b9b8ff7815b63f294510d417b5b12937.camel@vmware.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <603e3613b9b8ff7815b63f294510d417b5b12937.camel@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 6/16/22 23:03, Zack Rusin wrote:
> On Thu, 2022-06-16 at 21:55 +0200, Javier Martinez Canillas wrote:
>> Hello Zack,
>>
>> On 6/16/22 21:29, Zack Rusin wrote:
>>> On Tue, 2022-06-07 at 20:23 +0200, Javier Martinez Canillas wrote:
>>>> The platform devices registered by sysfb match with firmware-based DRM or
>>>> fbdev drivers, that are used to have early graphics using a framebuffer
>>>> provided by the system firmware.
>>>>
>>
>> [snip]
>>
>>>
>>> Hi, Javier.
>>>
>>> This change broke arm64 with vmwgfx. We get a kernel oops at boot (let me know if
>>> you'd like .config or just have us test something directly for you):
>>>
>>
>> Yes please share your .config and I'll try to reproduce on an arm64 machine.
> 
> Attached. It might be a little hard to reproduce unless you have an arm64 machine
> with a dedicated gpu. You'll need a system that actually transitions from a generic
> fb driver (e.g. efifb) to the dedicated one.
>

Yes, all my testing for this was done with a rpi4 so I should be able to reproduce
that case. I'm confused though because I tested efifb -> vc4, simplefb -> vc4 and
simpledrm -> vc4.
 
>>>
>>>  Unable to handle kernel NULL pointer dereference at virtual address
>>> 0000000000000008
>>>  Mem abort info:
>>>    ESR = 0x96000004
>>>    EC = 0x25: DABT (current EL), IL = 32 bits
>>>    SET = 0, FnV = 0
>>>    EA = 0, S1PTW = 0
>>>    FSC = 0x04: level 0 translation fault
>>>  Data abort info:
>>>    ISV = 0, ISS = 0x00000004
>>>    CM = 0, WnR = 0
>>>  user pgtable: 4k pages, 48-bit VAs, pgdp=00000001787ee000
>>>  [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
>>>  Internal error: Oops: 96000004 [#1] SMP
>>>  Modules linked in: vmwgfx(+) e1000e(+) nvme ahci(+) xhci_pci drm_ttm_helper ttm
>>> sha256_arm64 sha1_ce nvme_core xhci_pci_renesas aes_neon_bs aes_neon_blk aes>
>>>  CPU: 3 PID: 215 Comm: systemd-udevd Tainted: G     U            5.18.0-rc5-vmwgfx
>>> #12
>>
>> I'm confused, your kernel version seems to be 5.18.0-rc5 but this patch
>> is only in drm-misc-next now and will land in 5.20...
>>
>> Did you backport it? Can you please try to reproduce with latest drm-tip ?
> 
> No, this is drm-misc-next as of yesterday. drm-misc-next was still on 5.18.0-rc5
> yesterday.
> 

Right! I looked at the base for drm-tip but forgot that drm-misc was still on 5.18.

I'll look at this tomorrow but in the meantime, could you please look if the following
commits on top of drm-misc-next help ?

d258d00fb9c7 fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove
1b5853dfab7f fbdev: efifb: Fix a use-after-free due early fb_info cleanup

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


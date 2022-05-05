Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88A4C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 May 2022 08:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348800AbiEEIcX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 May 2022 04:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348621AbiEEIcW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 May 2022 04:32:22 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9483E340E9
        for <linux-fbdev@vger.kernel.org>; Thu,  5 May 2022 01:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651739322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fYz81dg5bl4ZI+KnAy5BTdapmYRz85hkJ+vnJKUIBv8=;
        b=EdIBSCWdRaAlUacMUGIGczhmY7vuW3lCmVPhLRwhfUsCJXBCA/YiMjGaUxSRle9hb6ZRcy
        wpwglB/bWJzM/YHi8JAO9aV/0dNYxRo3GDYyA+E94x9PFAh1QTKcjQfI/PUXhdJt3RxUQM
        vRr00yzpk0sObReLiPPz91mEGnjS9mY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-iUuBfg7PNt6zHCZGYl8xig-1; Thu, 05 May 2022 04:28:39 -0400
X-MC-Unique: iUuBfg7PNt6zHCZGYl8xig-1
Received: by mail-wr1-f72.google.com with SMTP id p10-20020adfaa0a000000b0020c4829af5fso1188925wrd.16
        for <linux-fbdev@vger.kernel.org>; Thu, 05 May 2022 01:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fYz81dg5bl4ZI+KnAy5BTdapmYRz85hkJ+vnJKUIBv8=;
        b=xN3aLZpMtbAAxS2NWtVds77rajVTkb8I00dn1f0YVEMMZP6wHU0Xnh0I45xQrS1DJT
         Rb64c1lQ76Sy8P+GfIMZhXcHqwaIAiFvaqDT07WYyeQEtJwDoRHi4Tk1puPfxfQvNtAf
         bY7sSQRel+7OJqg68f86Kxoi4fvWjFfDOXIBZ2Kn7/3OF0mNATecjHQZGPUI4zeH/5M1
         46v/a/5VvFQaVwwq81dBxxGGIMbc2iw07s/OCEw0c1CsNFttn1niPJyuHQIBbMlaLg7P
         XVr8uDIVYWdk1nRxpmb25m8/2/eY/8YB/NIskd9Sgjsg8clpuTiBpEQRwGAv1Z4WBrhR
         OFWg==
X-Gm-Message-State: AOAM533wzUaplPIV10AeChHWoZn4C9RJ6OGlBQWRn5Ac2oIAvrqwsnyZ
        YUT5e7EvSb2IHOcqapCaZtK5Nunb5aZFvT+yk4924gO3V/7bP3r2vHiLB/ODdP2pvMFSJ2i4PbU
        i4C7Vb/i0Jd3LFmjQSfAuvGY=
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id p186-20020a1c29c3000000b003509797b38fmr3533236wmp.22.1651739318023;
        Thu, 05 May 2022 01:28:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzh1HtWVDlzxjatPu/Dr4igigwNhESv1m4aEdiiTXztX7nlntl2xMWkAVAnsZwrAbZbONwhTw==
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id p186-20020a1c29c3000000b003509797b38fmr3533215wmp.22.1651739317617;
        Thu, 05 May 2022 01:28:37 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x12-20020a05600c21cc00b003942a244f42sm5800022wmj.27.2022.05.05.01.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 01:28:37 -0700 (PDT)
Message-ID: <237c7fa0-744d-97c2-2bba-3f714d6c2e9d@redhat.com>
Date:   Thu, 5 May 2022 10:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/3] fbdev/simplefb: Cleanup fb_info in .fb_destroy rather
 than .remove
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>
References: <20220504215151.55082-1-javierm@redhat.com>
 <20220504215722.56970-1-javierm@redhat.com>
 <974f4d00-89bc-a2da-6d65-ca4207300794@suse.de>
 <d9a5cb30-2d9b-50b5-d287-0ead0fe252f3@redhat.com>
 <78167587-fd2e-354c-485b-db4ee9251178@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <78167587-fd2e-354c-485b-db4ee9251178@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 5/5/22 10:05, Thomas Zimmermann wrote:

[snip]

>>
>> In other words, in most cases (i.e: only fbcon bound to the fbdev)
>> the driver's removal/ device unbind and the memory release will be
>> at the same time.
>>
> 
> We're one the same page here, but it's still sort of a mystery to me why 
> this works in practice.
> 
> I'm specifically talking about pci_request_regions() in vmwgfx [1]. IIRC 
> this would fail if simplefb still owns the framebuffer region. Lots of 
> systems run Plymouth during boot and this should result in failures 
> occasionally. Still, we never heard about anything.
>

Yes, I think is because Plymouth IIUC waits for a /dev/dri/card? to be
present and only uses a /dev/fb? as a fallback if a timeout expires.

At least in Fedora (even before the efifb -> simpledrm change) it will
use KMS/DRM since the DRM kernel module for the graphics device in the
machine would be in the intird.

So efifb was only used for fbcon and plymouth would only use DRM/KMS
and not its fbdev backend.

This seems to be sort of a corner case when you have {efi,simple}fb
in the early boot but the real DRM module only in the rootfs after the
initrd has done a pivot_root(2).
 
> Of course, it's always been broken (even long before real fbdev 
> hotunplugging). Switching to simpledrm resolves the problem.
>

Indeed. My opinion after dealing with these fbdev problems is that we
shouldn't try to fix all possible corner cases and just try to get rid
of fbdev as soon as possible.
 -- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


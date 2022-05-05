Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2232C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 May 2022 08:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245722AbiEEIfl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 May 2022 04:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349368AbiEEIfk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 May 2022 04:35:40 -0400
X-Greylist: delayed 73 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 01:32:01 PDT
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98CA2488B2
        for <linux-fbdev@vger.kernel.org>; Thu,  5 May 2022 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651739520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rqBSEx+prjdTiMrGpV1aqsQTWQSdTrwVLGOaM2DRpu0=;
        b=B2rVNF/82K29tAxdsJ6AJU940swyqY+PIwDfdbYxpBTtsm+mb9FTiG4uhMza5tyHM5WBPd
        BUCJNRLqyORMDIAvR7k4ops8PXid9T24U+H9oCcDE36H3xauwH/7OETcQzD9PUm6ecq8Ij
        aMwap4UqZozBl2JwcTGIjtEsaL7wFgw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-Totl_EkpPxKtN94MmnBmfA-1; Thu, 05 May 2022 04:30:46 -0400
X-MC-Unique: Totl_EkpPxKtN94MmnBmfA-1
Received: by mail-wm1-f71.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so1488001wmj.0
        for <linux-fbdev@vger.kernel.org>; Thu, 05 May 2022 01:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rqBSEx+prjdTiMrGpV1aqsQTWQSdTrwVLGOaM2DRpu0=;
        b=r2cMt0RW/cRi6dVl7zW8fahz9KISLacrvbjoIGZwoYLj0wMffQnE2B95Yo0gsKBYkI
         XiWQ7yaMQCBQ1kfqVqJnFeWe8MgkWz01lw/OsasPFJwxXclVtu0bl5NvcegGo3aBxO5I
         Pcaif83sei4fuaU56WdFy5eS7eF4v0o1rTIfEVg5FLwzsK0CS6aiajlGkqIv1wC5xBDx
         mAksuWjZKukHhz8WBW5n7sO1MNr6etpigStZ+pO7yNmHXH8ktPVnf2Fhx93p9S0AlzDJ
         qjQDT0Z8H4OSGh0KUEr80nsDC7Tr8MeEZv5UXfvvvUo0vx+NLfrymkegpNmHQxuq/TCG
         r1AA==
X-Gm-Message-State: AOAM531O6B6w92gHRP0aBigLQZNhvh1GGhl9XXXtp4w/0ORK0qk0Fp6A
        juQNwZAaA17A+9gl4ydC6l6gIvvZrWmB2d7C0v0sg/7raumcjwwAyMxLN3XhAuFvhmnXYxedNFJ
        n5jdG5pJJDY+AaKLPYkdHJCw=
X-Received: by 2002:a05:600c:21cc:b0:394:12ff:dd8d with SMTP id x12-20020a05600c21cc00b0039412ffdd8dmr3524891wmj.132.1651739445193;
        Thu, 05 May 2022 01:30:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFHaBQnPBJ08w4wMFqpq4uA/qAMN794Kl5iBycIsNges0PhcSzS7HhVQE1ACXB2xwj0udL/A==
X-Received: by 2002:a05:600c:21cc:b0:394:12ff:dd8d with SMTP id x12-20020a05600c21cc00b0039412ffdd8dmr3524869wmj.132.1651739444856;
        Thu, 05 May 2022 01:30:44 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l18-20020a1ced12000000b003942a244edcsm846083wmh.33.2022.05.05.01.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 01:30:44 -0700 (PDT)
Message-ID: <14afd90b-0bf3-aa01-3b97-db7e29fb858a@redhat.com>
Date:   Thu, 5 May 2022 10:30:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/3] fbdev: Fix use-after-free caused by wrong fb_info
 cleanup in drivers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>
References: <20220504215151.55082-1-javierm@redhat.com>
 <e0bc775a-f17a-adf1-9b2c-4be91468b7f8@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <e0bc775a-f17a-adf1-9b2c-4be91468b7f8@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 5/5/22 10:16, Thomas Zimmermann wrote:

[snip]

>> Patch #1 adds a WARN_ON() to framebuffer_release() to prevent the use-after-free
>> to happen.
>>
>> Patch #2 and patch #3 fixes the simplefb and efifb drivers respectively, to
>> free the resources at the correct place.
> 
>  From a quick look, vesafb seems to be affected as well.
>

Right, I wrongly assumed that we only cared about efifb and simplefb but forgot
that vesafb is used when setting a VESA mode with vga=foo. I'll add it in a v2.
 
> Best regards
> Thomas
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


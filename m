Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40FFC04A68
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jul 2022 19:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiGZTWO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jul 2022 15:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbiGZTWN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jul 2022 15:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 211E933E39
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Jul 2022 12:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658863331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HM/992FpowUrZBdOewYXTdFa78rfvZ1wIMJtEZDEzFo=;
        b=hCYqj18TRTj7zVlnuSFb6jjNcxUgHXb0ye4/w2uRCIciYIn9QQp7i7vLNQXIkmEaysvSdc
        6vxvR7yT7zCqcUkQusWjwlgpmA1w37NzEnMYHUh4BlFBEfwCXsN46PbrPflCVZGa0GPQ5F
        gPkMHM+Mm6v95JGPlSbPreb0H8vMmcY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-K2TGsJlpNp694cFET-gRng-1; Tue, 26 Jul 2022 15:22:08 -0400
X-MC-Unique: K2TGsJlpNp694cFET-gRng-1
Received: by mail-wm1-f71.google.com with SMTP id a18-20020a05600c225200b003a30355c0feso5664901wmm.6
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Jul 2022 12:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HM/992FpowUrZBdOewYXTdFa78rfvZ1wIMJtEZDEzFo=;
        b=GFL7bwUbiDCAkZpj3IS79n1AjWgJIDPO4Aqu66kVlUlVESZyivfLpKuURGinNwvroO
         H3tVJgeTjJQk4g4BFmFzIX0AVEIfpWrezjeWo1qIhnnHjfjg4CzLcWx0TjrTB+uULsAe
         kziww7mZmnfieDksPFGYZQlJUN3YjfIINk0lDi4LvNvakr+Yt6e1unySG1sVNON6djE7
         T9Uoclj14LoCSPXPC3IHKGfH5t5L47f9KDsp6X4mx6RIIsRSdq1Pyk09PEQ6F5cxkt4K
         blFRxCfi+ye0+ybDPRMQwR0Sk5WBffcmVNBhDwSroJCahyu2yZN7pJ86n5lWvS/eFI2r
         jSPQ==
X-Gm-Message-State: AJIora8513RtaCB/lvuZcahu8KyoFCHkCO6n9MnO4R1FTxKJq4hpkeQ8
        W6QImNkQATZZOeJIQvELFMOinM9PzaAr37rXdNLxIcODzD5hapqdOsjGzfuH/fgkGU66Dbu1Y5Q
        kE9YVsn3qGlr5W6M63VJGFGk=
X-Received: by 2002:a5d:64e5:0:b0:21d:945a:e7c4 with SMTP id g5-20020a5d64e5000000b0021d945ae7c4mr12161304wri.0.1658863327267;
        Tue, 26 Jul 2022 12:22:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vGZKU+Yu4t/pJR7G/x3ABdDb+Jc5JIBwBhoD8uXuQNqfQGzOOG9RFUs5hjLn5ORhAmUgcRxw==
X-Received: by 2002:a5d:64e5:0:b0:21d:945a:e7c4 with SMTP id g5-20020a5d64e5000000b0021d945ae7c4mr12161300wri.0.1658863326979;
        Tue, 26 Jul 2022 12:22:06 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z21-20020a05600c0a1500b0039c454067ddsm19704276wmp.15.2022.07.26.12.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 12:22:06 -0700 (PDT)
Message-ID: <90aef621-b686-12dd-de55-9a680f5783d7@redhat.com>
Date:   Tue, 26 Jul 2022 21:22:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 09/10] drm/ofdrm: Add per-model device function
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        mpe@ellerman.id.au, deller@gmx.de, mark.cave-ayland@ilande.co.uk,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
        paulus@samba.org, maxime@cerno.tech, geert@linux-m68k.org,
        sam@ravnborg.org
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <20220720142732.32041-10-tzimmermann@suse.de>
 <7b1a2807-59c7-d524-af8e-1ec634c740a7@redhat.com>
 <20220726144024.GP17705@kitsune.suse.cz>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220726144024.GP17705@kitsune.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Michal,

On 7/26/22 16:40, Michal Suchánek wrote:
> Hello,
> 
> On Tue, Jul 26, 2022 at 03:38:37PM +0200, Javier Martinez Canillas wrote:
>> On 7/20/22 16:27, Thomas Zimmermann wrote:
>>> Add a per-model device-function structure in preparation of adding
>>> color-management support. Detection of the individual models has been
>>> taken from fbdev's offb.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> ---
>>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>>
>> [...]
>>
>>> +static bool is_avivo(__be32 vendor, __be32 device)
>>> +{
>>> +	/* This will match most R5xx */
>>> +	return (vendor == 0x1002) &&
>>> +	       ((device >= 0x7100 && device < 0x7800) || (device >= 0x9400));
>>> +}
>>
>> Maybe add some constant macros to not have these magic numbers ?
> 
> This is based on the existing fbdev implementation's magic numbers:
> 
> drivers/video/fbdev/offb.c:                 ((*did >= 0x7100 && *did < 0x7800) ||
>

Ah, I see. Then we might have to go with the magic numbers...
 
> Of course, it would be great if somebody knowledgeable could clarify
> those.
>

Indeed.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AE3C19F29
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jul 2022 09:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiG0JpK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jul 2022 05:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiG0JpK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jul 2022 05:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17D82110C
        for <linux-fbdev@vger.kernel.org>; Wed, 27 Jul 2022 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658915108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d7wwuGLjAZB3K+Voj80d4Ozo5qLQ+l1QsRMGTb08BDM=;
        b=QPtBKN+J3b3qXIth+rxCs7rMxzKCaNFGhEXapV7qc8ffPr+WOmk6dAgGRmzvRb2Y6GWm93
        t3Iw7f5GxfRRLcWdZLMpT2yXTVVJLZkDbkipVmrUgqFAGXTsuxNJ7f4PIyhsVlsDWl+FaW
        IZRvEwkIlk15DNwwBdnw//kWWF/f4Mw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-hH1N5BVTMQu2sEedvVFZdQ-1; Wed, 27 Jul 2022 05:45:06 -0400
X-MC-Unique: hH1N5BVTMQu2sEedvVFZdQ-1
Received: by mail-wr1-f70.google.com with SMTP id h9-20020adfa4c9000000b0021ee4a48ea7so5885wrb.10
        for <linux-fbdev@vger.kernel.org>; Wed, 27 Jul 2022 02:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d7wwuGLjAZB3K+Voj80d4Ozo5qLQ+l1QsRMGTb08BDM=;
        b=HucTK057FI2s1vbgxRulHteZAmmPn2hl18Y3zT+WIkM9J0lTJWt7bK/YYpG5Gj/rwX
         wNJ5l5tLtJh5vCSEzWJkIuaLAKgixP4b73ughmkPMHuNvnfqdjuPtROUwyycK5W9Nkvf
         3hU9xQLdRUajL4pbUBrMrpu32+Pkw3CHwlMj+JC3NbyAsA7mFloZfZm8L5gevj3Cfmxs
         4mxWH4JoJ0mQ19R1jPcOpzjvXJlgz5L4xagVuWSN+12Z3PRzp0EOk5FXu8TxBSg507mJ
         ricBD2kuqwBv0EZtuy/llT5ZdLQpK3bFkp9WTDArJxOuamRZIfc4fqDeqNL+yTsWs5O3
         iEZA==
X-Gm-Message-State: AJIora8EnU5IhBxfe7zAqtYgtRTZ7PmPrhnSNmcf/lFNuxV8rKCsbxU0
        Viy0gCPaNP9j7Gtr2+dEma7uPmj+cDw59zFFWZs7uzkqltwgB3vEXNRmOdWdolokUn4mofkrNKg
        VDfWRnuSbPrmwaJs/+LGGuMM=
X-Received: by 2002:a05:600c:3caa:b0:3a0:18e4:781b with SMTP id bg42-20020a05600c3caa00b003a018e4781bmr2469516wmb.199.1658915105273;
        Wed, 27 Jul 2022 02:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tY1NapkC+jkHigs52/MIzuEN8IcNKNYICxfk8KUt9jGlsGLWmG7Fj2fsNnrteJALcuFgDk/A==
X-Received: by 2002:a05:600c:3caa:b0:3a0:18e4:781b with SMTP id bg42-20020a05600c3caa00b003a018e4781bmr2469489wmb.199.1658915105054;
        Wed, 27 Jul 2022 02:45:05 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b003a326ba4e99sm1915497wmq.34.2022.07.27.02.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 02:45:03 -0700 (PDT)
Message-ID: <6b7bdf72-5ed3-f075-ecb8-639e569c5cb9@redhat.com>
Date:   Wed, 27 Jul 2022 11:45:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 10/10] drm/ofdrm: Support color management
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, msuchanek@suse.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <20220720142732.32041-11-tzimmermann@suse.de>
 <abe3fa95-942b-6d2f-7167-83d0cea59444@redhat.com>
 <05511c35-da46-aefd-3e03-364b7311284c@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <05511c35-da46-aefd-3e03-364b7311284c@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/27/22 10:41, Thomas Zimmermann wrote:

[...]

>>
>>> +static void __iomem *ofdrm_mach64_cmap_ioremap(struct ofdrm_device *odev,
>>> +					       struct device_node *of_node,
>>> +					       u64 fb_base)
>>> +{
>>> +	struct drm_device *dev = &odev->dev;
>>> +	u64 address;
>>> +	void __iomem *cmap_base;
>>> +
>>> +	address = fb_base & 0xff000000ul;
>>> +	address += 0x7ff000;
>>> +
>>
>> It would be good to know where these addresses are coming from. Maybe some
>> constant macros or a comment ? Same for the other places where addresses
>> and offsets are used.
> 
> I have no idea where these values come from. I took them from offb. And 
> I suspect that some of these CMAP helpers could be further merged if 
> only it was clear where the numbers come from.  But as i don't have the 
> equipment for testing, I took most of this literally as-is from offb.
>

I see. As Michal mentioned maybe someone more familiar with this platform
could shed some light about these but in any case that could be done later.

[...]

>>> +
>>> +	new_crtc_state = drm_atomic_get_new_crtc_state(new_state, new_plane_state->crtc);
>>> +
>>> +	new_ofdrm_crtc_state = to_ofdrm_crtc_state(new_crtc_state);
>>> +	new_ofdrm_crtc_state->format = new_fb->format;
>>> +
>>
>> Ah, I understand now why you didn't factor out the .atomic_check callbacks
>> for the two drivers in a fwfb helper. Maybe you can also add a comment to
>> mention that this updates the format so the CRTC palette can be applied in
>> the .atomic_flush callback ?
> 
> Yeah, this code is one reason for not sharing atomic_check in fwfb.  The 
> other reason is that the fwfb code is only a wrapper around the atomic 
> helpers with little extra value.  I did have such fwfb helpers a some 
> point, but removed them.
>

Got it.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


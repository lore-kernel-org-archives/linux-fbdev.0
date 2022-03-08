Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ED8C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Mar 2022 14:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiCHOEK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbiCHOEJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Mar 2022 09:04:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7139C37BE6
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Mar 2022 06:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646748190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Dzu4ZGhznD+vnjXkLEQx87HJellkHDrk7AUKJZCM5U=;
        b=eSKgwLVRiVps8qF/SJKTsfKfG0iqYDjDe+wt1nTqFvWuEo46x0G+UnxZKBDO0pK1YBjhTh
        UO1CZFv6YVBCfzWv2YeTvNdtPRkq3jZl4QBBYY6zM77GFXPti5vL51czhtEMQo7l2DiMlZ
        ll34TGn3giUVCgZuaK4m44UiLZ1SkVU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-_vDomNwiMfqHGAyzZmk1Ng-1; Tue, 08 Mar 2022 09:03:09 -0500
X-MC-Unique: _vDomNwiMfqHGAyzZmk1Ng-1
Received: by mail-wm1-f69.google.com with SMTP id x5-20020a1c7c05000000b00389bcc8df46so1157561wmc.0
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Mar 2022 06:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3Dzu4ZGhznD+vnjXkLEQx87HJellkHDrk7AUKJZCM5U=;
        b=2Q3vDwOtqXSqsfwpSqxKLdouvV1h3/AKBkgAILb/cddAm9lbVOpDRugioJruKeNAW+
         WNI5QA9CQwAl52YJfqkpDYgw8+OP39YUGtQqNteRcd7Hs2VztOXZgCRo3lLAeKb0NAjG
         YHGF01E4jJ1gVRAvUSq2kQ5ZBcDY9/GfXVz3drJLlidIhuZoL+yOcgxpI8DhltgagPFx
         Kajsporz5A6lmSGLL2n7IZBc4g39PwNZ0EbW0sKmyyjRnic7aZ3lDSH8z5gophPVYWBB
         JLbR77nNWRNyA1KzMxF6wxpyJCIqaVBKnxzYd7FQ1wuOM0zwdQ0UT9RTqc/1I6RR5LCw
         4fmg==
X-Gm-Message-State: AOAM532VD+v/Er6acFkH3esc/3PsGbagD1UyqRV4K8JtON953soDL23q
        cpbprKRYwDiP6ByLWoilKpFYfEpq7xbupceZQORgbd2/VP3mpk3MbTIhmNt4fyV4dKvMTJ/3JG1
        pP11p7f+oPpMRkMEKRbkdn2M=
X-Received: by 2002:adf:f3c8:0:b0:1ed:9cd9:5bf with SMTP id g8-20020adff3c8000000b001ed9cd905bfmr12659037wrp.380.1646748187864;
        Tue, 08 Mar 2022 06:03:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxogP0qcX9WvYmcZuOA2yQ1VCsQNTVMYLXKzqTJIVl+GOcCr21I1GVI53FfWHW0LpykdInMXA==
X-Received: by 2002:adf:f3c8:0:b0:1ed:9cd9:5bf with SMTP id g8-20020adff3c8000000b001ed9cd905bfmr12658993wrp.380.1646748187327;
        Tue, 08 Mar 2022 06:03:07 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b001edb61b2687sm22575314wrt.63.2022.03.08.06.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:03:06 -0800 (PST)
Message-ID: <20e481be-3f2f-aad2-1b9d-9218320263b0@redhat.com>
Date:   Tue, 8 Mar 2022 15:03:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/9] fbdev: Put mmap for deferred I/O into drivers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220303205839.28484-1-tzimmermann@suse.de>
 <20220303205839.28484-3-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220303205839.28484-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/3/22 21:58, Thomas Zimmermann wrote:
> The fbdev mmap function fb_mmap() unconditionally overrides the
> driver's implementation if deferred I/O has been activated. This
> makes it hard to implement mmap with anything but a vmalloc()'ed
> software buffer. That is specifically a problem for DRM, where
> video memory is maintained by a memory manager.
> 
> Leave the mmap handling to drivers and expect them to call the
> helper for deferred I/O by thmeselves.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[snip]

>  
> +	/*
> +	 * FB deferred I/O want you to handle mmap in your drivers. At a
> +	 * minimum, point struct fb_ops.fb_mmap to fb_deferred_io_mmap().
> +	 */
> +	if (WARN_ON_ONCE(info->fbdefio))
> +		return -ENODEV;
> +

Maybe part of that comment could be printed as a WARN_ON_ONCE() message ?

Regardless, the patch looks good to me:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


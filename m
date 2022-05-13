Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC9CC433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 13 May 2022 12:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380197AbiEMM2b (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 13 May 2022 08:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiEMM23 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 13 May 2022 08:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B5A6E7A
        for <linux-fbdev@vger.kernel.org>; Fri, 13 May 2022 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652444907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAK0Gk2w3i58gSPmmVvLPauf3+gDSOWurZVw4Vf2rDQ=;
        b=R7/5lG15vZs5wuZ7uyacVY3tVz+xl58Ix873Ps6Tx3GPAQ/UPW/n8POPgWdpCM98LFSFi6
        pm9EbBfineHdwYJJlDMgY75uJ0TtV2UzRP1pORJntnNpIGd3+x3UdULq2CxyB8ixnGd2K3
        eyc3HWvpQodeURxarlkzIPu7YwpTO6k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-L92udiK3OgSiy9c3NVW6Cw-1; Fri, 13 May 2022 08:28:26 -0400
X-MC-Unique: L92udiK3OgSiy9c3NVW6Cw-1
Received: by mail-wr1-f69.google.com with SMTP id bj22-20020a0560001e1600b0020cccc6b25aso2902524wrb.1
        for <linux-fbdev@vger.kernel.org>; Fri, 13 May 2022 05:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NAK0Gk2w3i58gSPmmVvLPauf3+gDSOWurZVw4Vf2rDQ=;
        b=HTLKw9BlijXoUE+VMkZdUz5D8K7luF+Et5m5P9sfZfhJqxR2nCXkIXTNm9OiBqBHxw
         GF1a5jummN0uRveRPal2EQPMKmQpp6En8BgU/qRKuJUK1yLixxLsrh0JjI0EDIFwY7DM
         ZZ24MpLNELv/cdziYLq1vmuQxzhtjiQWmNTOpFZsmmpOAZu/OgHdqfqza2ACGKXurAW6
         fDCV4Ddc6eMXjZfOVNS8uwGYsJ1a/BFMxq/j+K+zSoQnAaFi5fmn4alMswCfJnhGsBwC
         rbJO88fjBTVPyqDrhR8W+FFU2oWEx6AJtLZG0blOEafV/MvrU1wNBmEAt0cEBEUq1AZr
         hlsA==
X-Gm-Message-State: AOAM533ld/5/PUIsrQdDnzY+tK9edQ+SkHvONaIY6UY9JZKzsOVF9g+/
        Vc2HXjDPp7ImSg1B4lRL6ALNPRdHCLlmzztbZLdKfWQyKOVrfCxvpDIupU30eR8TbsUL7X6dgG/
        +/i48o9Tq+RoUUstveoLGnSg=
X-Received: by 2002:a05:6000:156b:b0:20c:6ffb:9588 with SMTP id 11-20020a056000156b00b0020c6ffb9588mr3865396wrz.49.1652444904968;
        Fri, 13 May 2022 05:28:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwLT41J/yG1HkvUQOhV5KnK8fNGtzGb6CsJVszlDX5dbsHh8Cxbhd7a4okhWnFPei5mAdPOg==
X-Received: by 2002:a05:6000:156b:b0:20c:6ffb:9588 with SMTP id 11-20020a056000156b00b0020c6ffb9588mr3865368wrz.49.1652444904693;
        Fri, 13 May 2022 05:28:24 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bd19-20020a05600c1f1300b00395f15d993fsm1637910wmb.5.2022.05.13.05.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 05:28:24 -0700 (PDT)
Message-ID: <41e91473-bd0b-c0e4-85db-d92dd38d28bd@redhat.com>
Date:   Fri, 13 May 2022 14:28:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 3/7] fbdev: Restart conflicting fb removal loop when
 unregistering devices
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220511112438.1251024-1-javierm@redhat.com>
 <20220511113039.1252432-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220511113039.1252432-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 5/11/22 13:30, Javier Martinez Canillas wrote:
> Drivers that want to remove registered conflicting framebuffers prior to
> register their own framebuffer, calls remove_conflicting_framebuffers().
> 
> This function takes the registration_lock mutex, to prevent a races when
> drivers register framebuffer devices. But if a conflicting framebuffer
> device is found, the underlaying platform device is unregistered and this
> will lead to the platform driver .remove callback to be called, which in
> turn will call to the unregister_framebuffer() that takes the same lock.
> 
> To prevent this, a struct fb_info.forced_out field was used as indication
> to unregister_framebuffer() whether the mutex has to be grabbed or not.
> 
> A cleaner solution is to drop the lock before platform_device_unregister()
> so unregister_framebuffer() can take it when called from the fbdev driver,
> and just grab the lock again after the device has been registered and do
> a removal loop restart.
> 
> Since the framebuffer devices will already be removed, the loop would just
> finish when no more conflicting framebuffers are found.
> 
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
Pushed this to drm-misc (drm-misc-next). Thanks all!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


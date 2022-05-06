Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0958BC433EF
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 May 2022 07:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389568AbiEFHgO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 6 May 2022 03:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389582AbiEFHgN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 6 May 2022 03:36:13 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 471D25D674
        for <linux-fbdev@vger.kernel.org>; Fri,  6 May 2022 00:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651822349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Esh+VtFiG4BswDTMwa1WxXaR2Q4vfRjhnN3ZC2gg1v4=;
        b=YlOwHYaGgReuULOXTpbgRy8AAAwEbbKGv8n5IGZ6DcwjO88GUsPTv9VkB4fEOdJg5iAG0s
        QtRXSLWvo7pGCeZMOl6VdR4EfeYAxUXWi2leK9lV6ZIa0PSO2rpeWWCw4lLkSTOdX/Vnr0
        IXj4CBsFN6zhumttKCEnU32LmAlr9eU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-7v6KJqeCO_Kdtc-Na2T1hQ-1; Fri, 06 May 2022 03:32:27 -0400
X-MC-Unique: 7v6KJqeCO_Kdtc-Na2T1hQ-1
Received: by mail-wm1-f71.google.com with SMTP id 205-20020a1c02d6000000b003928cd3853aso2790667wmc.9
        for <linux-fbdev@vger.kernel.org>; Fri, 06 May 2022 00:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Esh+VtFiG4BswDTMwa1WxXaR2Q4vfRjhnN3ZC2gg1v4=;
        b=rpNKB0P90Tw55pMXTz7DkztFXCDpDRLmLCM5tjoLOENyoUdKI0yAC3IGTfjfo2G6vW
         dEEWwkcnlCgzNFkwjdejW8VGZTv0afPnp7O9aJiXLpY4J9iVSyn/nSoc4/MRS37LFAth
         VKFHCa5UM6CNnjp4a0272aCGPWPCtU3Ody4dDuOH95d8o+1CryCOqC4Uf8dOPjo9GN8K
         w9+UClc1TLtaY2PGQr4WxdtMsFB0ZMy8HzYnaNeqRmLE6qJg5b3cAuylvGx9LzEbpVY5
         YTzxTdpA/WFU0bToxwzkNV3VnGOsUupq0U3bPH/Q4Wuy/7GZ7BtVnsWwokqUx9/9vGIl
         ZsfQ==
X-Gm-Message-State: AOAM532jWlPkiNoH0/PnFnNJHKW2CoWidKdqt6ps+PnuUTOFnxNoALSq
        L54lgEgrJvCNqDAOhXgyLX+jJr15r00lNHteN5u2Z/1hf9DZMtyX7ftLR1VdE+bMadP33ZnDAl/
        UXHNibJh7mWXa7Ip8jBn3xF8=
X-Received: by 2002:a05:600c:4e86:b0:394:1cac:4146 with SMTP id f6-20020a05600c4e8600b003941cac4146mr8436303wmq.130.1651822346497;
        Fri, 06 May 2022 00:32:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3wzAqzDwdh+znVgqwfq+00rTuhWA2qWcgd56hBPkF6MqkT23hcfOtTlTn8ls2dSsXhVzhqg==
X-Received: by 2002:a05:600c:4e86:b0:394:1cac:4146 with SMTP id f6-20020a05600c4e8600b003941cac4146mr8436273wmq.130.1651822346271;
        Fri, 06 May 2022 00:32:26 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r10-20020a5d4e4a000000b0020c5253d921sm2803889wrt.109.2022.05.06.00.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 00:32:25 -0700 (PDT)
Message-ID: <642f515e-aa71-7c90-a715-e49dcf12baee@redhat.com>
Date:   Fri, 6 May 2022 09:32:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] Revert "fbdev: Make fb_release() return -ENODEV if
 fbdev was unregistered"
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220504115917.758787-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220504115917.758787-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 5/4/22 13:59, Javier Martinez Canillas wrote:
> This reverts commit aafa025c76dcc7d1a8c8f0bdefcbe4eb480b2f6a. That commit
> attempted to fix a NULL pointer dereference, caused by the struct fb_info
> associated with a framebuffer device to not longer be valid when the file
> descriptor was closed.
> 
> The issue was exposed by commit 27599aacbaef ("fbdev: Hot-unplug firmware
> fb devices on forced removal"), which added a new path that goes through
> the struct device removal instead of directly unregistering the fb.
> 
> Most fbdev drivers have issues with the fb_info lifetime, because call to
> framebuffer_release() from their driver's .remove callback, rather than
> doing from fbops.fb_destroy callback. This meant that due to this switch,
> the fb_info was now destroyed too early, while references still existed,
> while before it was simply leaked.
> 
> The patch we're reverting here reinstated that leak, hence "fixed" the
> regression. But the proper solution is to fix the drivers to not release
> the fb_info too soon.
> 
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
> 

Pushed this to drm-misc (drm-misc-fixes).

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EE4C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 10 May 2022 09:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbiEJJKV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 10 May 2022 05:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbiEJJKU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 10 May 2022 05:10:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25B1B1DFDA9
        for <linux-fbdev@vger.kernel.org>; Tue, 10 May 2022 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652173583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkLXI1wXFekph/z4VKeGBxzhcAjKRPjiQoN66BncwP8=;
        b=i9B9Pt3fkWA5lZ024hkhUVyS2eWPWmJ8gNRwODBhcvNk6tJ8jMwVGTYSCEKAph6+g34v5D
        u+vVPb0QN3kTWeMdZ5IhndW1okxjSBBvRrFsiELOsxhyFVdZvqnf5ilgDLtLB+pytZsgp+
        MqqRqhxnxikoZwWBNOFB8EUWQOnfY4E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-9MqrpdXIM_iDgynLr_wfOA-1; Tue, 10 May 2022 05:06:20 -0400
X-MC-Unique: 9MqrpdXIM_iDgynLr_wfOA-1
Received: by mail-wm1-f70.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso5020083wma.8
        for <linux-fbdev@vger.kernel.org>; Tue, 10 May 2022 02:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YkLXI1wXFekph/z4VKeGBxzhcAjKRPjiQoN66BncwP8=;
        b=XuWiw1X6NYkNISkP/79k04FmiCyBw7wGMgcA9BbIaJqp7k6DocpAswsVGZmcnOAyZI
         EI3cAx/reZQQ1ux+vYPNNZTSsPZ2+yCz44cuDQ1C5IwgOU2cdmpv9yDMQkY1tYj1+X5I
         qKdbo6H/x5n3cS1emdztLvmdf7rkznYcGeztp9VbkDEfj1uHvF3vANLGYi9B9f5OkL7v
         uRD9B067ZVVtgUinP87Ay5GYHF84oA89j6REShon2kV6AAj6LrA6n6HLJYVcTjd1D1VJ
         OsXd4apdcLwa/L5NXFyc04+zNOLWGXl4y3nPCgRC5wIQ9t42PBU7Wg0z66V+g7QwBLHl
         vY4A==
X-Gm-Message-State: AOAM5328t9PCBSjUl2aH8vOsHCz0fiGXjuH1SIxsSiyj9EwzrQimu2gy
        CaFnwkhaeimKkkh2zkMBW2DsYvInSwZNuLij6M6CUCouJHfLyUgmTunSFqYIF4df62kfcWGQNAn
        apExh/xYR/phkPHWwkvXHByA=
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id p186-20020a1c29c3000000b003509797b38fmr27220452wmp.22.1652173578862;
        Tue, 10 May 2022 02:06:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+io9oYE+kEwQcWEN1hSZmc2C7/AOzrie5EH4r5n8J8XZWOWG3RH6soTrmiHV4LmVSFrAdKg==
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id p186-20020a1c29c3000000b003509797b38fmr27220430wmp.22.1652173578640;
        Tue, 10 May 2022 02:06:18 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q8-20020a1cf308000000b00394975e14f4sm1894098wmq.8.2022.05.10.02.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 02:06:18 -0700 (PDT)
Message-ID: <35ffd96d-3cbe-12dd-c1ea-878299ec173c@redhat.com>
Date:   Tue, 10 May 2022 11:06:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/4] fbdev: Prevent possible use-after-free in
 fb_release()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20220505215947.364694-1-javierm@redhat.com>
 <20220505220413.365977-1-javierm@redhat.com>
 <753d0350-42dc-389b-b10b-4533ddcf32ac@intel.com>
 <1f788b8f-0bea-1818-349e-b1bc907bf251@redhat.com>
 <a339df59-9e00-c7cb-e33d-2ac626443639@intel.com>
 <3b7fe4fe-fdec-cef2-4e0e-309d9dc4a8af@redhat.com>
 <b5ab1c49-04e7-36c3-677d-2989b79e50ca@suse.de>
 <2bf27b09-0896-1849-254f-d5b19abdc892@redhat.com>
 <fc3e8a40-664f-07ae-7474-c0412a1ab1b5@intel.com>
 <1c36d431-d5c0-7278-c9e0-61867e9dc174@redhat.com>
 <79aaea41-5dab-f896-ab3d-d6bc9a5de615@suse.de>
 <2d8d8583-3a39-b826-dd83-ba5bc4c5b082@redhat.com>
 <7ffd92d7-9c07-fa9c-dc95-9e82719fd237@suse.de>
 <71ebd5f7-64d0-510a-6f1b-29921fca19fa@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <71ebd5f7-64d0-510a-6f1b-29921fca19fa@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 5/10/22 10:50, Thomas Zimmermann wrote:

[snip]

>>> Drivers shouldn't really explicitly call this helper in my opinion.
> 
> One more stupid question: does armada actually use 
> drm_fbdev_fb_destroy()? It's supposed to be a callback for struct 
> fb_ops. Armada uses it's own instance of fb_ops, which apparently 
> doesn't contain fb_destroy. [1]
>

No stupid question at all. You are correct on this. So I guess we still
need this call in the drivers that don't provide a .fb_destroy() handler.

I see many options here:

1) Document in drm_fb_helper_alloc_fbi() that drivers only need to call
   drm_fb_helper_fini() explicitly if they are not setting up a fbdev
   with drm_fbdev_generic_setup(), otherwise is not needed.

2) Make drm_fbdev_fb_destroy() an exported symbol so drivers that have
   custom fb_ops can use it.

3) Set .fb_destroy to drm_fbdev_fb_destroy() if isn't set by drivers when
   they call drm_fb_helper_initial_config() or drm_fb_helper_fill_info().

I'm leaning towards option (3). Then the fb_info release will be automatic
whether drivers are using the generic setup or a custom one.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


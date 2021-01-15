Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A267C433E0
	for <linux-fbdev@archiver.kernel.org>; Fri, 15 Jan 2021 14:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2370623884
	for <linux-fbdev@archiver.kernel.org>; Fri, 15 Jan 2021 14:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbhAOOHp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 15 Jan 2021 09:07:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732527AbhAOOHp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 15 Jan 2021 09:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610719578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yw+QcYUMu4KJ1/7zwWdqw3dTnkoFgsP+zeQ61z9wk6c=;
        b=SswQ9Ol+7/8KYmDrvEgHAQV0Y2cKn21sek48hY20oRpMOPLZ6SArtDTExKgthW6PFONK1w
        VBEpnsSC9abvyeUx6t0ryHCLRb43GUfXtNX3ZjVH+8T5X9dgfEZzyRexKYS35Oxmr4XhAf
        sTao9AMmgP2eMDJxZk3rtHvQhiFXsVI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-F8Sp1jn8OXezDBsJMyS4ZA-1; Fri, 15 Jan 2021 09:06:17 -0500
X-MC-Unique: F8Sp1jn8OXezDBsJMyS4ZA-1
Received: by mail-ed1-f70.google.com with SMTP id ck25so32930edb.16
        for <linux-fbdev@vger.kernel.org>; Fri, 15 Jan 2021 06:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yw+QcYUMu4KJ1/7zwWdqw3dTnkoFgsP+zeQ61z9wk6c=;
        b=C+jt4SGfbPT1MCcrDDP4Hxks8R/mJCmjmf0lI06ZyQ8xPYDurFwCmPwkbWnZ9k3d4k
         qse0qH3F3fQCFLqH2V4L/x0qdD3eb3OpnwpuDFsCgGQ2PJdV+6l+hLco8YhkecMeTNCk
         H6wLJUpXMAf8SO8TRf9wjelTisCPydGNS5PkbWD7YMD6e8FV54P1sy9sVu8tWx13LTRM
         ORkEEj++aYa2vXGna5+c7UBz+a3+GMAqQ7jTz+dMmN+WVBtqVSxvHcdQRLtDRoWvzypb
         vfe/BpRSEgRJ8saRj9rwAP1FCIruz0p053VvOYYbm+KLOuWvpI7xm+/nrl6tZsRTe2Fp
         wCpw==
X-Gm-Message-State: AOAM533NM2ncsvrla2jZbpseUwR7D6n5DP3JUD/59lQC5WlRm7N4eafb
        EXM6HKBTzRlJhFJCEYfD6NCqvXqVgY27Rc7HaiMDNOkOcZVA1yYJUy0liSqkufLoOOkNBkYlVlP
        0zcnmkGrDY6KUkgyJXPde8oCyZidzO9AtGww6C0ryJEx8ZLS1Ck1NpW2X6vLIros2hIiMSQyA5B
        E=
X-Received: by 2002:aa7:d7d8:: with SMTP id e24mr9462716eds.135.1610719575703;
        Fri, 15 Jan 2021 06:06:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz32dru5stz5DIotYEvOGg6GRi08jTzmU8VjdNUUgRfAXNJduvGPE+lvbHLWh0QUEN2Xd/58Q==
X-Received: by 2002:aa7:d7d8:: with SMTP id e24mr9462701eds.135.1610719575527;
        Fri, 15 Jan 2021 06:06:15 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id u2sm631163edp.12.2021.01.15.06.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 06:06:14 -0800 (PST)
Subject: Re: [PATCH] fbdev/simplefb: Add the N64's mode
To:     Lauri Kasanen <cand@gmx.com>, linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, linux-fbdev@vger.kernel.org
References: <20210115160102.cf4c85db9f815758716f086f@gmx.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <aeb93d4a-d7c0-5e0d-4de4-4a70f85cb202@redhat.com>
Date:   Fri, 15 Jan 2021 15:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210115160102.cf4c85db9f815758716f086f@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On 1/15/21 3:01 PM, Lauri Kasanen wrote:
> Signed-off-by: Lauri Kasanen <cand@gmx.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

What is the plan for merging this patch? I've another simplefb patch which
I need/plan to push to drm-misc-nexy soon, shall I also push this one then?

Or is there some plan to merge the entire series this used to be part of
in one go?

Regards,

Hans

> ---
>  include/linux/platform_data/simplefb.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/platform_data/simplefb.h b/include/linux/platform_data/simplefb.h
> index ca83376..27ea99a 100644
> --- a/include/linux/platform_data/simplefb.h
> +++ b/include/linux/platform_data/simplefb.h
> @@ -16,6 +16,7 @@
>  #define SIMPLEFB_FORMATS \
>  { \
>  	{ "r5g6b5", 16, {11, 5}, {5, 6}, {0, 5}, {0, 0}, DRM_FORMAT_RGB565 }, \
> +	{ "r5g5b5a1", 16, {11, 5}, {6, 5}, {1, 5}, {0, 1}, DRM_FORMAT_RGBA5551 }, \
>  	{ "x1r5g5b5", 16, {10, 5}, {5, 5}, {0, 5}, {0, 0}, DRM_FORMAT_XRGB1555 }, \
>  	{ "a1r5g5b5", 16, {10, 5}, {5, 5}, {0, 5}, {15, 1}, DRM_FORMAT_ARGB1555 }, \
>  	{ "r8g8b8", 24, {16, 8}, {8, 8}, {0, 8}, {0, 0}, DRM_FORMAT_RGB888 }, \
> --
> 2.6.2
> 


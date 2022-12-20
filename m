Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322C5C4167B
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiLTJi0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiLTJiZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699ADB5F
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4bHxLfE6qRmbmJ9vfsWvWUlnwpkYhHXJKMmhBNnZCVw=;
        b=gqLwjS+0HFrY6dwz4cyw57xPjgD+5ztn3YeeOHMopE7Jp9cQ35lr1XSjNOsQQok4vhZa/z
        tw9FfdugHbB0JCfbh8J/EvzH1AKg2uJPauiiQYtMeYhIc++YdIw5vTGP9SSz1NlheEfj8m
        guESQCRgiYsG9jJYWnHHWCF9aX9LQvw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-277-wfiBwazyNSSbPXfdOt7v0A-1; Tue, 20 Dec 2022 04:37:36 -0500
X-MC-Unique: wfiBwazyNSSbPXfdOt7v0A-1
Received: by mail-wr1-f70.google.com with SMTP id k1-20020adfb341000000b0024215e0f486so2099258wrd.21
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bHxLfE6qRmbmJ9vfsWvWUlnwpkYhHXJKMmhBNnZCVw=;
        b=B+sUQVEYS8Wye6gY0OqXH/XJBZeehNZAY425XZFm3a5fDgqA6F4xF8ni2JURYyN1CI
         wlUMtR/9sDzDRHY90IZIyclX1elo2kzeLi8VacQBFDN9M4PjqICA3MC8vZM6NvKkLl3x
         9o7vOr2XTmchYjriD5nvRDLklEw9mwU8P2IN6Uyx4Dreu3NFEqjv/b1sjB+39J0yEhRF
         jbJR+MEsbRTDingMLYUPmcbnik0WN2beeOjP86gJ+IqgDy4EqOzlnTJX6e1Jq7XviasG
         dO1QNmDOeQR9iqaakQvGr1DKGVMQ0BQ2tgid1+njHpWEzUf5Gtssa+aVTCyek29o3bDg
         AhHg==
X-Gm-Message-State: ANoB5pm+s5SK/XyY5GlKHc284U1GP52iIk3Y1+0l5d5LXZEyjCjAqimB
        tjtcMaB8P67nga24UMA5z3S0t8tCtNJet6I6jXWleKgMi5NLv8cZHOxmjn0dyc4Z/UJdQSELVbf
        u6b+kFubGKqsMikg0/AQYKJw=
X-Received: by 2002:a5d:6f11:0:b0:242:70f0:9196 with SMTP id ay17-20020a5d6f11000000b0024270f09196mr33065569wrb.45.1671529055091;
        Tue, 20 Dec 2022 01:37:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5A94U6u6cGzamMmT1GgT+wuXQtFEvsTtiTSWk5LQnUafJiCwGKhccUzi3oD1XqGmcmR4z97A==
X-Received: by 2002:a5d:6f11:0:b0:242:70f0:9196 with SMTP id ay17-20020a5d6f11000000b0024270f09196mr33065558wrb.45.1671529054902;
        Tue, 20 Dec 2022 01:37:34 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id az17-20020adfe191000000b00241bd7a7165sm12231930wrb.82.2022.12.20.01.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:37:34 -0800 (PST)
Message-ID: <6a6e3bfb-d320-8ccf-f047-55999552c8fc@redhat.com>
Date:   Tue, 20 Dec 2022 10:37:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 12/18] fbdev/offb: Allocate struct offb_par with
 framebuffer_alloc()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-13-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-13-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Move the palette array into struct offb_par and allocate both via
> framebuffer_alloc(), as intended by fbdev. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


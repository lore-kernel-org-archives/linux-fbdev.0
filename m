Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6314AC4332F
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiLTJ7q (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiLTJ6j (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:58:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D506178AF
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671530240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zR3NMVKBvjI/Fvz5cz8ZGpP1GVWOvCWnnAnJEkm9Lyc=;
        b=YQbNtg5sHPese9SLj08mepOoq3AFHGy06WCHdzoBVzgqFMyuxCIi07/N8/9nGy2srqPJ3v
        ahbD2tRgem1joVplAUxwW5XBUgU0jy47G1/bfXIxSJIk9NmG9yb4KPKO8MlszQytKK79dm
        tgvxEv256rGNQQyowLmvIV7eII1xI5U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-407-fXT8Oya_O7q7ROtli-w2Pg-1; Tue, 20 Dec 2022 04:57:18 -0500
X-MC-Unique: fXT8Oya_O7q7ROtli-w2Pg-1
Received: by mail-wm1-f69.google.com with SMTP id 21-20020a05600c021500b003d227b209e1so2425460wmi.1
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zR3NMVKBvjI/Fvz5cz8ZGpP1GVWOvCWnnAnJEkm9Lyc=;
        b=CtUbH4M6qP+K7vF0mROkG5PiBmjL0AB5iUMgFwEEr+b6OvUASBky+fgXhr+6uHl0Ed
         /aAAuk/mLNswnX8EcYWvhoD0VG/y1StcV2HbLPRhurz2l8m+T/0blViZ/xD1OQSuKVAW
         CJdBGDNHar5IvdPlKpzgttdaxuXt3R2FQDlKqvcaudVm9x7+qpr7Vklaw1cV+OASbRsN
         0SS/MOo9AbjV+hRXiSbq4IY2Hmmpu9xeRyQGx39CwOYqxs3rEPWWDH3J99DG3XUDTMjs
         7qkeTdjGVTVc5kviDaGdJPfACeyCrVls0CptS5kGjomUYsITusUsMfXexVMGl9wCP/4E
         W0+g==
X-Gm-Message-State: ANoB5pnJB/mtZvu8891cjN0hd0fh4L4Ytv00yfx8zGxnNytjLDn7Ej3A
        PfJFnGrl2kZK3XguVed5ijNnjO434VWUs4BYBIoIj/oi5x31YP0i6BFM01e6a7BxVeIYX3deUUK
        rtqgzNBKzilLNY24LCJ/HyVs=
X-Received: by 2002:a5d:6890:0:b0:242:661b:a20 with SMTP id h16-20020a5d6890000000b00242661b0a20mr35745371wru.20.1671530237827;
        Tue, 20 Dec 2022 01:57:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6JPMUHl7uM6zh/rUkEAM4pTMPxDqka9Nrm0jCwHQupJ0YXx5LY/m/SdGP2/SdhmzpZ5Bzfxg==
X-Received: by 2002:a5d:6890:0:b0:242:661b:a20 with SMTP id h16-20020a5d6890000000b00242661b0a20mr35745363wru.20.1671530237626;
        Tue, 20 Dec 2022 01:57:17 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c18-20020adfa312000000b00228dbf15072sm12764865wrb.62.2022.12.20.01.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:57:17 -0800 (PST)
Message-ID: <6069abcc-d81a-bb94-e603-e93baa64947b@redhat.com>
Date:   Tue, 20 Dec 2022 10:57:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] fbdev: Don't return value from struct
 fb_ops.fb_release
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221216174633.1971-1-tzimmermann@suse.de>
 <20221216174633.1971-3-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221216174633.1971-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/16/22 18:46, Thomas Zimmermann wrote:
> Change struct fb_ops.release and its implementations to not return
> a value. Returing an error is not necessary and callers of the
> function ignore it. It is also good practice to make clean-up code
> unable ot fail, as such failure cannot be handled.

typo here "to fail", but I think that you can just fix it when applying.

>
> In several places drivers tested for the correctness of the internal
> reference counting and failed silently if the counter was incorrect.
> This would be an error in the implementation, which would require
> fixing. So change these tests to return no error, but print a warning.
> 
> v2:
> 	* update omapfb2 (kernel test robot)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


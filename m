Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C1FC4332F
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Feb 2022 09:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiBRJYi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Feb 2022 04:24:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiBRJYh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Feb 2022 04:24:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FC3529834
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Feb 2022 01:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645176259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OrQCVaqQbXHTrFz+bGi4f699ia90v0XlEHoS7ms3G2o=;
        b=g9rhKjlEQKwHvljzwdbB65ZJVV+fmZrNDjevoA9QJYo5WE6XeY5m67bTn5jRZoy8i35qWB
        kUNddMHJopttpMRfnEXdg1vZ+p5sjKaqxkp8ZsVHIxYTt/mw0JH2pXAB+XWa0UHmTLynKT
        qjQ3sYKA0I4P4vdPUSY52OPhpVmf3BU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-9pNtIUOBPBaEhrBiOXj4lA-1; Fri, 18 Feb 2022 04:24:18 -0500
X-MC-Unique: 9pNtIUOBPBaEhrBiOXj4lA-1
Received: by mail-wr1-f70.google.com with SMTP id u9-20020adfae49000000b001e89793bcb0so1818428wrd.17
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Feb 2022 01:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OrQCVaqQbXHTrFz+bGi4f699ia90v0XlEHoS7ms3G2o=;
        b=4NBu4WcgPQ2FI+wNdCCEYTZ4iHJ7RpTbUP8XiEopLXu6S+DXGubQTPPsdbksLcm7hy
         pFrbwkFcCSlStlKndWRnKUMndxsxUm5SF33SSt4VxgZ8LYcCzzS3qSuesmofGEcJPXqI
         bYzYX7F3U2oZG0IdJ1WBl9la1703ExEil8QbLB2je4Jh34m1UJT/v+V4uKK7Uh+GkHvC
         LeypufqkADRNp2ygL5aUnA5G7RmWvNEuW/24kmc4jkMBYE54UYNKapnJHgkKY6ff7sN5
         SEUtauoV5Ln2Ivv+uLD8g6oN7ws+vCaE/+ARE4vk0wFgRYP0Orn4qwWfyz/TFXSCxVKh
         poWg==
X-Gm-Message-State: AOAM532j3IujOoT94z7PSORdzauFfA4nXhda2qxORyJ+MklYBtmpLnP9
        NgkAC5s7z/hvX9zDY4luv+yuujswKfVb53C9oCcWNvCEbZ+m8gR5KCQ9dpP1ReKOo7hYttrHyaW
        mRNQsftCpjTB/PFE5BwUobjE=
X-Received: by 2002:a7b:cd11:0:b0:37c:82e:d742 with SMTP id f17-20020a7bcd11000000b0037c082ed742mr9414117wmj.170.1645176257229;
        Fri, 18 Feb 2022 01:24:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+5F1ocqRF9F+pUDeSDknNeICJmEiZICFoS94DE83Jkq/Z+3iQAfZIvUUPzI8L1uiJUcbrpg==
X-Received: by 2002:a7b:cd11:0:b0:37c:82e:d742 with SMTP id f17-20020a7bcd11000000b0037c082ed742mr9414091wmj.170.1645176256935;
        Fri, 18 Feb 2022 01:24:16 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x18sm40908244wrw.17.2022.02.18.01.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 01:24:16 -0800 (PST)
Message-ID: <6c06a344-f998-1f15-0f94-c295d4831654@redhat.com>
Date:   Fri, 18 Feb 2022 10:24:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] fbdev: Improve performance of sys_imageblit()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        deller@gmx.de, geert@linux-m68k.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220217103405.26492-1-tzimmermann@suse.de>
 <20220217103405.26492-3-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220217103405.26492-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 2/17/22 11:34, Thomas Zimmermann wrote:
> Improve the performance of sys_imageblit() by manually unrolling
> the inner blitting loop and moving some invariants out. The compiler
> failed to do this automatically. The resulting binary code was even
> slower than the cfb_imageblit() helper, which uses the same algorithm,
> but operates on I/O memory.
> 
> A microbenchmark measures the average number of CPU cycles
> for sys_imageblit() after a stabilizing period of a few minutes
> (i7-4790, FullHD, simpledrm, kernel with debugging). The value
> for CFB is given as a reference.
> 
>   sys_imageblit(), new: 25934 cycles
>   sys_imageblit(), old: 35944 cycles
>   cfb_imageblit():      30566 cycles
> 
> In the optimized case, sys_imageblit() is now ~30% faster than before
> and ~20% faster than cfb_imageblit().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

This patch looks good to me as well.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


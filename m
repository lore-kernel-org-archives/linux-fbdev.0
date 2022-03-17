Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A96DC433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Mar 2022 11:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiCQLWM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Mar 2022 07:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiCQLWL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Mar 2022 07:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 676E71E374B
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Mar 2022 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647516054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooJ9GuDR1zDRA6wa1d+2YqoS6wsKS/sfV2gTAnIiGxs=;
        b=K/y3wYE5Kf+i+hJNcVhNUros1+pJaD+krNyBixqk0HX9mei6E0IL95Rn1g/dwMFrx8g1JB
        BWUqmlYP1/Siw6XIMaYxAYcWc46Pqgnr4H7Nr9nNJfMZGeF3kc33I/Vf8hPHaVhs59tKFf
        GNUo6Qs4Qr/A2wJKW4EHjh/z5D6IQbo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-xT8sX41YMC6R2iekS6j8RQ-1; Thu, 17 Mar 2022 07:20:53 -0400
X-MC-Unique: xT8sX41YMC6R2iekS6j8RQ-1
Received: by mail-wm1-f71.google.com with SMTP id r64-20020a1c2b43000000b0038b59eb1940so2973616wmr.0
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Mar 2022 04:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ooJ9GuDR1zDRA6wa1d+2YqoS6wsKS/sfV2gTAnIiGxs=;
        b=p7u669JIe2VNmcsX2trtLeRmP4gKzfTljuTjM12Ehe410sjSv1Q66I85FJ7430tENE
         +cwXmvCSMR+tXd4kBou/Dxh6PQtDj/p0Yn0l0M3s8zwFXk0Va4lR2/2Fjt7ziRpIO5fu
         tGOsSin7gMHwsKr7Sw5A3DIglx5w3jGjFThNYjdV4SIsvm/Q33kl8oOhXA2X2umVT94n
         So6lgGkVJ0reu67PoECdQEvAIx7HIlhavIxnYjxW32wgsb7KtEdqgvOEcmQ1Zkqy68ca
         bCKyasuI48Bu8wZTc6S+a+BGlYahu3S9ineEg9nI8IRik22QeiQfMt5ULlKoIXVT7ha2
         n72w==
X-Gm-Message-State: AOAM532t6RwtXpDnwc9TxCEsrah6xewFC3nxQDXAro5nTqgbCGoZ5kFw
        OafdhkbVbopVZR9vFaqVlrx/7yaVgZojGM+qWdMApa+axw+p7Th8cXYoOgFlLnpqDd3mZhsbhGH
        fiLpSU5m8t/Bg6N2ITCQ9tGc=
X-Received: by 2002:a5d:52c7:0:b0:1ed:a12e:bbed with SMTP id r7-20020a5d52c7000000b001eda12ebbedmr3565753wrv.97.1647516051886;
        Thu, 17 Mar 2022 04:20:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+noMHruT1Sne6ijibg7bHIXzxkZckSPpwOnAtzNb9wfj3uDW78GC2bclNntk+Vo7eA39oSA==
X-Received: by 2002:a5d:52c7:0:b0:1ed:a12e:bbed with SMTP id r7-20020a5d52c7000000b001eda12ebbedmr3565744wrv.97.1647516051687;
        Thu, 17 Mar 2022 04:20:51 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm4002044wmj.34.2022.03.17.04.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 04:20:51 -0700 (PDT)
Message-ID: <f867cce1-04dd-a87a-700d-343cc28f188f@redhat.com>
Date:   Thu, 17 Mar 2022 12:20:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] fbdev: Fix sys_imageblit() for arbitrary image widths
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        deller@gmx.de, m.szyprowski@samsung.com, geert@linux-m68k.org,
        sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220313192952.12058-1-tzimmermann@suse.de>
 <20220313192952.12058-2-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220313192952.12058-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 3/13/22 20:29, Thomas Zimmermann wrote:
> Commit 6f29e04938bf ("fbdev: Improve performance of sys_imageblit()")
> broke sys_imageblit() for image width that are not aligned to 8-bit
> boundaries. Fix this by handling the trailing pixels on each line
> separately. The performance improvements in the original commit do not
> regress by this change.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 6f29e04938bf ("fbdev: Improve performance of sys_imageblit()")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---

Looks good to me. Also Marek and Geert mentioned that fixes the issue
they were seeing.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


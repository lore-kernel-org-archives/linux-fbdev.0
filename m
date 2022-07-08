Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DCCC43334
	for <linux-fbdev@archiver.kernel.org>; Fri,  8 Jul 2022 12:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiGHMtS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 8 Jul 2022 08:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbiGHMtR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 8 Jul 2022 08:49:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48CBB183AD
        for <linux-fbdev@vger.kernel.org>; Fri,  8 Jul 2022 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657284554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXuSFlnIAxgCKPnUJ6Nag3HqR+rDg0TljYkgtGxjjVs=;
        b=Tb93t91mimvMq4XeLlj2mlzbf00dHAOvgBAmINMeV5Y8KPDd8g43xty87aMRKlmW8NY9qD
        DZY5Hmt34Mq837gT3wwImj1ZC48i/iQotfVvdEfRJSH/AP0QyPaX5O0gqphLcxYUrsyBsH
        OGklt5kic7sZ0dDwb2T1ZLx6xiIs38k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-CVF24tC2PCqRNWm9m8wv-w-1; Fri, 08 Jul 2022 08:49:13 -0400
X-MC-Unique: CVF24tC2PCqRNWm9m8wv-w-1
Received: by mail-wr1-f71.google.com with SMTP id g10-20020adfa58a000000b0021d419f7751so3870420wrc.23
        for <linux-fbdev@vger.kernel.org>; Fri, 08 Jul 2022 05:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BXuSFlnIAxgCKPnUJ6Nag3HqR+rDg0TljYkgtGxjjVs=;
        b=dE/jUL/ZqzRYVme2o9OAejiEIL9mEB/KltttBVLxhcRTsG0HHywYK7Efs1xlb0x8kU
         65WM0Eh05PMKFWs4H/QYm3/Dyj++/NY6awLGZZadUNtDz6QmMZA/ItHsCbkmHWl29XMR
         iWKWSx72X0ZR1ImgGiLaeMZYDHFNRkHlSKAWhd7YlGyOzAgj8/dH2t0IFKHcXYvLlAsa
         xSHalrcfLOB8ziCKnCnShMXrNIRn0b4mKMteRLDVsbNOYMQdbVGZP3OM4IeGlMC7UfNG
         iPyM3hD4pHJKS3+xLYryf4zJs65899HxRb5O/htP3UlInWdeO7p46c93m0/8NcnSMvNy
         rxpA==
X-Gm-Message-State: AJIora9xr/fbLpbCjWBt7jVbDUPC00w8efYlChsfkMCj8rkHwPWtP9b/
        anluiP88hzeFra+qEEpue2qwEazjcpP+KiRWobGyjMasrc1y9x/RnNCRIqRDfAng6v0JJ2HoWq3
        kNPraIb53ckU4I/IqX8Tbf1c=
X-Received: by 2002:adf:fcc8:0:b0:21d:68dc:814 with SMTP id f8-20020adffcc8000000b0021d68dc0814mr3198817wrs.102.1657284551971;
        Fri, 08 Jul 2022 05:49:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sXhd4T+yl5DMha3tRNDB/4iD3FiLVQoWs6+jCF56wa3Ebe+y62zjBioLN+cSMTshk3KpQlpg==
X-Received: by 2002:adf:fcc8:0:b0:21d:68dc:814 with SMTP id f8-20020adffcc8000000b0021d68dc0814mr3198802wrs.102.1657284551803;
        Fri, 08 Jul 2022 05:49:11 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j2-20020adfff82000000b0021a56cda047sm3218629wrr.60.2022.07.08.05.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 05:49:11 -0700 (PDT)
Message-ID: <3d80d394-0aea-8bfa-defa-af2b3c3784c1@redhat.com>
Date:   Fri, 8 Jul 2022 14:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/11] fbdev: Remove trailing whitespaces
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-2-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220707153952.32264-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 7/7/22 17:39, Thomas Zimmermann wrote:
> Fix coding style. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


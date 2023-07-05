Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC0BEB64DD
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Jul 2023 09:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjGEJOj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Jul 2023 05:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjGEJOi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Jul 2023 05:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3257F170E
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Jul 2023 02:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688548432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rik35amMtwyfsql6qwDwxhFyML3yiol4Y+GAZ2CyrAI=;
        b=iNTSzdNa12XsbUMb7g796WRj+R5RHCN6OCFxKCUMoJPTQ/UkjPD/hHYIeOYpPEPSse4rmu
        /MkenCf0D2sCiTyzblab0HL1bCMfri8CAdjcza/kUsLP+WqWxz0LKZxyc5MrKbCa7+O2c9
        lAtCKlQ8GQ8n44s8OmfazPXqlwIMW8Y=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-LbgXQ4vDMQiiO68Rbw607w-1; Wed, 05 Jul 2023 05:13:51 -0400
X-MC-Unique: LbgXQ4vDMQiiO68Rbw607w-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4edbdd8268bso6030004e87.2
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 02:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688548429; x=1691140429;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rik35amMtwyfsql6qwDwxhFyML3yiol4Y+GAZ2CyrAI=;
        b=GNSBVzdcd2DZc3sDHwos/XGwNSTOow/rI+dmQeCzHAZGOcoCf7HJdKF8l0VqVV8N7a
         9GO5C2s63GEY2833mH11b1LtSzR2kGDxQCgHyKNfViM56ucos/U+eBW8UyUkpJrBb8UP
         GAADEciKweDd8CVv5IwSlng4syixWslZQSa4rF9SI/O/m8R+R7GEwMNaC3IRWJTUVAgB
         pRxrJURVhL0dP48bc0r07bBr1nLquJf3adQ8KHzeExfTYs3usqnj9JJDbZQt0ey/ZXnH
         z/5+OfqovFMp8D+xC/Qmf4+CsRcbXRNM7SNiy1JV3jWd1HVcAfAd5pWEINhE9N9YNgSb
         Ze/Q==
X-Gm-Message-State: ABy/qLalKsKxndYPeM8CX25oG0O147WYVItp3BDP1ZjyyRWNKNQKfTSL
        JJGIYXfmS3IZfxgOTS68lCGiWBrl0MPp1KKeJ53xy1QMIbcROzZPXBFQvC4uJi8BooF+ktUZVbi
        +qv7bgD4lGLxvXhV10qPLy8g=
X-Received: by 2002:a05:6512:2390:b0:4f8:75af:e917 with SMTP id c16-20020a056512239000b004f875afe917mr13371318lfv.41.1688548429591;
        Wed, 05 Jul 2023 02:13:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEjlCwK+D/L2otHSAcjbQ8sKKCy18gUu/mb3rWmvZIWyjXZh7PIhlP01348E9bdMzGE5uNgkQ==
X-Received: by 2002:a05:6512:2390:b0:4f8:75af:e917 with SMTP id c16-20020a056512239000b004f875afe917mr13371303lfv.41.1688548429289;
        Wed, 05 Jul 2023 02:13:49 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fbc2c0addbsm1520495wmc.42.2023.07.05.02.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 02:13:49 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc:     linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/10] fbdev: Add fb_ops init macros for framebuffers in
 DMA-able memory
In-Reply-To: <45ed59d1-32a5-86cb-094f-5ce7ad758d5b@suse.de>
References: <20230704160133.20261-1-tzimmermann@suse.de>
 <20230704160133.20261-2-tzimmermann@suse.de>
 <875y6ysr6g.fsf@minerva.mail-host-address-is-not-set>
 <45ed59d1-32a5-86cb-094f-5ce7ad758d5b@suse.de>
Date:   Wed, 05 Jul 2023 11:13:48 +0200
Message-ID: <87cz16ra9f.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

[...]

>> 
>> The comment for I/O memory helpers says:
>> 
>> /*
>>   * Initializes struct fb_ops for framebuffers in I/O memory.
>>   */
>> 
>> I think that would be good to have consistency between these two,
>
> Sure, I had the same thought. I think I'll rather change the existing 
> comments a bit.
>

Yes, that works for me too. Thanks!

> Best regards
> Thomas
>
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


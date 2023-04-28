Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E62C77B61
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 15:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346313AbjD1PNV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346289AbjD1PNU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 11:13:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBF61FDB
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682694756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=Oz1etwE6qW0i+8FnYcVq9tVNQ4UteRozK3okCMA/rzp25Rcgi37jxYlQELlkoIRcbRjKii
        gTsIQtHuPrGhAiHGm7fdMQuwILolNSEZcoI3i5WLCKubWt8BuKuV64LWf2I5aIb/YV+6Qe
        8TaJt1JXPl8DanAW0Hp3NMe/r7SzABs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-nN-vqKWfMN6yfGZ4pcuWPQ-1; Fri, 28 Apr 2023 11:12:26 -0400
X-MC-Unique: nN-vqKWfMN6yfGZ4pcuWPQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2fe3fb8e32aso3708590f8f.1
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 08:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682694729; x=1685286729;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=lnItFHCA45PcwHKQ/k+HIKXL1QSpvYSqsXKbvMefT3hmkH5u6gq6N1ljgeaJvMN4DS
         I/Rrtsu7RUuX+kre2trqc86o7h+0AHCAgIq1NaBBDHKTp4oeDclx+ZTD9WWISpciDWAB
         bekwc+PCcJ094cJgREiNyaaoKGKkw0YieT3/1zQ9gtPbdW/jsxNO5L+KAVGWyeV8NHmZ
         UgLnokf4vBr8jZkKBqg3Zmq0A/RFWxCxqT8nZJQZmR3Y/t5Ib7/8qSH8SZVE9ZhNvkVU
         7FaWa16VWZEyuLRie1a8JEKlqKPsdV0JOKj0xeC0nB+yQnPzXoXE0fqh2GoQn0EMN72y
         +UVw==
X-Gm-Message-State: AC+VfDyJYjSb2+Km6h5wq8FcOHDvKQAQ2Dk5FLNRa7kAScVYSR9bR/dv
        TngCoC2A40lTawbJdMhAxqT+OqPXigMZTJG9IdqkoSaFWMwU5/On2/IzePUCiBA2EOKGtI0NcBi
        H43Ot5B1SQVJ19UwaK1Awyiw=
X-Received: by 2002:adf:e689:0:b0:304:760c:6474 with SMTP id r9-20020adfe689000000b00304760c6474mr4572628wrm.10.1682694728864;
        Fri, 28 Apr 2023 08:12:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44bsNLFtYJtMnmm9jFzKFRATuTWPXEJOmr7ScTjElY9MxGn1aNvKFBPBprMOJgW6uVbp7bQw==
X-Received: by 2002:adf:e689:0:b0:304:760c:6474 with SMTP id r9-20020adfe689000000b00304760c6474mr4572608wrm.10.1682694728534;
        Fri, 28 Apr 2023 08:12:08 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003f1958eeadcsm20815145wmq.17.2023.04.28.08.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 08:12:08 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 11/19] fbdev/udlfb: Use struct fb_info.screen_buffer
In-Reply-To: <20230428122452.4856-12-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
 <20230428122452.4856-12-tzimmermann@suse.de>
Date:   Fri, 28 Apr 2023 17:12:07 +0200
Message-ID: <87o7n8f3co.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use info->screen_buffer when reading and writing framebuffers in
> system memory. It's the correct pointer for this address space.
>
> The struct fb_info has a union to store the framebuffer memory. This can
> either be info->screen_base if the framebuffer is stored in I/O memory,
> or info->screen_buffer if the framebuffer is stored in system memory.
>
> As the driver operates on the latter address space, it is wrong to use
> .screen_base and .screen_buffer must be used instead. This also gets
> rid of casting needed due to not using the correct data type.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


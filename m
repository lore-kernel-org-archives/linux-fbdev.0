Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49439C77B60
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 14:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346158AbjD1O4p (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 10:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346199AbjD1O4o (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 10:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF46D2122
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682693764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=PR+cNzYx05GLiVHv68GfTw2m25Is60Y+J8g0c0kQC1DHKxcI1t+4bnDQFhLcE/FW0N7POL
        JFFWJuXkeMzeOMbNqt9t8kJcTWsGe+AWLZyhE3R7ExvMJkky0hlP4AU8571fjcod8oVxHO
        cGwPzafaVkFgHGwUJHbvm5D0ZNd4d8I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-oKV5izU6M3aFTLbFnf_3fw-1; Fri, 28 Apr 2023 10:56:02 -0400
X-MC-Unique: oKV5izU6M3aFTLbFnf_3fw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f17afcf99cso37216055e9.2
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 07:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682693761; x=1685285761;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=QF0r0p4jyFhw30J5MWD4006Ow4QNFxIeu6SPq90jbuAyWK2DpM0WplkZklQU5UupCN
         W26RYqBFjNG4OetF767/9HTdbYB1X3/as0OE3J2w/ywd7KQz6GbVHQQjA2vQEh/uJwkw
         ifGxXkiggbgRvvNbX3m9XD9q9tAfkcxwCYlgUnJF35t7G1GNQTxsQVuM0OlNkhr5pRV3
         VxzDazDrhD6O8+Q8gHZ6Uo7nfKmKKuRUmKBCQYTdDyKY8YAyHsdEXEwW6+VwvuapyqUK
         YodnJun1pfAb7Ey1fREl1OFmIpmT6CZ+S20It9AFuY20NTfTo2VDVhN6Lo9eNt5s8eFA
         hanQ==
X-Gm-Message-State: AC+VfDzP5gK8g+DbHUibbYaerZKt3qsnv59G0CODaGkI8RJ+i5kQIoO3
        cv/YfD9jv6AnkKw/FgZd43H5eyBmaHz9zK1bc2BsozZmSETNiI38lcFWGmTjl/lNNHed59VtgIE
        vcaZaQcQrWLQ5ar6sb/9E1N8=
X-Received: by 2002:a7b:ca47:0:b0:3f3:1cb7:b2a3 with SMTP id m7-20020a7bca47000000b003f31cb7b2a3mr3523004wml.9.1682693761369;
        Fri, 28 Apr 2023 07:56:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5D+So0l9OZcxXmKXissbZmCPVMCQGhKc30GIsDvrtfMVInauLc5DBWL85aCOW4eRSOWx5icQ==
X-Received: by 2002:a7b:ca47:0:b0:3f3:1cb7:b2a3 with SMTP id m7-20020a7bca47000000b003f31cb7b2a3mr3522987wml.9.1682693761048;
        Fri, 28 Apr 2023 07:56:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c1d0900b003f17eded97bsm28566672wms.19.2023.04.28.07.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 07:56:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 09/19] fbdev/ps3fb: Use struct fb_info.screen_buffer
In-Reply-To: <20230428122452.4856-10-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
 <20230428122452.4856-10-tzimmermann@suse.de>
Date:   Fri, 28 Apr 2023 16:55:59 +0200
Message-ID: <87ttx0f43k.fsf@minerva.mail-host-address-is-not-set>
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


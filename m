Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE223C77B61
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Apr 2023 16:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjDYQgx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjDYQgw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Apr 2023 12:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A1ACC08
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682440563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qlOgM/8RxDeZnqZ/gTRy5yhr/nqixhxpPSszW3G2Gb4=;
        b=Rc5zsAmHjWzlKahwirqof0j1uUJsfw3dT8PxbtAeTcCyRngaKIQK4fQ/7O2deO5mYXfEux
        grdVCF4NYrgDOmS4wHIsKLSW1KSQ4v07WmSGgJ5qWwPvRVFRHtLIvaYEGT8cx6YiRxfvPq
        cVuxaftNxE07bJNPb7iZRpg7xt7ovug=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-8oTAjrTkMDeTKDdl1HyA5A-1; Tue, 25 Apr 2023 12:36:02 -0400
X-MC-Unique: 8oTAjrTkMDeTKDdl1HyA5A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f1754de18cso34948575e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 09:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682440561; x=1685032561;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qlOgM/8RxDeZnqZ/gTRy5yhr/nqixhxpPSszW3G2Gb4=;
        b=Sf+OVhZjU+UBrjGkeyywwi7kuNz9auPeogQJ6Yjd4E3Up/DE9tc/jISiossVUQ70ng
         StCnZSYG6lTowr55rTnzkjPBE6S4HiniPFyXbVdK5pf78qRTOgt9gFPt1c5JFNYn/UPn
         yTj5g9xXIre9EfJh5nrabhrdldWAaNWk2mzX/ic46M0CJ6mMGojQ6RYy5nwqeC1lqZZD
         wBbotJsG5TgAbUykSudVqkld8Or68yF0tCV695cmkRk7dtQFFtQy6QhEFepukC1nqD6v
         XoHKHtAtI9r+llDAirWab5trGL8HR2LUfwX+oUtVreusvwoX4nWmfIOWzGC6MHN6QbbR
         qfSQ==
X-Gm-Message-State: AAQBX9cQ3boJm3tHIahrlyh0SRept6vYoHCOwB7fu49Qz0f7vOeEz9Ck
        dOx9BFGR5GsemTt5lcb+9U+dgB6F/t+aHsDjL1Q9SDR4x7eDiH7wujs/rfrOge3C/H0mtNKmirg
        TBG6/8SorN2ee+dSjMNQ1vN8=
X-Received: by 2002:a7b:cd88:0:b0:3f2:48dc:5e02 with SMTP id y8-20020a7bcd88000000b003f248dc5e02mr5905403wmj.27.1682440560771;
        Tue, 25 Apr 2023 09:36:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZarFNWyULU3TGqyTbs5AXJzHTA2jvJ02WhL98OC157wbJAwpXkEfhLfRIOLGtkAkghY0ysZA==
X-Received: by 2002:a7b:cd88:0:b0:3f2:48dc:5e02 with SMTP id y8-20020a7bcd88000000b003f248dc5e02mr5905389wmj.27.1682440560453;
        Tue, 25 Apr 2023 09:36:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c021000b003f17a00c214sm15336779wmi.16.2023.04.25.09.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:36:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/6] fbdev: Use screen_buffer in fb_sys_{read,write}()
In-Reply-To: <20230425142846.730-3-tzimmermann@suse.de>
References: <20230425142846.730-1-tzimmermann@suse.de>
 <20230425142846.730-3-tzimmermann@suse.de>
Date:   Tue, 25 Apr 2023 18:35:54 +0200
Message-ID: <87a5yvj4wl.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use info->screen_buffer when reading and writing framebuffers in
> system memory. It's the correct pointer for this address space.
>

Maybe can expand the explanation a little bit with something like this?

"The struct fb_info has a union to store the framebuffer memory. This can
either be info->screen_base if the framebuffer is stored in I/O memory,
or info->screen_buffer if the framebuffer is stored in system memory.

Since the fb_sys_{read,write}() functions operate on the latter address
space, it is wrong to use .screen_base and .screen_buffer must be used
instead. This also get rids of all the casting needed due not using the
correct data type."

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


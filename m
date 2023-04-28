Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49957C77B60
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 15:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346347AbjD1POM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 11:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346146AbjD1POG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 11:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B841FDC
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682694802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=ca9KjtbgbH6hjRMuDhhwwhwVTK+xxD/UtfRP/1bemgDCwksOI4agoF8eWxgnOUUdXWx+IF
        tQlYuVMi99AEJ9J6T+f0/1CB7vhD+krXFFm/LXci7/zN07Ces+5DwHnr0qpvTnC0ZsBt5v
        p6qBS63691dZlQehHO6cwe+pwKVqveo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-w2hCYr5WM2ai9enFviDc7A-1; Fri, 28 Apr 2023 11:13:02 -0400
X-MC-Unique: w2hCYr5WM2ai9enFviDc7A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30479b764f9so2401516f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 08:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682694773; x=1685286773;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=DkAzUM0EUeVkNcPj+AxbRg77zpd04alQz2OZ8EOz8EBO7H/Gupv8b9SJvej87OhFWX
         +ANYe1Q55A03NsUqjzeltmBbsUg/VrEGjR/D1K7//ardPCf3IFFd6RZgTx6x4Tiz7NTS
         MO3N4W0ZSqrqdJgnZAjw0SaEqaq6YbInvZsVhggO1fYiQWaopwKtsJixw6xCdWIbS/WR
         x/uto2cJ+Diz5TKYr3vMxVZy7eZkn308c1KAeEvb6PbRD6RuMi8Am5IfeeOANYtiK0td
         vS8mxAnYI0XkkgmyqQ3iBNmRwGcLh+LENeIkt9Ie/tWOksiz4WFa2PthS6KNlHLB2hA9
         fqDQ==
X-Gm-Message-State: AC+VfDxtWmZG/BmAJFuaeA+mAXKJvv6WY/Wu+6U8N+zMqAHPmn2yxGeJ
        lyDkYsv4kX0GC4681s3zZ+78yNcQeDdZZxPZekM2vN1O2k14su4y4XUXo/+16dBDBBsFLH70xD5
        eZCkVtVJG2LXo+FBjy2WRq1U=
X-Received: by 2002:a5d:4b50:0:b0:2fb:703d:1915 with SMTP id w16-20020a5d4b50000000b002fb703d1915mr4104086wrs.43.1682694772851;
        Fri, 28 Apr 2023 08:12:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YdjOvC7WPDQ+9GUn7fvYiqZ4HGFmEtMgoi3hW034RMkk1O2I0swh4tQ23ze2AgO9qMYdW6w==
X-Received: by 2002:a5d:4b50:0:b0:2fb:703d:1915 with SMTP id w16-20020a5d4b50000000b002fb703d1915mr4104063wrs.43.1682694772545;
        Fri, 28 Apr 2023 08:12:52 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d5950000000b0030490c8ccafsm9345789wri.52.2023.04.28.08.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 08:12:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 12/19] fbdev/vfb: Use struct fb_info.screen_buffer
In-Reply-To: <20230428122452.4856-13-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
 <20230428122452.4856-13-tzimmermann@suse.de>
Date:   Fri, 28 Apr 2023 17:12:51 +0200
Message-ID: <87leicf3bg.fsf@minerva.mail-host-address-is-not-set>
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


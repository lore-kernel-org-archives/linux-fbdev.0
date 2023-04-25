Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FF0C6FD18
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Apr 2023 16:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjDYQi5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjDYQi4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Apr 2023 12:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B006015471
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682440691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PNgY2KEcmfsm6cKr2gvXewChYpbqNROx2zrnYrsCFjY=;
        b=FJ6maUO09wz6tpfK4UA/WlPRNMPssqNMp9DaIbp/uQi2u/bmjDrnJp+9YvOhImowJKR7Aq
        VYhwzH6wYkrVKx/dQTtSgLJPckCPXbjPhmoKSn6dYh9jrmdEQ/8wcbJtJ0yRw54BeSbQVG
        CGFLVUtsVtqWvznvsb/fEi3fWNwQEq4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-2Ynip-DNOFCybP21wQ8nTA-1; Tue, 25 Apr 2023 12:38:09 -0400
X-MC-Unique: 2Ynip-DNOFCybP21wQ8nTA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f1749c63c9so21241085e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 09:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682440688; x=1685032688;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNgY2KEcmfsm6cKr2gvXewChYpbqNROx2zrnYrsCFjY=;
        b=cfTi0fgk3HdnCGR/AlnifxACtQ1LZMqeaJTQo1Yc/oIOGjD77ouq/DB4IPtxGUYUnO
         HLRt4frB71jPkbuGybCa8tGKNYd82TDRMp6MXEGWc7ObxY9fwI49lQ2BSygf8cUsL+o8
         K1rGd5cTzivbXUHWnZ8JGUCRt3K0yl03GYN075QZIGBJEF1qzzfzzOSg8/EnOYbqWBSd
         fA2yzezigluxHFGAElYgExOB78L3UBPXkHxTiRIyaNN69qpEgdOwzMkQp5dkTMqio4+J
         8ZzGX9rYutiYNhaVQdS7DSE80xOdXbJj2vMpWQy2L4E08Llj0vrJH2gqa+06fY7xymiL
         Q8jQ==
X-Gm-Message-State: AAQBX9cSFFy/wQAkTVOV95Pm2uPwnnrMroF0epngBWQSAQY5K1DYL5G4
        kDPMluGYsi3lkxF0f7CG1pXdSO0MUWhPBoGsZrzgoGLvtekW1JDinzLTw28zQz0b6i4py1xmv2l
        i7z/Y6piRY2RRJjqkK4KFD5w=
X-Received: by 2002:a7b:c8d9:0:b0:3ed:af6b:7fb3 with SMTP id f25-20020a7bc8d9000000b003edaf6b7fb3mr10991655wml.2.1682440688673;
        Tue, 25 Apr 2023 09:38:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y0/bFv3y9BzW+gGztulKEYZt2pDIDd1xyQ0jkfZ5hLeVaSLvS/gxxLfG6RPKXJ0zJIz9OfZA==
X-Received: by 2002:a7b:c8d9:0:b0:3ed:af6b:7fb3 with SMTP id f25-20020a7bc8d9000000b003edaf6b7fb3mr10991637wml.2.1682440688351;
        Tue, 25 Apr 2023 09:38:08 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c10-20020a7bc2aa000000b003f080b2f9f4sm18660386wmk.27.2023.04.25.09.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:38:08 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 3/6] fbdev: Don't re-validate info->state in fb_ops
 implementations
In-Reply-To: <20230425142846.730-4-tzimmermann@suse.de>
References: <20230425142846.730-1-tzimmermann@suse.de>
 <20230425142846.730-4-tzimmermann@suse.de>
Date:   Tue, 25 Apr 2023 18:38:07 +0200
Message-ID: <877ctzj4sw.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The file-op entry points fb_read() and fb_write() verify that
> info->state has been set to FBINFO_STATE_RUNNING. Remove the same
> test from the implementations of struct fb_ops.{fb_read,fb_write}.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


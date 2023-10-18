Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EA6CDB47E
	for <linux-fbdev@archiver.kernel.org>; Wed, 18 Oct 2023 08:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344615AbjJRI0j (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 18 Oct 2023 04:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjJRI0e (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 18 Oct 2023 04:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5462CF7
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Oct 2023 01:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697617549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LjzSocfdAfDkrBURoH/UDEiTk7o5qnArVSGlXdT8TDY=;
        b=bQuvNXI6+3KknQTlh68CBJP/J53FerbWJHv63ghxCHov5h+MHcmgkCATXYIR3FRPwOOTfA
        GXRDQBr1EEVgAmSqIO0nBkeQo359ivjhlyR+Q843wM93/mBHb30mq6WSaFy5XN8b5y9lf1
        CwvaBN4Pdmdt6Ke5ynVSvX327F6qNj0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-p5gC6_SePdClRyA5xB-DOg-1; Wed, 18 Oct 2023 04:25:45 -0400
X-MC-Unique: p5gC6_SePdClRyA5xB-DOg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32da8de4833so2215015f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Oct 2023 01:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697617544; x=1698222344;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjzSocfdAfDkrBURoH/UDEiTk7o5qnArVSGlXdT8TDY=;
        b=GJrnctGtjYBK3cEikmONWytSNQo/aQbcXDAUV2sMb+N9VJrNB/WknmXu92z2H0DlIX
         RY+qW3UbbBIhIvKCUg97/NxVoirJIzne37SauODxI8uknkMHLvjlmjKhkryrUQRvvKiD
         0DHKSMPGdnBymGp1HeRQV9k/PDOSibrTEuPMHoPiNUFM9hpia20q+S5iQWkpYXxxxMb5
         ZObjKAKYpA5BEUav6sr0GLQc8WZVui5CMZ6sUZw6iK+udGkViDw6tFKIYlvHAyiVuIFv
         ueUQaJBPjroy9Rx/VhLiGj6QDqsZLAEI0Yj0BEAnQO/htTJvPlRQotD/eBPnH2t3HxB7
         wb8w==
X-Gm-Message-State: AOJu0YxZyshY6nVaQRFzI/sIOA3qehCy413/pO+rb2VdehdJs38ghxji
        DCcp15EIjLJ48aRcsDxwHD+bqGlrMrm6wpqnjD5PWcqVsBsrdloinIt4grpbWOz4/A/ffVrAf8U
        UcH19d9yAEs5NE+MOoBgrRw4=
X-Received: by 2002:a5d:4c89:0:b0:32d:8094:f4c8 with SMTP id z9-20020a5d4c89000000b0032d8094f4c8mr3650287wrs.19.1697617544652;
        Wed, 18 Oct 2023 01:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa4Q8xItiTztaLFOsH4D6hLMKERtw9q396FzIJnVUMQIU6RTlte1VKHlDSYg+C3e5HZRfxSQ==
X-Received: by 2002:a5d:4c89:0:b0:32d:8094:f4c8 with SMTP id z9-20020a5d4c89000000b0032d8094f4c8mr3650275wrs.19.1697617544348;
        Wed, 18 Oct 2023 01:25:44 -0700 (PDT)
Received: from localhost (210.red-80-36-22.staticip.rima-tde.net. [80.36.22.210])
        by smtp.gmail.com with ESMTPSA id j14-20020adfea4e000000b0032d81837433sm1584752wrn.30.2023.10.18.01.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:25:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        sam@ravnborg.org, arnd@arndb.de, daniel@ffwll.ch
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-nvidia@lists.surfsouth.com, linux-omap@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 00/46] fbdev: Init fb_ops with helpers for I/O memory
In-Reply-To: <20230927074722.6197-1-tzimmermann@suse.de>
References: <20230927074722.6197-1-tzimmermann@suse.de>
Date:   Wed, 18 Oct 2023 10:25:43 +0200
Message-ID: <877cnkqquw.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Initialize struct fb_ops for drivers for hardware with framebuffers
> in I/O-memory ranges with the respective helper macros. Also select
> the appropriate Kconfig dependencies.
>
> The patchset is part of a larger effort to modularize the fbdev core
> and make it more adaptable. Most of these drivers do not initialize
> the fb_read, fb_write and fb_mmap callbacks in fb_ops. By leaving the
> callback pointers to NULL, they rely on the fbdev core to invoke the
> I/O-memory helpers by default. This default makes it impossible to
> remove the I/O-memory helpers on systems that don't need them. Setting
> the pointers explicitly will allow for the removal of the default. If
> a callback in fb_ops is unset, the operation will then be unsupported.
>
> Initializing struct fb_ops via helpers macros will also allow for a
> fine-grained setup, depending on Kconfig options. For example, it
> will be possible to leave out file I/O if FB_DEVICE has not been
> set.
>
> This patchset contains the majority of fbdev driver work. The updated
> drivers now initialize fb_ops with __FB_DEFAULT_IOMEM_OPS_RDWR,
> __FB_DEFAULT_IOMEM_OPS_DRAW and/or __FB_DEFAULT_IOMEM_OPS_MMAP if
> possible. Some drivers now use FB_DEFAULT_IOMEM_OPS, which sets all
> fields correctly. In Kconfig, each driver selects FB_IOMEM_FOPS to
> get the helpers for I/O memory. Drivers that use _RDWR, _DRAW and
> _MMAP unconditionally select FB_IOMEM_HELPERS, which selects the
> correct modules automatically.
>

I looked to all the driver changes as well and couldn't spot any issues.
For all the driver patches:

Acked-by: Javier Martinez Canillas <javierm@redhat.com>


-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


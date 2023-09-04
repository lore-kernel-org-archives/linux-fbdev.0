Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2A1C88CB2
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Sep 2023 13:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbjIDN3D (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Sep 2023 09:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjIDN3C (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Sep 2023 09:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8EECD4
        for <linux-fbdev@vger.kernel.org>; Mon,  4 Sep 2023 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693834098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8BbS0VR+viLE45lChE7wLN6LwznzmsTUr7hWT6afTU=;
        b=ZiAZFSGOxYgxpFBYbTMXDXXXhXWGWdpyuSB/p7MK4lE9bcU45hBJFEO5k0zohlJSXT+TZx
        JMPWokm687TDw79vaWBM7OfVdJl/MyOvKyp39MgOoImVH7de2rMQ2FW44OV+e8A4aldo45
        FsQ7DI5fhBpOSL6bA9zRFWenDE+M2Z8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-5UUdPFoWOlmbzGwn4V5yCw-1; Mon, 04 Sep 2023 09:28:16 -0400
X-MC-Unique: 5UUdPFoWOlmbzGwn4V5yCw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-402c46c4a04so9491665e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Sep 2023 06:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693834096; x=1694438896;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8BbS0VR+viLE45lChE7wLN6LwznzmsTUr7hWT6afTU=;
        b=NjrZN0e0ZcTfSWyhbqeZMYWG047E3GZsYzZLGStk6+m8cY+/x5JKExuBmIAMVpqIyw
         BTwTTUjmWNBb4mODbtTbaYKf/ZiUGSKwHkWi3lM261Ai1zmzjgGRtRJ6Y4gl3gsN2v7X
         +pVCQU2fhKyIYB7K52Q/H8BlgDWn+iqRAsQJ1dvQeXPJsKEg/gU6Bq/YwR4s35M0SIvs
         VTwgVPqbjirDBq/C59owi1W/jBimfmK2nqvQ1E91fCBSgfKxLEmAMij+O32FB5rnmaAY
         vw49g0LZyAIIrhbMCY9LiELZPy22+0ovXpe3TOLQ9BbTk5TNXUiRzvN0EgVY4PjD9lJt
         2FBA==
X-Gm-Message-State: AOJu0YxSgAU1s68gzvaVS4qY7vva3DaX5JavQKsb7iDFNcT0QtQWaFXU
        ZalVv/yaeIYEPjiBXGOyc0o9ClzRbejP7Oedq1pzNdeJHPLp600/KtHNkRmr5a4Ty66WAgh6/n4
        YS5UaHyl0uEyvk8yltfybxM0=
X-Received: by 2002:a05:600c:2945:b0:3fe:89be:cd3 with SMTP id n5-20020a05600c294500b003fe89be0cd3mr7455265wmd.22.1693834095942;
        Mon, 04 Sep 2023 06:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl7VfR/OsiuaD0NLKpcBP58yIezvg5tTwL4OjRo81CSensP8glNKF1MPDnFaTMcS52nY0Kpw==
X-Received: by 2002:a05:600c:2945:b0:3fe:89be:cd3 with SMTP id n5-20020a05600c294500b003fe89be0cd3mr7455246wmd.22.1693834095589;
        Mon, 04 Sep 2023 06:28:15 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p9-20020a1c7409000000b003fee53feab5sm14253513wmc.10.2023.09.04.06.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:28:15 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 7/8] staging/fbtft: Initialize fb_op struct as static const
In-Reply-To: <20230828132131.29295-8-tzimmermann@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-8-tzimmermann@suse.de>
Date:   Mon, 04 Sep 2023 15:28:14 +0200
Message-ID: <877cp6cbkh.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Replace dynamic allocation of the fb_ops instance with static
> allocation. Initialize the fields at module-load time. The owner
> field changes to THIS_MODULE, as in all other fbdev drivers.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


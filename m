Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9C2C7EE23
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 09:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbjFGJEa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbjFGJEG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 05:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23342213A
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686128505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dioh0Uh8M64nhVsxEDgz6W+eW/pWMCOha9EWfOMUYLQ=;
        b=VSEnU5gvIaJsiOBfsy2vUg5bvd4f2ul3+gFs81IdOAPJKyny02GvBDS0o2H1FaV7op1u2I
        BiHsvgJD3zsyy0lGng4iX2iWD11gVp9hBEukkTKiNT1PldWHJzX6b+W/YrJJaZI/hMdmEp
        GGGyn8Mz6Ix2m1oh3P7rHDeSxppToi0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-dFZp9yc2OWW5XnYfn3YQnA-1; Wed, 07 Jun 2023 05:01:43 -0400
X-MC-Unique: dFZp9yc2OWW5XnYfn3YQnA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7e6582938so46027775e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 02:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128503; x=1688720503;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dioh0Uh8M64nhVsxEDgz6W+eW/pWMCOha9EWfOMUYLQ=;
        b=Pres8fpFuEBWdjI6BlFbkor00kz9+1XF0sV+OMJkwV76Um80HUEb9uqIOqqHNPaBzG
         OpFqPrQdT3iWg++GQGHH1k+CFiU7LuNmZ3XHuROJzImvrBAXU9Lls1wgZQ1PINizZFkM
         H6iTK7iOdhWsEg+TcMBo6v5ZsyVuxfa6mbW7ugDcRBx8L4u5e6YXjoF6/TXMRYW7fsii
         clSi8tlFFw4Zt5lIobLGxF/ax/vt+6JuqSe5G54a7W06sit/jChC6MErvbwqeuxyiIBb
         risKyvRkinU69+BfKRLL+KLmj5k7kZkKm++tuFW41BntEF2z2n4Qsl5hN3p6r2eTfgUF
         5UnQ==
X-Gm-Message-State: AC+VfDy0P2zGWUn/FiJz+2byqwLmeeJrecPb+5sUv3gCRymlG5xvWYsX
        DaEnG2hocY6izflxJuGeX0vJsWnXm7DhJzDEKOCmLCSt/2QuIDboPf1ir87D9Mc6JITSoQg2rGL
        nZo9Nxw+bnv8Va6sKHkymCJw=
X-Received: by 2002:a05:600c:22c4:b0:3f7:f398:e1cc with SMTP id 4-20020a05600c22c400b003f7f398e1ccmr353835wmg.36.1686128502806;
        Wed, 07 Jun 2023 02:01:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72JJUmKTY0S/fTapCQpRDv/nnMwi2EWc1cCGgNDHz8vB5pxi81zoyZxiDc07QRDM6iPj/yxA==
X-Received: by 2002:a05:600c:22c4:b0:3f7:f398:e1cc with SMTP id 4-20020a05600c22c400b003f7f398e1ccmr353823wmg.36.1686128502608;
        Wed, 07 Jun 2023 02:01:42 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600000cc00b003093a412310sm14814796wrx.92.2023.06.07.02.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:01:42 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 13/30] fbdev/metronomefb: Use hardware device for dev_err()
In-Reply-To: <20230605144812.15241-14-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-14-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:01:41 +0200
Message-ID: <87cz27fxxm.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Replace the use of the fbdev software device, stored in struct
> fb_info.dev, with the hardware device from struct fb_info.device
> in load_waveform(). The device is only used for printing errors
> with dev_err().
>
> This change aligns load_waveform() with the rest of the driver and
> prepares fbdev for making struct fb_info.dev optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


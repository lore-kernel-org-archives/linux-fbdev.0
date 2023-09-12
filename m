Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6269CA0EC9
	for <linux-fbdev@archiver.kernel.org>; Tue, 12 Sep 2023 05:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjILFCv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 12 Sep 2023 01:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjILFCf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 12 Sep 2023 01:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3643110E4
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Sep 2023 22:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694494831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KBYVlpWMITOsO8/eEhkKH02de2tgqvU0jkM3B7miSKo=;
        b=BZjMg5MRfv2zup9q2qodnsCjD/Yg9//AI7O574nLMZ/P0+L31LXEwZ9nsc/czOwxu1ANgI
        1ouFQtrXSv4OWK+PtWulCmqzGxzivFPgeoa81Or9cfmvDFA7WUJJzFx41VtccQ5WEG8d2q
        vhBrJWJwSyEdQL2BKeF8wu7MKGYfh1g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-YxsRsNx_MdKnFslFCUftyw-1; Tue, 12 Sep 2023 01:00:29 -0400
X-MC-Unique: YxsRsNx_MdKnFslFCUftyw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31fb093a53aso860828f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Sep 2023 22:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494828; x=1695099628;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBYVlpWMITOsO8/eEhkKH02de2tgqvU0jkM3B7miSKo=;
        b=GeN+zPuV8EoTWqJ+wJ6poaOMSE//X5mHX1UKNy0RCh9Wxx3sbmp9Nso4DReZCI8Vsm
         D5idKBAaQpcew7K9G63idSZwyPqVkv3eHSLFeymNO4wi14GnyYu18yGy2FwJdJ/uPnPw
         Bji6mAJ4I/28rweoyjGn3RV0NZ4DWfzqyksEFvqepuNyrEo4jt/4eVjLjNdKU+kDCVvF
         Z1WQNUT8BQ6wMYyCNJUTu2a+JQ2JzOCyl7N0fcLQsCSXniZx/e/v1dabOJebHtF2VuwX
         9FJiIpuMJtADk1aqpEAugJIRtdZlL2GL2Ik3XWaHq1N240B1mNuLdH5qAQY8VrtCuieQ
         Hi+g==
X-Gm-Message-State: AOJu0YxfXieR12aMaSsK3BudX7s+JbKpKJfLgtQqLM/d299XB6gQA2B1
        eCXJcXeXRBDQTwc44XRlxHgqKXzVcJvkHxIS3M1HqMuUTdMP30CVbS8vU4EGx7MmyMSDf0S0Bcw
        HWZTUYXyPhVtxwpbcoO/Ur+k=
X-Received: by 2002:adf:ee02:0:b0:314:ca7:f30b with SMTP id y2-20020adfee02000000b003140ca7f30bmr7820197wrn.54.1694494828506;
        Mon, 11 Sep 2023 22:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUyYAM7TBdlujCiSnUR3HeMzMNBXcohDAKrKZsjMPscI7/naNL7SNtLI/kz3HDLp+0iUGfaw==
X-Received: by 2002:adf:ee02:0:b0:314:ca7:f30b with SMTP id y2-20020adfee02000000b003140ca7f30bmr7820186wrn.54.1694494828222;
        Mon, 11 Sep 2023 22:00:28 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d6-20020adfef86000000b00317ddccb0d1sm11778844wro.24.2023.09.11.22.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 22:00:27 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] drm: fix up fbdev Kconfig defaults
In-Reply-To: <20230911205338.2385278-1-arnd@kernel.org>
References: <20230911205338.2385278-1-arnd@kernel.org>
Date:   Tue, 12 Sep 2023 07:00:26 +0200
Message-ID: <87fs3k2dg5.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

Hello Arnd,

> From: Arnd Bergmann <arnd@arndb.de>
>
> As a result of the recent Kconfig reworks, the default settings for the
> framebuffer interfaces changed in unexpected ways:
>
> Configurations that leave CONFIG_FB disabled but use DRM now get
> DRM_FBDEV_EMULATION by default. This also turns on the deprecated /dev/fb
> device nodes for machines that don't actually want it.
>
> In turn, configurations that previously had DRM_FBDEV_EMULATION enabled
> now only get the /dev/fb front-end but not the more useful framebuffer
> console, which is not selected any more.
>
> We had previously decided that any combination of the three frontends
> (FB_DEVICE, FRAMEBUFFER_CONSOLE and LOGO) should be selectable, but the
> new default settings mean that a lot of defconfig files would have to
> get adapted.
>
> Change the defaults back to what they were in Linux 6.5:
>
>  - Leave DRM_FBDEV_EMULATION turned off unless CONFIG_FB
>    is enabled. Previously this was a hard dependency but now the two are
>    independent. However, configurations that enable CONFIG_FB probably
>    also want to keep the emulation for DRM, while those without FB
>    presumably did that intentionally in the past.
>
>  - Leave FB_DEVICE turned off for FB=n. Following the same
>    logic, the deprecated option should not automatically get enabled
>    here, most users that had FB turned off in the past do not want it,
>    even if they want the console
>
>  - Turn the FRAMEBUFFER_CONSOLE option on if
>    DRM_FBDEV_EMULATION is set to avoid having to change defconfig
>    files that relied on it being selected unconditionally in the past.
>    This also makes sense since both LOGO and FB_DEVICE are now disabled
>    by default for builds without CONFIG_FB, but DRM_FBDEV_EMULATION
>    would make no sense if all three are disabled.
>
> Fixes: a5ae331edb02b ("drm: Drop select FRAMEBUFFER_CONSOLE for DRM_FBDEV_EMULATION")
> Fixes: 701d2054fa317 ("fbdev: Make support for userspace interfaces configurable")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks for fixing this and sorry that I missed the defaults changed.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


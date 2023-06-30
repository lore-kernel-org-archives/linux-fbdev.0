Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629F7EB64DC
	for <linux-fbdev@archiver.kernel.org>; Fri, 30 Jun 2023 20:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjF3UaW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 30 Jun 2023 16:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjF3UaV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 30 Jun 2023 16:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5AA3AAD
        for <linux-fbdev@vger.kernel.org>; Fri, 30 Jun 2023 13:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688156970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7z4+FJGtx+jfLkCNL8iZp50XQ8kawtYgJi/zo0dFBDw=;
        b=V+cKKrNcB018SeD0TX371GJ/vgV6j/X510pwIGR7ofg8sHhaiGdLLb/Oq83M4DZlro7S44
        OU1qPXZl6aPY2xHieddeLY3b/dnraGNbY1jasPkGnJYw67qVxKdQfI2lTfHqOsqmMYsO0m
        agZfeKztNSqNd2vtLJNM29AfaYpq5wo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-5TuPUF7gOD2r9o8lJDZ1Mg-1; Fri, 30 Jun 2023 16:29:26 -0400
X-MC-Unique: 5TuPUF7gOD2r9o8lJDZ1Mg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbb0c01e71so13296985e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 30 Jun 2023 13:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688156962; x=1690748962;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7z4+FJGtx+jfLkCNL8iZp50XQ8kawtYgJi/zo0dFBDw=;
        b=WSD5cAe8jULeLnhnr6G5NVdm1vqNwhK6qJ2k8BMzDMIDTX6SOdwNLwndEiCpfNGJZR
         PIh9ypcrMv/JtGaCUyDfv5ycJJRL+42QM98sxK2TuET9d/St3YTC/xDLdv4MgfD7ubPb
         Z9bseL5JN6JuIgz16xItIkmKGIPYue3DCPas3ijHnjwaG7QTkVc3QBCZmvq1rSQUc2Z8
         hZoHdgPWEqBocoLur9R3DT9slh5gCmD/9SQq9aIoqvbNEcE+JeZxcYXmvY497oQxBTrb
         C9CL03JklJ80dZ4fO6rW+QU81D16T5SmnJWzwF/gsEyedqs3k+Wgkv1j/J8LaOmWgWZk
         o3fA==
X-Gm-Message-State: AC+VfDyx71vg5ebWMnG8wwf7BgSDpLuvV3exb4nc3Q8F3x2Yvm7YAmJd
        F+Z5mWg+/cBDdEH2Rody4NreSEbYnp6HNLHaQ/kkG250Q7TrHI2oYyCw9qEc41lgeR2bgJL1kdm
        qxyXNJTiyb/fvHCB5f5d+PQ8=
X-Received: by 2002:a7b:c8c9:0:b0:3f8:fe2a:25c2 with SMTP id f9-20020a7bc8c9000000b003f8fe2a25c2mr2902277wml.38.1688156962807;
        Fri, 30 Jun 2023 13:29:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5t8O8YZhUAlsnULK6AfHeoTDYcnWUXH+rludG0BAB8MB7qDFkZFaO5oKC6zcLL0Qt4ESi3eA==
X-Received: by 2002:a7b:c8c9:0:b0:3f8:fe2a:25c2 with SMTP id f9-20020a7bc8c9000000b003f8fe2a25c2mr2902251wml.38.1688156962461;
        Fri, 30 Jun 2023 13:29:22 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n10-20020a1c720a000000b003fa96620b23sm15085928wmc.12.2023.06.30.13.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 13:29:21 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 0/2] Allow disabling all native fbdev drivers and only
 keeping DRM emulation
In-Reply-To: <ZJ8T/Fexkr9wEZoP@smile.fi.intel.com>
References: <20230629225113.297512-1-javierm@redhat.com>
 <ZJ8RY7ZUlryrPB50@smile.fi.intel.com>
 <878rc0etqe.fsf@minerva.mail-host-address-is-not-set>
 <ZJ8T/Fexkr9wEZoP@smile.fi.intel.com>
Date:   Fri, 30 Jun 2023 22:29:20 +0200
Message-ID: <875y74elsv.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Fri, Jun 30, 2023 at 07:38:01PM +0200, Javier Martinez Canillas wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > On Fri, Jun 30, 2023 at 12:51:02AM +0200, Javier Martinez Canillas wrote:
>> >> This patch series splits the fbdev core support in two different Kconfig
>> >> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
>> >> be disabled, while still having the the core fbdev support needed for the
>> >> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
>> >> disabling all fbdev drivers instead of having to be disabled individually.
>> >> 
>> >> The reason for doing this is that now with simpledrm, there's no need for
>> >> the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
>> >
>> > How does simpledrm works with earlycon=efi?
>> >
>> 
>> simpledrm isn't for earlycon. For that you use a different driver (i.e:
>> drivers/firmware/efi/earlycon.c). I'm just talking about fbdev drivers
>> here that could be replaced by simpledrm.
>
> So, efifb can't be replaced. Please, fix your cover letter to reduce false
> impression of the scope of usage of the simpledrm.
>

Nothing to fixup.

You are conflating the efifb fbdev driver (drivers/video/fbdev/efifb.c)
with the efifb earlycon driver (drivers/firmware/efi/earlycon.c). I'm
talking about the former (which can be replaced by simpledrm) while you
are talking about the latter.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


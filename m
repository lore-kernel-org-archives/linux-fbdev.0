Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BADEB64D7
	for <linux-fbdev@archiver.kernel.org>; Fri, 30 Jun 2023 12:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjF3Me2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 30 Jun 2023 08:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjF3Me1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 30 Jun 2023 08:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C120C1B4
        for <linux-fbdev@vger.kernel.org>; Fri, 30 Jun 2023 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688128416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g8RTn9EqhVA4WoU3sjJyfFdw9WjQDdZ+q4iTAZZl7DE=;
        b=FmqS+w0Ok2GAPyA5dNjTToWXe2W7a/0TX7MgrhWq80YW3lKE2abIlD3ma34zcdL1i5BHaY
        hdrVffG0FMg/bh+mZv6Mz3PzDHub3pTZbq7SxnqNfTpyswRtxKLDRoUWFO12AbocqAuY36
        j+vLpBeGG+kVaMtv6aFZwaVswaG3H1M=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-he642Uu_PdyDrh9STlpM-Q-1; Fri, 30 Jun 2023 08:33:33 -0400
X-MC-Unique: he642Uu_PdyDrh9STlpM-Q-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb1a5788f0so1817447e87.2
        for <linux-fbdev@vger.kernel.org>; Fri, 30 Jun 2023 05:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688128412; x=1690720412;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8RTn9EqhVA4WoU3sjJyfFdw9WjQDdZ+q4iTAZZl7DE=;
        b=OfAJ3sTkfoR+hX/UQGTpRZpDOd6gSvZUWSlVyRR3t6qi4SRoGyJWeuApEcF3gaW2JJ
         7Ob9Ccl280O4Tw07hNIKQpTZZNQi0g+wlDGKrXFJKLEFghPuhuUezK/RU9bvt9PySRHZ
         AoxiY4b2tp6cppOYzTOnsMqksS+MFQ8zKj63hJz4WCfj14roiLp6aeLb09y4yl8dB6NB
         TPoJmzBfzasAVhfdJuvItJeUCmmYhePPvsRhwjBOkiMqj7bIs796YSBg0sT2ucotonPr
         XOzLdtk2cv5PIvzjj4DdZofmnPwKS/6/JVjhvYHDWalAXBvnDFiWFEfJcri4qzP2GTgx
         /J1A==
X-Gm-Message-State: ABy/qLZsg0Bepo3cxsjuj+FI5aKELbxEf0pB4WO6foNvrur1VHZSywh0
        ubsZ6/hzGyKBbFMKqaVnmIRQJN+ClXZdH2hsEXnGLOmB+ahvLxX0fjW3tWHnryfGRgy+FAXU1dM
        xC/wRxCTxRVF/tFd6nUeHT2o=
X-Received: by 2002:a19:e01d:0:b0:4fb:7592:cc7a with SMTP id x29-20020a19e01d000000b004fb7592cc7amr1864472lfg.20.1688128412056;
        Fri, 30 Jun 2023 05:33:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEPcKIsx1PFyrX6glb99eed7uOYj0G9AORD207eHckxnKyQzVkzS+r7LJmJCOj1yiVBtwnBmg==
X-Received: by 2002:a19:e01d:0:b0:4fb:7592:cc7a with SMTP id x29-20020a19e01d000000b004fb7592cc7amr1864445lfg.20.1688128411633;
        Fri, 30 Jun 2023 05:33:31 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c22d500b003f9cb3c8958sm22023924wmg.3.2023.06.30.05.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 05:33:31 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
In-Reply-To: <d231d0fe-c5f5-073a-3b8c-9441e1674c24@suse.de>
References: <20230629225113.297512-1-javierm@redhat.com>
 <d231d0fe-c5f5-073a-3b8c-9441e1674c24@suse.de>
Date:   Fri, 30 Jun 2023 14:33:30 +0200
Message-ID: <87bkgxdt9h.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

Thanks a lot for your review.

> Hi Javier
>
> Am 30.06.23 um 00:51 schrieb Javier Martinez Canillas:
>> This patch series splits the fbdev core support in two different Kconfig
>> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
>> be disabled, while still having the the core fbdev support needed for the
>> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
>> disabling all fbdev drivers instead of having to be disabled individually.
>> 
>> The reason for doing this is that now with simpledrm, there's no need for
>> the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
>> now disable them. But it would simplify the config a lot fo have a single
>> Kconfig symbol to disable all fbdev drivers.
>
> I still don't get the point of this change. We've disabled the fbdev 
> drivers once. And they are off now and remain off.
>

Yes, but doing that means you have a bunch of these in your kernel config:

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_ARMCLCD is not set
...

I don't know how the kernel configuration management for the OpenSUSE
kernel package works, but at least in Fedora this translates to needing to
have a lot of explicit disable configurations in the form of:

$ cat redhat/configs/common/generic/CONFIG_FB_CIRRUS 
# CONFIG_FB_CIRRUS is not set

$ ls redhat/configs/common/generic/CONFIG_FB_* | wc -l
61

I want to get rid of all those and the goal of this series is to reduce
that configuration to only:

$ cat redhat/configs/common/generic/CONFIG_FB
# CONFIG_FB is not set

$ cat redhat/configs/common/generic/CONFIG_FB_CORE
CONFIG_FB_CORE=y

> The patchset now introduces FB_CORE, which just adds more options. But 
> you're not reducing the code or compile time or any thing similar.
>

No need for any redhat/configs/common/generic/CONFIG_FB_* because those
don't need to be explicitly disabled anymore since CONFIG_FB isn't set.

And the "Frame buffer hardware drivers" section in the .config goes away.

So it is a configuration simplification even when you can achieve the same
with the existing Kconfig symbols.

> I'd like to suggest a change to these patches: rather then making FB and 
> DRM_FBDEV_EMULATION depend on FB_CORE, make them select FB_CORE. That 
> will allow the DRM subsystem to enable framebuffer emulation 
> independently from framebuffer devices. If either has been set, the 
> fbdev core will be selected.
>

Yes, I guess that making it a non user-visible option makes sense. I'm
just wary of using select because I've bitten in the past by circular
dependencies when other symbol depends on it.

But I'm OK with that change and will do in v2.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


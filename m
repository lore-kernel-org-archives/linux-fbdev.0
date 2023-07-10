Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BD8EB64DC
	for <linux-fbdev@archiver.kernel.org>; Mon, 10 Jul 2023 08:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjGJIq4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 10 Jul 2023 04:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjGJIqw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 10 Jul 2023 04:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E291D1734
        for <linux-fbdev@vger.kernel.org>; Mon, 10 Jul 2023 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688978721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8Md5DxJ/DXNzZNPaIMm/A+OyRkUpEJ0KHRBY8+I9Hg=;
        b=KwxDryorXwPbK0TayX/PBjYP1TPa3VM38JyHMD5RlUVdb9dzCviP/5a/gG7bDbm6DeI6BQ
        rAasWOG63ZeoLRg3f6yOaQFM6jM14t72o3XeUmj34dHLyadp65uYPAbrHcGaAAHs8KwMMr
        vhF2VX7/gpJiDPTr9CvMnSNhshxDeF8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-xfzsNLq6MHyok1ew7aQ8IQ-1; Mon, 10 Jul 2023 04:45:17 -0400
X-MC-Unique: xfzsNLq6MHyok1ew7aQ8IQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b710c5677eso20676561fa.0
        for <linux-fbdev@vger.kernel.org>; Mon, 10 Jul 2023 01:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688978716; x=1691570716;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8Md5DxJ/DXNzZNPaIMm/A+OyRkUpEJ0KHRBY8+I9Hg=;
        b=ekIA60o+mXfJFrymAALCMqMaTXq1OolZ+DI/ksNPGN2z5iutcZtLZtA1SmrFHin1EI
         VJbrZE8e/vwUNDJWYYYfOLysfYGCRMnnZ2yRXBWHbNj+ERzBo8xc3XCaxR5NBn0WfwbK
         1bZfaa+VeYr8SUWAoCSGIgDT7Qc2+jxklUPPvgh6ChAJ8uF+VBabnFiwuxnZn4t+CruB
         2KYz70NmwdApZjKxgjJjvIO5dipExAeBz5wztWFZKHts1b0nhM4BEd0Ie+suPQQWFfU1
         1hEmFrDD6vKCIOov+ZQNDnqp0tun39r9wYq42uZr4QjDkkVyf8Csys7cdkDz9JABeEhq
         2Yhw==
X-Gm-Message-State: ABy/qLa0VGKz68zlL+LOteZb/QW27ZvgRfJwerhm1mVQeyBgUMULfJmp
        l7l+BZ//VA8zOaMoAnKHVPGsKTvHnR1BDgoKebV9O3VeptM4be6ymLiiayVKawq4mxQXx2JeS+n
        POIvc+s8c9xjKOcYRrT5aR98=
X-Received: by 2002:a2e:9d45:0:b0:2b4:6ca3:7747 with SMTP id y5-20020a2e9d45000000b002b46ca37747mr8749620ljj.28.1688978716100;
        Mon, 10 Jul 2023 01:45:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHBycuiZhcq3PBfEMMSqEg7n8D8wH0mWIJ/M8B+HzpOeS4E5z8EOtnuZXMLz/KbMGsmr/2rOw==
X-Received: by 2002:a2e:9d45:0:b0:2b4:6ca3:7747 with SMTP id y5-20020a2e9d45000000b002b46ca37747mr8749594ljj.28.1688978715728;
        Mon, 10 Jul 2023 01:45:15 -0700 (PDT)
Received: from localhost ([62.15.161.174])
        by smtp.gmail.com with ESMTPSA id c16-20020a7bc850000000b003fbb06af219sm9780811wml.32.2023.07.10.01.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 01:45:15 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        suijingfeng@loongson.cn, decui@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, kys@microsoft.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        kernel test robot <lkp@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-efi@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] fbdev/hyperv_fb: Include <linux/screen_info.h>
In-Reply-To: <20230710075848.23087-1-tzimmermann@suse.de>
References: <20230710075848.23087-1-tzimmermann@suse.de>
Date:   Mon, 10 Jul 2023 10:45:14 +0200
Message-ID: <87lefoi291.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Include <linux/screen_info.h> to get the global screen_info state.
> Fixes the following errors:
>
>>> drivers/video/fbdev/hyperv_fb.c:1033:10: error: use of undeclared identifier 'screen_info'
>     1033 |                 base = screen_info.lfb_base;
>          |                        ^
>    drivers/video/fbdev/hyperv_fb.c:1034:10: error: use of undeclared identifier 'screen_info'
>     1034 |                 size = screen_info.lfb_size;
> 	 |                        ^
>>> drivers/video/fbdev/hyperv_fb.c:1080:3: error: must use 'struct' tag to refer to type 'screen_info'
>     1080 |                 screen_info.lfb_size = 0;
> 	 |                 ^
> 	 |                 struct
>>> drivers/video/fbdev/hyperv_fb.c:1080:14: error: expected identifier or '('
>     1080 |                 screen_info.lfb_size = 0;
> 	 |                            ^
>    drivers/video/fbdev/hyperv_fb.c:1081:3: error: must use 'struct' tag to refer to type 'screen_info'
>     1081 |                 screen_info.lfb_base = 0;
> 	 |                 ^
> 	 |                 struct
>    drivers/video/fbdev/hyperv_fb.c:1081:14: error: expected identifier or '('
>     1081 |                 screen_info.lfb_base = 0;
> 	 |                            ^
>    drivers/video/fbdev/hyperv_fb.c:1082:3: error: must use 'struct' tag to refer to type 'screen_info'
>     1082 |                 screen_info.orig_video_isVGA = 0;
> 	 |                 ^
> 	 |                 struct
>     drivers/video/fbdev/hyperv_fb.c:1082:14: error: expected identifier or '('
>     1082 |                 screen_info.orig_video_isVGA = 0;
> 	 |                            ^
>     8 errors generated.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307101042.rqehuauj-lkp@intel.com/
> Fixes: 8b0d13545b09 ("efi: Do not include <linux/screen_info.h> from EFI header")
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com> (supporter:Hyper-V/Azure CORE AND DRIVERS)
> Cc: Haiyang Zhang <haiyangz@microsoft.com> (supporter:Hyper-V/Azure CORE AND DRIVERS)
> Cc: Wei Liu <wei.liu@kernel.org> (supporter:Hyper-V/Azure CORE AND DRIVERS)
> Cc: Dexuan Cui <decui@microsoft.com> (supporter:Hyper-V/Azure CORE AND DRIVERS)
> Cc: Helge Deller <deller@gmx.de> (maintainer:FRAMEBUFFER LAYER)
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Sui Jingfeng <suijingfeng@loongson.cn>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-efi@vger.kernel.org
> Cc: linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS)
> Cc: linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
> Cc: dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER)
> ---
>  drivers/video/fbdev/hyperv_fb.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F47C46CA1
	for <linux-fbdev@archiver.kernel.org>; Mon, 18 Sep 2023 09:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbjIRJcG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 18 Sep 2023 05:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240888AbjIRJbq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 18 Sep 2023 05:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7691010A
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Sep 2023 02:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695029459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K9mKfMs2axUjRk4VejYXL9YNHsofaFImODtn3an3J0Q=;
        b=HKnJ1Q1/Gmg8a2th+z+8irXMsfuEQTW+jOumgrPyD1+VaDEubvXo2+I+TowsWqYjyMhMRp
        PUHJlA7G50vaMsHLfvgIa7jxChI7k6KE9oI3rf9xbejy8PwcsMV4c+uEUH6ZKyWKujMcoV
        8m+WCqqMuuJl++W1oz0hNDD+74PS6sg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-gBWllRC1O7WgXvflOpgbxw-1; Mon, 18 Sep 2023 05:30:57 -0400
X-MC-Unique: gBWllRC1O7WgXvflOpgbxw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-321544abeeeso351665f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Sep 2023 02:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695029456; x=1695634256;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9mKfMs2axUjRk4VejYXL9YNHsofaFImODtn3an3J0Q=;
        b=gbq/HrSfJ58FxN8sEkXK14ZvQ3UD8QrywjX6M1JkFhQMBY8WyJUcIvSMUrwRTMYW39
         3WqlaRcUuyrDRcYH+xqGnj9YoiXmiY+0AAyTqQddtWivFfnAkIFvNxq8kB5AeEl7j8fx
         ZpvgDlbDDuseifYijMM08+IMUDlVs3rFZD6jknZH0zsRQPfnNbROhm3CqQxd1QqcrUWP
         f8Mesw03LSRRBFqNrPLqfPSQ+gPXze4lni2jg3bfpI+q958j8iNZTtkYsxqarxVt2cbG
         V0hRuhQVTZ/eEPzWOP6mhEz3QUI/QafcwqwqwcRyuExNelKCGiBf5FBvh3IKR3V17fj+
         j25Q==
X-Gm-Message-State: AOJu0Yw4msCA+rCajLyu0LGnQ4xSf7Iloq8jObkEKOoXhOiXHpyy4C1d
        /aQl7afyotFlsT/Dazmwnz8Mo8aZ0dchGrgOhhnk4CdmDaaxHtCIwroxI+BjkcNwG9nr7ZwLd4x
        TQmu4Pwmz/xVzrjg9PaNQTPg=
X-Received: by 2002:a5d:4152:0:b0:317:5182:7b55 with SMTP id c18-20020a5d4152000000b0031751827b55mr6601626wrq.42.1695029455962;
        Mon, 18 Sep 2023 02:30:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuVwKer/t6wO8e6EaqpLJk3xr8QAnbzNM6Ra4QUQXA+9orH05TCHII2aGbpDgbji3C7zRZ1Q==
X-Received: by 2002:a5d:4152:0:b0:317:5182:7b55 with SMTP id c18-20020a5d4152000000b0031751827b55mr6601614wrq.42.1695029455646;
        Mon, 18 Sep 2023 02:30:55 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q11-20020adff50b000000b0031c71693449sm12122610wro.1.2023.09.18.02.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:30:55 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        sam@ravnborg.org, arnd@arndb.de, rdunlap@infradead.org,
        glaubitz@physik.fu-berlin.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fbdev/sh7760fb: Depend on FB=y
In-Reply-To: <20230918090400.13264-1-tzimmermann@suse.de>
References: <20230918090400.13264-1-tzimmermann@suse.de>
Date:   Mon, 18 Sep 2023 11:30:54 +0200
Message-ID: <87o7hz4ylt.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Fix linker error if FB=m about missing fb_io_read and fb_io_write. The
> linker's error message suggests that this config setting has already
> been broken for other symbols.
>
>   All errors (new ones prefixed by >>):
>
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_probe':
>      sh7760fb.c:(.text+0x374): undefined reference to `framebuffer_alloc'
>      sh4-linux-ld: sh7760fb.c:(.text+0x394): undefined reference to `fb_videomode_to_var'
>      sh4-linux-ld: sh7760fb.c:(.text+0x39c): undefined reference to `fb_alloc_cmap'
>      sh4-linux-ld: sh7760fb.c:(.text+0x3a4): undefined reference to `register_framebuffer'
>      sh4-linux-ld: sh7760fb.c:(.text+0x3ac): undefined reference to `fb_dealloc_cmap'
>      sh4-linux-ld: sh7760fb.c:(.text+0x434): undefined reference to `framebuffer_release'
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_remove':
>      sh7760fb.c:(.text+0x800): undefined reference to `unregister_framebuffer'
>      sh4-linux-ld: sh7760fb.c:(.text+0x804): undefined reference to `fb_dealloc_cmap'
>      sh4-linux-ld: sh7760fb.c:(.text+0x814): undefined reference to `framebuffer_release'
>   >> sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0xc): undefined reference to `fb_io_read'
>   >> sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x10): undefined reference to `fb_io_write'
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x2c): undefined reference to `cfb_fillrect'
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x30): undefined reference to `cfb_copyarea'
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x34): undefined reference to `cfb_imageblit'
>
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309130632.LS04CPWu-lkp@intel.com/
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Agreed with your change.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


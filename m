Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4335BC88CB7
	for <linux-fbdev@archiver.kernel.org>; Tue, 13 Jun 2023 10:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241388AbjFMKiw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 13 Jun 2023 06:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbjFMKiv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 13 Jun 2023 06:38:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757B8127
        for <linux-fbdev@vger.kernel.org>; Tue, 13 Jun 2023 03:38:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30fc26affa9so1502776f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 13 Jun 2023 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686652728; x=1689244728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6d+VLj6m3MAAbwrIUd63IBRinbYN+a8k/C8reDLCUoA=;
        b=hgjHCdmVZj17ygZWDKclgn2+Ytse1qSnmaG4LRvuBitz3LJyh5HgOVAUSo0/r7wbdt
         fdSIKGBQtVODe5/DiwzNAY75tQn14eC3cn9Q2yhq2toPlE76Oa5oFJdV9l1XnL0YG0RH
         fxvfeGPQ4hK4wvvH1FIqK7kR5+J3EkpRC2wIwVTAmEGdctNMUqczSpR/pqHqlcdrvXNx
         w+5FbTeVgBNFZVVGyto35QUzWBVlGziPVY46F9DgTYoTMe+PwdW3jVov2buriiM7Vv2s
         PvmiMKy9I+IiUkPF6osBSwKSkROBznVLomANfzqMBfERLZUvUZy0htIwFzMk6D4nAIGS
         /3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686652728; x=1689244728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6d+VLj6m3MAAbwrIUd63IBRinbYN+a8k/C8reDLCUoA=;
        b=V3Gv3BjYCn5FrwA1z84/It5YwtWFYaiEr+k4ksFcjTPttbE6EOM/YbIRMG643jh8L8
         HD8PfIUDfA4wqu9fVd6+CLasCbRDNSju83pxjUiUIit7CkHSTw0hiGWWZLANIFRSWf0m
         bId1P5gSt+ySDwF5oyxJIPYO0RHXDj2RbJRm+8AplYNtXZLjjY30v5JjXaKRyoq8JDKs
         BSgSPv50aYcxJo/VSFhP8jt8URI+jl8JFRmO06w1xETIdqVEzDEsSXf+r4NIXC3AxPdH
         O/RCm17LrgSUYZJ/7d9/MEUkCHrGlSKL5rZrb6GDuEBVHlVZPNKotxYBVmh6ej5AJSSj
         zvRQ==
X-Gm-Message-State: AC+VfDwlGCWKjGHX2PB75UewBohHFDJuGUQwOi9svT4oVvPaSZtCnyVT
        qvr0IG2fZ87HnMsp7+4LU7rOsg==
X-Google-Smtp-Source: ACHHUZ5HGIJRgD5nl4Qh50NEPcobvGP0CTVSW1VYZZsJoGlj0SicoFaUzO4TaUafxBw4qtclMnMW2w==
X-Received: by 2002:a5d:6a0b:0:b0:309:46a4:6378 with SMTP id m11-20020a5d6a0b000000b0030946a46378mr5778964wru.12.1686652727984;
        Tue, 13 Jun 2023 03:38:47 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id f9-20020a5d6649000000b0030f9dc63ff1sm13001387wrw.88.2023.06.13.03.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:38:47 -0700 (PDT)
Date:   Tue, 13 Jun 2023 11:38:45 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        jingoohan1@gmail.com, dan.carpenter@linaro.org,
        michael.j.ruhl@intel.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 03/38] backlight/gpio_backlight: Compare against
 struct fb_info.device
Message-ID: <20230613103845.GC169438@aspen.lan>
References: <20230612141352.29939-1-tzimmermann@suse.de>
 <20230612141352.29939-4-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612141352.29939-4-tzimmermann@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jun 12, 2023 at 04:07:41PM +0200, Thomas Zimmermann wrote:
> Struct gpio_backlight_platform_data refers to a platform device within
> the Linux device hierarchy. The test in gpio_backlight_check_fb()
> compares it against the fbdev device in struct fb_info.dev, which
> is different. Fix the test by comparing to struct fb_info.device.
>
> Fixes a bug in the backlight driver and prepares fbdev for making
> struct fb_info.dev optional.
>
> v2:
> 	* move renames into separate patch (Javier, Sam, Michael)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 8b770e3c9824 ("backlight: Add GPIO-based backlight driver")
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: linux-sh@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v3.12+

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

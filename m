Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4CEC88CB4
	for <linux-fbdev@archiver.kernel.org>; Tue, 13 Jun 2023 10:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241379AbjFMKoE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 13 Jun 2023 06:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242000AbjFMKn4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 13 Jun 2023 06:43:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502FB124
        for <linux-fbdev@vger.kernel.org>; Tue, 13 Jun 2023 03:43:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30aea656e36so3744452f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 13 Jun 2023 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686653034; x=1689245034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lLutf+KjWhvbo43jAnwMCduq5kRauIVlF499sKJllbw=;
        b=Tebomd8VGnHhE+w+b5CDwdcS6jy9JR89a+qkbngyLC3vc5+twB5SNidRwHh8NSOpTS
         8eixPLK7D9svCm4RQ2GP30c3/796+q4cnYUMOlCy6c40JEPNXkEkS7wrcrdVaUEZSpBD
         gkFF/FftbPA51jZWmI0j8ob+kCrNOdaqU8QdhcbGMFklAApFOnRrXOxr1P5swptKYNSQ
         UhhygDT75/rVeDlcxd07SdAfiga5m8drWXG0wieQRnmDOEWbdLLPegxwmL+T0ifjxOY/
         WIT42o16znUkIkH3rckPRfxp5Zbb5kcGoo79bKSgFm5CR8AkMxcaCxCsJwB05IMDV3co
         1Cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686653034; x=1689245034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLutf+KjWhvbo43jAnwMCduq5kRauIVlF499sKJllbw=;
        b=G1L/tqFjYGGNDKtIyNm9zc3TwSYchJwLVdSs7wdBVsGz60CITw0QSrNZ6N90YFMBF/
         Kjktw1f3saPVSwYbNBVkFudal9BnkhqRhOdKrKKeeAEGSihp2PsIfR7zD0wJPh1hNJ6a
         X1oIVPlvrDnfQZzbNZ3keYwU1TAJ0snxY5B207iSIGiggqxTi1uN032DQ+qVnrWGxSZK
         FSmUODYCFlMmkT8sUHnqaP0RCLm4Lc7E7osklr1of9//HU2aRz9cU7+EquF86wEASLjf
         zxYvxbHzSqVz1wgKMOSqupF9v18Y78Bm0gv/9vImhstyTL8OU+07nLybfJnSnrswfmNF
         O/gQ==
X-Gm-Message-State: AC+VfDz9z8B+1Q9G1XA7To+8SyLLlgLgJhV8F5Dc1cepiL0f9iUQxk0x
        KuGjdBEbEaPNVUhhNfGmxrxH1Q==
X-Google-Smtp-Source: ACHHUZ68YtIfx45+cpnaYyoXbSrtLiflqoiv4n5LwHVoZuuqCHc2tdBqIZicnmX+p5XeiXBR68Vz0w==
X-Received: by 2002:a5d:4dd0:0:b0:306:43ad:b34e with SMTP id f16-20020a5d4dd0000000b0030643adb34emr6204325wru.18.1686653033700;
        Tue, 13 Jun 2023 03:43:53 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n7-20020adff087000000b0030ae5a0516csm14960636wro.17.2023.06.13.03.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:43:53 -0700 (PDT)
Date:   Tue, 13 Jun 2023 11:43:51 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        jingoohan1@gmail.com, dan.carpenter@linaro.org,
        michael.j.ruhl@intel.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 38/38] fbdev: Make support for userspace interfaces
 configurable
Message-ID: <20230613104351.GG169438@aspen.lan>
References: <20230612141352.29939-1-tzimmermann@suse.de>
 <20230612141352.29939-39-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612141352.29939-39-tzimmermann@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jun 12, 2023 at 04:08:16PM +0200, Thomas Zimmermann wrote:
> Add Kconfig option CONFIG_FB_DEVICE and make the virtual fbdev
> device optional. If the new option has not been selected, fbdev
> does not create files in devfs, sysfs or procfs.
>
> Most modern Linux systems run a DRM-based graphics stack that uses
> the kernel's framebuffer console, but has otherwise deprecated fbdev
> support. Yet fbdev userspace interfaces are still present.
>
> The option makes it possible to use the fbdev subsystem as console
> implementation without support for userspace. This closes potential
> entry points to manipulate kernel or I/O memory via framebuffers. It
> also prevents the execution of driver code via ioctl or sysfs, both
> of which might allow malicious software to exploit bugs in the fbdev
> code.
>
> A small number of fbdev drivers require struct fbinfo.dev to be
> initialized, usually for the support of sysfs interface. Make these
> drivers depend on FB_DEVICE. They can later be fixed if necessary.
>
> v2:
> 	* set FB_DEVICE default to y (Geert)
> 	* comment on {get,put}_device() (Sam)
> 	* Kconfig fixes (Sam)
> 	* add TODO item about FB_DEVICE dependencies (Sam)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  Documentation/gpu/todo.rst               | 13 ++++++++
>  drivers/staging/fbtft/Kconfig            |  1 +
>  drivers/video/fbdev/Kconfig              | 13 ++++++++
>  drivers/video/fbdev/core/Makefile        |  7 +++--
>  drivers/video/fbdev/core/fb_internal.h   | 38 ++++++++++++++++++++++++
>  drivers/video/fbdev/omap2/omapfb/Kconfig |  2 +-
>  include/linux/fb.h                       |  2 ++
>  7 files changed, 72 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index 68bdafa0284f5..f226f934ca5af 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -452,6 +452,19 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>
>
>  Level: Starter
>
> +Remove driver dependencies on FB_DEVICE
> +---------------------------------------
> +
> +A number of fbdev drivers provide attributes via sysfs and therefore depend
> +on CONFIG_FB_DEVICE to be selected. Review each driver and attempt to make
> +any dependencies on CONFIG_FB_DEVICE optional. At the minimum, the respective
> +code in the driver could be conditionalized via ifdef CONFIG_FB_DEVICE. Not
> +all drivers might be able to drop CONFIG_FB_DEVICE.
> +
> +Contact: Thomas Zimmermann <tzimmermann@suse.de>
> +
> +Level: Starter
> +
>
>  Core refactorings
>  =================
> diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
> index 4d29e8c1014e0..5dda3c65a38e7 100644
> --- a/drivers/staging/fbtft/Kconfig
> +++ b/drivers/staging/fbtft/Kconfig
> @@ -2,6 +2,7 @@
>  menuconfig FB_TFT
>  	tristate "Support for small TFT LCD display modules"
>  	depends on FB && SPI
> +	depends on FB_DEVICE
>  	depends on GPIOLIB || COMPILE_TEST
>  	select FB_SYS_FILLRECT
>  	select FB_SYS_COPYAREA
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index f82357d4f84da..19eaca5e04283 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -57,6 +57,16 @@ config FIRMWARE_EDID
>  	  combination with certain motherboards and monitors are known to
>  	  suffer from this problem.
>
> +config FB_DEVICE
> +	bool "Provide legacy /dev/fb* device"
> +	depends on FB
> +	default y
> +	help
> +	  Say Y here if you want the legacy /dev/fb* device file and
> +	  interfaces within sysfs anc procfs. It is only required if you
> +	  have userspace programs that depend on fbdev for graphics output.
> +	  This does not effect the framebuffer console. If unsure, say N.

Nitpicking but this *is* documentation so:
s/effect/affect/


Daniel.

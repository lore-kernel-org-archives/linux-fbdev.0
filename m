Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2D84039;
	Thu,  1 Jan 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767273429; cv=none; b=SnSxci3fJ9WMSkYVnieojQSoTj2vYYN04L3sfGD9v3xqwoFDQzJYXSZHqGv0scK9oPsc1CGK+nqQ26ewEkza/eQNXN010T7DVcbwKAc69NcCUW18nOphjNNsV9KZjpgbIcSXOMnJWYsM9PzCA0rnIVxLhpdt+sLzEnShKxwOZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767273429; c=relaxed/simple;
	bh=Skja5y5X+v166ojjcRNolfjfHMhaHlAIATFHcsiMej8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAXLSc9A1fVfnOOnIKzPc48a3C8Hk6oNqr2k/FebJRMA2LeLsNiCBIsNcAxp+kborkPs8MzJuz7uvC11gvPKWI9LqBlegdl13s5ohnzAFtpNJzsdQ4z+CIRELusfx0hFC+CXqHl7xSOE8anODDQDVT/RHUFmHeUiPI03Dho4rbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAzACEN7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAzACEN7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD5BC4CEF7;
	Thu,  1 Jan 2026 13:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767273426;
	bh=Skja5y5X+v166ojjcRNolfjfHMhaHlAIATFHcsiMej8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jAzACEN7FVv2AX4inqHPyyhoWFddeVrNvWL3IyVqd8nLg8LE8+40ia9XDcYbINai6
	 TXy3ySu2d6fi6BPniNA4ZcBpSgK0cZVmVM5NPHuPkyFpgA8ZObJhULoyf4G4o3eNRv
	 H+pqZS+tvy5Dako/Wib4tJFRAiCVMzeh2Q2s0ROrTrbqc4rVrPo6eTThRS1/GuIT4l
	 /SRwlrPRKcHmimq7g8CQI5XFy/7FIN5VKt30BbwhnbxhpaNB+U7xPo0IXAxLGdNS0f
	 nkfrVQX3L/ANc27SoHIN7KvXIj9CwiN96of263+5VXlmQLqo82wlAYCpI0zwBb+9VI
	 Dunc+n2NA8Ixg==
Message-ID: <55f6c9c7-b55e-43db-a787-bdd55cce654e@kernel.org>
Date: Thu, 1 Jan 2026 14:17:02 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] video/logo: move logo selection logic to Kconfig
To: Helge Deller <deller@gmx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
References: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
 <20251230-custom-logo-v1-6-4736374569ee@kernel.org>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20251230-custom-logo-v1-6-4736374569ee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Happy new year!

On 30/12/2025 at 23:20, Vincent Mailhol wrote:
> Now that the path to the logo file can be directly entered in Kbuild,
> there is no more need to handle all the logo file selection in the
> Makefile and the C files.
> 
> Move all the logo file selection logic to Kbuild, this done, clean-up
> the C code to only leave one entry for each logo type (monochrome,
> 16-colors and 224-colors).
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
>  drivers/video/logo/Kconfig  | 49 +++++++++------------------------------------
>  drivers/video/logo/Makefile | 21 +------------------
>  drivers/video/logo/logo.c   | 46 ++++--------------------------------------
>  include/linux/linux_logo.h  |  9 ---------
>  4 files changed, 14 insertions(+), 111 deletions(-)
> 
> diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
> index 1d1651c067a1..9bf8f14c6856 100644
> --- a/drivers/video/logo/Kconfig
> +++ b/drivers/video/logo/Kconfig
> @@ -25,6 +25,7 @@ config LOGO_LINUX_MONO
>  config LOGO_LINUX_MONO_FILE
>  	string "Monochrome logo .pbm file"
>  	depends on LOGO_LINUX_MONO
> +	default "drivers/video/logo/logo_superh_mono.pbm" if SUPERH
>  	default "drivers/video/logo/logo_linux_mono.pbm"
>  	help
>  	  Takes a path to a monochromatic logo in the portable pixmap file
> @@ -42,6 +43,7 @@ config LOGO_LINUX_VGA16
>  config LOGO_LINUX_VGA16_FILE
>  	string "16-color logo .ppm file"
>  	depends on LOGO_LINUX_VGA16
> +	default "drivers/video/logo/logo_superh_vga16.ppm" if SUPERH
>  	default "drivers/video/logo/logo_linux_vga16.ppm"
>  	help
>  	  Takes a path to a logo in the portable pixmap file format (.ppm),
> @@ -61,6 +63,13 @@ config LOGO_LINUX_CLUT224
>  config LOGO_LINUX_CLUT224_FILE
>  	string "224-color logo .ppm file"
>  	depends on LOGO_LINUX_CLUT224
> +	default "drivers/video/logo/logo_dec_clut224.ppm" if MACH_DECSTATION || ALPHA
> +	default "drivers/video/logo/logo_mac_clut224.ppm" if MAC
> +	default "drivers/video/logo/logo_parisc_clut224.ppm" if PARISC
> +	default "drivers/video/logo/logo_sgi_clut224.ppm" if SGI_IP22 || SGI_IP27 || SGI_IP32
> +	default "drivers/video/logo/logo_sun_clut224.ppm" if SPARC
> +	default "drivers/video/logo/logo_superh_clut224.ppm" if SUPERH
> +	default "drivers/video/logo/logo_spe_clut224.ppm" if SPU_BASE
>  	default "drivers/video/logo/logo_linux_clut224.ppm"
>  	help
>  	  Takes a path to a 224-color logo in the portable pixmap file
> @@ -71,44 +80,4 @@ config LOGO_LINUX_CLUT224_FILE
>  
>  	    magick source_image -compress none -colors 224 destination.ppm
>  
> -config LOGO_DEC_CLUT224
> -	bool "224-color Digital Equipment Corporation Linux logo"
> -	depends on MACH_DECSTATION || ALPHA
> -	default y
> -
> -config LOGO_MAC_CLUT224
> -	bool "224-color Macintosh Linux logo"
> -	depends on MAC
> -	default y
> -
> -config LOGO_PARISC_CLUT224
> -	bool "224-color PA-RISC Linux logo"
> -	depends on PARISC
> -	default y
> -
> -config LOGO_SGI_CLUT224
> -	bool "224-color SGI Linux logo"
> -	depends on SGI_IP22 || SGI_IP27 || SGI_IP32
> -	default y
> -
> -config LOGO_SUN_CLUT224
> -	bool "224-color Sun Linux logo"
> -	depends on SPARC
> -	default y
> -
> -config LOGO_SUPERH_MONO
> -	bool "Black and white SuperH Linux logo"
> -	depends on SUPERH
> -	default y
> -
> -config LOGO_SUPERH_VGA16
> -	bool "16-color SuperH Linux logo"
> -	depends on SUPERH
> -	default y
> -
> -config LOGO_SUPERH_CLUT224
> -	bool "224-color SuperH Linux logo"
> -	depends on SUPERH
> -	default y
> -
>  endif # LOGO
> diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
> index ac8e9da3f51a..c32238fddaa6 100644
> --- a/drivers/video/logo/Makefile
> +++ b/drivers/video/logo/Makefile
> @@ -5,16 +5,6 @@ obj-$(CONFIG_LOGO)			+= logo.o
>  obj-$(CONFIG_LOGO_LINUX_MONO)		+= logo_linux_mono.o
>  obj-$(CONFIG_LOGO_LINUX_VGA16)		+= logo_linux_vga16.o
>  obj-$(CONFIG_LOGO_LINUX_CLUT224)	+= logo_linux_clut224.o
> -obj-$(CONFIG_LOGO_DEC_CLUT224)		+= logo_dec_clut224.o
> -obj-$(CONFIG_LOGO_MAC_CLUT224)		+= logo_mac_clut224.o
> -obj-$(CONFIG_LOGO_PARISC_CLUT224)	+= logo_parisc_clut224.o
> -obj-$(CONFIG_LOGO_SGI_CLUT224)		+= logo_sgi_clut224.o
> -obj-$(CONFIG_LOGO_SUN_CLUT224)		+= logo_sun_clut224.o
> -obj-$(CONFIG_LOGO_SUPERH_MONO)		+= logo_superh_mono.o
> -obj-$(CONFIG_LOGO_SUPERH_VGA16)		+= logo_superh_vga16.o
> -obj-$(CONFIG_LOGO_SUPERH_CLUT224)	+= logo_superh_clut224.o
> -
> -obj-$(CONFIG_SPU_BASE)			+= logo_spe_clut224.o

Removing the logo_spe_clut224.o target was a mistake. This removes the
logo_spe_clut224 object which is still being referenced in

  arch/powerpc/platforms/cell/spu_base.c

The Cell processor (found, for example in the PS3) has a unique
feature in the kernel: it will not only show the standard penguin
logos for each of the core, but also show an extra line of logos for
each of its SPE core. More details with a screenshot here:

  Link: https://lore.kernel.org/all/20070710122702.765654000@pademelon.sonytel.be/

And indeed, on a ps3_defconfig, I am getting this build error:

    CC      arch/powerpc/platforms/cell/spu_base.o
  arch/powerpc/platforms/cell/spu_base.c: In function 'init_spu_base':
  arch/powerpc/platforms/cell/spu_base.c:775:39: error: 'logo_spe_clut224' undeclared (first use in this function); did you mean 'logo_linux_clut224'?
    775 |                 fb_append_extra_logo(&logo_spe_clut224, ret);
        |                                       ^~~~~~~~~~~~~~~~
        |                                       logo_linux_clut224

This extra logo feature is a weird beast only used by a single CPU. I
will just restore the logo_spe_clut224.o target in v2 and leave it
untouched.

I checked and the other logo objects are not being referenced anymore
throughout the kernel.


Yours sincerely,
Vincent Mailhol

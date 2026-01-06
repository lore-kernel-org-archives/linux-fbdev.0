Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C51818A93F;
	Tue,  6 Jan 2026 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767730225; cv=none; b=FGvc4JSogj0VHNs3z2TlMciOoozpwMMhqjC2II7C7fZ+VMGZ2R07DcE0p09Qfk9yNsn+bjpgYWx+yEqro7QkZuDiiwr3U0z2O0ntdSF8qs4K7PFbPM4QahM3O9P6uS80Aj6ArlJIBE2ChmgMYcscHyJ3txf5Xu2s3E9QdKnhh5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767730225; c=relaxed/simple;
	bh=fw85eJeqFzn2Gmp3rDsA60cIlrejZWMm6fXN5BHjh9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXp7C608VTpXQtgUSOWivlMI2MpX11KK0dfYPRsiAfGH8HTKQZEZ4zqzrv4cBt4GkdwI0DBSWLIu9/KSb9TZsj8VSf43IsFsWX2j5Bypy+tXZc2D7SAUL90rOm5n94pYcg35T+H3qXD3kfUzZmoMJP4p/Jr3j35CXSSc7LNt/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1gl8q2P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1gl8q2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC50C116C6;
	Tue,  6 Jan 2026 20:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767730224;
	bh=fw85eJeqFzn2Gmp3rDsA60cIlrejZWMm6fXN5BHjh9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c1gl8q2PKWXPiOLoF+ybDhPI+ydAdQmROQe0hYeoVT898khgHnV/fR4fwyX7YsPes
	 1RPlGlWCYRLR572ddZW0c7X5Wn+3NNTHyeOdsGKxkbG46KxzzhMijEnMszd/0p+WZy
	 b7rbJNmT70yJ2uiUepn+dRkTr/MvfkcSFBuNBCU4qmb87PyYYw6ITSsIa4UWz2IQZR
	 3ZOlAiZ4YjJuppMbC8ToA5LXC9QmmCWqHlOpNP6Wnjxe7i1KERmNeKgzZFwvTiJEpH
	 bNBSc3BLaX1nL3+ISWmlvZPKQCU5K1wXfNU1H7ptsgwHgr6uLnlW0fd+aKoQI2RGHq
	 HedZquYuIKQtg==
Message-ID: <dda4052e-b843-43fa-850c-a1bb20e4a8e3@kernel.org>
Date: Tue, 6 Jan 2026 21:10:19 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] video/logo: move logo selection logic to Kconfig
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Helge Deller <deller@gmx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org>
 <20260101-custom-logo-v2-6-8eec06dfbf85@kernel.org>
 <CAMuHMdVy48F5HAfqfJgbY83KDAztb9YWTqm8mT1ntTfj0311oA@mail.gmail.com>
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
In-Reply-To: <CAMuHMdVy48F5HAfqfJgbY83KDAztb9YWTqm8mT1ntTfj0311oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/01/2026 at 12:48, Geert Uytterhoeven wrote:
> Hi Vincent,
> 
> CC linux-m68k
> 
> Thanks for your patch, which is now commit bd710b3da7308cb1
> ("video/logo: move logo selection logic to Kconfig") in fbdev/for-next.
> 
> On Thu, 1 Jan 2026 at 16:26, Vincent Mailhol <mailhol@kernel.org> wrote:
>> Now that the path to the logo file can be directly entered in Kbuild,
>> there is no more need to handle all the logo file selection in the
>> Makefile and the C files.
> 
> This may do the wrong thing when booting a multi-platform kernel.
> 
>>
>> The only exception is the logo_spe_clut224 which is only used by the
>> Cell processor (found for example in the Playstation 3) [1]. This
>> extra logo uses its own different image which shows up on a separate
>> line just below the normal logo. Because the extra logo uses a
>> different image, it can not be factorized under the custom logo logic.
>>
>> Move all the logo file selection logic to Kbuild (except from the
>> logo_spe_clut224.ppm), this done, clean-up the C code to only leave
>> one entry for each logo type (monochrome, 16-colors and 224-colors).
>>
>> [1] Cell SPE logos
>> Link: https://lore.kernel.org/all/20070710122702.765654000@pademelon.sonytel.be/
>>
>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> 
>> --- a/drivers/video/logo/Kconfig
>> +++ b/drivers/video/logo/Kconfig
> 
>> @@ -61,6 +63,12 @@ config LOGO_LINUX_CLUT224
>>  config LOGO_LINUX_CLUT224_FILE
>>         string "224-color logo .ppm file"
>>         depends on LOGO_LINUX_CLUT224
>> +       default "drivers/video/logo/logo_dec_clut224.ppm" if MACH_DECSTATION || ALPHA
>> +       default "drivers/video/logo/logo_mac_clut224.ppm" if MAC
> 
> E.g. an m68k multi-platform kernel including Mac support will scare
> non-Mac users into thinking their machine was assimilated by the
> Apple Empire...
> 
>> +       default "drivers/video/logo/logo_parisc_clut224.ppm" if PARISC
>> +       default "drivers/video/logo/logo_sgi_clut224.ppm" if SGI_IP22 || SGI_IP27 || SGI_IP32
>> +       default "drivers/video/logo/logo_sun_clut224.ppm" if SPARC
>> +       default "drivers/video/logo/logo_superh_clut224.ppm" if SUPERH
>>         default "drivers/video/logo/logo_linux_clut224.ppm"
>>         help
>>           Takes a path to a 224-color logo in the portable pixmap file
> 
>> --- a/drivers/video/logo/logo.c
>> +++ b/drivers/video/logo/logo.c
>> @@ -48,59 +48,21 @@ const struct linux_logo * __ref fb_find_logo(int depth)
>>         if (nologo || logos_freed)
>>                 return NULL;
>>
>> -       if (depth >= 1) {
>>  #ifdef CONFIG_LOGO_LINUX_MONO
>> -               /* Generic Linux logo */
>> +       if (depth >= 1)
>>                 logo = &logo_linux_mono;
>>  #endif
>> -#ifdef CONFIG_LOGO_SUPERH_MONO
>> -               /* SuperH Linux logo */
>> -               logo = &logo_superh_mono;
>> -#endif
>> -       }
>>
>> -       if (depth >= 4) {
>>  #ifdef CONFIG_LOGO_LINUX_VGA16
>> -               /* Generic Linux logo */
>> +       if (depth >= 4)
>>                 logo = &logo_linux_vga16;
>>  #endif
>> -#ifdef CONFIG_LOGO_SUPERH_VGA16
>> -               /* SuperH Linux logo */
>> -               logo = &logo_superh_vga16;
>> -#endif
>> -       }
>>
>> -       if (depth >= 8) {
>>  #ifdef CONFIG_LOGO_LINUX_CLUT224
>> -               /* Generic Linux logo */
>> +       if (depth >= 8)
>>                 logo = &logo_linux_clut224;
>>  #endif
>> -#ifdef CONFIG_LOGO_DEC_CLUT224
>> -               /* DEC Linux logo on MIPS/MIPS64 or ALPHA */
>> -               logo = &logo_dec_clut224;
>> -#endif
>> -#ifdef CONFIG_LOGO_MAC_CLUT224
>> -               /* Macintosh Linux logo on m68k */
>> -               if (MACH_IS_MAC)
> 
> MACH_IS_MAC can be a runtime check.

OK. I missed this.

I think there are two options to fix this:

  1. Keep CONFIG_LOGO_MAC_CLUT224 untouched
  2. Remove logo_mac_clut224.ppm

The first option is less controversial but I would like to ask you what
you think about removing the logo_mac_clut224 file.

Here, we are speaking of the Macintosh 68k which ended sales in 1995,
right? So the user base should be rather small, I guess.

And people who still want the custom MAC logo would still be able to add

  CONFIG_LOGO_MAC_CLUT224="path/to/logo_mac_clut224.ppm"

to their config to restore the old behaviour anyway.

My choice would go more toward the removal option but what do you think?


>> -                       logo = &logo_mac_clut224;
>> -#endif
>> -#ifdef CONFIG_LOGO_PARISC_CLUT224
>> -               /* PA-RISC Linux logo */
>> -               logo = &logo_parisc_clut224;
>> -#endif
>> -#ifdef CONFIG_LOGO_SGI_CLUT224
>> -               /* SGI Linux logo on MIPS/MIPS64 */
>> -               logo = &logo_sgi_clut224;
>> -#endif
>> -#ifdef CONFIG_LOGO_SUN_CLUT224
>> -               /* Sun Linux logo */
>> -               logo = &logo_sun_clut224;
>> -#endif
>> -#ifdef CONFIG_LOGO_SUPERH_CLUT224
>> -               /* SuperH Linux logo */
>> -               logo = &logo_superh_clut224;
>> -#endif
>> -       }
>> +
>>         return logo;
>>  }
>>  EXPORT_SYMBOL_GPL(fb_find_logo);


Yours sincerely,
Vincent Mailhol


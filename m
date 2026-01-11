Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7D2853EE;
	Sun, 11 Jan 2026 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768166764; cv=none; b=tschnSd0VRD0SHWnxOJCj02SG3ch4ped4dspyyV4XAbf/8jyxwaEieS/8DCbWXrB07PEtMwwXuAXcJ/fyZKvG/XwzzFlQgyZ+Xdi+imomX7ONjZ7NmMs9MLgToi36N0tNUMmenZg+bbZkedWZq7+MSbGcDUqHm6a5l6O+ZKn1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768166764; c=relaxed/simple;
	bh=s5jblEsCOIT04MrKBnvGy+lMBUADNsEWPlmYaB1oizw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpMu8dcyvuzeMbK4BTlu0b1WRn5dpjKBAe9JtEwdSmZZ4uveWT6EKGakx5Pk1L4tz0ke/0/L9yjk4jwx3U1ZeE0qfjaCgsGi4+XWFEuTmxE94TwAogn3BTEiVo3AouNLGiT7VW8NyXN+AsgvQVvrxc6+VqNlOIuUk3ujW8picLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEMmQ9B4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEMmQ9B4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C44FC4CEF7;
	Sun, 11 Jan 2026 21:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768166763;
	bh=s5jblEsCOIT04MrKBnvGy+lMBUADNsEWPlmYaB1oizw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YEMmQ9B48yZVuinyjMHjUqxfDHVeaANWrveeR9+MqDl2gf9oDVLQLJqVqbvtnx2ft
	 es+NoYldiPk14hdmjahePyEKCYLhWL3mc8YUezSlapO3OkurIRCgsIgyf6o4f/+s4z
	 OD5+/qZAUNj9FHKOsqVqI1bwTCzOLksxWWGzTl06LLScKTGCPsTDQ17sLxnmtgOURh
	 3pKr/qyZlhSC5mg4m6aNoaT5Nsu2mFlBLmjWOf20TtYVbyL1KHCI4dG645vefIpIQD
	 +edg2g3zNKgTtiHTARvsHQ0fnawUcYvkobvnKVW49QOm4iOaCf+RYsCqg2d6hCct+F
	 Kudgg+mggqjcw==
Message-ID: <db3cacfb-cd10-495b-b761-96ee6d7ee95a@kernel.org>
Date: Sun, 11 Jan 2026 22:25:59 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video/logo: don't select LOGO_LINUX_MONO and
 LOGO_LINUX_VGA16 by default
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260110-mono_and_vga16_logos_default_to_no-v1-1-30f36da979b4@kernel.org>
 <d48231e4-6c69-4948-99a9-121cd17e2db0@gmx.de>
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
In-Reply-To: <d48231e4-6c69-4948-99a9-121cd17e2db0@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/01/2026 at 20:12, Helge Deller wrote:
> On 1/10/26 13:23, Vincent Mailhol wrote:
>> Nowadays, nearly all systems have a color depth of eight or more and
>> are thus able to display the clut224 logo. This means that the
>> monochrome and vga16 logos will never be displayed on an average
>> machine and are thus just a waste of bytes.
>>
>> Set CONFIG_LOGO_LINUX_MONO and CONFIG_LOGO_LINUX_VGA16 configuration
>> symbols to no by default.
> 
> I agree, that on basically every system today there is no need for the
> monochrome or VGA16 logo.
> But I'm not sure about the historic/exotic platforms, e.g. m68, sparc
> and so on.
> 
> So, maybe instead of dropping the default "y", we should e.g. do:
> +    default y if SUPERH

SUPERH also has a clut224 logo, so I assume we can also default to no
for it.

> +    default y if XYZ (some other architecture/platform) ???
> +    default n  (for all others)
> 
> The question is: Which arches may have needed the VGA16 or monochrome logo?

My wild guess would be none. Furthermore, no one "needs" a logo. It is
just a fun thing to add. This is why the LOGO sub menu is turned off by
default and that none of the defconfig would automatically select a LOGO.

And so, because a user interaction is needed anyway, the few who still
want a monochrome or vga16 logo can turn the option back on just after
selecting the LOGO sub-menu.

I guess the same could be said in reverse: we could keep all the logo on
by default as it is now and the users who only need the clut224 can turn
off the monochrome and vga16. But let's go for the majority ;)

Well, if someone can come with the list you are looking for, I will
happily add it to the patch. We can wait for a couple weeks if you want,
no rush here!

Or your can already stage it in fbdev-next and I will send you a v2 as
needed. Maybe we will get more comments if this reaches linux-next?


Yours sincerely,
Vincent Mailhol


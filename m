Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44B2777E0;
	Wed, 31 Dec 2025 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767163605; cv=none; b=iBGGbpOeARjE+WtIM5xSTNtjzBRlt5BpTjveEYAunMzpH3u7AK3vweEA5eGsJu1bloMn6cKuVTshj+mYdlxpW4im9dkgJJvurdqaaSWdYFUNb28fztg83e5wCWtDTz+LvICQCJWKBISauklGymX9brDpUAKgUkYi3HY4clySmmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767163605; c=relaxed/simple;
	bh=QpQpiIjMgAqmAOmtydj8BNOPhOz9nWYymZ8gOyeJv+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIEjNQUoPKBA9+aFkAmpopWg1aBFIxFY/TJmmor7Nm0j3j474Z0iilg7gVq8bZo7yLZp0zuFn2WunZ0zDbVWne8W+s+1sbrNsRwt4EHOuxTR2eAyG7GeJBWAakZY5mvlqEJarXoq4CLVxS49KVtokKUzOE6ZGGLEr1fSEFI7WZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntXMmUJA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntXMmUJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3916C113D0;
	Wed, 31 Dec 2025 06:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767163605;
	bh=QpQpiIjMgAqmAOmtydj8BNOPhOz9nWYymZ8gOyeJv+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ntXMmUJAxO5H8srGF4tNdHgo0lFMwkrc1fuFBV00J5Tb+WM/T7R4u9JOqctNUZQJ9
	 XYxl5+6LClFAMnewT84dKC1wdD+L79lms4e7jJI4B4VRIxvVk2wh2RzN/kfoBQ9zvQ
	 vrajgYUrYswv2oj5VfBfcCLGHqZVOUHJM9Bs/2yQIXICCypPBdj14NXNB4lM76yYbj
	 3WP6S9UtMNNFKDrShzihHTivi5+OaTM8HRj6TmoWmoIqcaiL8YXJS2olROD3vsiwPM
	 wq+5LcGZxXeY3d9OSMaJQUJCY2ZOsqjtPZsDyuyJA7RN+y8l5QIgTHuscvyfK+PDFN
	 /r6pVdO9HecjA==
Message-ID: <0949ad6f-d703-47c9-8681-c64f17da07ac@kernel.org>
Date: Wed, 31 Dec 2025 07:46:40 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] video/logo: allow custom boot logo and simplify logic
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Helge Deller <deller@gmx.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
References: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
 <12a2ee5ca1a085fe0bd0c1b2d6e08589445cbf66.camel@physik.fu-berlin.de>
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
In-Reply-To: <12a2ee5ca1a085fe0bd0c1b2d6e08589445cbf66.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/12/2025 at 00:19, John Paul Adrian Glaubitz wrote:
> Hi Vincent,
> 
> On Tue, 2025-12-30 at 23:19 +0100, Vincent Mailhol wrote:
>> This series allows the user to replace the default kernel boot logo by
>> a custom one directly in the kernel configuration. This makes it
>> easier to customise the boot logo without the need to modify the
>> sources and allows such customisation to remain persistent after
>> applying the configuration to another version of the kernel.
> 
> Wouldn't it make more sense to make the boot logo to be configurable
> at runtime so that users don't have to rebuild their kernel at all
> to change their boot logo?

I thought about that. The problem is that the logo is loaded really
early in the boot process. To be able to modify the logo without
rebuilding the full kernel, the logo would basically need to become a
kernel module that would be stored in either an initrd or on the filesystem.

The above is not impossible, but would require delaying the logo.

If we go in that direction, I think that my series as it is right now
would be a prerequisite anyway. Personally, I am happy with the logo
just being configurable when compiling the kernel, so I do not intend to
put more effort into this afterward. However, that would have prepared
the ground if anyone wants to implement in the future what you just
suggested.


Yours sincerely,
Vincent Mailhol


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D25273D6F;
	Fri,  2 Jan 2026 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767374726; cv=none; b=jtw/UKznYbVbLVagL0erwc/jB3vQ+zC5V85vkHX9PepcnLws1g8V7UpKHetnKjHbKDunE8r9tB9/8mMaJLrf+hsQYAhfvtc8xQv96zvycgZxqPGCwi8qPMwzme+kAEEgTQOh59r8ETaUyZxbe2QXLPl+BG+hnfjQfV6kDa1Hbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767374726; c=relaxed/simple;
	bh=kvvC6Qfv6P9WmeJ9eiyxpvWUaffcud2t3Ti1L74sy7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0llSwmxBXRDvQ9E0xqmng0+EKdgEFWSk27Fiykjdw58+dZhIGeVz1m7Ewgbh0c6mzriYwRLgybBs74VvYnNprQQk9GcDqzU5gf0POkixwL3m8hCwKqDSR0A0jgLOD+/ffpGXTK7VUAbCWW3X1s58SbSKsjaZi2SN+8ob60lKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDxUeQQP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDxUeQQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9C3C19421;
	Fri,  2 Jan 2026 17:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767374725;
	bh=kvvC6Qfv6P9WmeJ9eiyxpvWUaffcud2t3Ti1L74sy7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GDxUeQQPPTy8OXTI4yr/g+F2Iy+RpCmOn2j2WHPOkeu5+ZBJ8ZB+JNBfN+AU9u/WY
	 ENmSusyy7LlsNG6RsviOfy2yT4Ma/cPPqmrF5CgtB+JeMwpqBykRtPhyxhwqAuO5lw
	 /aSWN6SKJFcLePujiZ8nNoKGIIX3GEeKBaxe6cEXMHr77doc4CHTWwOjmglQEjbJ1W
	 vE4CeKN5j5BBtGcxL78lzMr6X4OgbZPINIJZHFOV+Q51HPgynaHDNGeEUm594JgVBW
	 JBWHOda9tUOz8R7htU0U8th3B6twL5mbQsqK/Bcih+sHplV1K7Mhe1nubY3KUgY87a
	 wHj6nZ/hpfQDA==
Message-ID: <d20c6baa-bd1f-4de7-afa7-0abb99e3bcb5@kernel.org>
Date: Fri, 2 Jan 2026 18:25:20 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] video/logo: remove orphan .pgm Makefile rule
To: David Heidelberg <david@ixit.cz>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
 Helge Deller <deller@gmx.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
 <20251230-custom-logo-v1-1-4736374569ee@kernel.org>
 <e04c9862-761f-4f36-b978-b760d2a0a928@ixit.cz>
 <d1c1d037-7be8-49a3-81d7-59d33efba81b@kernel.org>
 <ec760546-b320-4b14-a792-916ec552a3ea@ixit.cz>
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
In-Reply-To: <ec760546-b320-4b14-a792-916ec552a3ea@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/01/2026 at 18:18, David Heidelberg wrote:
> On 02/01/2026 18:13, Vincent Mailhol wrote:
>> On 02/01/2026 at 17:34, David Heidelberg wrote:
>>> On 30/12/2025 23:20, Vincent Mailhol wrote:
>>>> The kernel has no actual grey-scale logos. And looking at the git
>>>> history, it seems that there never was one (or maybe there was in the
>>>> pre-git history? I did not check that far…)
>>>>
>>>> Remove the Makefile rule for the .pgm grey scale images.
>>>
>>> Great to see this series.
>>
>> Thanks!
>>
>>> I think the Fixes: tag should still go here, even if it is not very
>>> specific.
>>
>> But then, what do I put in the fixes tag? This:
>>
>>    Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>
>> ?
> 
> Yes
> 
>>
>> I am not sure it is worth bothering the stable team for something that
>> isn't causing any real harm.
> 
> That was my original thinking as well, but the Fixes tag is not only
> about stable backports. It is also used for tracking, tooling, and
> documentation, so stable picking up such patches is just one of its
> purposes.

OK. Then why not. I added the tag in my local tree, but I will wait a
couple days for the other review comments before sending. I will not
spam everyone with a v3 just for that.


Yours sincerely,
Vincent Mailhol


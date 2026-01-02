Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446672C15B4;
	Fri,  2 Jan 2026 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767374331; cv=none; b=jZOobztrc9DHE+EZNlsXvX9JhbBHgw9tEJrm+Z3L/0HBukoWJpe45UCx606IyoSlP+VGKCdM5kWXiitR7MiHIjf+hqGq6mEVF6cu3hP0SKxzmvCS0Px+ay2ZK5lv8V4da2QLRJ855KkHQ3GMnFYQwsg2BeFwFOGukNpuY9LesfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767374331; c=relaxed/simple;
	bh=1E9We0nFmU1toA5DlV2iSCVX1FuJwtMdFE0FQXgkHFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=HefP8H3bmuohMqHuTJEUjjxUQa8b8ikk63ZPLl/viu9AO1mve/e7t6MRcvUaPLrsFpuJK48s+87lGx8HBpiiaAZINRmMyV3hIJgz29qYb44d0/5pgbcPA2fVMF/pnePaidItN7p9InNV2uKBM6bcJS2TkFMyju7EzABNilJs5YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueHS8s1p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueHS8s1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CB4C116B1;
	Fri,  2 Jan 2026 17:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767374330;
	bh=1E9We0nFmU1toA5DlV2iSCVX1FuJwtMdFE0FQXgkHFg=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=ueHS8s1pt/vb3iEbtNDP9TnLQLRTfGB64gzgTnM2jjTHNz5l4vPQmbyoY1j/3WePq
	 xnCKnFNmcEn0/kviWN2ECPRW8EO8J9BCAvTM1FtSHBFeyMlUuG4+IyPVbRpOgg+k/m
	 3hrNU2ptyEQT9y4yZ2QKmFQLjcJcgNXIXWP/sKDLESgdKKum4lM9rHC9bq4j3GqJBM
	 B+RSulfPtQBgS9aiZEVjRrCCZ7kbJhrPC5GLaqYMUdY64Yi/IVzp5nIioXjQBmomgd
	 +AqVypTgS4iuqCAlzhAkCQvmvCq7iSAyjGXsnxSrlqQX2wkRCtnjdlEleZRO3JoFAG
	 kyOOxiKsMNEPA==
Message-ID: <71446537-a2a0-4051-8e4d-20256bf17824@kernel.org>
Date: Fri, 2 Jan 2026 18:18:45 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] video/logo: allow custom boot logo and simplify logic
To: Markus Reichelt <ml@mareichelt.com>
References: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
 <20260102163053.GE26548@pc21.mareichelt.com>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Cc: Helge Deller <deller@gmx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260102163053.GE26548@pc21.mareichelt.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/01/2026 at 17:30, Markus Reichelt wrote:
> * Vincent Mailhol <mailhol@kernel.org> wrote:
> 
>> This series allows the user to replace the default kernel boot logo by
>> a custom one directly in the kernel configuration. This makes it
>> easier to customise the boot logo without the need to modify the
>> sources and allows such customisation to remain persistent after
>> applying the configuration to another version of the kernel.
> 
> Hah! What I have been doing for so many moons is to just cp my own logo
> 'logo_linux_clut224.ppm' -> 'drivers/video/logo/logo_linux_clut224.ppm'
> for each custom kernel build - that works like a charm.
> Maybe... I'm too pragmatic? It's that famous 'kill bill' logo from ages
> ago, 224 colors PPM

I was doing the same! I then started a rework a couple years ago to
implement this idea.. At that time, I was less experienced and did not
fully understood Kbuild. The result worked but was ugly and stayed in my
local tree.

This winter holidays, I had a bit of free time, revisited my old idea,
and this time, found something I thought was worth upstreaming. Thus
this series.

> Haven't tested your patch series cos stuff just works for me.
> Looking forward to feedback from all those logo nerds out there.

Looking forward for your Tested-by tag!


Yours sincerely,
Vincent Mailhol


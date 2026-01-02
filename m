Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA8191F94;
	Fri,  2 Jan 2026 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767390881; cv=none; b=FUF4hnx+d54N5Q9uBdpdm8HxTNmMlYpAAoYmy3lxzs6w1PsGvKa/O5EpDJilOLGNleT0qnbUs4is6Dhr3dyYlJJiJ+nZZpEW0BRP1TU+5sLwFsup1udFcwrXTZ50g0i9AjvQtbJ4exQNu1mIUGr5xfTP9gUJn1FTlNBvj6FX1sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767390881; c=relaxed/simple;
	bh=fZhjcNdpKA/3s74Xfhpo6iC9TGgzcsA+YHpOK1tEpFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDFj/7UdxhrJDsV6zTjoY8exCQRUorHItt/TUUMALaV8+ZP1DkgiDl8TH0gBlUpfAERNkFmm75lkCr6XS3rtDWqWz80NXT/ASn7fWbEb3qfTXTUo3qlaQ6hBVLHlDYprBxJa/a57IUoc8nWn0OKOsN/UxBO9lqZcCEwZgQSRMhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBxSst9t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBxSst9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADADC116B1;
	Fri,  2 Jan 2026 21:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767390881;
	bh=fZhjcNdpKA/3s74Xfhpo6iC9TGgzcsA+YHpOK1tEpFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aBxSst9tfD8ocKpLfHUjxhNAK030wia66yBOCwtBfItdOm3hajc+xpK9nlaMTswr0
	 oCU5vg/NbpMBuvhHEczmHLQDewsH71MFcq1LvZfxvASRtX/+ah2TV1kFiYf2HHMiDY
	 9oMbZO40PGNvjR2nzFyiPm7MBYEz4Pb7eJQwMHhS40hz5CmUmekYP6zZv/RrfpicPx
	 nGBj3xwGl7iGbkIU5mvnSVh6ccD/RQk2Q6/XaTv1qPyBNEM/Q85LOQuEmjj+RPSUGF
	 vWekUK+/Qt8Lf96ChZcagUnGMiruJ/ndUH+Bc1PKN4BdevaEjFnVRuojrD+dLbF+//
	 CfgDuIGH/JsfQ==
Message-ID: <cd012433-4285-425a-84a7-f52897057d41@kernel.org>
Date: Fri, 2 Jan 2026 22:54:36 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] newport_con: depend on LOGO_LINUX_CLUT224 instead of
 LOGO_SGI_CLUT224
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
 <20251230-custom-logo-v1-4-4736374569ee@kernel.org>
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
In-Reply-To: <20251230-custom-logo-v1-4-4736374569ee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/12/2025 at 23:20, Vincent Mailhol wrote:
> newport_show_logo() is only activated if CONFIG_LOGO_LINUX_CLUT224 is
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^
This should have been CONFIG_LOGO_SGI_CLUT224. But that's only a typo in
the patch description.

@Helger, do you want me to send a v3 or can you directly apply the typo
fix in your linux-fbdev/for-next branch?

> set (otherwise it is a NOP). This configuration value will be removed
> in an upcoming change so instead, make it depend on LOGO_LINUX_CLUT224.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0A222599;
	Fri,  2 Jan 2026 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767383726; cv=none; b=TxAQ5U4qM326xGpgHz2kKaANp6qLk9quf6+fA9+fxVQr4ggyTnFMSEunYIzNbh58apHPYzu7kKr9xeX2t1/or6EEj/6JuQcxtgfuj93wNDsI0npRhh3oDSs0Tx/M1Eon/m/1dyeHLpo7QREnGxaFfTDrboxX/utXVKf2G3b2wtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767383726; c=relaxed/simple;
	bh=fdzRTxYd/8fmC6E2ix6d2vlYTiXxFbzTh9K6C3MRL4U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K/K9wa7bZrbqKY24Vl6sIcxNEBlQSX9k+5igRvqtQweZ+v/kv3eWXjM46YXZsktM42bWl6bL3x9G711kYaLposbuicJgNxwYQL57K3jr8Qxx0wHG2hqXW5zt8xNcnZZlaLY+J/l/5E0dXmEgseIdDpZMAvPaoazpeKsfleumjzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwOIPmre; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwOIPmre"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8DCC116B1;
	Fri,  2 Jan 2026 19:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767383725;
	bh=fdzRTxYd/8fmC6E2ix6d2vlYTiXxFbzTh9K6C3MRL4U=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=XwOIPmre24NB2/ps9S9LNtzPJQYlhHhk0YSog0nBIedNk7YdYpBMSu3/4rnT8jOs/
	 9Fn1NUJBv8SeRVGjT9PqvQLI0kmpo00xnNr4cuJ196IIMgTCv8P0kxAKtqD6NFsBsH
	 Cwxmp87efdurqu/UXOXGmwB/naLJAknRsK+UEjrVZYV7wgZ7GAEH00jF8XX0LthptV
	 eTUcpqme2knOvYsTtVfYH0A+oodCsoxOi44SZXF/QI1Ue2BsKXVCCQMlArxaCM4HSo
	 Gf808ynrS7rZ1pt6e8cIC7IYMcRex5qXgBp7a5O5VG7PQdMk1Bo3ieFJqg4vVkqiR2
	 IIwOnLBL4M0DQ==
Message-ID: <633a3a65-4f13-4a4a-9e6b-92301ea81b47@kernel.org>
Date: Fri, 2 Jan 2026 20:55:20 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] video/logo: allow custom boot logo and simplify logic
From: Vincent Mailhol <mailhol@kernel.org>
To: Markus Reichelt <ml@mareichelt.com>
Cc: Helge Deller <deller@gmx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
References: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
 <20260102163053.GE26548@pc21.mareichelt.com>
 <71446537-a2a0-4051-8e4d-20256bf17824@kernel.org>
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
In-Reply-To: <71446537-a2a0-4051-8e4d-20256bf17824@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/01/2026 at 18:18, Vincent Mailhol wrote:
> On 02/01/2026 at 17:30, Markus Reichelt wrote:

(...)

>> Haven't tested your patch series cos stuff just works for me.
>> Looking forward to feedback from all those logo nerds out there.
> 
> Looking forward for your Tested-by tag!

D'oh, I misread your message. When my brain parsed your text, I read it as:

  Haven't tested your patch series cos work stuff…

As if you were too busy with your work to test it now.


Yours sincerely,
Vincent Mailhol


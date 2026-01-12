Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9A280A58;
	Mon, 12 Jan 2026 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768213891; cv=none; b=aL7FrvCP2EXacChG1cn0p157MjUGxFS4AY8N5U3/09EyHA9iQ7QmZJcuyUoRE7CjhKLrmHBQ3OrKo/3cA1ctOFMqGwxMY91cglA3MdKcS5ZeqTzPtdmnmvvgq9UdDwuCh6736kepn2XKXGR2drdGYrqh06PadMgJ0YKMAQV7daw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768213891; c=relaxed/simple;
	bh=achdYpePb5Ag4HNfkw+wiZcXGWvngtwTk3SjBa5kfDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNFCBZY/LyCO6K92nHVfd2MeirPGWnBUgsrOPwZ2MSwKCerwXBKa4D+cXwGL4LE8762Mol8OfUakYqWNfLGlug9xbdljVdWQxs1lk7Sda7jWPQlHNI7V/tP0D2KupH1CxIeIUOLwtbT8rIndpiPVlEZfNarVnFiPSKwNNfZNAzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wm4vWG/e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wm4vWG/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD08CC16AAE;
	Mon, 12 Jan 2026 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768213891;
	bh=achdYpePb5Ag4HNfkw+wiZcXGWvngtwTk3SjBa5kfDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wm4vWG/ewTi4x+6VoLyklXdqwu/4i5fNRTTkAHd/JSglTRWj5xIXVmyVK34Odi7Ei
	 zcrBYQsreF8KTbT0/54omeiyRQVwxWP0oHqRWuPiykexxG0SqSm0lorYTxxEzcOchl
	 gY5uT4uiaN+XpFEXWHHsaBxoxbnGV6uhMCqbG7vQ=
Date: Mon, 12 Jan 2026 11:31:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Karthikey Kadati <karthikey3608@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Unix Antigravity <unix.antigravity@test.com>
Subject: Re: [PATCH 1/4] staging: sm750fb: Convert sw_i2c_read_sda to return
 bool
Message-ID: <2026011212-strongbox-snore-e1cc@gregkh>
References: <20260112102502.19761-1-karthikey3608@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112102502.19761-1-karthikey3608@gmail.com>

On Mon, Jan 12, 2026 at 03:55:02PM +0530, Karthikey Kadati wrote:
> The sw_i2c_read_sda function currently returns unsigned char (1 or 0).
> 
> Standardize it to return bool (true or false) to match kernel standards.
> 
> Signed-off-by: Unix Antigravity <unix.antigravity@test.com>

You have to be a legal person to sign off on a patch, with a valid email
address :(

Also, your patches were a patch series, but not connected to each other,
nor were they related.  I see them in my inbox as:
   1   T Jan 12 Karthikey Kadat (2.0K) [PATCH 4/4] staging: atomisp: Replace ia_css_region with v4l2_rect
   2   T Jan 12 Karthikey Kadat (2.4K) [PATCH 2/4] staging: octeon: Remove port status typedefs
   3   T Jan 12 Karthikey Kadat (9.1K) [PATCH 3/4] staging: atomisp: Remove input_system typedefs
   4   T Jan 12 Karthikey Kadat (1.1K) [PATCH 1/4] staging: sm750fb: Convert sw_i2c_read_sda to return bool

But not threaded, so that's a bit odd.  Perhaps you didn't use git
send-email for these?

thanks,

greg k-h

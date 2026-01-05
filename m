Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B43128BE;
	Mon,  5 Jan 2026 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767604354; cv=none; b=jIHQECzTz8VlOYq5PjAizFoa3bauhAkr7dILWuggVGnqn4Rr2RmglspyfMBbfLwBODCWM8nX1ghGGc7Y53Pv0llYD5fPNLUK9ZjMGqmpuF3eSTF5tT2kiwdSOa9xtp56zGdphCRejUepZG0YCNglog7u8hwG9RjKA996t5dVvkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767604354; c=relaxed/simple;
	bh=C1W9fhxW+cUNMF7uiOONv8Z5SsvysSW3gf1k1fchxsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K12BYasCVPweCEpW8F5VG9j8gxigi7yz2u5pMTpi5hwBah8uzv7xkSc91HWC6ThU0HCOZBcpUx+Qzjrf3PlOzj2Z+6oTlZ7EIQYeOgbegGFAsvrsTpRnf5hOwkCTCS9m3iCI+MNVwiJMhsmZo5sfuxHW0zR+uUx9cIiGyxkkx1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0QrqJXdy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0QrqJXdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255DAC116D0;
	Mon,  5 Jan 2026 09:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767604353;
	bh=C1W9fhxW+cUNMF7uiOONv8Z5SsvysSW3gf1k1fchxsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0QrqJXdyG9H25q8C1UEzy0ortPamAS8mDa++XynbWKs98Z7kY4MX9CegkgDuec7YD
	 5rH4QGvO3ppox96pZOcF1gznK2iQ4S+xjDb4S9Vy+oFTnX8y7vjUXKSj4k24hfPmuL
	 uXBqik97J/q77Hiw2mVqQBC1IbgxgyVerqDqRmIA=
Date: Mon, 5 Jan 2026 10:12:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: linux-staging@lists.linux.dev, sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: fix unused tmp in sw_i2c_wait
Message-ID: <2026010555-surely-uncheck-bac2@gregkh>
References: <20260105021026.556244-1-sun.jian.kdev@gmail.com>
 <20260105074917.607201-1-sun.jian.kdev@gmail.com>
 <2026010505-surging-resurface-a7d3@gregkh>
 <CABFUUZHRz919=C=fmMqH1sQcURbm+qiQB795xWPCd9Rax_M4ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABFUUZHRz919=C=fmMqH1sQcURbm+qiQB795xWPCd9Rax_M4ZQ@mail.gmail.com>

On Mon, Jan 05, 2026 at 04:57:48PM +0800, sun jian wrote:
> Hi Greg,
> 
> Sorry about that — I mistakenly replied only to you.
> 
> As you pointed out, sw_i2c_wait() sits on the bit-banged I2C GPIO
> transitions, so changing the delay semantics without hardware validation
> is risky. I don't have access to the hardware to validate timing/behavior,
> and I can't justify that udelay(1) is equivalent to the existing loop.
> 
> Please ignore v2 (and v1). I won't resend a warning-only workaround.
> 
> If someone with the hardware can help validate a proper fix (e.g. a
> well-justified time-based delay, or reworking this to use a proper I2C
> bit-banging helper), I'm happy to revisit.

A time-based one is going to be the correct solution as every cpu will
run that "let's count some numbers" loop at a different speed :(

thanks,

greg k-h

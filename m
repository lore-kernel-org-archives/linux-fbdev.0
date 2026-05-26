Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBC43AE704;
	Tue, 26 May 2026 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812511; cv=none; b=qx00vq9pECUxVdzbp3lMoZ8b8px6Af9z55FjRZW1jYL3kzkmyaq7DHTaxN/hf+4JiX2lkGGHJhOQ2mnPYJRZ8p+eGLmU3izRXNEKqBj3OXpVnIwviD60GvHlfnQDk3F8F/JJoboIAgNkc+EMA8Iwivcv/MVEaR7EO0QUJ6QvrfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812511; c=relaxed/simple;
	bh=Vn1QNejWOmdwHf1YX/e1RHPQ6d7CJkarXW6LJSwW6I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noRrCGdSc6TSgwqNvHkmsEas3uaEDcn8AXj8MfqWE9jBAt5GkiBpuueqg2+j25zwj/PEpzLTk0Dfo7vzjHcCasHVF6cFr+Y5ZoXKApGIwt4Q4O8CLW/v4vYamxsbOC8npmnyqPWpOei5XrzIdjija2idguJnZN+GUrrSOT3FG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xEvkgsxB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xEvkgsxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B3F1F000E9;
	Tue, 26 May 2026 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779812510;
	bh=xwRSJlscEwLalAgr5GspEYDs8S8ptrjiKAWpnKJuDDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=xEvkgsxBONIpHNP9YiscNZXqEu7VMDhPYzjoPAyuJOjkqcNk63KZg8ZIwBzlMJQjE
	 /l1hwtVw+SX1CZQpFeR0az8GONGf7vX4AjMfgHIKdKY2g08XmNTj0tHcFZmGu4+Axe
	 CmUoeDHYq/qJlpHAkjvLtpNa+evDHgqGpffu3NFU=
Date: Tue, 26 May 2026 18:20:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Emmanuel Arias <eamanu@riseup.net>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] staging: sm750fb: fix CamelCase variables name in
 sm750
Message-ID: <2026052623-cause-region-02e3@gregkh>
References: <20260526131631.1237672-1-eamanu@riseup.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526131631.1237672-1-eamanu@riseup.net>

On Tue, May 26, 2026 at 10:16:31AM -0300, Emmanuel Arias wrote:
> Replace CamelCase variable name with snake_case:
> - pvReg -> pv_reg

Why are you keeping the "pv_"?  What does that mean?

> - setAllEngOff -> set_all_eng_off
> 
> Reported-by: kernel test robot <lkp@intel.com>

The test robot told you to make this change?

> Closes: https://lore.kernel.org/oe-kbuild-all/202605171049.KbaBnrJV-lkp@intel.com/
> Signed-off-by: Emmanuel Arias <eamanu@riseup.net>
> ---
>  drivers/staging/sm750fb/sm750.c    |  6 +++---
>  drivers/staging/sm750fb/sm750.h    |  4 ++--
>  drivers/staging/sm750fb/sm750_hw.c | 12 ++++++------
>  3 files changed, 11 insertions(+), 11 deletions(-)

What changed from v1?

thanks,

greg k-h

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034CB331A5B;
	Tue,  7 Jul 2026 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415308; cv=none; b=u2tzN76RNZGqGsxeDQ6Xr3g6eLPwG0iUUPEyod2xOE6UrakX5qcfRacXtxheQ3hgpo93mQ4CIUqVxJy0ecYp8xhI3NnO3arjh8C577+tft99p3q4iQR7X3k7Foharw2Ok20lPM5J1b3Pj+x9HbAJcJSG62ZiKo5SjtllGfvRDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415308; c=relaxed/simple;
	bh=zlhtgNkVnWqwGdtNZ6NiYL3PwfGWarfzXXU1qtH1JQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVZqSmmwg6EDq7covNtAvTPapcdlh6tNvRZttt1e4VS5VJKP5NLDgAzgBrG9r/LnnYLQA1CIvWrWKcRl4AHsQcvTWJSMAkwYEvF6ErlnE23vXBWd1WLGd6/Jsb5Z8cHMnPxIf5GXENgznqJZ41DGciFIoql4zjRMAg6CdOrq72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xm2wKfnj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xm2wKfnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E291F000E9;
	Tue,  7 Jul 2026 09:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783415306;
	bh=FKzvUY0CEml5/qgLfDuQEA4KzMAzFatcf8H2zjBdtHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xm2wKfnjx38h+PRMWdDWA1OqB5w8Vl0ybrZcHbIXh9ogyI3C9ap0bJIcaXB6EqXqv
	 wOJHDXmGbtbfiSJI9cEEKJYAsSUqOhH+bl9art3e8fq4MszOi3Z7F8im4pP6cbFDTc
	 S7PQsT1q05soAxOiNHuzLxhD5vL34Jc8t0cCBeBI=
Date: Tue, 7 Jul 2026 11:08:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michail Tatas <michail.tatas@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: sm750fb: rename pvReg to pv_reg
Message-ID: <2026070759-registrar-kilometer-f8ff@gregkh>
References: <cover.1779661132.git.michail.tatas@gmail.com>
 <fae018f80f61acea030d9893f3085998a78e4edf.1779661132.git.michail.tatas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fae018f80f61acea030d9893f3085998a78e4edf.1779661132.git.michail.tatas@gmail.com>

On Mon, May 25, 2026 at 02:15:38AM +0300, Michail Tatas wrote:
> Rename variable pvReg to pv_reg as per
> the Linux coding standards

But "pv_reg" is not a correct name, right?  It's still in "hungarian"
notataion, which is not what we use in the kernel.

thanks,

greg k-h

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792828927;
	b=0aIX6Bytdvy5Av7AzLMxWQukhK9X3po+glF9+cqFwIoVlc5OGkSZpyDadeCoHKY1a6nX
	 5R3/Z7nusIksRU0qLio1tA5pbnFowONjMnH4Uh9zuKY4E3U5f4OnVc+bp8AUErJ104pkA
	 ypXu4W23G0AkRvaiKZcSQ1W8/3g/f80/nqF+OaLdarp/RQYs/bCObBwT/nWozTeG9waty
	 sOQUpUvBdam1eHpqHJvdhZHmKHQYEHGElxkep3FpZ1iabQFsTEMJVosRg4Juj6IV9KCtN
	 7yt3mOVPVhV+6g0z5cPaQrOaCTP+FcSmfWX+JtJjwTpHx9Y2rVIibGVNxFTHOk9QJKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792828927;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DV44IEVxsgNfjhnADWClL/5FXmIJ2/pi6MF+MrsiDt8=;
	b=xscsPJXjMgN45RtN0cQPAmHGdbDt+z6tHhWvGY+enXALtknAC/GySTH7upd9KjaDXWmR
	 sn7XBDOy6bnLIGPweaA5UrVOttS6NRMEY0DzPeSPJIuRJXmGmREwMHFc3G4epmwSXPf+Z
	 WYa/uMrhUjny99UR5fBXlUofKYfJplEzCqR32ZAXjEUIC3FCKEsS2g3xuiufV6nwmOIF2
	 llYWgsxt9F/nb51WuxQJtFYTU9bXQ37Y44lkh/39odvRBx3GqvYyURIplDpKuG1RYHGct
	 T7mQrFS6g+jsS8NEsmhOEWnNJ9wpdQfEl/45ytmUSdBU2hHPPxjS3Au9ENESnUjT1pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=q9UTBbAq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D70606A31A;
	Sat, 24 Oct 2026 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=q9UTBbAq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6821F01825;
	Sat, 24 Oct 2026 08:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792828926;
	bh=DV44IEVxsgNfjhnADWClL/5FXmIJ2/pi6MF+MrsiDt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=q9UTBbAqpTlxRWm1Sv9ajNi+lRe2+Hqi4rhpezBy+EaiawJiVbLskimmLYAatN3xQ
	 joJZNFWDATobnYUhBBqSKv/OCfTv3ZJEie4AIkqiEJnXDLnjYYQmOEgr0/cNzA/61q
	 690PjoaN5Z0nUaH5rMCE2J+FgjmJduCjjSnnmr14=
Date: Sat, 24 Oct 2026 10:02:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: clean up PLL calculation code
Message-ID: <2026102448-tackle-footnote-9ca0@gregkh>
References: <20261024073549.29531-1-himanshu.bakshi478@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024073549.29531-1-himanshu.bakshi478@gmail.com>

On Sat, Oct 24, 2026 at 01:05:49PM +0530, himanshu bakshi wrote:
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> 
> Improve the PLL calculation function's documentation and
> readability.
> 
> Simplify candidate selection by skipping candidates that do
> not improve the frequency error, and defer updating the PLL
> parameters until the best candidate has been selected.

How was this found and tested?

thanks,

greg k-h

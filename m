Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158710;
	b=Y6IBsm1tj4RC6x5bpprHoHDvBHk9OA0qJcKidA/TcMo7i1gEFnZA4Z6dQckCc8YyNTOm
	 RXG40yNu85gMIhxCpzVC8KLy4mZMNPgeUH1loiVRI2fOPmcImVFOMkbUgSiqpPXpw2YNw
	 Mm+jDwmQMWvtHr56T26XE0ycrpBTM1N38DYb41e+H8Kr05hjO/D6uGlxImeezsPdm/osM
	 sB4mOE56oJjEdy12mFbBp6mv31aGSRZOpsHyzJGQHghudI2qKhdFw2YYuqpRy4krjLcXX
	 GfUmL7OzUq6y+yS/xzaklumHVmZ7TSYJtEg0E0BF9/b3ws4NdhOTb5GWbSmLm0U/KLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158710;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3d6BYKx617y+5C/yVo6hbgQboIQwul5S916z2T5RP8Q=;
	b=RO34DR4Iv+Y6u68KaGKoyR/N1XYL4pzbPNHJH0nj5Y2UAyu5xVEeGAnweawYsxoL8wJw
	 k+U0og7CIBjhk1Bjj6VNYolL1xvQUIcnmxr/MwPomYfz1V8gRi4DkvtyqIBv7RtIJRl9r
	 SVl6hnEe515i2gEL2SQ1UdDO1Tep5BRkmuiWavetZBdM9+5Q70dWe2OCtVT/XTMthPBFO
	 xguO/e11czmdoF+G6/6rUes+pFy7VO5T7hT9EXmg8ivtPMOJ+ZBO1YRmkxs+AzBIj3SU4
	 gEqmZMwZHaY79l397+hddMomX90uT52XD4mQPERRrvG9GzOf9M3BH97mq3UKQsassYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fGnujN7N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDD4606A320;
	Fri, 20 Nov 2026 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fGnujN7N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA43C1F000C4;
	Fri, 20 Nov 2026 07:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795158710;
	bh=3d6BYKx617y+5C/yVo6hbgQboIQwul5S916z2T5RP8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fGnujN7Nfb2qjPyKFY65gCBntef2fLHWpdgIoWoOlbdUT4quRBxbGL4Oa8hnBLSXc
	 yIyhZTjrUmnfq3uYZMfSx5MIsQ8GM53dRGMrYLEMMpIzVRVDBiPFsFTUV7YiRoIwZZ
	 gowc/VNKFUUSCrDAcJLY5h6ewxI+Lt9zTjFc/88U=
Date: Fri, 20 Nov 2026 08:11:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Temitope obabi <obabitemitope765@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
	julia.lawall@inria.fr
Subject: Re: [PATCH v2] staging: sm750fb: Remove redundant NULL and zero
 assignments in probe
Message-ID: <2026112033-diagnoses-cartload-9d93@gregkh>
References: <20261019202015.1724-1-obabitemitope765@gmail.com>
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
In-Reply-To: <20261019202015.1724-1-obabitemitope765@gmail.com>

On Mon, Oct 19, 2026 at 11:20:15PM +0300, Temitope obabi wrote:
> The sm750_dev structure is allocated with devm_kzalloc() just above,
> so its memory is already zeroed. Remove the explicit NULL assignments
> to fbinfo[0] and fbinfo[1] and the zero assignment to mtrr.vram, which
> only set fields that are already zero.
> 
> Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
> 
> ---
> Changes in v2:
> - Remove an accidental duplicate of the note at the end of the patch.
>   No code changes.
> 
> Note: Greg replied to my earlier sm750fb patch that keeping the
> explicit zero assignments is good because it is clear what is
> happening. In that patch the allocation was in a different function.
> Here the assignments are in lynxfb_pci_probe(), just after the
> devm_kzalloc() call and its NULL check, so I think removing them may
> still be useful.

Let's leave them as-is, it's nice to be explicit at times.

thanks,

greg k-h

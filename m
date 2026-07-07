Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6230D407;
	Tue,  7 Jul 2026 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783425004; cv=none; b=FuMpP11SEAJf5FAomhDSskZsm9r4br9sUZzC3++A5UiQSf+1EFlmN9rvMzNsF72PvArhsUI50fnsV83ezKsezymcDA2wQQWxEFi7tnKzpb0VV5c4q7J6gKaK5H0MOWpqAkMhSu1WYr+SuI0gl42Z70JQckZ6AintynQrTx0/k/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783425004; c=relaxed/simple;
	bh=Bda5eFjiLbA2wYierlxgBru+blJoXCqSSMAWWipqjBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mK54rdT7v2CcCxBaxNA2Wvu1Ar8AU2aNvE+NxfV7nfRL6UieFCDqLkYjeMRNRAwEhiyDldtuLJxsecRyiGjoscNxPr813kqUQDIrH9vgx4uiecjnM6Et3tzTuqmusdBGsfkhtMIXiiWbH6ZIj/D/Tb3ta59dl47zm4QF1UL1BgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pJYMs8vU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pJYMs8vU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEB41F000E9;
	Tue,  7 Jul 2026 11:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783425002;
	bh=25qM7BWGpxl52xZe/zhpGA3A5CVRhwzDFn5BA+VBYEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pJYMs8vU7OnGZa0Gk1fRhQkPm9wl0jKIhXkAdNzQLg8okEt9lcqtKTypGdQRnL1jf
	 8SX5bKVmPiyUE8dZf1nPgUKnHJaNX05/LbrZJJ7tK9W+YmLEEAv3ESDinAWTpZKRIb
	 ms5t8Fi438eJyKxp5J6IjCGXyDHzVIpMjClMdANI=
Date: Tue, 7 Jul 2026 13:49:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Moreira <andrem.33333@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: sm750fb: rename variables to comply with
 kernel style
Message-ID: <2026070749-devotedly-clash-2e28@gregkh>
References: <2026070710-exact-unveiling-e321@gregkh>
 <20260707114327.22950-1-andrem.33333@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707114327.22950-1-andrem.33333@gmail.com>

On Tue, Jul 07, 2026 at 08:43:27AM -0300, André Moreira wrote:
> Rename 'pvReg' to 'regs' to remove Hungarian notation, and rename
> 'setAllEngOff' to 'set_all_eng_off' to avoid CamelCase throughout
> the driver.
> 
> Signed-off-by: André Moreira <andrem.33333@gmail.com>
> ---
> Changes in v3:
>   - Added changelog history to satisfy the bot.
> 
> Changes in v2:
>   - Renamed 'pv_reg' to 'regs' to completely remove Hungarian notation, based on Greg KH's feedback.

Does not apply to the staging-testing branch :(

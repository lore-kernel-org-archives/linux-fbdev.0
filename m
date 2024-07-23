Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D2152196;
	Tue, 23 Jul 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739966; cv=none; b=ndpF3i42h5jI9EUfJBN+pTIs+Zqheuo42U5ZCLNe8b5yBW676dq55lwip9Vk0bspNlCvrolCbRUUsU2U6coPuXJu7CBiT32WfGK1y1EFb1hN4j70xpl3d9nwYQfdbWwYRf5HD0FRS3Sd6SPmxmDDmG5pxrOSKnOlnT85RMZtMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739966; c=relaxed/simple;
	bh=4zf1JXvv0esj9HUFMk4EOsHlw0qJZffThWkBqIIdgpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wrh4jTbppACtI5pW9Zk2DAv9na2S3+1s36K+jcHd+FUkM+3B68oF+FuB0a51Z4Fla3aT+FWll4yaENZ2VwrBoa0d6hS7kXkq8K7Pdmk6S5r0DnEHUfSywBmyz8kSEQk/3myvP9gTtUGEhesyguMAmXK6XijPZecVAiKJ77cMWDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Curd4mrX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Curd4mrX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57570C4AF0A;
	Tue, 23 Jul 2024 13:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721739965;
	bh=4zf1JXvv0esj9HUFMk4EOsHlw0qJZffThWkBqIIdgpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Curd4mrXxyTXwZWutnk/jTDuGUZOQ83CO59yDgiYhFYG9fvqkwOUTk9xzC9LSEGYD
	 GxeAPOKoBc6WeW8AbJ8OAzER1/7+J2wKPVG0AKDasGx2m+05OWgndwa4y1pYdKI9sh
	 Gv1KAk8r8n++EwPW5CR3xeZRZbBXsXkwI5yCsG8Q=
Date: Tue, 23 Jul 2024 15:06:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: remove unnecessary braces in if
 statements and space before close parenthesis in function call
Message-ID: <2024072320-trimness-scribe-8055@gregkh>
References: <20240723060311.32043-1-riyandhiman14@gmail.com>
 <2024072339-elderly-charbroil-5d5d@gregkh>
 <CAAjz0QbtK=c98QP5t76_=_Xrg4+3bHksXR=_QJfz0W0f_zZ=vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAjz0QbtK=c98QP5t76_=_Xrg4+3bHksXR=_QJfz0W0f_zZ=vA@mail.gmail.com>

On Tue, Jul 23, 2024 at 06:28:19PM +0530, Riyan Dhiman wrote:
> Hi,
> 
> Thank you for your feedback on my patch submission.
> I have reviewed the mailing list traffic and noted that the last patch
> addressing the same coding style issue was submitted in April. Given this
> timeframe, I believed it was appropriate to submit my patch to contribute
> to the resolution of the ongoing issue.
> As this is my first contribution to the Linux kernel, I want to ensure that
> my submission aligns with the requirements. I would greatly appreciate your
> guidance on how to improve my patch and avoid duplicating previous efforts.

The issue is that the checkpatch warning for too many () characters is
just not right, and shouldn't be applied for staging fixes, sorry.  The
code is fine as-is.

thanks,

greg k-h

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E170E26F47D;
	Tue, 18 Feb 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901434; cv=none; b=Tp80CBfs5PLAxUFRZFyb26nyp5Wwc3zgj7LdxK6G/ozrkkmSc5BsJBUSnbkNMaP54e8aCWglSYOZVS+DRs1aVahAsdJRS5QgMkS0UtP6ZOMvBO6UF40kGJcotOWzTRMEwKMnuTyxnqZwY11n2QvDY1HNDFIzybNp5Dx7rvzse2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901434; c=relaxed/simple;
	bh=tU9Zd8NFakzAf3zN7ldSQi3XanfcSI1SkdescDqtkVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSm/e95nMWDKsvA+eJ7LgO3uk+h6DO6DAzGNcQuZo+LE8PZidps+3f04r6xJGN6W6EdyuVh156pBiIOEytnqcMmzErJ9jPP1J0yD8NBD056BCLPYMVbEoRG0Fcz3F7ZfRitwSzKoSiuErXBgvkmsG5ataKSnJuF3Exp8MetOvbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JUFIZ3Ok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JUFIZ3Ok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E6FC4CEE2;
	Tue, 18 Feb 2025 17:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739901433;
	bh=tU9Zd8NFakzAf3zN7ldSQi3XanfcSI1SkdescDqtkVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUFIZ3OkwXpBsOy7q8AANQJFVNfXQxZ2GiZkYesdqyl1mbjHz9H5nF1al6Nxyh9Oj
	 EKybpiQA7X/PE3rmHjwbcJLgM5EvGLDZrOldpJko+lyGYgKOaygiMT0YWk49KT6W9Q
	 jFSQx3LRcshbdts9cLWA3I9t3ACojhzqf1NFoVSY=
Date: Tue, 18 Feb 2025 18:57:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Fix CamelCase and remove volatile
 warnings
Message-ID: <2025021854-habitual-bulldog-df4b@gregkh>
References: <20250218173712.15770-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218173712.15770-1-madhurkumar004@gmail.com>

On Tue, Feb 18, 2025 at 11:07:12PM +0530, Madhur Kumar wrote:
> Fixed multiple coding style issues in sm750fb:
> - Replaced CamelCase variable names with snake_case.
> - Removed incorrect use of volatile in memory-mapped IO.
> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

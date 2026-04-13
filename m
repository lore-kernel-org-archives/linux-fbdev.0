Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E503563C4;
	Mon, 13 Apr 2026 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776060191; cv=none; b=uCWg09altIVmY+DtwnYwd75aJtR+MWw1CaPl7gqQar5gi22hIXtg2S892kLVyjYlrrP8HxYNznbTGD3wfenn+W5HFG18spHHiTbqHeeM8j6KFLlQJcj3eam7C8ypXKJZ15XEvaUwfsNoe/uA789quYoKRRToyNWfLoWsna12Mfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776060191; c=relaxed/simple;
	bh=+DPhsLBBr6AVydYKg13IxgF99bqlwElolEyMA8nzvkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9TROTV+2i5UY64+uvH/zw0BymXEQEmfqxeKMC69HLBdPMmVi3a051dKkgUSTELlW8wICzYt+k1rx7LaysdfIfjST+kwl+gbQoOUGFUFrjOMkry7ruFDUmtfJTKD0zpLigkhB4/UZGgj81ngdq8qOcYWJ+ObADm0NOCODqJddwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HM2+d5KG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HM2+d5KG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41F8C116C6;
	Mon, 13 Apr 2026 06:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776060191;
	bh=+DPhsLBBr6AVydYKg13IxgF99bqlwElolEyMA8nzvkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HM2+d5KGugbLjCNpBQ/HCi/7c+Shj1UmJV/P4QoiDPXZPjTAhPkSQMkPjunxmSz4c
	 sSGTsgm7CBOcLusRB/rIgcJq3dnQr3UUlQm5peqZRXdoGqybDCnpXVz5WMoAR4BcIP
	 dAy12TR7iNoxtKomBxJWg/KFMbDnf7W/gEoirq0o=
Date: Mon, 13 Apr 2026 08:03:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Baker <mzndmzn@gmail.com>, andy@kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: fbtft: replace empty macro args with
 identity converter
Message-ID: <2026041338-guiding-concur-3831@gregkh>
References: <20260412173317.3329-1-mzndmzn@gmail.com>
 <20260412173317.3329-2-mzndmzn@gmail.com>
 <CAHp75VcdWMvvM-oKTqRACSXSUiVsEh1Ep_82MsJxfbrG4thUdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcdWMvvM-oKTqRACSXSUiVsEh1Ep_82MsJxfbrG4thUdA@mail.gmail.com>

On Mon, Apr 13, 2026 at 08:58:50AM +0300, Andy Shevchenko wrote:
> On Sun, Apr 12, 2026 at 8:33 PM Baker <mzndmzn@gmail.com> wrote:
> >
> > The define_fbtft_write_reg macro calls 'modifier' as a function.
> > Passing an empty token as modifier is undefined behavior in C for
> > fixed-arity macros. Introduce fbtft_no_conv() as an identity
> > function to replace the empty args in the no-conversion cases.
> 
> This trick is used in the kernel (usually for u8). If you really want
> to improve, use _Generic() instead.

No, sorry, this code is fine as-is.

greg k-h

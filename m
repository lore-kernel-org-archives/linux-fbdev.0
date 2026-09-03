Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D113C9896;
	Thu,  3 Sep 2026 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424204; cv=none; b=L7PeoSc76hDBbE8mj7l1m6Po5XuPW0taXyRBdKm6V0GR2pVUX9OCdIjC1J5Y3UYs49jAsQ2SzMxL/6AZxonrrIycBGWQP1wwhHLajRERM09WDgRxCnDqDA5JuhSxToyqq7/uV1a1KxmQn10cyQcM74iX/RWADKvlM5d48Ks0jwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424204; c=relaxed/simple;
	bh=cizoKl8SeKdIEKtzNznN0qCxh7J/pJvNp9NuBqgP2cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj6vf/5Y5ICUciwIHFjZ5Hrvansb+TMK4ouC5kaJM0D/QHGS/qzICF/jRzd+Qb49+lwnUcE2zTlWGfbuEwXf0tlkp5+R8C/ZNA/kV8iGH8soH8d8Vq0b7vq3OMBjz08viKY0IVtU8iUZ5zMUjfBwaU9WtByehFsute/ulI1MPHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F3Lgj7dq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F3Lgj7dq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424A61F000E9;
	Thu,  3 Sep 2026 08:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788424203;
	bh=wnGZxPBdOlznc/8mB6JQ2wgYprEsmK93tjnCCBwxzGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F3Lgj7dqtVIbV3TtSlR9AE8nRwjvTBBsywJkQXDkrXqrylnGo8hXCW3YSbxkYCMsG
	 HES3SRK71bXj1zTL5Bids/Lr+tqR0UzmW5rfk5N3q+K9v5Qe0MUc3G8u9N79KMVEk7
	 x/e2m5ikSaxBYSIdnQaxEdHCzhW8VNA7Wj/qGoNc=
Date: Thu, 3 Sep 2026 10:29:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Anshika Jain <anshikajain196872@gmail.com>,
	Andy Shevchenko <andy@kernel.org>, sashiko-bot@kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: fix len<=0 buffer overflow in
 define_fbtft_write_reg()
Message-ID: <2026090347-squiggle-girdle-5ff4@gregkh>
References: <20260902045026.7442-1-anshikajain196872@gmail.com>
 <87wlt3vnzp.fsf@yellow.woof>
 <CABj3sPEMo3B9B0ynfLGD=NmMu+0zpZ_Ydf2yyT7NDaT3DDNq=A@mail.gmail.com>
 <87cxuu68u3.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cxuu68u3.fsf@yellow.woof>

On Thu, Sep 03, 2026 at 10:24:36AM +0200, Nam Cao wrote:
> No html email please, the mailing lists will not get them.
> 
> Anshika Jain <anshikajain196872@gmail.com> writes:
> > I'd like to keep this as a small safety check for the future, not as a fix
> > for a bug happening today. If you think that's not worth adding, I'm fine
> > dropping the patch.
> 
> As mentioned, such bug would show up immediately in testing. So I vote
> dropping it.

Agreed, I've now dropped it from my review queue.

thanks,

greg k-h

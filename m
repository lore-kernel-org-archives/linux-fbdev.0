Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114EC15382E;
	Sat,  5 Apr 2025 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743851174; cv=none; b=l1pVICxKN7V4dSIwIPho2B/kSoXVhQVmHgfL4SPueMvDRhnsbAxsFwXPliS63S7haoD6EbxrDdnP1zN2kWOf2JQ6nutwgxi2ab97OkTydiFxUbnNuOblYJ5ICTmwW7Y5niYu9FgMgKxQR3Nh4coty9YhI8cRh9Wu+WVNN8eNzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743851174; c=relaxed/simple;
	bh=lR/MOYEzw57ORCMDpIjzO9xpbxS3BbBJ0Zizq7hwF1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtauUGRZ7j+C6lCBdb7QIBaW1ElfK4AJ9yMMJ9bszERORo29K9ABEu65hot+tJlre4Z4Z+JoEEr6OZREfgor9kTgtoa8jAPxEQNtewBe3IUuNuaZ3OJ7c62gnTPkZKNWeCS2vx8mmrHLPJDHdaabbjjAWKUVtsFcl3SEzdaYNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1zjUaVJU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1zjUaVJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4B2C4CEE4;
	Sat,  5 Apr 2025 11:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743851173;
	bh=lR/MOYEzw57ORCMDpIjzO9xpbxS3BbBJ0Zizq7hwF1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1zjUaVJUbgSiP0LJDEvPPYyFHaxKgnPCJT9ScY2sZOGNBOnQixkTqAp3VYl4I1XD+
	 aCUp1GsQlSmjwklCrePMKV4xZF5y80es7MjKgJcgvCEnwj5uzN71ybdYYgjuv0xhq0
	 +27bmjZ7PeAHOelSZWrPKT35HwPfEl/0Zd8q6mZs=
Date: Sat, 5 Apr 2025 12:04:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Akintola <princerichard17a@gmail.com>
Cc: sudipm.mukherjee@gmail.com, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] staging: sm750fb: change sii164GetDeviceID to
 snake_case
Message-ID: <2025040505-colonial-pencil-69b4@gregkh>
References: <67f0f9ff.df0a0220.33076c.f0e5@mx.google.com>
 <CAMyr_bJpE=NHi4bS=_eAWcm1gxKiKDA3YQ_mYRCDi3tjuBjknQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMyr_bJpE=NHi4bS=_eAWcm1gxKiKDA3YQ_mYRCDi3tjuBjknQ@mail.gmail.com>

On Sat, Apr 05, 2025 at 11:08:53AM +0100, Richard Akintola wrote:
> On Sat, Apr 5, 2025 at 10:38 AM Richard Akintola
> <princerichard17a@gmail.com> wrote:
> >
> > Change camelCase function name sii164GetDeviceID to sii164_reset_chip
> 
> Just noticed a typo here, would send another that has the correct
> commit message.
> 

All of these need to be linked together, you are sending them
individually.  Please use a tool like 'git send-email' that does this
automatically for you, because as-is, I can't take these, sorry.

thanks,

greg k-h

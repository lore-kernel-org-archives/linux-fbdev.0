Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340AD30DEB2;
	Sat, 18 Jul 2026 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784355589; cv=none; b=FCEXYarxEBOd2gO3pdF+3NHs2vlVfHRmcGXA881HtM1OZw6nK8QOuyEpS2S1KTxOXfzJ9kvFo6shtBxR2dBM3ZqfC7n3goqojMGoT909LtK4GhVf7cuHzsXs1kJn/iMfKileKoWxYZey8Rsf8RgRAKf5/oqN/vDBFDsncWKYiGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784355589; c=relaxed/simple;
	bh=1uieLuc1BQPmwJNXUsXykeHyVIjjpZXhIAoRSuvi+68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KE4TgZq3+bts4llvjsXACDW2N/sDmC5+77WfqwS/GJV4QcQf/vncY1BA95Tu+N/5W8WKlwl4+nsVCGvyZz4IB41FBsUuCWXkGZRSH4tDyRp3UcurfIX0Ivrwad6GnxrvW51D1hDpCK+do/PB4kkEEnnjmiAEViF5ckzrAhJiwac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=luSnyBZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="luSnyBZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D35B1F000E9;
	Sat, 18 Jul 2026 06:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784355587;
	bh=DOplUozCS7Iul5ee3dKUnMD010kIGW9TzKrccs2hL84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=luSnyBZw6078uSNHEOFIHoYtggR4lmuuZf6N5nJVVK5vweUZryVmWGu+fwq4Sk2LF
	 Nybul75a5vH4vtR3lxh3sQHr1TumYoVLjs5Uii/vxgEyk6b5pVyqi0i3Ol1GEjSxhO
	 O1i/zFzGNmU6TsSg5PxHe+rtAc5s7H7xujHrZZDM=
Date: Sat, 18 Jul 2026 08:19:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nils Lehnen <nils.lehnen@proton.me>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: (No Subject)
Message-ID: <2026071824-suburb-dimmed-2c36@gregkh>
References: <20260718055132.441-1-nils.lehnen@proton.me>
 <20260718055709.466-1-nils.lehnen@proton.me>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718055709.466-1-nils.lehnen@proton.me>

On Sat, Jul 18, 2026 at 05:57:26AM +0000, Nils Lehnen wrote:
> >From b62c709ab6d719d625199dfdb3053589f925eaad Mon Sep 17 00:00:00 2001
> From: Nils Lehnen <nils.lehnen@proton.me>
> Date: Sat, 18 Jul 2026 07:43:49 +0200
> Subject: [PATCH 1/2] staging: sm750fb: remove dead VALIDATION_CHIP
>  conditionals

Something went wrong here :(


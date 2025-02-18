Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638902356BA;
	Tue, 18 Feb 2025 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904486; cv=none; b=et2xPfkAqcgkXOIsqYFRAZFeUUTwzD6ll4yM6fmJY6nWuSuB/CiTa04qWPd06ozur+Sp1VNA9A8REYVHhi8izRSMpv9hzs6D3eIwBb0zGgtLeamQOm6xhJCoiBVpf9+ZlNCtMz76HxVBA3uDO/d+SdDqHKCaL/Pd13JRYWfsqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904486; c=relaxed/simple;
	bh=eQku/ltOrPfhbzsZOdgcUSqfg47tSUXUyWsAxYA3rZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKvYLpFmUyUANLAZNO8iseqJBxfYWddHOHG5prul/23IRaxWlFHvuCXAreyoJHpUgihzlbLejEl5e0nC48HiiAKt8a6nciFAQ538Zz502Bi08xMUmblQRkAW8qiMwLg/A807arZ/NmKhpvdJ/8AIZSbNjhRPoOC8Xo+tRF3UO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jRy8tA/q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jRy8tA/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F6AC4CEE2;
	Tue, 18 Feb 2025 18:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739904485;
	bh=eQku/ltOrPfhbzsZOdgcUSqfg47tSUXUyWsAxYA3rZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jRy8tA/qSZVnwOZRRQgd556dMJkJJ9fFKmaPxIsj7CPf9WEZvMyIbqHIYF+1UEIOd
	 XIDJ9mrmL2CMft7Zod1J/3XR459taQb1/F03PkKdv5WB1P3CKbrqiwxPwVA+zlucel
	 ddla6NAAohMlSjZuP1Lap1NhH6TFOJGU/jCY7+ws=
Date: Tue, 18 Feb 2025 19:48:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Fix CamelCase and remove volatile
 warnings
Message-ID: <2025021843-subsector-decipher-e7cf@gregkh>
References: <20250218184343.20585-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218184343.20585-1-madhurkumar004@gmail.com>

On Wed, Feb 19, 2025 at 12:13:42AM +0530, Madhur Kumar wrote:
> Fixed multiple coding style issues in sm750fb:
> - Replaced CamelCase variable names with snake_case.
> - Removed incorrect use of volatile in memory-mapped IO.
> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---

For some reason you sent this out again and ignored my bot's previous
review?

confused,

greg k-h

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6AF232395;
	Thu, 30 Oct 2025 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824783; cv=none; b=UOujD9zDONhv9nv8RoI6cs8FzrznOJr9+KeMefh603jyWVe9HIRXrEmpJ0ZEVWawCz8CgfIthQqoRn7blrdc+fnRIjbVGp3enHCGYiVSncP6rST0btrZ7wF0GZfYDuUDDxgJyJQGRwNerqhGkct3Vuz6AHAwS4hEpbjjQFZfKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824783; c=relaxed/simple;
	bh=reiNpeqTPEeJU6gOHFXRhPO54XWsRkqnewY5o9KMMDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dL7e/6eBiGw95pClgiyXxbCLgUJUI7NiLHlas/bI+YbMxXuLunJr03XPoo6fXyRFGMpoTiFqOfWyxQ6ut+G70PhJVwK6DhIPgucSDXB+mq8eezZ4CDqIoLdsf1Ed9myXxYJitxbfnuvQX9NpbZ/BhzIilq/xL12OBHpZsFcjHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hz2a8B2n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hz2a8B2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D92BC4CEFF;
	Thu, 30 Oct 2025 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761824783;
	bh=reiNpeqTPEeJU6gOHFXRhPO54XWsRkqnewY5o9KMMDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hz2a8B2nAz+J+MqNj3XJWzeVhFnHgmnKxDMGrxgKNJHwV9Zt0Sl2LJYbw9jTJzwcq
	 j5Vdd/3qwXooUYn4PtiKS0USib3p1lY1QHAj0r4TRFxThcAqyO+1RozVogiGKS+wav
	 M4/63umk7L2ayO8Yh4Vn++Xy++tM3wZxFu3TaNkwSytRL19wlvdxh5iuXQFkfGeomq
	 oy4rnPAOceDk63XM1KYxjtqJokm1wqgTwfp1vDT33eZeCc2yh9flgYvvVobw4r9cU6
	 mr9hswKxc9hAvcyd6aHovQaIdCs9zVQ8Ka1KiXWX+49qARSBxpQyXh3x0BksTJrXl2
	 CrqTV588Bt/lQ==
Date: Thu, 30 Oct 2025 11:47:26 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Randy Dunlap <rdunlap@infradead.org>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] leds: Drop duplicate LEDS_EXPRESSWIRE config
Message-ID: <aQNQTlGed2XCY0lH@aspen.lan>
References: <20250729-expresswire-dep-fix-v1-0-635cd4cc746b@dujemihanovic.xyz>
 <20250729-expresswire-dep-fix-v1-1-635cd4cc746b@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250729-expresswire-dep-fix-v1-1-635cd4cc746b@dujemihanovic.xyz>

On Tue, Jul 29, 2025 at 07:18:29PM +0200, Duje Mihanović wrote:
> While moving said config symbol out of the "if NEW_LEDS" block, I
> accidentally left a copy inside that block. Remove it.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/all/b6c481bb-e854-405e-a428-90301789fe20@infradead.org/
> Fixes: 2cd0d1db31e7 ("leds: expresswire: Don't depend on NEW_LEDS")
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

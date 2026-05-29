Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A6631E833;
	Fri, 29 May 2026 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048892; cv=none; b=Cxjfmgsw0PCV2uR94OkXnKKPhHeAuK4r+CXUdrlS7T1IkFv6+owzFb0L6Syeu376ARCUXzvENNrwivJhiz1RLhzdndHNy1HY5W6tw79haJTpRnfKG+YuPF8Mx7vlgQ2pppv7zVBNJW9VfZ/j5dyDZU9Xldk7UZACYrugFA443g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048892; c=relaxed/simple;
	bh=mkftG1497aD4Pdh1IFIy0l2/xnbdOjhiCCxVTjY6l8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCEjwIBdm5l8g/WneLWkQSFFUhRdkKI/XDVSzmZUZ6MWloqSHTTFaxJF2GryvUy3xHRaF5eH53kFttdwjCbFH8W65U4xQJ4Zp1QxZxlyAAb73F01j9XyKjY2QeL5vsY2vKnCm8paqb84mVdMEUuPIqysHB16AwMOh3hHjKEbkHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzdsUzu7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzdsUzu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112B61F00893;
	Fri, 29 May 2026 10:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780048891;
	bh=mkftG1497aD4Pdh1IFIy0l2/xnbdOjhiCCxVTjY6l8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jzdsUzu7sixsZCw9+4zNQNrHc328nlcGG5lKjCztOrywKABZ/1bRkh6Uy+2JgJFzZ
	 EgynfvCBGtzZqrfBr68ocw7QVwZsEw4iJL/zvw/qWHkxl3+ffONuMsjwcPECfKdUvk
	 TubwT2Iw+eTWcM6XViSglwm8AoFvqR2Qa4wSQtYUT2xCs8L59qvVBPyfABujcsWyXs
	 h7ZpvjVoFFjz9lmdPCQHoHf4uZ69KqL0aEvym9N6wFb53Jy1SrozOFMYmlflpCw/sR
	 akSAUjYGka0Eo2XmnXptUkA6ttOVoVNg6M5F3Oec4Eq9Qw5AYI+VTbKtqjxeoAsrLT
	 UxywWndFFItPQ==
Date: Fri, 29 May 2026 11:01:26 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Helge Deller <deller@gmx.de>, Junjie Cao <caojunjie650@gmail.com>,
	Jianhua Lu <lujianhua000@gmail.com>,
	Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: Use named initializers for arrays of
 i2c_device_data
Message-ID: <ahlj9ttqaFwuSADJ@aspen.lan>
References: <20260518111203.639603-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518111203.639603-2-u.kleine-koenig@baylibre.com>

On Mon, May 18, 2026 at 01:12:03PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
>
> While touching all these arrays, unify usage of whitespace in the list
> terminator.
>
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

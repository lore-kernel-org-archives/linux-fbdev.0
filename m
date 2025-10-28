Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4545315785;
	Tue, 28 Oct 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654103; cv=none; b=XR69z5yqrsyH1hu7v3Vz31SEA8+7/AkprxSOzGBpf41fGBiY3KvcNvyHRYY7zDuxXI1XxT3CKbA9CwEA9dhUofH+OCBkEngUXpmc6eEoFYGFEIlqKrGUcIZIbkD1YZD1NWr0kNf39JzWOA+agH/MkWJOnapufq4W+BtZSKs+5Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654103; c=relaxed/simple;
	bh=F1yAdiDYrdDLxP84lx9QVn1zjhW7IesRkHoYslG/PWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKOgfJ8q1dnE42o+Ys63+8SsNendg+YUijTJBEMSk8BAtATfbryLsyw49NosdALR4j+BuTQWblJnfbuaKwcpvKmuw4Up+NoZeLLlOvCLMM986oLdKL7VNr7iHb9GVtmbwX70f0htfwlNc/SKngVNUQc1GGRkZ05oW+GhnSv53Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teYCzjcf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teYCzjcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF51FC4CEE7;
	Tue, 28 Oct 2025 12:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761654102;
	bh=F1yAdiDYrdDLxP84lx9QVn1zjhW7IesRkHoYslG/PWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=teYCzjcfSbq7gGRP9JKtgbbIrz+JLL0d46u9j4/vG1Jl8xpbWEhrQABLG3sglqPc4
	 vNDqlSSF1jqXTxFzGisZfrvlYaZ3ndmy0rEp6IBji/d3oNGH5vf1Vl75MSeMt9AL7c
	 2CqKfGc8NUYf7ciwr0rbURBp6MKAUTh/dMA19tl+cTy4Wk9M4yamnIJFzkCK13QzsH
	 Dgt3AXt6GWtcO9bsWv9fihYCCtI//sz8qGgfX51khITJOreLYL9FKK0ERFqpFG2SCw
	 ELm2cf0pSirBNiCAYyX9kCICzk+peIIw3glPoSsqGQe45BbnQy/m0AYwn51K3WFP1I
	 sDe51zom4b+VQ==
Date: Tue, 28 Oct 2025 12:22:32 +0000
From: Daniel Thompson <danielt@kernel.org>
To: duje.mihanovic@skole.hr
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: ktd2801: depend on GPIOLIB
Message-ID: <aQC1iJlm2jS479_0@aspen.lan>
References: <20250411-ktd-fix-v1-1-e7425d273268@skole.hr>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250411-ktd-fix-v1-1-e7425d273268@skole.hr>

On Fri, Apr 11, 2025 at 07:22:18PM +0200, Duje Mihanović via B4 Relay wrote:
> From: Duje Mihanović <duje.mihanovic@skole.hr>
>
> The ExpressWire library used by the driver depends on GPIOLIB, and by
> extension the driver does as well. This is not reflected in the driver's
> Kconfig entry, potentially causing Kconfig warnings. Fix this by adding
> the dependency.
>
> Link: https://lore.kernel.org/all/5cf231e1-0bba-4595-9441-46acc5255512@infradead.org
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

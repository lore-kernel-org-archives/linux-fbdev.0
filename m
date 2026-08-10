Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6941C3BFE24;
	Mon, 10 Aug 2026 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360538; cv=none; b=HS27olnfU5FU/OUljPhla5EbCsR6OVTvFyvdYssAIap0KBqn5QGArr8r5aSwJmZUm2gIaXb+gG6Vi2dR+/bC67t9B/2t9TayraulqLnxbOsduKbk9+nPPDwZFRVtBSTMQLFU8l6KTdjSfnUiX0rrs5udOfASxWBA818KvWFXh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360538; c=relaxed/simple;
	bh=XRWYCBrquG5DAJ/NRjL4Ab5YIiDOl41JyD/GrEtkEME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKdoS/AQf8UJSqbj7y/mC615qi2Xm/7bx4DpIo9yhsal6QCYJPJabOfkCdNuKIOsNxMUyW/O+Cr9/4bDE7INlhI8ecwoqgMwMdpfKk3O6qIgKfUeWhCr8FbplqUPKe94JrBolf6hqf7rUxOnFIE59W2K7bHOITmTHj2jBVlj6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbF2g1EG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbF2g1EG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D576A1F00A3A;
	Mon, 10 Aug 2026 11:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786360537;
	bh=XRWYCBrquG5DAJ/NRjL4Ab5YIiDOl41JyD/GrEtkEME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FbF2g1EGDtBAiJBqPJ5WaDnXn6cNxWdLUur1yuHRZkxjiv8NbCxcgYMbQg6xDh8Y9
	 90cUL+Zk5CelWEdd8DaT+TaqGsnxCeDsqtZ9zRRC6dz4sFeKTW5eFUUPtJLVyiMn+n
	 AF8N3399oDc9Zi4rDndmkW9q6ZxWMdZ2WPYW9LrhxQxgkmfxhL7Yokbt2iA7XbvPVe
	 a/VfRMCyUjxH+2E7kDZOfdb/SdAQgvbvvoAQrJCeRqiQcObgsA/oYtCOP9Mvw8RFNj
	 HOZ5OrmR70XEWAa/ETwQmLql5aOLGbIxcW8+2fkwOfSaOI/s4ts0bhckNHoUqL2Y04
	 a+bJ6ww3sn1Xw==
Date: Mon, 10 Aug 2026 12:15:33 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Levente Szajko <raedrimhun@proton.me>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: backlight: Use sysfs_emit() instead of sprintf()
Message-ID: <anmy1YLtzj89bqfb@aspen.lan>
References: <20260805135027.43890-1-raedrimhun@proton.me>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805135027.43890-1-raedrimhun@proton.me>

On Wed, Aug 05, 2026 at 01:51:39PM +0000, Levente Szajko wrote:
> Replace sprintf() with sysfs_emit() in the sysfs show callbacks of
> backlight.c and lcd.c, as recommended by Documentation/filesystems/sysfs.rst.
>
> No functional change intended.
>
> Signed-off-by: Levente Szajko <raedrimhun@proton.me>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

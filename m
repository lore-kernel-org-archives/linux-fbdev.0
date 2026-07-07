Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2035C390205;
	Tue,  7 Jul 2026 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415174; cv=none; b=gq5TzSbLOUBKnPBmJBc2tl3yWpW9P4vdTs+4ZL+nV1QEVRJDRtiwi9i+Ky/igAVyyAS9T4NcNC3pt6Cix8v4nr0QHqpyb8uCP1HOyYdeWAdxjnfVSZokoxHD3au7Mzi4ti3tE6lALcvSfi544aOHnbqLf4JsR/Mr4SFewGfNtgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415174; c=relaxed/simple;
	bh=28FqUzoGc80n7Xui8X5xCXQl0CqfdJwwDkKoGdcTNrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti/mT2VrCzzKtaeWStwAJAxDKX0JOsA2Qi7jtGfwYBNF8vHE4jLeX/efzPxQ0YCkfjjDDZB01uh/hXfiH29vM+ul0eIA5fLaS7npexKsUyTD+p4ibOsSeBVnN/Gncjd3SzN2X1/HNsMMcyKeYGupmokVOWhB0WR0ujIpJLN1Fe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gM2ddroG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gM2ddroG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517151F00A3A;
	Tue,  7 Jul 2026 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783415172;
	bh=6vSbk8Qzyw7M2MWzxo8RNMDE82ejPy5u8VmkzuaO5SQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gM2ddroGoBTHOtRvhXV2SLAtY4LNiPAcbLxx2LAQvxBxHouA8ecWbK+WJ/hblbzre
	 AeYO0ZKgv7qmknmrBO5nw8GChNoW2RmkjmDi+b2mdZvkmeVpbY4pHSOIyanKfPalNm
	 uhR3SjfLqk7xoIU7UOghhwfT4nJHcNyD4JybS9Lc=
Date: Tue, 7 Jul 2026 11:06:10 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Gabry <Gabry.256@proton.me>
Cc: "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
	"teddy.wang@siliconmotion.com" <teddy.wang@siliconmotion.com>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: sm750fb: rename Bpp parameter to bpp
Message-ID: <2026070743-stubble-brick-6d56@gregkh>
References: <hpslpD7esY-xE37Tvrz0V8gD8YoZwdu6IlQ8LjUz5fY5mevEeDxM-dLC64t43G4mpVfHB_xCDUESoNFZ7ua9k7B_k2NrY2u-P6NYIJSuGt4=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hpslpD7esY-xE37Tvrz0V8gD8YoZwdu6IlQ8LjUz5fY5mevEeDxM-dLC64t43G4mpVfHB_xCDUESoNFZ7ua9k7B_k2NrY2u-P6NYIJSuGt4=@proton.me>

On Thu, May 28, 2026 at 06:36:45PM +0000, Gabry wrote:
> The Linux kernel coding style prefers snake_case over CamelCase foridentifier names.
> 
> Rename the 'Bpp' parameter (bytes per pixel) of sm750_hw_fillrect()
> and sm750_hw_copyarea() to 'bpp' to comply with this standard. Update
> the function prototypes in sm750_accel.h and the corresponding
> kernel-doc descriptions accordingly.
> 
> This is a pure rename with no functional change, and addresses a
> checkpatch.pl warning:
> 
>   CHECK: Avoid CamelCase: <Bpp>
> 
> Signed-off-by: Gabriele Rizzo <gabry.256@proton.me>

Does not match up with your "From:" line :(

Also, this is the second version of this patch you sent out, what
changed from the first?

thanks,

greg k-h

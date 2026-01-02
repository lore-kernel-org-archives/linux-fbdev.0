Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AAA9463;
	Fri,  2 Jan 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767371457; cv=none; b=q2ARRx2RGzLRjv4F87YqJHnYJ2dULZI7yeCiY0sToP+vmD47kUM4jJfk5g+JpMk/wbLMlFMzAhfcn8pJ8xl9ya2g1nBVg9jMQrqK+j7/yiyooQLqM3iiamYpsGN8dPiwTueCLmH++q/6oLEpRr3YhF1QHwVNS8Q3YemFgU84jAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767371457; c=relaxed/simple;
	bh=W9x6B8RzXHD/s8bwGkmccsIgeP5fFleFJ110N4EFG7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6YqvmZH0QMI7Tj9xDvInwib/efGP+/6D0usL7kT9EnjlfNXGDHJ9u1cMhTRlKY1d3edleEbssXXFJH80Qgg4oueHsp62VQ2jRfXstDzD5sHJ5YqmN3T+ind64Us+VgFmwV2FYhEYQmT7qlwskgy39DliuBEJXTzjhvi4OruSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=lqf5AkAa; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="lqf5AkAa"
Date: Fri, 2 Jan 2026 17:30:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1767371454;
	bh=W9x6B8RzXHD/s8bwGkmccsIgeP5fFleFJ110N4EFG7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=lqf5AkAa/DoxkAYzjCuBjHhW+xWFdftVlnaQy71fwhffSKJqE0SXgt+qVrCJGIvSu
	 mCq00ogYsb04ofykSwXzsY5TbCgigxrqBPbPFuuc5duzFyyhWXP5zTcHG3/Sjmo3KX
	 c3LkNMivFTKjZIdEUOr0R2Qg+acBDyzy9aS+fTmghtotPOQtxw1VisplcNxQubXRdB
	 wizQhu87oa6ebSs7NNcs60u54Nna1C6wq/PCE2OsKwOKOs7U7WPP+QYEjEwUxdjrwo
	 4tQjfDfdicqbYjucDpgmCdthoZhoCkKTZgROznMG+HkrUOFtCsk46BSnyMzsa410/5
	 PI5bsenp+hO0g==
From: Markus Reichelt <ml@mareichelt.com>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 0/6] video/logo: allow custom boot logo and simplify logic
Message-ID: <20260102163053.GE26548@pc21.mareichelt.com>
Mail-Followup-To: Vincent Mailhol <mailhol@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
References: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>

* Vincent Mailhol <mailhol@kernel.org> wrote:

> This series allows the user to replace the default kernel boot logo by
> a custom one directly in the kernel configuration. This makes it
> easier to customise the boot logo without the need to modify the
> sources and allows such customisation to remain persistent after
> applying the configuration to another version of the kernel.

Hah! What I have been doing for so many moons is to just cp my own logo
'logo_linux_clut224.ppm' -> 'drivers/video/logo/logo_linux_clut224.ppm'
for each custom kernel build - that works like a charm.
Maybe... I'm too pragmatic? It's that famous 'kill bill' logo from ages
ago, 224 colors PPM

Haven't tested your patch series cos stuff just works for me.
Looking forward to feedback from all those logo nerds out there.

Markus

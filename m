Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03EA386451;
	Tue, 14 Apr 2026 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183743; cv=none; b=YGzV15BrqIXDq504dxbUKDwhCXZ5bNYmnehYMzk9zmJo1Lbp4T+HfVWx2bluuATPwtEPF2yHA+Gokn7DvtAQ8dr5UqBzRD+keHv2mHwrbjb0SjPbIst8/4WsUqOMou3qUxt8eHAYPuVH3+CEgg9++SjxvS60AW4ydxIZTDPPkfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183743; c=relaxed/simple;
	bh=7QPQx98w0vfSRTmQEZsX9ZnLp6xe+L/O04W9VIyKjf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txvxGsociFOnzMpd2zuYsAjLlSrNSYzEbh4Ggfyqs21d304kczUxS0cWgn+qQP6Lzq6LpK0IC1MPSiIzjmUkC0aXps2TmtK/Tk3sNukqUx7gY9WW7R24fvAUmg5Ylxd/fpxTGx1rrGNV1pBobWI9UdNvPNsYpdW0yloBM2aFT3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLO5NtAY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLO5NtAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7005C19425;
	Tue, 14 Apr 2026 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776183743;
	bh=7QPQx98w0vfSRTmQEZsX9ZnLp6xe+L/O04W9VIyKjf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLO5NtAYQ3osx0vyOtFP1RnfpoGlWrjRR97Mxf9XLnThmWAGOO9tg2Hqqa+qIwRgt
	 2mfYUWa9PhPht7lmX60IpLZNfYxuhAHNl/OuMIkc4H0Zixl9Md1gCoAJbhAnKBBBmf
	 CbPqa1Sjm2covRdFAdBBPhw8mtkvgSsnCIX27tSgBjQMX6+bInyYGfwaMmvewPaEqy
	 Q+Z1ftzFyrxsXjO0yf7jCFHjZVw66+3KGQPvFNh9Lwd9DWLhyJ+dkgVEh0dmN0Ij01
	 W90XDZ26CR7ri4yB5oJcuAapKP8AZY+aC0Qdbyw9FERiZzjgYyB2kdeKoxaSXHH9k+
	 GwFhCLAn5YbhA==
Date: Tue, 14 Apr 2026 17:22:18 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: Add cgbc backlight driver
Message-ID: <ad5purZ0jef5a1KR@aspen.lan>
References: <20260327-backlight-cgbc-remove-x86-dependency-v1-0-4851c9e95371@bootlin.com>
 <20260327-backlight-cgbc-remove-x86-dependency-v1-2-4851c9e95371@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-backlight-cgbc-remove-x86-dependency-v1-2-4851c9e95371@bootlin.com>

On Fri, Mar 27, 2026 at 08:39:33PM +0100, Thomas Richard wrote:
> Add missing backlight driver in CONGATEC BOARD CONTROLLER entry.
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

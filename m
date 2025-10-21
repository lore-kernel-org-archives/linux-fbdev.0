Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E23264F99;
	Tue, 21 Oct 2025 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032274; cv=none; b=F93bX6ICBZTCW/rWqDxms1X4ZEvsis7dzQoB4qQRZEQPyYXgdrNu3IQqwpWynBkwS1iTwJWPPNpbilMP4Um8BiX1YW58qMkODlPRCiakvEacFFz/4N5RsXtmpqO0PPgrw9tEx8ZxcZIJjJ3UExZsUSFIAatHY0xyFYfbUazagWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032274; c=relaxed/simple;
	bh=lZKwihMCOd7/pzj0SQjHelSQ5IF7oTaMW+peov8i0ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFgm9nixEQtIDTtA9HKdmBv/3G3kbbUbnaSgIhe0T/2XeGeEDCjqI30JgixzZMouT/GjJmVDEdpa5jHj/uTdcgQM+87znN5DpOI3D68ko3qv7JbwOmyYskZFeeXhSUT67JOSiaG2zBdkCBqHdfH2UTlv39rcCnWsTra5Zn+Gx4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kW/EJQgP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kW/EJQgP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDB2C4CEF1;
	Tue, 21 Oct 2025 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761032274;
	bh=lZKwihMCOd7/pzj0SQjHelSQ5IF7oTaMW+peov8i0ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kW/EJQgPBBI7WcMU1JHnx8XIIwwccqd3W5ijXkwJKyVUOvmJCjlyVBlQTUuHo24nH
	 0aoCTuNsaanKdzvj8Utef060Q1z5lmWz/x3HoKZmvdmNpQxjmrwAiBMWHDvHiLjhHR
	 aJtN2r5Q5PNcOMbfQZYWSFcEORE0Kx1b284tQd5g=
Date: Tue, 21 Oct 2025 09:37:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Olle Lukowski <olle@lukowski.dev>
Cc: Andy Shevchenko <andy@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_ra8875: replace udelay with
 usleep_range
Message-ID: <2025102120-ride-repaint-7a22@gregkh>
References: <20251020-staging-fbtft-ra8875-usleep-v1-1-9592dd390c13@lukowski.dev>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-staging-fbtft-ra8875-usleep-v1-1-9592dd390c13@lukowski.dev>

On Mon, Oct 20, 2025 at 10:15:36PM +0300, Olle Lukowski wrote:
> Replace udelay(100) calls with usleep_range(100, 200) to allow the
> scheduler to yield instead of busy-waiting. This is the preferred API for
> sleep durations above 10 microseconds.

As per this type of change, have you tested it on real hardware?
Without that, we can't accept this change, and such checkpatch.pl
comments should be ignored.

thanks,

greg k-h

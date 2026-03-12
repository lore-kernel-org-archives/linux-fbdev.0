Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFEA36C0C6;
	Thu, 12 Mar 2026 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349347; cv=none; b=f8EsxmmPOTncBlbTSGc3ZEVf6H5LbV/zDmM+XodSp8ynwFcsu1pxMV0cKrKtLJ545Gc0LiA3ebnpqxmih8WLWZpPVyIk9JOGlibGggnJGeCEx3J95SBO9wAYr7AGtVoSBG4q0J+rAOw7bMZAK9IX5E5v/DdE8bKXT03/DGoIM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349347; c=relaxed/simple;
	bh=HBjNEsK0kgWWG6H5HyNT9caAsXMcaiE0vxMO6T4D4Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzJYC6ztPWt7UkQOAJXoWx+tuktCoKKmlo9iPYxh+T9CcvDA7Ded/pbfgEnW4k18IonQwmx2p8/9V7t03u44wgYVG0dGejLzXwPkOr9ugXp7RdKDdwxy43v5FaH0iOiUv4a8IKL4Yb8wg/oORboBMJNvW82Gp+HuoNm7LYD5PJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1/Rx93PS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1/Rx93PS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=rvd89gy3M/R88xH2NB6tQwBMKfAM+iXnOUeThTDccJE=; b=1/Rx93PSD4XhywynZXNYgCMI2x
	RgAKeeyHO2saVPOJsuKlt3vxGGVQT3DGmWlnXRBetrxYt3NOUK3EWshx17jvGYWd8WZ4TqzQvebAT
	FNazQJRzDabG2KIZuACvkNXeV2GIbRaWJ5NWvhid0TcZTp7Tt7IH3u4fMEicQWwzd68eQ8rrA964s
	oIKoT8+t2AvHT8zNi2D91gImYnB6EAGZjovnvfq42J2e9LE8wuRLjwfIsb8+VTIU7sH4IN/u2aGzf
	W+7YXr7omURbmx7qTWK5GLYmdyI3rv0OW9GVogNeze7lSfNV8K4Ox4iwXNeogxnA9cZW2VGyR5bn9
	h5L4yV6A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nAi-0000000FOT8-2SJi;
	Thu, 12 Mar 2026 21:02:20 +0000
Message-ID: <034989df-cf86-4136-8522-6c48e5523645@infradead.org>
Date: Thu, 12 Mar 2026 14:02:18 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fbdev: update outdated help text for CONFIG_FB_NVIDIA
To: robgithub <rob.github@jumpstation.co.uk>, Helge Deller <deller@gmx.de>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org
Cc: Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
 Sukrut Heroorkar <hsukrut3@gmail.com>,
 Mukesh Rathor <mrathor@linux.microsoft.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260312205507.70b9013b@hexa5>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260312205507.70b9013b@hexa5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/12/26 1:55 PM, robgithub wrote:
> The help text for CONFIG_FB_NVIDIA refers to obsolete hardware and
> incorrect default behaviour. This patch updates the description to
> reflect the current state of the driver and supported devices.
> 
> Signed-off-by: robgithub <rob.github@jumpstation.co.uk>

Inline patches are preferred over attachments.

I thought that Claws mail could send inline patches successfully. (?)

Documentation/process/email-clients.rst says that it works (after a little
configuration setting).

I don't know anything about which products are supported, so I have no
comment on that.

In the patch, the indentation is incorrect. Kconfig help text should be
indented with one tab + 2 spaces, not with 4 spaces.

thanks.
-- 
~Randy


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7875933A032;
	Mon, 15 Sep 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947911; cv=none; b=LKAgT0voclKFqMziTL84K+LBmUgDlY0Tj6RX+v7xvR/gu2ebFtqisYobTEUO9b/KASrT/VUukdYkG4FeY0t7jsTbrOHfOI63S185paXCPbQwllGSir2uTC7o1g+SYj64l5ceMoCkEen30gdaaA1ulXYXQfTg9VqR3jLWXPXntgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947911; c=relaxed/simple;
	bh=U2NxZp55bh/g4Bpl7yA/2C+cFMjRxak3v0321vSLHbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKkka9E03J5EcdJ23KKUclQNn9YI/hNbDqup0vtCKSBNK/qAPHqrx/mNtU6eAP7+5ic+gce5wxwPYg2ANsBFavsOlZWbvfn/SEuOx0NUKSAW2DQbdTTHBhrKF4ReeqKbhJjnsMknP7ViLbpjmljwDhKLINsdALxi+Kud+jDHA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQz8ZlBG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQz8ZlBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3908C4CEF1;
	Mon, 15 Sep 2025 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757947911;
	bh=U2NxZp55bh/g4Bpl7yA/2C+cFMjRxak3v0321vSLHbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQz8ZlBG3AUGf1039ykzz5ukRMehIllHrqWRuHJxYUKbJ9RLtOto2t3ViKa3rEvlT
	 5Y7C0jHirt0PXvxH/soZWDWKfjtZwIHJCPym0Z3MgJLvkXfLrqbLI5X0csa5hJVrm+
	 SnHLBwqrepxZMFOPaHWc5Pz+v1RBgunZ/GG4slP+87wubUyDfx+UCZQWLqMpd3ppkC
	 1Y1UpB5KVBhb8UX+JiD5DiBVKx6KDVDLf5iORr71lLvj9zW+OS2BTkDGIxaWU6DSKY
	 mIkvFOsOTPoRMnyyyC/hxWpmRaD2d3B1R+B1ZLP5insPotIx6scq8wrcYh2TRODifi
	 wkRUEu+4ullHg==
Date: Mon, 15 Sep 2025 15:51:44 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com, deller@gmx.de,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, simona@ffwll.ch, fnkl.kernel@gmail.com,
	j@jannau.net, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	sven@kernel.org, alyssa@rosenzweig.io, neal@gompa.dev,
	support.opensource@diasemi.com, duje.mihanovic@skole.hr,
	dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 10/15] backlight: jornada720: Include <linux/io.h>
Message-ID: <aMgoABOReK7j6QuP@aspen.lan>
References: <20250715122643.137027-1-tzimmermann@suse.de>
 <20250715122643.137027-11-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715122643.137027-11-tzimmermann@suse.de>

On Tue, Jul 15, 2025 at 02:24:47PM +0200, Thomas Zimmermann wrote:
> Include <linux/io.h> to declare IOMEM(). Avoids dependency on
> backlight header to include it.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E21D53D;
	Sat, 17 Feb 2024 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187086; cv=none; b=NnVvbcne5GWqL2eA2vR1I6ZHa6+Wap9Jf/ehm2Ys/2dMfTREN759cEilbnsskZo7REGl+aIxZl103WcGQeseUApuySwGVNRCKcRB4WCvXQey6UMaC8PjjzDBoVlXRP17gwA0W9bvRO11LO/UdP+vzfvdiKAm47TmmMLLMPunQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187086; c=relaxed/simple;
	bh=ugLCeL/mwE26YkA0WU8mZxmfRwV9jKgBifhbOfWy+H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPPI2OK8BBuP/sg1QbtipkKfdWmFcB77U6XQSOwEgww+jpVBWFExGSibuJgfuNGxyCbd4HyVRSZmxAsrizhRcEKIkZQldhXr4ltFvKFLLk/Z/cH1sKoPk4zMy1ZGIDaf1XnTVjTIhcxv2T3Qsj3ekMY0yPfUNELsy4VXr0rcuec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GMHsUtT7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GMHsUtT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69424C433C7;
	Sat, 17 Feb 2024 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708187085;
	bh=ugLCeL/mwE26YkA0WU8mZxmfRwV9jKgBifhbOfWy+H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMHsUtT7uwx4J71+s3VCzwTbwMxN1fCnPfDM+4CRRb03Finq8MAZKZOYQjMeosCxQ
	 ABQMPlmAWVhPf28MYvEy9WIlCveqen1s3MinNTrVe1lo4mf5nVtk+VnL95Vh8SPS1l
	 0RYrMdtnGGRXJK653t+cN+FZ5nFxRFjerrJMGsW8=
Date: Sat, 17 Feb 2024 17:24:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
	jani.nikula@linux.intel.com, daniel@ffwll.ch, airlied@gmail.com,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 2/8] staging/fbtft: Include <linux/backlight.h>
Message-ID: <2024021735-impure-excitable-6266@gregkh>
References: <20240213084403.20995-1-tzimmermann@suse.de>
 <20240213084403.20995-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213084403.20995-3-tzimmermann@suse.de>

On Tue, Feb 13, 2024 at 09:42:20AM +0100, Thomas Zimmermann wrote:
> Resolved the proxy include via <linux/fb.h>, which does not require the
> backlight header.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

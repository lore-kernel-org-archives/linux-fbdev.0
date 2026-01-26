Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3720DD52;
	Mon, 26 Jan 2026 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416108; cv=none; b=aa6TbOAb/6tKahLYply+eaGnIMIi3kd/guM3UUpUpJJTaYr5IaVj7x3aucW9TII5xe+pXmPtlb+Xyx8x2zUics6HEMQF2Of4BxSgNRCx/qodR4eH+6hyiZqGI+yG7193ium+VoCJfwTlijNCBcO8rdErS9tY4f7oEaoJZ2hYf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416108; c=relaxed/simple;
	bh=usa0U3J/t7rWhIRFX+n7Ph/rpD+CzdJPl76FuUsIbac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAx7C3uxW30sQkKYiRjxvpqnQ3B7tNJEFZ3yYvAeYeUAesJ4v1fB9gyF+bCxauMfY/EaOR4ba4ovAl6bUgRyUKVmrr6EhPB3eOO/B80A+bCddat0NjSjSFVYmWIzyHJkf5uNfTeHKfcjw5MQAFZA8ojRLk9QIbVfmNcmy6R3Ptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLbaMKG2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLbaMKG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F048C116C6;
	Mon, 26 Jan 2026 08:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769416108;
	bh=usa0U3J/t7rWhIRFX+n7Ph/rpD+CzdJPl76FuUsIbac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLbaMKG2HqHjC04DLKVtYluLnUfTTSbSWRr1mBIcuzHf3uaJZ8BNjyFc4ct6qZtLN
	 v3STGt0FH9SOZ6fEMyLxlQlsbfQyXS+RwXeukVCA5ZaAZM3vww5ygd61H7YS4lGV5y
	 cZM4nszFqTeA8M0c061Use+X9L1XgzHXBqeyePVb4AEs8k+sYrpsflmeZeJUYWiKif
	 BG3mDW2UgaPiGy37QZgsi0SVMLijQ3oc4/F2GzegPmBPMWw1dtiOnF/6LHg+yTimcz
	 C2DbteJeXEjLNu6XX/L6yeuL3s4FokDEBDgk1krl3hLTmcXjRbTP4dHWdQuKxSYbux
	 7SzQHZVPl6zzA==
Date: Mon, 26 Jan 2026 08:28:23 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: briannorris@chromium.org, jwerner@chromium.org, javierm@redhat.com,
	samuel@sholland.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
	chrome-platform@lists.linux.dev, dri-devel@lists.freedesktop.org,
	Hans de Goede <hansg@kernel.org>, linux-fbdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 01/12] firmware: google: framebuffer: Do not
 unregister platform device
Message-ID: <aXclp4omCL-BTV7R@google.com>
References: <20260115082128.12460-1-tzimmermann@suse.de>
 <20260115082128.12460-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115082128.12460-2-tzimmermann@suse.de>

On Thu, Jan 15, 2026 at 08:57:11AM +0100, Thomas Zimmermann wrote:
> The native driver takes over the framebuffer aperture by removing the
> system- framebuffer platform device. Afterwards the pointer in drvdata
> is dangling. Remove the entire logic around drvdata and let the kernel's
> aperture helpers handle this. The platform device depends on the native
> hardware device instead of the coreboot device anyway.
> 
> When commit 851b4c14532d ("firmware: coreboot: Add coreboot framebuffer
> driver") added the coreboot framebuffer code, the kernel did not support
> device-based aperture management. Instead native driviers only removed
> the conflicting fbdev device. At that point, unregistering the framebuffer
> device most likely worked correctly. It was definitely broken after
> commit d9702b2a2171 ("fbdev/simplefb: Do not use struct
> fb_info.apertures"). So take this commit for the Fixes tag. Earlier
> releases might work depending on the native hardware driver.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: d9702b2a2171 ("fbdev/simplefb: Do not use struct fb_info.apertures")

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>

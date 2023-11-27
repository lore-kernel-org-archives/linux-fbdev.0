Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F1930357;
	Mon, 27 Nov 2023 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gVydtS9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5ECC433C7;
	Mon, 27 Nov 2023 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701093253;
	bh=3+9Ueuma8TxHWXhIh18cI3XqRceeHiPhdxjt04xqfAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVydtS9gZm84o8VAEMNb8GBXKlgSAvD7mZIM21b+cTF+CRDORd3CbHdp83N4+w+8m
	 v8kqcaUWwLS2NgdFbDcuM032o+oKv62Mhqxz62pHUm/AGaLEnHBKVpFPnutcwHfF0i
	 u3y2gZtrpzGlFCbERyml8074Usts0mI9oJZ+niHI=
Date: Mon, 27 Nov 2023 13:30:07 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, deller@gmx.de, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 26/32] staging/sm750fb: Initialize fb_ops with fbdev
 macros
Message-ID: <2023112700-pulp-framing-806e@gregkh>
References: <20231127131655.4020-1-tzimmermann@suse.de>
 <20231127131655.4020-27-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127131655.4020-27-tzimmermann@suse.de>

On Mon, Nov 27, 2023 at 02:15:55PM +0100, Thomas Zimmermann wrote:
> Initialize all instances of struct fb_ops with fbdev initializer
> macros for framebuffers in I/O address space. Set the read/write,
> draw and mmap callbacks to the correct implementation and avoid
> implicit defaults. Also select the necessary helpers in Kconfig.
> 
> Fbdev drivers sometimes rely on the callbacks being NULL for a
> default I/O-memory-based implementation to be invoked; hence
> requiring the I/O helpers to be built in any case. Setting all
> callbacks in all drivers explicitly will allow to make the I/O
> helpers optional. This benefits systems that do not use these
> functions.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-staging@lists.linux.dev
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806945592F1;
	Tue,  8 Sep 2026 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881253; cv=none; b=iYkMdJfNyLjkDdrQZ0h+XsQGsKLaUni64LWmMlTg7CXPM44SmiXsX8a6/ue5cc5GLf49JKAoLVqc1AXT4Mu2t/ZpsyDyg74K6/C/q3zN6HejJGTO+mVVMN2PkDvWfJkNw0dJQi5QhAqqzRFyUmKH8IbOSRp/URsPaGLtD20b0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881253; c=relaxed/simple;
	bh=LDIeXFUopTSINrPNEcCn3RhrD5FDxXJRt0fSAhAvEBU=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=QYBiZ6ZM+zd5Ia8QsASy8+WC6sFKpX3vnEvLqpOOV8QOOoVbyO629j1XqpFSjjLn5bOqmAgRTBr8eYKAPDGY1XaSG7PbSVb055lBHbhbOoxysIaqTgY07D6gXVG+oblQg2fVkxSoL2nXdsMlNUuzVdIypaTKdy+sB8dhSaIq5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5c65ouB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5c65ouB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F591F00A3A;
	Tue,  8 Sep 2026 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788881245;
	bh=9Y0RYiQlqdq8T8rHGKcY5WJFbZOHMj5XD8BYUCfkmiM=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=i5c65ouBuEyZ6oB7J0Er0dVut/Yg1ePEEy4oGAe64mY5uM6ZfpbkeT5m9W1IA29ab
	 JpZ8/TAPB6a+2NvkxIL3f43y3pKy3+R0TC/cYTdy6ySa2sA4ar26sqHKau57vlmrUD
	 jUqXiw954XFwqTofPlkk19Rd+03vy+ibx0rr6Jd6qWdhOzm+xsuUUy33Uj1Yq52ZJW
	 ijmyGte57XMTYBeOmQngxbymMaE/F8EJ6TAWS+WzjcxZj+Lz3mcDTkMdZK7PZzdBmi
	 IYXFACNOY2LwM8qmgJLPf4tQ/RvntUz7HPGkC10AaLkELj5a6/IQ76M/xV1tJVqxDk
	 w55vjeDNey8AA==
Message-ID: <315455b0aa801c7dbd1b1e2ecf7282c3@kernel.org>
Date: Tue, 08 Sep 2026 15:27:22 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 4/7] vga_switcheroo: Add post_switch callback to
 client ops
In-Reply-To: <20260709092215.168172-5-tzimmermann@suse.de>
References: <20260709092215.168172-5-tzimmermann@suse.de>
Cc: airlied@gmail.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, dakr@kernel.org, deller@gmx.de, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, jfalempe@redhat.com, joonas.lahtinen@linux.intel.com, linux-fbdev@vger.kernel.org, lukas@wunner.de, lyude@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com, sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tursulin@ursulin.net, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

On Thu, 9 Jul 2026 11:16:00 +0200, Thomas Zimmermann wrote:
> Add post_switch to struct vga_switcheroo_client_ops to inform the
> switcheroo client about a completed switch of the output.
> 
> This callback is intended to replace the reprobe client op. It is a
> rename of reprobe for consistency with pre_switch.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

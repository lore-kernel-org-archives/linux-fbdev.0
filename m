Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8504517BD2;
	Tue,  8 Sep 2026 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881287; cv=none; b=Xifv7AG4G5cRUk/pwUV9q8BuBmCRFVoWb20Rw44e3qhbzRbU4nxHUjIu+RkGKeUykkdm5uPFXvvJo4Rt28GmGjxyNwcNP0ptJ4lLbhdcU9iW/xnIZPk/UUMLjkVRzKZbnEgN6a6cL92IXub4dJwbkg1bastss7jGvUgqTNejAMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881287; c=relaxed/simple;
	bh=O/rkv+CIuEu8T1QlxSeEFwDTvGzAyUGKViPcnMdI1kQ=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=jf/QDg7O3kgQaEbzo1uvOoPoQkmIHFdcqr4rbmbZL+moZzrbWHE7D9vp3bNsWckRQ8TVt602rfirlv2hXgptQQikkKfEJRMvCuZLOXaZKAk9HDp3mdB8oN+Pfm06JxM1MHS0ezdNrkFjsXphXS/UxBlkzQKO4kUUR0vNk8FM86w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvCV66AB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvCV66AB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205C11F00A3D;
	Tue,  8 Sep 2026 15:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788881277;
	bh=qQbruPdcRkbgl8HfIhF5I/ft20+teeU0jvwgM4rj26A=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=XvCV66ABTo4OWC/44sKVa92p43c+0v2J/iue6EFeR7/Ok7g9uSLGMfm7n9kpFj+16
	 eaikSUvoM2QGhoGsPbre8P6lPx0m5u79AcCtOL8NixpXvvpGIOiF04OfQV3zomh5TZ
	 f3fXub9npQTUMyUJhRJ5Fswyh1Z5p5dLb8nCk+HQiCMiFmNxmADmW9gI0h4g6nfSGw
	 EXqAJM6Y8TwdYsZiWXGUcNq56dSWn3+VTCvOiUanLgZEith4u8+5FXT6jvORYU7bXF
	 O2/G0LRiyojLTsip/Af1WrCdo3eZlYiM4WM7rNVggZa/d3sP+EDG9zDB+raGj+HlMv
	 9IimSxGYTwg7g==
Message-ID: <73f10ae2aa96eeefbec0f1308d85899b@kernel.org>
Date: Tue, 08 Sep 2026 15:27:54 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 5/7] drm: Implement struct
 vga_switcheroo_client_ops.pre_switch
In-Reply-To: <20260709092215.168172-6-tzimmermann@suse.de>
References: <20260709092215.168172-6-tzimmermann@suse.de>
Cc: airlied@gmail.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, dakr@kernel.org, deller@gmx.de, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, jfalempe@redhat.com, joonas.lahtinen@linux.intel.com, linux-fbdev@vger.kernel.org, lukas@wunner.de, lyude@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com, sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tursulin@ursulin.net, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

On Thu, 9 Jul 2026 11:16:01 +0200, Thomas Zimmermann wrote:
> Call drm_client_dev_acquire_outputs() from vga_switcheroo's pre_switch
> callback. Pushes fbcon updates from vga_switcheroo into DRM's fbdev
> emulation. This affects amdgpu, i915, nouveau and radeon. No other
> drivers implement vga_switcheroo.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

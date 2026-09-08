Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F3C55292C;
	Tue,  8 Sep 2026 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881335; cv=none; b=rW7QeAH5DetAnjXftuqYzJOzPMzPf2qAJXl3JDnuKaTwdb5SRiwvvkrrBU1N1/16rukG84RBPspblr2dIuUW7o5hV2LaYLsJdGJkMf8KP73FpEw8VtDvz/SLv/ygXWA8IZIbGzyb8sDUcumln2FS/ijvPBug+aBEdsgtQ8Rey+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881335; c=relaxed/simple;
	bh=SAX51uipggwjwhVhuLZzQSv1Ugsk+esZJ2OCKPxsuoA=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=TUsvNcwOoNdWbkLB10pFeQOxqFW0qveMbAmyUOmxQ/Vcla+AJetyug9jxzNZR7mJ8zYJBV4SVkcXLCg7qMQD/jM1/pAGIT/OaJjifFsz35zJkxDkwCiLE86F4VJ5VQULDrXXYbOS/l5ORyIDpbxFrZbEziRRIdOlxAW4+nwpvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV9cKUZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV9cKUZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D9C1F00A3F;
	Tue,  8 Sep 2026 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788881328;
	bh=i5px7Z02W9P6PnBrjrtniLAiKpg60s8L1n7dEkh5OQ4=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=AV9cKUZR4BhWai6g0oRaFc+2nidqX3yLaigBsGDyNfIM9Tp9ryU2OpqVcrUTzyMJ0
	 a7rHY3+Dxqx77MNGGXEBHbWhivFf1kRuBhB9zr/0JzXUii3rBKbtWHVLrXD0ObgDKE
	 4Rb3TTUQ6T9sL8hZvgbUK7hQfZFnSfYzfcZ/FiHiCWjzRkUq52HEZ1sLetA+UpjmJs
	 ynne02lnBaKeUPBAbk/k/4X3FDPGQyZPTfqAwwbsLw46L4fAPFbthEt35ALko5jj9M
	 X8EzF/TchCrO3QWwCAYH97FlSzn+aZabOSmxvtw5S7rlS3RMAGxFks23AE3qmOuA7A
	 MMWb30OAsCDbA==
Message-ID: <88959eaf8836f080a10f67dda5e2adda@kernel.org>
Date: Tue, 08 Sep 2026 15:28:45 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 6/7] drm: Implement
 vga_switcheroo_client_ops.post_switch
In-Reply-To: <20260709092215.168172-7-tzimmermann@suse.de>
References: <20260709092215.168172-7-tzimmermann@suse.de>
Cc: airlied@gmail.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, dakr@kernel.org, deller@gmx.de, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, jfalempe@redhat.com, joonas.lahtinen@linux.intel.com, linux-fbdev@vger.kernel.org, lukas@wunner.de, lyude@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com, sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tursulin@ursulin.net, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

On Thu, 9 Jul 2026 11:16:02 +0200, Thomas Zimmermann wrote:
> An output's attached display might have changed while a DRM client's
> device did not have the output switched to it.
> 
> The nouveau_switcheroo_reprobe() callback sends a hotplug notice to
> DRM's internal clients, so that they can reconfigure their display
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

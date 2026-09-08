Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF1559311;
	Tue,  8 Sep 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881048; cv=none; b=gWaRn3xoZhPciT5MoAOAJTTaaMMFfR4pbLI5h4XXIVX3JG0TITHsbTnnycOcRrZqk6eCHeJ0po8iLjudyMJ/kXvIl2WsMZGJRqEiFsQ1V3RDLMGhPTwceCRHw91nTD4HpvKbyPY5oxrkXSwOzjnQud4qbEBtix0NwSg4Kt81G9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881048; c=relaxed/simple;
	bh=z+07XIyvk26kw721M87RfmrOAqtbOvzfpl5JJTAyUnI=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=g5Fqh8eLEf6wTtWzwyvvLbs2TEMpfub0o7OhehTuOjMwajBUtdWBrdKE4Ojnr+CSJ5rN///3Ui74fNci+fud7wZXt+M6yvkKGV1xWnE3b/dOcDNmx5rXeL7XDE402f9eIelIy3z3j797M48oz56Bk+uY85n1OY42v8fVSY68yrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885BE1F00A3A;
	Tue,  8 Sep 2026 15:23:57 +0000 (UTC)
Message-ID: <2a3a7a962caadab3399d3e03f5538d90@kernel.org>
Date: Tue, 08 Sep 2026 15:23:54 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 1/7] drm/edid: Include <linux/fb.h>
In-Reply-To: <20260709092215.168172-2-tzimmermann@suse.de>
References: <20260709092215.168172-2-tzimmermann@suse.de>
Cc: airlied@gmail.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, dakr@kernel.org, deller@gmx.de, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, jfalempe@redhat.com, joonas.lahtinen@linux.intel.com, linux-fbdev@vger.kernel.org, lukas@wunner.de, lyude@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com, sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tursulin@ursulin.net, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

On Thu, 9 Jul 2026 11:15:57 +0200, Thomas Zimmermann wrote:
> We currently get <linux/fb.h> via <linux/vga_switcheroo.h>. Include it
> explicitly.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

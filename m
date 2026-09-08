Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB699558218;
	Tue,  8 Sep 2026 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881228; cv=none; b=dThiCoUtdEEB4Evaqm1bzWTW0O4PWbNlRuug3/mUNo9S5gvysCtQBwSWYtAetfUPgxtzFpRzFyRjK3RgwgiIiW3vxx3fpQf8gc51/3D5hXYiisBXeAl0mzFDr+ZpqwcjG/pq99LBJvidyjmeb1NALVARzFS722qJBLrl0MQaKHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881228; c=relaxed/simple;
	bh=HIpj1xX77+ZjqlOmTpu4xpWPdZtezlMr9cAqsTk6EMI=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=Q/jYAUJaJANMhrYT6NPa+5mG9gZP0l5b0xz8Zo2DeaicY0X071+/tQgdQSfs0A2GT9Ld8oVHF2HYw62LjEhR8inqrCd4arwPQZUUg2Rz1D5Ta51Y2Dm/UCVN+T8vdm5jUW/OKMPDPve0PDwN+C8Ynu2u022dPmvBphdERn+1FXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJaO26YQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJaO26YQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADED1F00A3A;
	Tue,  8 Sep 2026 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788881223;
	bh=45Fa9JFJgFfxvMXU87kkWtdb4QSxmQx0SdJUFfq54ZE=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=WJaO26YQEBESzQ+3+b4rBC4UvX2za9FEQXE6OjU06tsjMOKruOfHgjVU3OfNEKChr
	 Vyoi1VuCgZ3tlP62Ne6W+P7cu3seWG0c/EHV1AFLITSLy5tFI2iqIb8hmbhxb7Kvl9
	 WFNMiCfnk4ILz94eoTQWnkmM16Mjg+5EWijqRsK0cQP9UPnZo1DdiwmDs1Hk9/tPJO
	 PlS6aH1ZBPSAyr7BcO6VhkrJqpyV5xIxqPrnFO4tytf7Y4EwEIV3jv9xQ4+Ml+kqMT
	 AFMq2j7A4SCxp6nKvzlPeQ8PtwtNc7gmAlwN93R3Ams3lJkVXm13RWHUJhwxGt6PuR
	 vqjKcbOPxYy5g==
Message-ID: <467a6478db3c7140ca9f4d0e5c11d029@kernel.org>
Date: Tue, 08 Sep 2026 15:26:59 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 3/7] vga_switcheroo: Add pre_switch callback to
 client ops
In-Reply-To: <20260709092215.168172-4-tzimmermann@suse.de>
References: <20260709092215.168172-4-tzimmermann@suse.de>
Cc: airlied@gmail.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, dakr@kernel.org, deller@gmx.de, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, jfalempe@redhat.com, joonas.lahtinen@linux.intel.com, linux-fbdev@vger.kernel.org, lukas@wunner.de, lyude@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com, sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tursulin@ursulin.net, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

On Thu, 9 Jul 2026 11:15:59 +0200, Thomas Zimmermann wrote:
> Add pre_switch to struct vga_switcheroo_client_ops to inform the
> switcheroo client about upcoming switches of the outputs.
> 
> This callback is intended to replace the hard-coded call to fbdev's
> fb_switch_outputs(). With DRM supporting more clients than just fbdev
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

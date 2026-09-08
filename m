Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3087C5592E9;
	Tue,  8 Sep 2026 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881354; cv=none; b=BDFug3OgQetGP96/hO9r5Y0fpVoz+70Kdcrm+TAcOyaNtNAbYYchhVqmluWXEmA0dcM86ruDLNnqP3r+BfGj/wfqJtpQpYhdiXaphRwWz/ejRinnphtLg0E+EgDILdjX4w6kiZpw/tLrvpJcaBcVVM0yWmHmrIw/BRtFmjLpLOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881354; c=relaxed/simple;
	bh=NlBtDJi3P9pIUHGAjCufD+ui7QB8zGF8I96T0bysY6k=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=opjvIjQACdmSQik6hqOhEjIchDLTe19FP2/jHXdTj9ssqMMH9D4SgZDxBFfOas2Xck+Q9LlhAWc3fpuqx6DXTby4qX1h9fKlqY9BD/lEhRRa1bLLd8qjoQMg4KShAiY5MwoNN8/vRvgQwHriwaFBhMLs2Ovg+W7S5g6Hm7uru/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16FA1F00A3D;
	Tue,  8 Sep 2026 15:29:06 +0000 (UTC)
Message-ID: <449b3558fdef8f6d6356b72c933e751b@kernel.org>
Date: Tue, 08 Sep 2026 15:29:00 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 7/7] vga-switcheroo: Remove unused interfaces
In-Reply-To: <20260709092215.168172-8-tzimmermann@suse.de>
References: <20260709092215.168172-8-tzimmermann@suse.de>
Cc: airlied@gmail.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, dakr@kernel.org, deller@gmx.de, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, jfalempe@redhat.com, joonas.lahtinen@linux.intel.com, linux-fbdev@vger.kernel.org, lukas@wunner.de, lyude@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com, sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tursulin@ursulin.net, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

On Thu, 9 Jul 2026 11:16:03 +0200, Thomas Zimmermann wrote:
> Remove all unused interfaces that used to implement the functionality
> of pre_switch and post_switch.
> 
> For pre_switch, remove vga_switcheroo_client_fb_set(). This further
> allows for removing all symbols and data structures that refer to
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

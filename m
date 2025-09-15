Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D533A02D;
	Mon, 15 Sep 2025 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947974; cv=none; b=gOwQz9X7nh4awGsBC5teuIaH2eWFcJXL2ByGErgukWX+KyNzOs0Epjxnc10Bsd6R6dgvZR3GdboXd+CEXDkzHWMjTUjvarsiZGMbeCRSQMRaRM7HTU2kym8umjUawc6/YovgoQiUcCCOsWmaBWzh1eOuXZgug/4VW+SkYhdxHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947974; c=relaxed/simple;
	bh=RlgkNdnWQ5dTMluE1r0no4k85o7lN8vC1qiDzEi0o1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5rn6TbXKgyDR8wcXvfIbKyE9vmGOtZlx4mC+zapDhU63cv7RM5gaDmxTojguuMvNXbgkfh9AnHbFF02gf2Af4n2xgHwWSOIuSiudzBPusZb1/qZF/0wWzslv1jSb3JCCF/U16+TLDUCJZc38e1Ug8oT+oL6F6EFBy7vEm6KjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqXeQ9/q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqXeQ9/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E63C4CEF1;
	Mon, 15 Sep 2025 14:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757947973;
	bh=RlgkNdnWQ5dTMluE1r0no4k85o7lN8vC1qiDzEi0o1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqXeQ9/qGMI3Xz8b/u13HhaAN30nR3xuJgGTTixqhp3D8kOkTbPhDQ0eAkP2tpKdO
	 VG1V3FMAvMrME64Dwpm0REXMmZVRGLdeMfrBrtTD9PW8tt4T64JlHtl08Q0s95xpSp
	 OOTrOKCMfiru9V78lj/zyVjLhjq49sukE654Q2UcDx+4SsLCLua3mLsVd//P2fOEMT
	 faryL7F97MuR9JJO6b4QrlI1vxbNwT/Ajuo1jVMmufOqBVJNNoSR8vPw3kkUAlc9Le
	 fud8gm6CdbgCD4H4zdIpa57utEou+HsfskAO9ETfJpaLhf23OJHbR47Hzh63kspoCx
	 tOraXDjDEu3YQ==
Date: Mon, 15 Sep 2025 15:52:46 +0100
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
Subject: Re: [PATCH v2 12/15] backlight: led_bl: Include <linux/of.h>
Message-ID: <aMgoPjEoogukj9uj@aspen.lan>
References: <20250715122643.137027-1-tzimmermann@suse.de>
 <20250715122643.137027-13-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715122643.137027-13-tzimmermann@suse.de>

On Tue, Jul 15, 2025 at 02:24:49PM +0200, Thomas Zimmermann wrote:
> Include <linux/of.h> to declare struct of_count_phandle_with_args().
> Avoids dependency on backlight header to include it.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316BA25A357;
	Sat, 14 Feb 2026 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104526; cv=none; b=EInZeAitYHP/66Y/hHsTkJdWJFmu7EtsfXraT4tEMp4d5OLSOVCHVpc3G21AxG7NTiZREhrjPl/AMe4FKds93rk1Qd6VEfwjwwhWo74lc5EFzNNhjAIqNd+H3rfA1gVG0CAZYghoaLXSKZC49B2RyIUoPupvWVhV33TCVVhYMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104526; c=relaxed/simple;
	bh=DXqKvvM5+P464FqmXM7ywFIAJJJnPeDBq6zQooW9zfw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL4zHfFE6Vn689vKEJ0dDKFiPbgEvmC67zbHQ6qLDJvg2snJEtzIOduim59qSKv9srlhLwlcWg3XWIYOJkDRTQB1rBqTmbOZdjO2uIChEeL9uAJ3qlhseSvxlLbJ1AKXdIiurQuA3I/lv8qbD4uMCHwFJyAypbTeYuZBWx+/9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfoRcbY6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfoRcbY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7652C16AAE;
	Sat, 14 Feb 2026 21:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104526;
	bh=DXqKvvM5+P464FqmXM7ywFIAJJJnPeDBq6zQooW9zfw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=ZfoRcbY6ZN6cVKeBnCI+mZjbG9SbMQoP6W0ncCipYZHusGgWb3Mmm1h5WyeexyuTY
	 BPAohFZxM45GgUnl7TKLc77gD7RuHQL7JEdhFOVoV+uKi4Wd2jG2krGQMnjQ9nENw+
	 sn+634dOOhq/oDHNEUX8uXItnw7LzMB/ywjg5QV7huSg8tksVhF4RFkX1usH05XM9q
	 BFWkEqMRyfmXRUdVWazS5uEcaJilJkpT81Z5BlK0wtVjbqnAN7pqu8awU0DCquXBgt
	 niuH+Ka3rRqrKoTt13/oX32DcM+6mS3Bl5K7JIWtTBCSZZrmgpREK7kNFXMeq2LC8V
	 0PWGfpBqoawxw==
Date: Sat, 14 Feb 2026 22:28:41 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [GIT PULL] fbdev fixes and updates for v7.0-rc1
Message-ID: <aZDpCUcIXLmuydoF@carbonx1>
References: <aZBlTsIwTzS0tqBD@carbonx1>
 <177110244909.2897141.11184148040863874004.pr-tracker-bot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177110244909.2897141.11184148040863874004.pr-tracker-bot@kernel.org>

Hi Linus,

* pr-tracker-bot@kernel.org <pr-tracker-bot@kernel.org>:
> The pull request you sent on Sat, 14 Feb 2026 13:06:38 +0100:
> 
> > http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.0-rc1
> 
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/8b3c75a39cc3cde78332f0e10898104a5e1e2807


Linus, I'm really sorry, but I messed up drivers/gpu/drm/Kconfig while
trying to fix a merge conflict.
My patch series should not have touched drivers/gpu/drm/Kconfig at all.
That's purely my fault and not the fault of the patch author.

Can you please revert the changes done to drivers/gpu/drm/Kconfig by
commit 8f582bcd132c ("drm/hyperv: Remove reference to hyperv_fb
driver") or alternatively apply the patch below?

Thanks,
Helge



From ea47a4a9b1e9c0a665df5ef6e6b9bd3653c21d9e Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Date: Sat, 14 Feb 2026 22:16:34 +0100
Subject: [PATCH] Partly revert "drm/hyperv: Remove reference to hyperv_fb
 driver"

This partly reverts commit 8f582bcd132cf1290e1fbd56b9f783dabe637dd4
which was messed up by me while trying to fix a merge conflict.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 65db9928439b..d3d52310c9cc 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -265,152 +265,6 @@ config DRM_SCHED
 	tristate
 	depends on DRM
 
-source "drivers/gpu/drm/sysfb/Kconfig"
-
-source "drivers/gpu/drm/arm/Kconfig"
-
-source "drivers/gpu/drm/radeon/Kconfig"
-
-source "drivers/gpu/drm/amd/amdgpu/Kconfig"
-
-source "drivers/gpu/drm/nouveau/Kconfig"
-
-source "drivers/gpu/drm/nova/Kconfig"
-
-source "drivers/gpu/drm/i915/Kconfig"
-
-source "drivers/gpu/drm/xe/Kconfig"
-
-source "drivers/gpu/drm/kmb/Kconfig"
-
-config DRM_VGEM
-	tristate "Virtual GEM provider"
-	depends on DRM && MMU
-	select DRM_GEM_SHMEM_HELPER
-	help
-	  Choose this option to get a virtual graphics memory manager,
-	  as used by Mesa's software renderer for enhanced performance.
-	  If M is selected the module will be called vgem.
-
-source "drivers/gpu/drm/vkms/Kconfig"
-
-source "drivers/gpu/drm/exynos/Kconfig"
-
-source "drivers/gpu/drm/rockchip/Kconfig"
-
-source "drivers/gpu/drm/vmwgfx/Kconfig"
-
-source "drivers/gpu/drm/gma500/Kconfig"
-
-source "drivers/gpu/drm/udl/Kconfig"
-
-source "drivers/gpu/drm/ast/Kconfig"
-
-source "drivers/gpu/drm/mgag200/Kconfig"
-
-source "drivers/gpu/drm/armada/Kconfig"
-
-source "drivers/gpu/drm/atmel-hlcdc/Kconfig"
-
-source "drivers/gpu/drm/renesas/Kconfig"
-
-source "drivers/gpu/drm/sun4i/Kconfig"
-
-source "drivers/gpu/drm/omapdrm/Kconfig"
-
-source "drivers/gpu/drm/tilcdc/Kconfig"
-
-source "drivers/gpu/drm/qxl/Kconfig"
-
-source "drivers/gpu/drm/virtio/Kconfig"
-
-source "drivers/gpu/drm/msm/Kconfig"
-
-source "drivers/gpu/drm/fsl-dcu/Kconfig"
-
-source "drivers/gpu/drm/tegra/Kconfig"
-
-source "drivers/gpu/drm/stm/Kconfig"
-
-source "drivers/gpu/drm/panel/Kconfig"
-
-source "drivers/gpu/drm/bridge/Kconfig"
-
-source "drivers/gpu/drm/sti/Kconfig"
-
-source "drivers/gpu/drm/imx/Kconfig"
-
-source "drivers/gpu/drm/ingenic/Kconfig"
-
-source "drivers/gpu/drm/v3d/Kconfig"
-
-source "drivers/gpu/drm/vc4/Kconfig"
-
-source "drivers/gpu/drm/loongson/Kconfig"
-
-source "drivers/gpu/drm/etnaviv/Kconfig"
-
-source "drivers/gpu/drm/hisilicon/Kconfig"
-
-source "drivers/gpu/drm/logicvc/Kconfig"
-
-source "drivers/gpu/drm/mediatek/Kconfig"
-
-source "drivers/gpu/drm/mxsfb/Kconfig"
-
-source "drivers/gpu/drm/meson/Kconfig"
-
-source "drivers/gpu/drm/tiny/Kconfig"
-
-source "drivers/gpu/drm/pl111/Kconfig"
-
-source "drivers/gpu/drm/tve200/Kconfig"
-
-source "drivers/gpu/drm/xen/Kconfig"
-
-source "drivers/gpu/drm/vboxvideo/Kconfig"
-
-source "drivers/gpu/drm/lima/Kconfig"
-
-source "drivers/gpu/drm/panfrost/Kconfig"
-
-source "drivers/gpu/drm/panthor/Kconfig"
-
-source "drivers/gpu/drm/aspeed/Kconfig"
-
-source "drivers/gpu/drm/mcde/Kconfig"
-
-source "drivers/gpu/drm/tidss/Kconfig"
-
-source "drivers/gpu/drm/adp/Kconfig"
-
-source "drivers/gpu/drm/xlnx/Kconfig"
-
-source "drivers/gpu/drm/gud/Kconfig"
-
-source "drivers/gpu/drm/sitronix/Kconfig"
-
-source "drivers/gpu/drm/solomon/Kconfig"
-
-source "drivers/gpu/drm/sprd/Kconfig"
-
-source "drivers/gpu/drm/imagination/Kconfig"
-
-source "drivers/gpu/drm/tyr/Kconfig"
-
-config DRM_HYPERV
-	tristate "DRM Support for Hyper-V synthetic video device"
-	depends on DRM && PCI && HYPERV_VMBUS
-	select DRM_CLIENT_SELECTION
-	select DRM_KMS_HELPER
-	select DRM_GEM_SHMEM_HELPER
-	help
-	 This is a KMS driver for Hyper-V synthetic video device. Choose this
-	 option if you would like to enable drm driver for Hyper-V virtual
-	 machine.
-
-	 If M is selected the module will be called hyperv_drm.
-
 # Separate option as not all DRM drivers use it
 config DRM_PANEL_BACKLIGHT_QUIRKS
 	tristate

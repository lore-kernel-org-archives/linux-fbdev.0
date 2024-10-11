Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC288199231;
	Fri, 11 Oct 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679833; cv=none; b=WMkqu0PgPYF96v9w8deRNbn5W+i9XGshVU6GK4n6cllYHLVZQbW34mtbG+7RKY3Aa8nZTlW3rxoFFnlHxKVBn67RFzOZGrfjJEJSulOIhpHxLe2AOvij4OUyS+jtkbadaV3tPsLIg8YYhZzcRpnbNtfkgaJoajp8U2AKpwU9D5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679833; c=relaxed/simple;
	bh=hXf5ZVrtNgDS3dJuM8VIaRrDfixpeJRIiaypoU+N7+w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iqF16gDyX/JXmU4TIaJRixS/vaWPcuwcAOqx9hbd25yF0ZZSDDEQqYVAHcyiDju5oc2x5cG/rPpuH0sHxfIuAwemdZlUPe+NIftUMn9ip2u5c34zw/1M5n351nawfsl7rEMVm18nVoO8H4Oels4Efv1bt7zMH/RcevB5gH2zESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cI9518Mv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cI9518Mv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A51C4CEC3;
	Fri, 11 Oct 2024 20:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728679833;
	bh=hXf5ZVrtNgDS3dJuM8VIaRrDfixpeJRIiaypoU+N7+w=;
	h=Date:From:To:Subject:From;
	b=cI9518MvSHywq79vw/T6Bi+RM+5MZh42BWb6PNJfJLZHxfS6x18M1mLXgl5yPkb7P
	 KRJL2fdtB+Bbi+ydZx4iI1+oTMI2x4Fhymyh678i2jAUA7DQln5B+C2zrbkl95Qt/X
	 Vh4yFKi4L/PcwtP1clAIU1lx0nEs9FSTMrxVUKwtfqkiQoboReu8jrDnndURwsyORv
	 H3/nFlONtI2Vt5k/yC6KuX/z8orhKx4whSImVr5Apw45Z56VhoIIpfY3nu5uImBOYX
	 1CIAX7v4ECe8oypPko81GmOvvwGDQSrMPeeT9dzBPEXJPZKFb5R4MR+uqhyncEWUQ7
	 FFljQTa4Pvi6g==
Date: Fri, 11 Oct 2024 22:50:28 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: [GIT PULL] fbdev platform_driver::remove() migration for v6.12-rc3
Message-ID: <ZwmPlIK9-O-396Sh@carbonx1>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

will you consider pulling one huge, but trivial patch from Uwe Kleine-König
to switch all fbdev drivers at once back to struct platform_driver::remove()?

Thanks,
Helge

----------------------------------------------------------------
The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.12-rc3

for you to fetch changes up to 01ecc142ef7c8c5081a39be81c1d8ab7c10dd7b8:

  fbdev: Switch back to struct platform_driver::remove() (2024-10-08 21:47:18 +0200)

----------------------------------------------------------------
fbdev platform driver migration for 6.12-rc3:

- switch fbdev drivers back to struct platform_driver::remove()

----------------------------------------------------------------
Uwe Kleine-König (1):
      fbdev: Switch back to struct platform_driver::remove()

 drivers/video/fbdev/amifb.c                                       | 4 ++--
 drivers/video/fbdev/arcfb.c                                       | 2 +-
 drivers/video/fbdev/atmel_lcdfb.c                                 | 2 +-
 drivers/video/fbdev/au1100fb.c                                    | 2 +-
 drivers/video/fbdev/au1200fb.c                                    | 2 +-
 drivers/video/fbdev/broadsheetfb.c                                | 2 +-
 drivers/video/fbdev/bw2.c                                         | 2 +-
 drivers/video/fbdev/cg14.c                                        | 2 +-
 drivers/video/fbdev/cg3.c                                         | 2 +-
 drivers/video/fbdev/cg6.c                                         | 2 +-
 drivers/video/fbdev/clps711x-fb.c                                 | 2 +-
 drivers/video/fbdev/cobalt_lcdfb.c                                | 2 +-
 drivers/video/fbdev/da8xx-fb.c                                    | 2 +-
 drivers/video/fbdev/ep93xx-fb.c                                   | 2 +-
 drivers/video/fbdev/ffb.c                                         | 2 +-
 drivers/video/fbdev/fsl-diu-fb.c                                  | 6 +++---
 drivers/video/fbdev/gbefb.c                                       | 6 +++---
 drivers/video/fbdev/goldfishfb.c                                  | 2 +-
 drivers/video/fbdev/grvga.c                                       | 2 +-
 drivers/video/fbdev/hecubafb.c                                    | 2 +-
 drivers/video/fbdev/hgafb.c                                       | 2 +-
 drivers/video/fbdev/hitfb.c                                       | 2 +-
 drivers/video/fbdev/imxfb.c                                       | 2 +-
 drivers/video/fbdev/leo.c                                         | 2 +-
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c                        | 2 +-
 drivers/video/fbdev/metronomefb.c                                 | 2 +-
 drivers/video/fbdev/ocfb.c                                        | 2 +-
 drivers/video/fbdev/offb.c                                        | 4 ++--
 drivers/video/fbdev/omap/omapfb_main.c                            | 2 +-
 drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c   | 2 +-
 drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c         | 2 +-
 drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c        | 2 +-
 drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c        | 2 +-
 drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c        | 2 +-
 drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c     | 2 +-
 drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c             | 2 +-
 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c          | 2 +-
 .../video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c   | 2 +-
 drivers/video/fbdev/omap2/omapfb/dss/core.c                       | 6 +++---
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c                      | 2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dpi.c                        | 4 ++--
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c                        | 2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss.c                        | 2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c                      | 6 +++---
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c                      | 2 +-
 drivers/video/fbdev/omap2/omapfb/dss/sdi.c                        | 6 +++---
 drivers/video/fbdev/omap2/omapfb/dss/venc.c                       | 6 +++---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c                    | 2 +-
 drivers/video/fbdev/p9100.c                                       | 2 +-
 drivers/video/fbdev/platinumfb.c                                  | 2 +-
 drivers/video/fbdev/pxa168fb.c                                    | 2 +-
 drivers/video/fbdev/pxa3xx-gcu.c                                  | 8 ++++----
 drivers/video/fbdev/pxafb.c                                       | 2 +-
 drivers/video/fbdev/s1d13xxxfb.c                                  | 2 +-
 drivers/video/fbdev/s3c-fb.c                                      | 2 +-
 drivers/video/fbdev/sh7760fb.c                                    | 2 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c                            | 2 +-
 drivers/video/fbdev/simplefb.c                                    | 2 +-
 drivers/video/fbdev/sm501fb.c                                     | 2 +-
 drivers/video/fbdev/tcx.c                                         | 2 +-
 drivers/video/fbdev/uvesafb.c                                     | 2 +-
 drivers/video/fbdev/vesafb.c                                      | 2 +-
 drivers/video/fbdev/vfb.c                                         | 2 +-
 drivers/video/fbdev/vga16fb.c                                     | 2 +-
 drivers/video/fbdev/via/via-gpio.c                                | 2 +-
 drivers/video/fbdev/via/via_i2c.c                                 | 2 +-
 drivers/video/fbdev/vt8500lcdfb.c                                 | 2 +-
 drivers/video/fbdev/wm8505fb.c                                    | 2 +-
 drivers/video/fbdev/wmt_ge_rops.c                                 | 2 +-
 drivers/video/fbdev/xilinxfb.c                                    | 2 +-
 70 files changed, 88 insertions(+), 88 deletions(-)

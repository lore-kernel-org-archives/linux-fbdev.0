From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 26 Feb 2014 10:08:05 +0000
Subject: Re: [RFC PATCH 0/5] Move IPUv3 core out of staging, add CSI support
Message-Id: <20140226100805.GU21483@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387561966-31758-1-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1387561966-31758-1-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Feb 26, 2014 at 11:39:03AM +0300, Dan Carpenter wrote:
> 
> Please fix the following static checker complaints before moving out of
> staging:
> 
> drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c:164 ipu_dmfc_setup_channel() warn: variable dereferenced before check 'dmfc' (see line 157)

Note that what's being talked about being moved out is only the above,
not the files in drivers/staging/imx-drm.  DRM people have not yet
reviewed imx-drm itself, which is a necessary step - but nevertheless,
thanks for running a static checker on this stuff.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

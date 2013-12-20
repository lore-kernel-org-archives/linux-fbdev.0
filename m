From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 20 Dec 2013 19:12:29 +0000
Subject: Re: [RFC PATCH 0/5] Move IPUv3 core out of staging, add CSI support
Message-Id: <20131220191229.GA27254@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387561966-31758-1-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1387561966-31758-1-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Dec 20, 2013 at 06:52:41PM +0100, Philipp Zabel wrote:
> Hi,
> 
> this is mostly about the first patch, which moves the IPUv3 core code
> (drivers/staging/imx-drm/ipu-v3) to drivers/gpu. host1x, which
> serves a similar purpose, already sits there.
> The other four patches add the necessary code for CSI and SMFC handling,
> which is used by the V4L2 CSI capture driver.
> 
> Currently this is based on Russell's patch
>     [PATCH 62/64] imx-drm: pass an IPU ID to crtc and core
> 
> I am aware that there are now quite a few other patches in the pipeline
> that touch drivers/staging/imx-drm/ipu-v3/*, so I am happy to rebase this
> (or them) as needed. I'd like to move the core code out of staging so that
> we can start submitting V4L2 code for video capture and scaling / colorspace
> conversion in parallel.

I'd recommend doing the move (if the gpu/drm maintainer agrees) after
3.14-rc1 as then all of my pending patches would be applied and we would
be synced up with everything.

Once this "core" is moved, what is keeping the rest in staging and why
isn't it moving out as well?

thanks,

greg k-h

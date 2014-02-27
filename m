From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 27 Feb 2014 20:42:22 +0000
Subject: Re: [PATCH 0/3] Move IPUv3 core out of staging
Message-Id: <20140227204222.GB7649@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393328624-28013-1-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1393328624-28013-1-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Feb 25, 2014 at 12:43:40PM +0100, Philipp Zabel wrote:
> Hi,
> 
> this series has two small cleanups for the IPUv3 core driver and then moves
> it from drivers/staging/imx-drm/ipu-v3 to drivers/gpu. In this directory there
> is already the host1x driver, which serves a similar purpose.

I've applied the first 2, I don't understand your follow-up for patch 3,
so I just dropped both copies of it...

I need an ack from a DRM maintainer before I can take that one anyway.

thanks,

greg k-h

From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 16 Sep 2010 08:20:18 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: reconfigure the framebuffer, when free
Message-Id: <20100916082017.GB12314@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1009141644130.31947@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009141644130.31947@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Sep 14, 2010 at 04:48:54PM +0200, Guennadi Liakhovetski wrote:
> Currently the sh_mobile_lcdc driver only reconfigures the hardware interface,
> when a new monitor is plugged in. This patch adds support for dynamic
> framebuffer reconfiguration, when no user is holding the framebuffer device
> node open.

Applied, thanks.

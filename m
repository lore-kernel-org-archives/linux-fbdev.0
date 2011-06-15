From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 15 Jun 2011 05:53:38 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_hdmi: fix regression: statically enable RTPM
Message-Id: <20110615055336.GL17891@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1106141610430.19402@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1106141610430.19402@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jun 14, 2011 at 04:27:22PM +0200, Guennadi Liakhovetski wrote:
> A recent modification to the runtime PM code on mach-shmobile made a wrong 
> RTPM implementation in the sh_mobile_hdmi driver apparent, which broke 
> HDMI hotplug detection support on ap4evb. This patch does not implement a 
> proper dynamic RTPM support for sh_mobile_hdmi, instead it restores the 
> previous working state by statically enabling it. A more power-efficient 
> solution should be implemented for the next kernel version.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.

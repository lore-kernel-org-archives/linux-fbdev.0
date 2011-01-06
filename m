From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Jan 2011 08:07:45 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdcfb: Enable 32 bpp and 24 bpp support
Message-Id: <20110106080745.GD15914@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110105102100.13620.6354.sendpatchset@t400s>
In-Reply-To: <20110105102100.13620.6354.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Jan 05, 2011 at 07:21:00PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch extends the LCDC driver with 24 bpp
> and 32 bpp support.
> 
> These modes have been kept disabled earlier due
> to dependencies between the potential two LCDC
> channels that are exported as two separate
> framebuffer devices. The dependency boils down
> to a byte swap register that is shared between
> multiple channels.
> 
> With this patch applied all single channel LCDC
> hardware can chose freely from 16, 24 and 32 bpp.
> Dual channel LCDC must stick to the same setup
> for both channels.
> 
> Without this patch only 16 bpp is fully supported.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied, thanks.

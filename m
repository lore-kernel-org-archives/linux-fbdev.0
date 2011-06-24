From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Jun 2011 08:10:03 +0000
Subject: Re: [PATCH] fsl-diu-fb: remove check for pixel clock ranges
Message-Id: <20110624081003.GE24184@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308860426-17920-1-git-send-email-timur@freescale.com>
In-Reply-To: <1308860426-17920-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, agust@denx.de, yorksun@freescale.com

On Thu, Jun 23, 2011 at 03:20:26PM -0500, Timur Tabi wrote:
> The Freescale DIU framebuffer driver defines two constants, MIN_PIX_CLK and
> MAX_PIX_CLK, that are supposed to represent the lower and upper limits of
> the pixel clock.  These values, however, are true only for one platform
> clock rate (533MHz) and only for the MPC8610.  So the actual range for
> the pixel clock is chip-specific, which means the current values are almost
> always wrong.  The chance of an out-of-range pixel clock being used are also
> remote.
> 
> Rather than try to detect an out-of-range clock in the DIU driver, we depend
> on the board-specific pixel clock function (e.g. p1022ds_set_pixel_clock)
> to clamp the pixel clock to a supported value.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied, thanks.

From: Shawn Guo <shawn.guo@linaro.org>
Date: Mon, 08 Apr 2013 08:35:05 +0000
Subject: Re: [PATCH v6] video: mxsfb: Introduce regulator support
Message-Id: <20130408083502.GG5047@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365360299-8707-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1365360299-8707-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Apr 07, 2013 at 03:44:59PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Instead of using a custom binding for retrieving the GPIO that activates the 
> LCD from devicetree, use a standard regulator.
> 
> This approach has the advantage to be more generic. 
> 
> For example: in the case of a board that has a PMIC supplying the LCD voltage, 
> the current approach would not work, as it only searches for a GPIO pin.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.


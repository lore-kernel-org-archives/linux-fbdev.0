From: Shawn Guo <shawn.guo@linaro.org>
Date: Mon, 27 May 2013 07:16:02 +0000
Subject: Re: [PATCH] video: mxsfb: Let device core handle pinctrl
Message-Id: <20130527071601.GK7782@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369619294-10362-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1369619294-10362-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sun, May 26, 2013 at 10:48:14PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit ab78029 (drivers/pinctrl: grab default handles from device core)
> we can rely on device core for handling pinctrl, so remove 
> devm_pinctrl_get_select_default() from the driver.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>


From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 17 Jul 2013 22:24:52 +0000
Subject: Re: [PATCH RESEND] video: mxsfb: Let device core handle pinctrl
Message-Id: <20130717152452.dd28be37a9b60d5a0e179bab@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373923884-13332-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1373923884-13332-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, 15 Jul 2013 18:31:24 -0300 Fabio Estevam <festevam@gmail.com> wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit ab78029 (drivers/pinctrl: grab default handles from device core)
> we can rely on device core for handling pinctrl, so remove 
> devm_pinctrl_get_select_default() from the driver.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Andrew,
> 
> Should this go via your tree?

Well, no, it should really be reviewed by and merged by
Jean-Christophe.  Is there a problem in fbdev land?

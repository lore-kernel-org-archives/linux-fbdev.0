From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Tue, 28 May 2013 15:25:17 +0000
Subject: Re: [PATCH] video: mxsfb: Let device core handle pinctrl
Message-Id: <20130528152517.GA23899@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369619294-10362-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1369619294-10362-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 12:09 Tue 28 May     , Fabio Estevam wrote:
> Hi Jean-Christophe,
> 
> On Mon, May 27, 2013 at 11:44 AM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > On 22:48 Sun 26 May     , Fabio Estevam wrote:
> >> From: Fabio Estevam <fabio.estevam@freescale.com>
> >>
> >> Since commit ab78029 (drivers/pinctrl: grab default handles from device core)
> >> we can rely on device core for handling pinctrl, so remove
> >> devm_pinctrl_get_select_default() from the driver.
> > Linus we should do a pass on the kernel to clean this
> 
> Not sure which 'Linus' the comment was meant to be directed to, but I
> have already sent several patches removing
> devm_pinctrl_get_select_default() and many of them were already
> applied by the maintainers.

here I mean linusw

Best Regards,
J.

From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Tue, 10 Mar 2015 12:51:16 +0000
Subject: Re: [PATCH] video: treat signal like timeout as failure
Message-Id: <20150310125116.GA26020@opentech.at>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421731430-13207-1-git-send-email-der.herr@hofr.at>
 <54FEE70D.3010307@ti.com>
In-Reply-To: <54FEE70D.3010307@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 10 Mar 2015, Tomi Valkeinen wrote:

> On 20/01/15 07:23, Nicholas Mc Guire wrote:
> > if(!wait_for_completion_interruptible_timeout(...))
> > only handles the timeout case - this patch adds handling the
> > signal case the same as timeout and cleans up.
> > 
> > Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> > ---
> > 
> > Only the timeout case was being handled, return of 0 in 
> > wait_for_completion_interruptible_timeout, the signal case (-ERESTARTSYS)
> > was treated just like the case of successful completion, which is most 
> > likely not reasonable.
> > 
> > Note that exynos_mipi_dsi_wr_data/exynos_mipi_dsi_rd_data return values
> > are not checked at the call sites in s6e8ax0.c (cmd_read/cmd_write)!
> > 
> > This patch simply treats the signal case the same way as the timeout case,
> > by releasing locks and returning 0 - which might not be the right thing to
> > do - this needs a review by someone knowing the details of this driver.
> 
> While I agree that this patch is a bit better than the current state,
> the code still looks wrong as Russell said.
> 
> I can merge this, but I'd rather have someone from Samsung look at the
> code and change it to use wait_for_completion_killable_timeout() if
> that's what this code is really supposed to use.
>
If someone that knows the details takes care of it
that is of course the best solution. If someone Samsung is 
going to look into it then it is probably best to completly
drop this speculative patch so that this does not lead
to more confusion than it does good.

thx!
hofrat

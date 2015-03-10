From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 10 Mar 2015 14:15:11 +0000
Subject: Re: [PATCH] video: treat signal like timeout as failure
Message-Id: <20150310141511.GL8656@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421731430-13207-1-git-send-email-der.herr@hofr.at>
 <54FEE70D.3010307@ti.com> <20150310125116.GA26020@opentech.at>
In-Reply-To: <20150310125116.GA26020@opentech.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Mar 10, 2015 at 01:51:16PM +0100, Nicholas Mc Guire wrote:
> On Tue, 10 Mar 2015, Tomi Valkeinen wrote:
> 
> > On 20/01/15 07:23, Nicholas Mc Guire wrote:
> > > if(!wait_for_completion_interruptible_timeout(...))
> > > only handles the timeout case - this patch adds handling the
> > > signal case the same as timeout and cleans up.
> > > 
> > > Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> > > ---
> > > 
> > > Only the timeout case was being handled, return of 0 in 
> > > wait_for_completion_interruptible_timeout, the signal case (-ERESTARTSYS)
> > > was treated just like the case of successful completion, which is most 
> > > likely not reasonable.
> > > 
> > > Note that exynos_mipi_dsi_wr_data/exynos_mipi_dsi_rd_data return values
> > > are not checked at the call sites in s6e8ax0.c (cmd_read/cmd_write)!
> > > 
> > > This patch simply treats the signal case the same way as the timeout case,
> > > by releasing locks and returning 0 - which might not be the right thing to
> > > do - this needs a review by someone knowing the details of this driver.
> > 
> > While I agree that this patch is a bit better than the current state,
> > the code still looks wrong as Russell said.
> > 
> > I can merge this, but I'd rather have someone from Samsung look at the
> > code and change it to use wait_for_completion_killable_timeout() if
> > that's what this code is really supposed to use.
> >
> If someone that knows the details takes care of it
> that is of course the best solution. If someone Samsung is 
> going to look into it then it is probably best to completly
> drop this speculative patch so that this does not lead
> to more confusion than it does good.

IMHO, just change it to wait_for_completion_killable_timeout() - that's
a much better change than the change you're proposing.

If we think about it...  The current code uses this:

                if (!wait_for_completion_interruptible_timeout(&dsim_wr_comp,
                                                        MIPI_FIFO_TIMEOUT)) {
                        dev_warn(dsim->dev, "command write timeout.\n");
                        mutex_unlock(&dsim->lock);
                        return -EAGAIN;
                }

which has the effect of treating a signal as "success", and doesn't return
an error.  So, if the calling application receives (eg) a SIGPIPE or a
SIGALRM, we proceed as if we received the FIFO empty interrupt and doesn't
cause an error.

Your change results in:

                timeout = wait_for_completion_interruptible_timeout(
                                        &dsim_wr_comp, MIPI_FIFO_TIMEOUT);
                if (timeout <= 0) {
                        dev_warn(dsim->dev,
                                "command write timed-out/interrupted.\n");
                        mutex_unlock(&dsim->lock);
                        return -EAGAIN;
                }

which now means that this call returns -EAGAIN when a signal is raised.

Now, further auditing of this exynos crap (and I really do mean crap)
shows that this function is assigned to a method called "cmd_write".
Grepping for that shows that *no caller ever checks the return value*!

So, really, there's a bug here in that we should _never_ complete on a
signal, and we most *definitely can not* error out on a signal either.
The *only* sane change to this code without author/maintainer input is
to change this to wait_for_completion_killable_timeout() - so that
signals do not cause either premature completion nor premature failure
of the wait.

The proper fix is absolutely huge: all call paths need to be augmented
with code to detect this function failing, and back out whatever changes
they've made, and restoring the previous state (if they can) and
propagate the error all the way back to userland, so that syscall
restarting can work correctly.  _Only then_ is it safe to use a call
which causes an interruptible sleep.

Personally, I'd be happier seeing this moved into drivers/staging and
eventually deleted from the kernel unless someone is willing to review
the driver and fix some of these glaring problems.  I wouldn't be
surprised if there was _loads_ of this kind of crap there.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

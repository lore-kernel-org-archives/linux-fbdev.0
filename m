From: James Cloos <cloos@jhcloos.com>
Subject: Re: radeonfb lockup in .28-rc (bisected)
Date: Tue, 28 Oct 2008 05:24:44 -0400
Message-ID: <m3k5bt2hsc.fsf@lugabout.jhcloos.org>
References: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
	<1225152347.8004.49.camel@pasglop>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753462AbYJ1JZx@vger.kernel.org>
In-Reply-To: <1225152347.8004.49.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Tue, 28 Oct 2008 11:05:47 +1100")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Krzysztof Halasa <khc@pm.waw.pl>, "David S. Miller" <davem@davemloft.net>, linux-fbdev-devel@lists.sourceforge.net

>>>>> "Benjamin" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

Benjamin> First, let's see if it's related to the imageblit. Can you
Benjamin> re-apply the reverted patch and apply this little hack on top:

Benjamin> +#if 0
Benjamin>  	/* We only do 1 bpp color expansion for now */
Benjamin>  	if (info->flags & FBINFO_HWACCEL_DISABLED || image->depth != 1)
Benjamin>  		goto fallback;
Benjamin> @@ -275,6 +276,7 @@ void radeonfb_imageblit(struct fb_info *
Benjamin>  	return;
 
Benjamin>   fallback:
Benjamin> +#endif

Benjamin> And let me know if that makes it not lockup.

Indeed, if-zero-ing out that block does work.

Since that if essentially removes to call to radeonfb_prim_imageblit(),
I wonder whether:

        /* X here pads width to a multiple of 32 and uses the clipper to
         * adjust the result. Is that really necessary ? Things seem to
         * work ok for me without that and the doco doesn't seem to imply
         * there is such a restriction.
         */

is relevant?

Or whether the card is unhappy with the creg settings.  It does seem,
now that I read the code, that:

void radeon_fifo_update_and_wait(struct radeonfb_info *rinfo, int entries)
{
        int i;

        for (i=0; i<2000000; i++) {
                rinfo->fifo_free = INREG(RBBM_STATUS) & 0x7f;
                if (rinfo->fifo_free >= entries)
                        return;
                udelay(10);
        }
        printk(KERN_ERR "radeonfb: FIFO Timeout !\n");
        /* XXX Todo: attempt to reset the engine */
}

is in play.  It is probably spinning through all of the 2000000 possible
udelay(10) calls.  I don't think I ever gave it twenty seconds before
giving up.  And certainly not forty seconds, if the freeze happens after
setting the DST_Y_X register.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6

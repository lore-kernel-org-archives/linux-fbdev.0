From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 23 Jun 2017 09:07:33 +0000
Subject: Re: [Ksummit-discuss] [TECH TOPIC] printk redesign
Message-Id: <10423619.jNvHD4M0jW@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170619052146.GA2889@jagdpanzerIV.localdomain>
	<CGME20170622134852epcas2p4b6deccc56b52c71eada58fba2d527793@epcas2p4.samsung.com>
	<CAKMK7uGWBFJ70KPexoyyYiWMOkKTga5KEO5zPtN70pRHBV90cQ@mail.gmail.com>
In-Reply-To: <CAKMK7uGWBFJ70KPexoyyYiWMOkKTga5KEO5zPtN70pRHBV90cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>


Hi,

On Thursday, June 22, 2017 03:48:34 PM Daniel Vetter wrote:
> On Thu, Jun 22, 2017 at 3:42 PM, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > Tears pretty much guaranteed, and after a few hacks from Alan&me I
> > concluded that the only way to fix this is to at least partially
> > rewrite fbdev (a dead subsystem, so no one's volunteering), with the
> > risk that you get to revert it all because someone is indeed relying
> > on that super-flexible module loading order sequence. The simplest fix
> > would probably be to make the entire fbdev->fbcon setup depency a
> > hard-coded function call, or maybe at most a one-shot symbol_get
> > attempt.
> 
> I did once hash out a plan how to fix this with the least amount of pain:
> 
> 1. Merge a patch to build the fbcon support into the overall fb.ko
> module, so that the dynamic loading nonsense is essentially disabled,
> and fbcon becomes a Kconfig/compile-time only option, no longer a
> runtime-selectable thing.
> 
> 2. Wait 1 year and pray that no one reports a regression. If you're
> unlucky, try to fence them of with a runtime option to disable fbcon.
> 
> 3. Rip out the notifier nonsense and replace it by direct function
> calls. You can only do that once 1. won't be reverted anymore.
> 
> 4. Push the console_lock donw the callchains until it's again at the
> right spots, auditing all the other stuff meanwhile to make sure the
> locking is still correct.
> 
> 5. Apply your patch to make console_lock sane.
> 
> Adding fbdev maintainers and lists just.

Your plan sounds good to me.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


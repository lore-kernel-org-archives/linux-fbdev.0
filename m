From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: Radeon X300, radeonfb, dual head
Date: Thu, 19 Apr 2007 10:44:06 +0200
Message-ID: <200704191044.07083.hjk@linutronix.de>
References: <200704181409.51475.hjk@linutronix.de>
	<46272535.5040303@cryosphere.shacknet.nu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <46272535.5040303@cryosphere.shacknet.nu>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Wanda <wanda@cryosphere.shacknet.nu>
Cc: linux-fbdev-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

Am Donnerstag, 19. April 2007 10:15 schrieb Wanda:
> 
> Hello,
> 
> i had the same issue about fifo timeout. You certainly get very random
> refresh of the screen too if you activate dri. That is not a Xorg bug
> but rather a radeonfb one. It comes from radeonfb_accel.c, if i remember
> well. Just try and read the patch i send to the list (thread "radeonfb
> doesn't work with an ati X800 pcie", file: radeon_accel.c.2.6.20.diff) 
> Also, you will certainly need all the xxx.c.2.6.20.diff as well. You
> will find them in the april archive. If that doesn't help you try luca's
> one + aty.patch (same thread) In that case you are integrated a bunch of
> xorg code in radeonfb :). Luca's patch isn't compatible with mine except
> when applyed with aty.patch. I need it for my card, otherwise it doesn't
> work. But it could be incompatible with your card. Luca's patch still
> generates 2 *.rej file. You can install them manually and very easily by
> reading the rej file.
> 
> If nothing works for you , you have certainly a legacy instead an atom
> bios. In that case most of the patches won't help you. But keep trying.
> I get finally my x800  working with them. xorg and radeonfb work now
> together without a problem. Indeed, i don't have black screens or screen
> corruptions any more ;)

Hi,
thanks for your hints. But at the moment, I'd be lucky if I could get xorg
working with dual head even without radeonfb. It would be nice if I could
have a framebuffer console, though. Is one of these patches about to get
in mainline? I (have to) work with new kernels all the time, so it would 
be quite inconvenient if I had to apply (and maintain) an out-of-tree
patch every time I compile a new kernel.

If one of these patches looks acceptable for the fb-devel folks, I'm
willing to review, test, and submit updated patches if it works.

Thanks,
Hans

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Console & FBDev vs. locking
Date: 28 May 2003 13:46:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1054122360.602.197.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: James Simmons <jsimmons@infradead.org>

Hi !

While working on various power management issues with fbdev, I noticed
that there's an almost complete lack of locking in there and I've
spotted several races. Some of them seem to be present at the vt
subsystem level as well. Unless I've missed something, what we have
today is:

All printk originated console call should done with the console
semaphore held. The console-sem is the de-facto locking mecanism for the
console today, while not fine-grained, it's probably plenty enough for
what we need in 2.5 and unless previous implementations which ran with
irqs off, the console drivers can actually block and rely on HW
interrupts.

However, the following (at least), break the rule and call the console
driver in a racy way:

 - Most of vt_ioctl.c userland calls. Things like KDSETMODE for example
can end up into a call to unblank_screen() -> redraw_screen()

 - Console blanking/unblanking: worst, that one is called at interrupt
time from a timer

 - In fbcon: all of the cursor handling (fortunately, _at least_, it's
no longer calling the driver at interrupt time).

 - Any userland access to fbcon via ioctls, that is mode change for
example, which can be a tricky task and leave the card in some unuseable
state until the mode change is complete, do race with anything else.

I can produce a patch fixing as much of these as I can find if you agree
that is the correct way, that is adding acquire_console_sem() in places
where it belongs, that is almost every of the above, except for the
blanking timer which has to be deferred to process context.

Any comments ?

Regards,
Ben.

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Dri-devel] Re: DRM and pci_driver
	conversion
Date: Tue, 28 Oct 2003 00:55:09 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1067298909.26680.22.camel@gaston>
References: <Pine.LNX.4.44.0310271316580.1636-100000@home.osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0310271316580.1636-100000@home.osdl.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ian Romanick <idr@us.ibm.com>, David Dawes <dawes@XFree86.Org>, dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

> In other words, I'd keep it so simple that versions don't really matter,
> because the low-level driver doesn't do enough complex things that you'd
> be forced to upgrade it all the time. I don't think fbdev is at all the 
> proper interface - I think the proper interface is something that is so 
> close to the hardware that the hardware _forces_ all issues, and there are 
> never any questions of what the low-level driver should be.
> 
> And since people still want to run X on old setups too, clearly X will 
> have to have the ability to have its own user-space module. That's needed 
> for other operating systems _anyway_, so this wouldn't obviate that. 

I see your point about fbdev not beeing the proper interface here.

But then, what would be the relationchip between that low level stuff
and fbdev ? (fbdev beeing a driver providing basically mode setting &
basic framebuffer support for client applications, fbcon beeing just
one of them here, with possibly later on some accel modules as well)

Same question goes for XFree.

Do they still just map register space and blast registers ? Or do you
expect all register accesses to go through some kind of "command pipe" ?

There are lots of tricky things to do especially at board init time
that basically require direct register access (and if possible beeing
in the kernel with irq off for subtle things like "measuring" the
board PLL, unfortunately necessary on some cards).

So the main service the "low level" module would provide would be
just basic card identification (list of PCI IDs), mapping facilities
for fb & registers, arbitration so that things like fbdev can get full
ownership (prevent ring commands) when mode switching & such, and the
actual DMA/IRQ command blasting engine (equivalent of current DRI module).

This looks like just an extension of the current DRI modules, and having
things like fbdev stack on top of them...

Ben.



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/

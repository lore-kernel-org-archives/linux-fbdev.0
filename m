From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Linux-fbdev-devel] OLS and console rearchitecture
Date: Wed, 28 Jul 2004 23:57:59 +0100
Sender: dri-devel-admin@lists.sourceforge.net
Message-ID: <1091055478.31913.7.camel@localhost.localdomain>
References: <20040728185346.36263.qmail@web14921.mail.yahoo.com>
	 <20040728213102.GB26087@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040728213102.GB26087@dreamland.darkstar.lan>
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
To: Kronos <kronos@people.it>
Cc: Jon Smirl <jonsmirl@yahoo.com>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>, DRI Devel <dri-devel@lists.sourceforge.net>

On Mer, 2004-07-28 at 22:31, Kronos wrote:
> There was a thread on acpi-devel about POSTing VGA ROM after resume:
> 
> http://marc.theaimsgroup.com/?l=acpi4linux&m=109023076427394&w=2
> 
> The code does a real mode switch in kernel and execute the ROM. Ok, doing
> that in userspace is more elegant, but that code is not a mess (though
> it's arch dependant).

And also some cards do rather deep magic or don't even have a real
video ROM but a BIOS hack that goes away. This got discussed - its fun

> Btw, how do we POST non-x86 (eg. ppc) video boards? I don't think that
> there's x86 code in their ROM...

Same way X does - x86emu

> > 7) Mode setting from normal user space - devices will have a standard
> > IOCTL accepting a mode string like fbdev currently uses.
> 
> sysfs? I sent a patch a while ago but didn't get much feedback.

How do you atomically tie sysfs objects to fbdev and X permissions
models ?

> > 14) A new framebuffer memory manager is needed for mesa GL support. Ian
> > is working on it. The memory manager will be part of the support
> > library driver code.
> 
> sisfb has a memory manager for fb/drm, it may be worth a closer look.

Its way too slow and doesn't deal with a lot of things it should, its a
problem even on DRI today. Ian has some design for a mostly user space
allocator which is critical as DRI can hit 100K allocs/second.




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
--

From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Resource management.
Date: Tue, 22 Feb 2005 05:13:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502220450190.22255@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org> 
 <200502220653.01286.adaplas@hotpop.com>  <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
  <9e473391050221170111610521@mail.gmail.com> 
 <Pine.LNX.4.56.0502220319330.20949@pentafluge.infradead.org>
 <21d7e99705022120462cb9494c@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
In-Reply-To: <21d7e99705022120462cb9494c@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: James Simmons <jsimmons@pentafluge.infradead.org>, Jon Smirl <jonsmirl@gmail.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, adaplas@pol.net, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> > 1. Lots of work that would take lots of time. To my knowledge all fbdev
> >    developers work in there spare free time. No one does this for a
> >    living.
> 
> So do most of the drm developers, I know I do and Jon Smirl does, and
> Eric Anholt does and I think us three have been the largest
> contributers apart from new driver submissions...

Ug :-( That is sad!!!

> > 2. Sharing of headers. The dri headers are isolated in the drm directory.
> >    I totally understand why :-) It makes merging easier for them. The
> >    disadvantage is no one in the fbdev can use them easily :-(
> 
> I plan to move them in 2.6.12 maybe .. it might be 2.6.13 by the time
> I get around to it, just some minor issues.. Arjan asked me for this
> ages ago as well...

Okay. Where will they go? include/video ?

> > 3. DRM has way to much functionality for most embedded devices. I have
> >    talked to embedded guys before and they want a simple api to work with.
> >    By default DRM builds in everything. A simple api mean alot to those
> >    guys. Plus the extra built in code bloat takes up to much space which
> >    is precious on embedded devices. If a devices doesn't support dma then
> >    the dma code doesn't need to be built in.
> 
> Well crap on that, the old DRM didn't build everything in people
> complained aw this code is too messy, build everything in, now you
> want to revert? damn you all!!! :-), 

Ha Ha. I didn't know the history. 

> I understand I'm just saying we
> can't have it both ways.. and too be honest I'm an embedded person and
> I just want it to work, with a Linux kernel you rarely get to an every
> byte counts embedded env, of if you are you aren't using the stock
> Linus kernel....

I can live with this issue as long it would not increase the complexity of 
framebuffer only devices. Simple api is very important to me. The current
fbdev api is designed to be very simple for the most common cases. It can 
get complex tho with exotic hardware.

> > 4. Which comes to the next point. The code is not modular enough. Take
> >    drm_bufs.c. Everything is a ioctl function. This has a few disadvantages.
> >    One is the fbdev layer couldn't just link into it so fbcon could use
> >    it. The second is it's not easy to take advantage of things like sysfs.
> >    If you could untangle the code somewhat it would make life so much
> >    easier. That would include making life easier for OS ports.
> 
> the reason we can't take advantage of sysfs or anything like it is
> that we can't bind to the PCI device as we break things.. this is the
> root of a lot of our problems...

Is this because you want to be OS portable? This makes things very very 
hard to merge. Fbdev attempts to take advantage the most powerful linux
kernel features.

> > 5. The license issue. The DRI code is GPL and additional rights. What is that?
> Nope the drm code is BSD... there should be no GPL anywhere near it...
> it is GPL in the kernel as of course it is imported into a GPL work..
> but the code is available for BSD uses....

If it is GPL in the kernel then that is fine. We can work with that. I 
don't care about userland code.

> Jon's last plan - was like to have a radeon basic module, with fb and
> drm personalities and in fact any number of personalities..taking
> radeon as example:
> base module : hotplug, reset, monitor probing, memory management, CP
> programming and locking.
> fb: adds accelerated fb functions using CP locking.
> drm: adds drm functionality on top of base module, drm ioctl interfaces etc..

That will be a huge amount of work! BTW what does CP stand for?  

> I've looked at Alans ideas on a vga_class driver and have decided they
> are unworkable due to the massive initial changes they involve in
> *every* fb/drm driver in the kernel, I cannot undertake a work of that
> magnitude without fb people being involved and the chances of breaking
> a lot of stuff.. maybe a 2.7 thing but I don't think we'll ever have a
> 2.7 for this stuff...
> 
> What I do think though is that ideas of a the vga class driver could
> be made into a helper module that the base graphics driver uses to do
> some standard things, like reset and stuff..
> 
> I'm hoping to get a better handle on these ideas and write something
> up.. but they are mostly Jons ideas better presented :-)

As for the VGA class driver. We already have something like that for the 
fbdev layer. Take a look at vgastate.c. It was written originally so you 
could go from vgacon to fbdev without fbcon and back to vgacon state 
again. It also has common functions for all the drivers to work with. I 
already asked Jon to merge his work with that code. That code could also 
be very useful for vgacon in the future. We need vga core management in 
the kernel.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

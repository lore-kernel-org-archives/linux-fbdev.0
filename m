From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: Current discussion about the future of free software graphics
Date: Tue, 11 May 2004 20:30:45 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040512033045.16034.qmail@web14921.mail.yahoo.com>
References: <40A13BA0.609@us.ibm.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNkSE-0006RR-EZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 May 2004 20:30:46 -0700
Received: from web14921.mail.yahoo.com ([216.136.225.5])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BNkSE-0005nI-2I
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 May 2004 20:30:46 -0700
In-Reply-To: <40A13BA0.609@us.ibm.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Romanick <idr@us.ibm.com>, James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net

If everyone will please read Benh's original post describing this... Ben and I
had been emailing on this topic before he wrote this.

--- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> I agree with the idea of moving the EDID decoding & mode selection to
> userland. In this regard, though, I beleive we should aim toward some
> simple library that sits with the kernel, eventually distributed with
> the kernel tree, to live in initramfs optionally since it may be
> required to even get a console at boot (which is fine, initramfs is
> available early). The video cards themselves have PCI drivers that can
> "trigger" detection by the library via hotplug, the library could manage
> things like persistent configuration, either separate desktops or
> geometry of a complex desktop, etc... and eventually notification of
> userland clients of mode changes.
> 
> One reason for that is lots of monitors lie about their capabilities in
> their EDID block, so we want "override" files.
> 
> The kernel driver in this case doesn't need to be that much different
> than the current fbdev's though, except that we want to move the HW
> access for graphics commands to the kernel too, which basically turns
> into merging the DRI driver and the fbdev. There is no need, I think, to
> re-invent the wheel from scratch here, it would be a lot more realistic
> to build on top of those existing pieces.

What this is saying is that very early in the boot process the graphics driver
will be initialized. At this point it will generate a hotplug event. This event
will be handled by an app and lib that live in initramfs.  This is not saying
that mode-setting will be delayed until normal user space starts. The initial
hotplug event occurs very early in the boot process, almost as early as the
current device driver based code runs. 

This is very similar to the way udev works. Udev is a user space replacement for
devfs. Instead of having a /dev with 40,000 devices in it, udev builds one on
the fly at each boot with exactly your devices in it. Now that I have used udev
instead of devfs I have to agree that it is a much better solution. In fact the
udev app will run before the mode-setting app since it's the udev app that
creates the devices in /dev now by detecting additions to sysfs. udev FAQ:
http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ
We all know Linux is non-functional without a /dev directory, and now /dev is
being build in user space.

Andrew, akpm, has also explained to me that even the current fbdev is not really
active at boot. Instead those initial printk's are queued until the fbdev driver
initialized and prints them.

So moving mode setting to user space is not the end of the world. Everything
will still work. This is more like a monolithic vs microkernel type of decision.
All of the existing code is going to be reused (if we can figure out the
licenses). I've already built a very messy prototype by moving the existing
fbdev code to user space and it works just fine. I also called another little
app which executed the VBIOS and reset secondary cards at boot via hotplug.

I've convinced myself of the advantages of moving mode setting to user space,
but maybe I've missed something that someone else will point out. But let's look
at this as an engineering problem and try to come up with a robust, efficient solution.

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
Yahoo! Movies - Buy advance tickets for 'Shrek 2'
http://movies.yahoo.com/showtimes/movie?mid=1808405861 


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3

From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Sat, 25 Oct 2003 14:02:04 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031025210204.30378.qmail@web14913.mail.yahoo.com>
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADVbr-0003gL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 25 Oct 2003 14:06:07 -0700
Received: from web14913.mail.yahoo.com ([216.136.225.240])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1ADVXx-0004sC-BF
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 25 Oct 2003 14:02:05 -0700
In-Reply-To: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
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
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>, Jeff Garzik <jgarzik@pobox.com>, Egbert Eich <eich@xfree86.org>

--- Linus Torvalds <torvalds@osdl.org> wrote:
> Quite frankly, I'd much rather see a low-level graphics driver that does
> _two_ things, and those things only:
> 
>  - basic hardware enumeration and setup (and no, "basic setup" does not
>    mean "mode switching": it literally means things like doing the 
>    pci_enable_device() stuff.
> 
>  - serialization and arbitrary command queuing from a _trusted_ party (ie
>    it could take command lists from the X server, but not from untrusted
>    clients). This part basically boils down to "DMA and interrupts". This 
>    is the part that allows others to wait for command completion, "enough 
>    space in the ring buffers" etc. But it does _not_ know or care what the 
>    commands are.
> 
> Then, fbcon and DRI and X could all three use these basics - and they'd be
> _so_ basic that the hardware layer could be really stable (unlike the DRI
> code that tends to have to upgrade for each new type of command that DRI
> adds - since it has to take care of untrusted clients. So DRI would
> basically use the low-level driver as a separate module, the way it
> already uses AGP).
> 

Linus, why don't you refuse updates from these projects until this is sorted
out? Your proposal is exactly what it needed. For a year now I have been poking
at these issues and making very little progress. I do know that all of the
pieces needed already exist; but without some incentive there is very little
reason to rearchitect the existing code. 

Personally I'm working on a standalone version of Mesa (OpenGL). This would
allow us to write a 3D hardware based windowing system in response to the ones
on the Mac and MS Longhorn. But instead of working on a windowing system I've
spent all of my time trying to help sort out the video device drivers.


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/

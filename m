From: Egbert Eich <eich@pdx.freedesktop.org>
Subject: Re: RE: [Dri-devel] Memory management of AGP and VRAM
Date: Tue, 11 May 2004 18:50:05 +0200
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <16545.1085.173860.37370@xf11.fra.suse.de>
References: <409BFE5B.5020308@us.ibm.com>
	<20040509164514.17651.qmail@web14922.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: jonsmirl@yahoo.com wrote on Sunday, 9 May 2004 at 09:45:14 -0700 
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Ian Romanick <idr@us.ibm.com>, Egbert Eich <eich@pdx.freedesktop.org>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Jon Smirl writes:
 > Can you run grub or lilo on these machines?
 > 
 > Also, these is no rule saying a device driver can't have several tables of _init
 > register values that can be used to set the mode on a primary monitor at boot. I
 > would just like to see all of the code that does DDC decoding and modeline
 > computations moved to user space. When you add up that code there is about 40K
 > of it in the fbdriver and about 50K in the radeon driver. When the fbdev drivers
 > start probing for multiple heads, TV support, etc that code is going to get even
 > larger. Since the code is used only rarely (in kernel terms) this code should be
 > in user space instead of the driver.
 > 
 > I've also proposed that if you really, really want to you could do the DDC
 > probing the in driver at boot and mark all of the code _init. Then the user
 > space code would take over after that. Note that I'm talking about early
 > userspace (initrd) timeframe, not normal user space.

Wouldn't it be the job of the kernel bootstrap process to do this initial setup?
This bootstrap code would be wiped once the kernel starts up.

 > 
 > > 
 > > Allow me to speak up for users of IBM pSeries hardware or Sun SPARC 
 > > hardware.  Users of those systems face exactly the same issues as Mac 
 > > users.  I imagine most embedded systems will be in the same boat.  Being 
 > > forced to use a serial console for early boot messages is so 1980's. ;)
 > > 
 > > The kernel doesn't need to have support for everything, but I think it's 
 > > important to have at least minimal support.
 > > 

I'm not speaking about a text mode. 
I would think on most systems the firmware would provide some reasonable
initial mode that the kernel can use. If there is no such firmware one 
would expect there is some preboot software that is used to bootstrap the
kernel that could do such a setup - using a number of fixed modes hard
coded in tables. (It is a pain to debug, though).

Cheers,
	Egbert.


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3

From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: RE: [Dri-devel] Memory management of AGP and VRAM
Date: Sun, 9 May 2004 09:45:14 -0700 (PDT)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040509164514.17651.qmail@web14922.mail.yahoo.com>
References: <409BFE5B.5020308@us.ibm.com>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <409BFE5B.5020308@us.ibm.com>
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
Content-Transfer-Encoding: 7bit
To: Ian Romanick <idr@us.ibm.com>, Egbert Eich <eich@pdx.freedesktop.org>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Can you run grub or lilo on these machines?

Also, these is no rule saying a device driver can't have several tables of _init
register values that can be used to set the mode on a primary monitor at boot. I
would just like to see all of the code that does DDC decoding and modeline
computations moved to user space. When you add up that code there is about 40K
of it in the fbdriver and about 50K in the radeon driver. When the fbdev drivers
start probing for multiple heads, TV support, etc that code is going to get even
larger. Since the code is used only rarely (in kernel terms) this code should be
in user space instead of the driver.

I've also proposed that if you really, really want to you could do the DDC
probing the in driver at boot and mark all of the code _init. Then the user
space code would take over after that. Note that I'm talking about early
userspace (initrd) timeframe, not normal user space.

--- Ian Romanick <idr@us.ibm.com> wrote:
> Egbert Eich wrote:
> 
> > However chipset probing/display device probing and mode setting isn't
> > required to live in kernel space. Portability and system stability 
> > arguments speak against it. In fact only Apple MAC users seem to
> > advocate this idea to be able to an initial video mode on their
> > systems.
> 
> Allow me to speak up for users of IBM pSeries hardware or Sun SPARC 
> hardware.  Users of those systems face exactly the same issues as Mac 
> users.  I imagine most embedded systems will be in the same boat.  Being 
> forced to use a serial console for early boot messages is so 1980's. ;)
> 
> The kernel doesn't need to have support for everything, but I think it's 
> important to have at least minimal support.
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Sleepycat Software
> Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
> deliver higher performing products faster, at low TCO.
> http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
> _______________________________________________
> Mesa3d-dev mailing list
> Mesa3d-dev@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/mesa3d-dev

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3

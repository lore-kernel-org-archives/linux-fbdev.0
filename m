From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Dri-devel] Re: Rage128/Radeon framebuffer updates
Date: Sat, 16 Aug 2003 09:19:00 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030816161900.85239.qmail@web14905.mail.yahoo.com>
References: <1061028282.881.114.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14905.mail.yahoo.com ([216.136.225.57])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19o3lz-0006T6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 16 Aug 2003 09:19:23 -0700
In-Reply-To: <1061028282.881.114.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, dri-devel <dri-devel@lists.sourceforge.net>, Paul Mackerras <paulus@samba.org>

--- Benjamin Herrenschmidt <benh@kernel.crashing.org>
wrote:

The big picture here is that aty128fb and radeonfb
have not had their PCI ID tables updated since 2.6 was
started. Any hardware made since then can't use the
framebuffer drivers.

> So you still go to ROM unconditionally... Well, we
> should get that tested, I don't have the offending
x86
> hardware, but I'd like to know if that still works
with all
> those DFPs for which we obtain the EDID via the BIOS
> image in RAM...

I can't break something that doesn't exist in the 2.6
framebuffer code.

> Again, adding that fixed the driver for a _lot_ of
> users, so I'd like not to change that until we have
a
> replacement with real i2c accesses...

I am not changing this, it doesn't exist in 2.6.

> (Note: The DFP code may not be in the current 2.6
> version of the driver, it's only in 2.4 afaik, it's
part of
> some radeonfb updates I have pending).
> 
> What we could do is, if we can figure out which is
> the primary card, do the RAM search on it only, and 
> use ROM for others, but then, that leads me to
another
> question regarding multiple cards: Are they all
POSTed
> (initialized) by the BIOS? I though x86 BIOSes only
> initialized the first card ?

Only the primary card is POSTed and copied to low RAM.
Note that it is possible to mix vendors and the copy
in RAM may not even belong to a Rage/Radeon.

The correct solution is to read the I2C data like
XFree does and not to rely on the copy in the BIOS.
The Redhat installer also gets it data from I2C.
Reading the copy in low RAM doesn't work if the user
switches monitors either. Besides, how are you sure
the copy in low RAM belongs to your adapter?

Another way to get EDID data is to use an INT10 from a
user level program.  This is compilcated because you
need to use the real mode emulator and change the
INT10 vectors for the various cards.

When PCI/X gets here next year this problem will be
much worse since it will be trivial to install
multiple video cards.

I'm all for using EDID data, it just needs to
retrieved in the correct manner.

> If they aren't, then there's no point in that fix
anyway
> since neither aty128fb nor radeonfb will work on a
card
> that wasn't POSTed by the BIOS.

I have a small program that will POST a secondary
card. Starting XFree on them as a primary or secondary
will also POST them.

I have been annoying ATI (without success) for months
trying to get code out of them to do this so that I
can add it directly to the fb driver.

> Also, looking quickly at the patches:
> 
>  - r128: why do you change the chip generations this
> way ? Is
> there any _use_ of that change (splitting
> PCI/nonPCI) or it's
> just that you prefer it like that ? I'd rather leave
> it the way
> it was, and/or eventually add some bit flags
> indicating if it's
> PCI and/or AGP...
> 

The change was made to select a string for the
appropriate chip generation in the sign-on message. 

The driver has to know PCI or AGP. The PCI IDs are
used to tell.

>  - r128 & radeon : your change of the setup
> functions to turn them into module params, 
> I'm not sure I like them at least not at this
> point. This will change the syntax on the kernel
> command line at least, which I'd rather not do 
> at this stage

2.6 has provided module functions to standardize the
module parameter syntax. 

The only chage is under the old scheme you could say:
modprobe radeonfb 1024x768
now you have to say:
modprobe radeonfb mode=1024x768
Is there a way to do unnamed params with the new
functions, or was that purposely left out?

I have posted several times indicating that I believe
setting the mode from the load command to be
non-functional in 2.6 anyway and asking for an
explaination of how it is suppose to work. 

The current code, which I did not change, only uses
the mode data to set the mode variables and not to
actually set the mode. It I modify the driver to
actually set the mode fbconsole breaks.

>  - AFAIK, Paul Mackerras <paulus@samba.org> is the
> current aty128fb
> maintainer, can you pass the changes through him ?

I sent him a copy. Doesn't he read the fbdev list?


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

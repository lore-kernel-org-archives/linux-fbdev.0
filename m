From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Rage128/Radeon framebuffer updates
Date: 16 Aug 2003 12:04:42 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1061028282.881.114.camel@gaston>
References: <20030816012448.22328.qmail@web14902.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030816012448.22328.qmail@web14902.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, dri-devel <dri-devel@lists.sourceforge.net>, Paul Mackerras <paulus@samba.org>

On Sat, 2003-08-16 at 03:24, Jon Smirl wrote:
> linux/pci_ids.h just had a check-in which caused a big
> merge conflict with my patch. I have tried to sort it
> out.
> 
> Please check Radeon PCI IDs and chip families in
> radeonfb driver. It is important that the PCI IDs of
> secondary devices be marked as such.
> 
> This patch merges Rage128 and Radeon changes into a
> single patch. It is against current 2.5 bk r1.1188.

So you still go to ROM unconditionally... Well, we should
get that tested, I don't have the offending x86 hardware,
but I'd like to know if that still works with all those
DFPs for which we obtain the EDID via the BIOS image in RAM...

Again, adding that fixed the driver for a _lot_ of users, so
I'd like not to change that until we have a replacement with
real i2c accesses...

(Note: The DFP code may not be in the current 2.6 version of
the driver, it's only in 2.4 afaik, it's part of some radeonfb
updates I have pending).

What we could do is, if we can figure out which is the primary
card, do the RAM search on it only, and use ROM for others,
but then, that leads me to another question regarding multiple
cards: Are they all POSTed (initialized) by the BIOS ? I though
x86 BIOSes only initialized the first card ?

If they aren't, then there's no point in that fix anyway since
neither aty128fb nor radeonfb will work on a card that wasn't
POSTed by the BIOS.

Also, looking quickly at the patches:

 - r128: why do you change the chip generations this way ? Is
there any _use_ of that change (splitting PCI/nonPCI) or it's
just that you prefer it like that ? I'd rather leave it the way
it was, and/or eventually add some bit flags indicating if it's
PCI and/or AGP...

 - r128 & radeon : your change of the setup functions to turn them
into module params, I'm not sure I like them at least not at this
point. This will change the syntax on the kernel command line at 
least, which I'd rather not do at this stage

 - AFAIK, Paul Mackerras <paulus@samba.org> is the current aty128fb
maintainer, can you pass the changes through him ?

Ben.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

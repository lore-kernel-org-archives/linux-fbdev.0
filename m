From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: [Dri-devel] Rage128 and Radeon patches
Date: Thu, 14 Aug 2003 09:00:38 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030814160038.11209.qmail@web14906.mail.yahoo.com>
References: <1060857726.602.53.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14906.mail.yahoo.com ([216.136.225.58])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19nKX0-00014I-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 14 Aug 2003 09:00:54 -0700
In-Reply-To: <1060857726.602.53.camel@gaston>
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
Cc: dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- Benjamin Herrenschmidt <benh@kernel.crashing.org>
wrote:
> This is a problem. We also parse it to find the DFP
> EDID and/or flat panel informations, do that work 
> with the real ROM ? I don't know much about x86
> BIOSes, but at least for the DFP EDID, I suppose
> that one is read in RAM by the BIOS, not in the
> ROM...

On x86 machines low RAM contains a copy of the ROM,
now you are getting a pointer to the real ROM. The
contents are identical. The only difference is that
you need to use the readb()/readw()/etc macros to read
it. On the x86 readb() does nothing, but on other
platforms it will trigger a PCI read cycle. This plus
side to this is that you can use multiple video cards.

The ROM stuff is only enabled on the X86 platform. It
was IFDEF'd that way before I made my changes. I did
not change the way it was previously IFDEF'd for other
platforms.  You may want to try enabling the ROM on
the Apple platforms. It will probably work, if it does
change the IFDEFs. The old technique of relying on the
copy in low memory does not work on Apples since their
BIOS doesn't make the copy, that's why it was IFDEF'd
off.

> You may want to look at the version I have in my
> tree on ppc.bkbits.net/linuxppc-2.5-benh. I don't
have
> much time to sync with your before a couple of weeks

> for now... This version rely on my Power Management
> stuffs I posted earlier that James didn't seem to
merge
> yet though.

I looked through the diff for this. The only potential
conflict is where I cleaned up some error paths.
Please keep my changes as the old code was not freeing
resources where it should have. You may want to
experiment with enabling the ROM on the Mac.

My code does not change the behavior of the driver
other than by adding PCI IDs and the way the ROM is
accessed on the X86. It would be nice if you could
check out my code and at least make sure it compiles
and loads on a Powerbook.


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

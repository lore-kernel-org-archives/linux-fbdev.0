From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: [Dri-devel] Rage128 and Radeon patches
Date: Thu, 14 Aug 2003 15:47:29 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030814224729.32404.qmail@web14911.mail.yahoo.com>
References: <1060898658.13316.4.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14911.mail.yahoo.com ([216.136.225.249])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19nQsT-0007a5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 14 Aug 2003 15:47:30 -0700
In-Reply-To: <1060898658.13316.4.camel@gaston>
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

> Well... Again, this has to be verified in real life,
> but
> my understanding is that the BIOS code, once it has
> probed
> the DFP flat panel, will put the EDID data in RAM
> somewhere
> within the copy of the BIOS, which is where we then
> find
> it... The best thing would still be, of course, to
> implement
> full DDC probing in radeonfb like XFree does. This
> has been
> on my todolist for a while now, but I lack time. 
> 
> Ben.
> 

Putting the EDID data into the RAM copy will never
work the case where there are multiple cards since
there is only one copy of the ROM in low RAM.

Personally I'd just like to ignore the boot VROM and
do everything in the Radeon driver code. But ATI won't
give out detailed info on how to read EDID or reset
the card with C code from the driver. So instead we
end up with the idiotic x86 emulator and doing INT10's
in simulated real mode.

Maybe someone with more leverage can coax this info
out of them.....


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

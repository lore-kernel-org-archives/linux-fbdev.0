From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [Dri-devel] Rage128 and Radeon patches
Date: 15 Aug 2003 00:04:19 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1060898658.13316.4.camel@gaston>
References: <20030814160038.11209.qmail@web14906.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030814160038.11209.qmail@web14906.mail.yahoo.com>
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
Cc: dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-08-14 at 18:00, Jon Smirl wrote:
> --- Benjamin Herrenschmidt <benh@kernel.crashing.org>
> wrote:
> > This is a problem. We also parse it to find the DFP
> > EDID and/or flat panel informations, do that work 
> > with the real ROM ? I don't know much about x86
> > BIOSes, but at least for the DFP EDID, I suppose
> > that one is read in RAM by the BIOS, not in the
> > ROM...
> 
> On x86 machines low RAM contains a copy of the ROM,
> now you are getting a pointer to the real ROM. The
> contents are identical. The only difference is that
> you need to use the readb()/readw()/etc macros to read
> it. On the x86 readb() does nothing, but on other
> platforms it will trigger a PCI read cycle. This plus
> side to this is that you can use multiple video cards.

Well... Again, this has to be verified in real life, but
my understanding is that the BIOS code, once it has probed
the DFP flat panel, will put the EDID data in RAM somewhere
within the copy of the BIOS, which is where we then find
it... The best thing would still be, of course, to implement
full DDC probing in radeonfb like XFree does. This has been
on my todolist for a while now, but I lack time. 

Ben.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

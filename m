From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Dri-devel] Rage128 and Radeon patches
Date: 14 Aug 2003 12:42:07 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1060857726.602.53.camel@gaston>
References: <20030814034338.25567.qmail@web14907.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030814034338.25567.qmail@web14907.mail.yahoo.com>
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

On Thu, 2003-08-14 at 05:43, Jon Smirl wrote:
> Hopefully these is the last versions. They implement:

Please CC me any further radeonfb patches, I have my own stuff
pending that I need to sync (and I sort of took over maintainership)

> 1) add every know PCI ID
> 2) access ROM directly instead of relying on copy in
> low RAM. This allows multiple cards. Required
> MPP_TB_CONFIG fix in driver.

This is a problem. We also parse it to find the DFP EDID and/or
flat panel informations, do that work with the real ROM ? I don't
know much about x86 BIOSes, but at least for the DFP EDID, I suppose
that one is read in RAM by the BIOS, not in the ROM...

> 3) implemented kernel 2.6 module parameters
> 4) Cleaned up error paths and made sure resources are
> released on errors. Both build without compiler
> warnings now. You can ins/rm mod multiple times
> without problem. Just don't do it from a window in
> your X server.
> 5) Driver marks both primary and secondary devices as
> being in use.
> 
> These drivers are bigger than the old ones but that's
> because I added descriptions for the parameters and a
> bunch more error messages. Code is probably smaller.
> Strip the strings and remove unneeded entries from the
> device table for embedded systems.
> 
> I don't own Apple hardware. Anyone want to make sure I
> didn't break Powerbooks?

You may want to look at the version I have in my tree
on ppc.bkbits.net/linuxppc-2.5-benh. I don't have much time
to sync with your before a couple of weeks for now... This version
rely on my Power Management stuffs I posted earlier that James didn't
seem to merge yet though.

> It would be nice if someone with Radeon documentation
> verified my chip IDs and family classifications. It is
> important that secondary devices are marked correctly
> in the driver. I did the best I could from Xfree
> source and PCI databases.

The ChipIDs aren't in the documentation. I suppose the best source
here is the XFree driver.

> Patches are against the current 2.6 kernel tree.
> Anyone want to volunteer to get these into the kernel?
> 
> 
> =====
> Jon Smirl
> jonsmirl@yahoo.com
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! SiteBuilder - Free, easy-to-use web site design software
> http://sitebuilder.yahoo.com
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

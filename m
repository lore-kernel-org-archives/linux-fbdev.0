From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: reguest for comments regarding an imac_fb
 and efifb unification
Date: Thu, 6 Mar 2008 20:39:52 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803062038100.26657@anakin>
References: <p0623091ac3f5e718e844@[192.168.9.5]>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JXM5W-0004Pl-3z for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Mar 2008 11:49:11 -0800
Received: from wilson.telenet-ops.be ([195.130.132.42])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JXLwd-0006pX-Ov
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Mar 2008 11:40:00 -0800
In-Reply-To: <p0623091ac3f5e718e844@[192.168.9.5]>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Scott D. Davilla" <davilla@4pi.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 6 Mar 2008, Scott D. Davilla wrote:
> I've involved in development that involves a non-standard efi 
> bootloader and both imac_fb and efifb console framebuffers and it 
> seem redundant to have two console framebuffers that perform the same 
> function. efi_fb is actually a simplification of imac_fb.
> 
> Both imac_fb and efifb are actually very simple in operation, they 
> both assume a linear video frame buffer with fixed x,y dimensions.
> 
> In actual usage;
> 
> 	imac_fb is used in two ways, 1) setup using command-line 
> params or DMI info for traditional Apple desktops and 2) setup using 
> command-line params that are created by mach_boot_linux, the AppleTV 
> bootloader.
> 
> 	efifb is always setup by using screen_info that the 
> bootloader configures.
> 
> 	Nether actually depends on EFI but rather neither can depend 
> on  video/pc bios, these might/might not hang/crash the hardware.
> 
> So it seems that by adding command-line param setup to efifb and some 
> DMI checks, imac_fb can be merged into efifb. efifb is really a 
> strange name as it has no interaction with EFI, it just happens to 
> get used under an EFI environment. It's really just a non-accelerated 
> linear video frame buffer configured by screen_info boot params so it 
> could be used by any hardware that has a linear framebuffer 
> organization.
> 
> Which brings up the point, is there another more general console 
> frame buffer that could replace both imac_fb and efifb? It seems that 
> a generic console framebuffer that assumes a linear video framebuffer 
> that does not make video bios calls (nor PC bios) and can be 
> configured by screen_info params or command-line params would be 
> something that already exists? Is there such a console frame buffer?
> 
> I'm willing to pursue this but I want to check the general consensus 
> about such a venture and possible ramifications that I might not have 
> considered.

There exist a few more drivers for simple linear video frame buffer
devices with fixed x,y dimensions:
  - offb, for Open Firmware based machines,
  - vesafb, for VBE 2.0 compliant graphic boards.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

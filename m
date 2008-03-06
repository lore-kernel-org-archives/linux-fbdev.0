From: "Scott D. Davilla" <davilla@4pi.com>
Subject: reguest for comments regarding an imac_fb and
	efifb unification
Date: Thu, 6 Mar 2008 14:05:17 -0500
Message-ID: <p0623091ac3f5e718e844@[192.168.9.5]>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JXLPv-0007bX-NR for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Mar 2008 11:06:12 -0800
Received: from mx.4pi.com ([24.172.19.59])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JXLPt-0003F9-Kz
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Mar 2008 11:06:10 -0800
Received: from [192.168.9.5] (rbl.4pi.com [24.172.19.62])
	by mx.4pi.com (Postfix) with ESMTP id 81DB93A3219E
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu,  6 Mar 2008 14:06:00 -0500 (EST)
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

I've involved in development that involves a non-standard efi 
bootloader and both imac_fb and efifb console framebuffers and it 
seem redundant to have two console framebuffers that perform the same 
function. efi_fb is actually a simplification of imac_fb.

Both imac_fb and efifb are actually very simple in operation, they 
both assume a linear video frame buffer with fixed x,y dimensions.

In actual usage;

	imac_fb is used in two ways, 1) setup using command-line 
params or DMI info for traditional Apple desktops and 2) setup using 
command-line params that are created by mach_boot_linux, the AppleTV 
bootloader.

	efifb is always setup by using screen_info that the 
bootloader configures.

	Nether actually depends on EFI but rather neither can depend 
on  video/pc bios, these might/might not hang/crash the hardware.

So it seems that by adding command-line param setup to efifb and some 
DMI checks, imac_fb can be merged into efifb. efifb is really a 
strange name as it has no interaction with EFI, it just happens to 
get used under an EFI environment. It's really just a non-accelerated 
linear video frame buffer configured by screen_info boot params so it 
could be used by any hardware that has a linear framebuffer 
organization.

Which brings up the point, is there another more general console 
frame buffer that could replace both imac_fb and efifb? It seems that 
a generic console framebuffer that assumes a linear video framebuffer 
that does not make video bios calls (nor PC bios) and can be 
configured by screen_info params or command-line params would be 
something that already exists? Is there such a console frame buffer?

I'm willing to pursue this but I want to check the general consensus 
about such a venture and possible ramifications that I might not have 
considered.

Thanks
Scott

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

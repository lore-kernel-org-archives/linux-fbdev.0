From: "Jochen Roth" <jochen@panix.com>
Subject: S3triofb
Date: Sat, 23 Nov 2002 06:19:43 -0500 (EST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200211231119.gANBJhk03235@panix3.panix.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail3.panix.com ([166.84.1.74])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18FYK9-0005b9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 23 Nov 2002 03:19:45 -0800
Received: from panix3.panix.com (panix3.panix.com [166.84.1.3])
	by mail3.panix.com (Postfix) with ESMTP id 0A1DF98213
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 23 Nov 2002 06:19:44 -0500 (EST)
Received: (from jochen@localhost)
	by panix3.panix.com (8.11.6/8.8.8/PanixN1.0) id gANBJhk03235
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 23 Nov 2002 06:19:43 -0500 (EST)
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
To: linux-fbdev-devel@lists.sourceforge.net

Hello,

I am in the process of porting Linux to the IBM NetworkStation series
of thin clients. I am currently working on the NS 1000 model, which
is based on a 200 MHz 603ev and some PReP support hardware, NatSemi
SuperIO, S3TrioV2/DX, and AMD 10/100 Ethernet for the Ethernet models.

See http://sourceforge.net/projects/networkstation/ for patches.

I got S3triofb working on the machine as a crude hack with static
mappings, etc. The NS models do not have open firmware or residual
data. I plan to set up mock residual data in the boot loader, but
that does not really belong here.

My plan for the S3 Trio driver was to make it depend on PCI device
configuration only, and use OF information if present to determine
things like the default graphics mode.

Here are some questions I have:

- Who is the current maintainer for the S3triofb? Maybe I wasn't
  looking in the right places, but I didn't figure it out. I emailed
  Peter de Schrijver, who is listed in the driver as author, but I
  haven't heard back.

- The current (2.4.19 for me) S3triofb has a workaround in it to
  reset the PCI BAR0 register to 0xc6000000, with size 64 megs.
  I a) want to figure out for what model this was necessary to add
  some sort of fix, and b) this does not make sense to me as the
  proper address for a 64 meg window wouldn't be 0xc6000000, but
  something naturally aligned, like 0xc[48]000000. Very weird.

- I have not been able to find any programming reference for the S3
  chip in my hardware, V2/DX. I have found s3.txt somewhere, I forget
  where -- immense help so far in understanding the current driver.
  Does anybody have documents for these chips? I tried s3graphics/VIA
  and got no response. I know that the XFree86 guys have docs as pdf,
  but I am not registered as a developer or contributor, and I was
  told this would take months to accomplish.

- I looked briefly at http://gtf.org/garzik/kernel/files/s3fb/ -- is
  this code functional? I know, I should just ask Jeff Garzik.

- I started out wanting to support the V2/DX in my box. Then it occured
  to me that, hey, I could support all Trio64 and 32 models while I'm
  at it. Next thing you know, you arrive at s3fb above. OTOH, Trios
  aren't exactly cutting edge, and S3 is pretty dead these days. Maybe
  the s3fb above is not in the mainline kernel for a reason? On Intel
  machines this hardware is probably supported by the vesa drivers, so
  there it not much incentive from that perspective. What do people here
  think?

Regards,
Jochen



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

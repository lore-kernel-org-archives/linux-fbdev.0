From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [ANNOUNCE]: VM86 Daemon
Date: 01 Apr 2003 10:29:34 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049185774.593.46.camel@zion.wanadoo.fr>
References: <1049104351.1037.53.camel@localhost.localdomain>
	 <3E886C5F.28140.1013B3CA@localhost>
	 <1049160350.1059.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from griffon.mipsys.com ([217.167.51.129] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190H8e-0002Fd-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 00:29:00 -0800
In-Reply-To: <1049160350.1059.39.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Kendall Bennett <KendallB@scitechsoft.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This is interesting, but brings back a point I had in mind
for some time (regardless of having that daemon or not), which
is to provide a consistent API for fbdev's to provide EDID
informations to a "monitor" layer (or to userland) and for
fbdev's to setup appropriately based on EDID informations.

There are several issues here. One is the actual retreival of
the EDID data. There are several ways to do it, and all of them
must be implemented in an ideal world:

 - BIOS stuff (via something like your daemon)
 - Direct i2c (for all platforms that don't have a BIOS or cannot
   run it)
 - Other arch specific way (this includes what we do on some PPCs
   which is to retreive the EDID block from the device tree provided
   by the firmware).

Once the fbdev can provide, upon request, the EDID and probing info
(some cards can tell you if something is connected even without
providing an EDID, like on the S-Video output, or on the VGA output
with a non-DDC capable monitor), we need some consistent API to
retreive that from, userland at least

Then, we need fbdev to "validate" modes based on those EDID infos
(via fbmon ?).




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/

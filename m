From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [ANNOUNCE]: VM86 Daemon
Date: 01 Apr 2003 13:34:51 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049196891.596.57.camel@zion.wanadoo.fr>
References: <1049104351.1037.53.camel@localhost.localdomain>
	 <3E886C5F.28140.1013B3CA@localhost>
	 <1049160350.1059.39.camel@localhost.localdomain>
	 <1049185774.593.46.camel@zion.wanadoo.fr>
	 <1049189944.1009.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from griffon.mipsys.com ([217.167.51.129] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190K1m-0002RP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 03:34:06 -0800
In-Reply-To: <1049189944.1009.61.camel@localhost.localdomain>
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

On Tue, 2003-04-01 at 11:41, Antonino Daplas wrote:

> How I'm currently doing it with the extended vesafb driver is this:
>
> .../...

Ok, good. I'll investigate adapting that to radeonfb & aty128fb
at least.

Also, It would be very useful if we defined a standard ioctl to
retreive the EDID block from userland when available.

This would help some fbdev based apps (especially the maconlinux
emulator) and would be useful for some distro X autoconfig tools,
especially on platforms where X cannot get that EDID via it's
current mecanisms.

Actually, I would like 2 things:

 - Be able to know that the display has been detected as beeing a
TFT panel, and in this case, a "simple" way to retreive the
fb_var_screeninfo of the "native" panel mode. 

 - Returning the full EDID block when it exist

What do you think about adding some ioctl's for that ?

Ben.



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeon framebuffer
Date: 26 Jun 2003 10:15:20 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1056615320.13642.74.camel@gaston>
References: <200306232145.01589.wturkal@cbu.edu>
	 <1056551922.13642.49.camel@gaston>  <200306251342.31473.wturkal@cbu.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-1-152.w193-252.abo.wanadoo.fr ([193.252.38.152] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19VRvY-0000P1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 26 Jun 2003 01:16:21 -0700
In-Reply-To: <200306251342.31473.wturkal@cbu.edu>
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
To: Warren Turkal <wturkal@cbu.edu>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-06-25 at 20:42, Warren Turkal wrote:

> Radeon Mobility 7500 in a laptop. Apparently, the monitor is connected through 
> DVI. BTW, there was a fix for radeon screen blanking on DVI in the XFree86 
> bugzilla at http://bugs.xfree86.org/cgi-bin/bugzilla/show_bug.cgi?id=26. I 
> think you could probably use it to fix console blanking for the radeon.
> 
> BTW, I am not on the list.

If it's a laptop, it's probably LVDS. I indeed changed the code to retreive
the EDID from BIOS for laptops based on recent XFree driver, though I haven't
updated the 2.5 codebase with that change yet.

Thanks for the URL for the blanking fix.

Ben.



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php

From: Warren Turkal <wturkal@cbu.edu>
Subject: Re: radeon framebuffer
Date: Wed, 25 Jun 2003 13:42:30 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200306251342.31473.wturkal@cbu.edu>
References: <200306232145.01589.wturkal@cbu.edu> <1056551922.13642.49.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from cpe-024-165-217-216.midsouth.rr.com
	([24.165.217.216] helo=braindead ident=foobar)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19VFE5-00040G-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 25 Jun 2003 11:42:37 -0700
In-Reply-To: <1056551922.13642.49.camel@gaston>
Content-Disposition: inline
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wednesday 25 June 2003 09:38 am, Benjamin Herrenschmidt wrote:
> On Tue, 2003-06-24 at 04:45, Warren Turkal wrote:
> > I just wanted to make sure that the developers of this list know that the
> > radeon framebuffer only works enough to completely white out my screen
> > when doing anything other than text mode stuff in 2.5.73
>
> radeonfb in current Linus tree doesn't have all of my latest fixes,
> though I can't say for sure those would help or not. What card & what
> monitor setup do you have ?
>
> Ben.

Radeon Mobility 7500 in a laptop. Apparently, the monitor is connected through 
DVI. BTW, there was a fix for radeon screen blanking on DVI in the XFree86 
bugzilla at http://bugs.xfree86.org/cgi-bin/bugzilla/show_bug.cgi?id=26. I 
think you could probably use it to fix console blanking for the radeon.

BTW, I am not on the list.

Thanks, Warren
-- 
Treasurer, GOLUM, Inc.
http://www.golum.org



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php

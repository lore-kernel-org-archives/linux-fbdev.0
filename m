From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: New radeonfb, mostly untested
Date: Thu, 11 Sep 2003 08:38:21 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063262300.2023.23.camel@gaston>
References: <Pine.GSO.4.21.0309110801220.1879-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xL6t-0007Fs-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 23:39:19 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19xL6r-0007BL-Ob
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Sep 2003 23:39:19 -0700
In-Reply-To: <Pine.GSO.4.21.0309110801220.1879-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kronos <kronos@kronoz.cjb.net>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-09-11 at 08:03, Geert Uytterhoeven wrote:
> On Wed, 10 Sep 2003, Benjamin Herrenschmidt wrote:
> > > It  fails only  if  compiled  as module. I  see  that fb_find_mode  (and
> > > my_atoi) are marked  as __init. Maybe they get discarded  after boot and
> > > when  radeonfb module  tries  to call  them it  ends  up in  deallocated
> > > memory...
> > 
> > Exactly, they should definitely not be marked __init
> 
> That doesn't harm. If MODULE is defined, fb_find_mode() is an inline function
> that knows about 640x400@70 only, cfr. <linux/fb.h>.

But that's wrong ! Why would you want to prevent a modular driver to
use fb_find_mode ? Especially in that case where I'm looking for a mode
in the modedb built from EDID list...

On the other hand, if I add the flags for "detailed timings" vs "calculated"
in the modedb list obtained from EDID, I will have to parse the list
manually or change fb_find_mode prototype, to get to the detailed timing...
Another possibility is to change my algorithm to first use the mode returned
by parse_edid (which is from the detailed timings), then only fallback to
fb_find_mode

Ben.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

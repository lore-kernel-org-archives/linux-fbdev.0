From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Unifying radeon.h constant files
Date: Mon, 01 Sep 2003 08:08:37 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1062396517.32736.71.camel@gaston>
References: <20030901052543.31422.qmail@web14915.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19thso-0002uf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 31 Aug 2003 23:09:46 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19thso-0002HD-1B
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Aug 2003 23:09:46 -0700
In-Reply-To: <20030901052543.31422.qmail@web14915.mail.yahoo.com>
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
Cc: kronos <kronos@kronoz.cjb.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-09-01 at 07:25, Jon Smirl wrote:
> What do you think about getting rid of include/video/radeon.h and replacing it
> with the much more comprehensive one from XFree86? It would make life easier if
> constants had the same names in the kernel and XFree86 code. radeonfb would
> need to be touched up for about 100 name changes. 
> 
> char/drm/radeon_drv.h has a third set of names but that is up to the DRI people
> to fix. If we can get radeonfb and 2D XFree on the same set of names I'll see
> if I can get the 3D people to go along.
> 
> If this works for Radeon we should do it for Rage128 too.

I'm all for doing that, but not until I've finished the new version of
the driver ;) Also, I have a bunch of additional constants used by the
Power Management code that don't have the RADEON_ prefix neither and are
not in XFree, we would have to fixup that too. 

Ben.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

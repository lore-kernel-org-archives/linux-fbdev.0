From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Add three new IOCTLs to FB API
Date: Mon, 22 Sep 2003 13:25:11 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030922202511.53395.qmail@web14915.mail.yahoo.com>
References: <Pine.GSO.4.21.0309220919230.4957-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1XFA-0006QM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 13:25:12 -0700
Received: from web14915.mail.yahoo.com ([216.136.225.228])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A1XF9-00010Q-Pc
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 13:25:11 -0700
In-Reply-To: <Pine.GSO.4.21.0309220919230.4957-100000@vervain.sonytel.be>
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
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sun, 21 Sep 2003, Jon Smirl wrote:
> > I'd like to add three new IOCTLs to the FB API to help support standalone 
Mesa.
> > The idea is to eliminate the need for config files. Xfree might even use
these
> > in the future.
> 
> For 2.4.x or 2.6.0?
For 2.6

> > 2) Get 3D driver name. Return the name of the DRM driver that is associated
> > with this fb device. For example aty128fb would return r128, radeonfb would
> > return radeon. Empty string if there is none. There are eight DRM drivers
> and
> > 15 fb ones.
> 
> I think this should be done using sysfs, too. I.e. symbolic links between the
> fbdev and drm drivers in /sys.

Initially the fb device will need to provide strings for the name of the 3D
driver. A user app is going to read these strings and load the DRM driver.
After the DRM driver is loaded it can make links.

Another solution would be for the fb driver to reference a symbol in the
appropriate DRM driver. This would make modprobe load them both.

What should the /sys entries look like for fb devices?



=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

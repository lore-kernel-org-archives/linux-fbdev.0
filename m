From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: Framebuffer vt's second monitor ATI
	9000
Date: Sat, 20 Dec 2003 17:53:25 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1071903204.11192.4910.camel@gaston>
References: <003e01c3c61f$9b116480$1b2625d5@capricho>
	 <Pine.GSO.4.58.0312191213210.29115@waterleaf.sonytel.be>
	 <006b01c3c626$9a3dbca0$1b2625d5@capricho>
	 <20031219211413.GB1305@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXb0h-0007kq-NQ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Dec 2003 22:54:47 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AXb0h-0007x9-8G
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Dec 2003 22:54:47 -0800
In-Reply-To: <20031219211413.GB1305@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Kronos <kronos@kronoz.cjb.net>
Cc: Javier Vizcaino <javizca@mi.madritel.es>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-12-20 at 08:14, Kronos wrote:
> Il Fri, Dec 19, 2003 at 12:52:36PM +0100, Javier Vizcaino ha scritto: 
> > : > Questions:
> > : > -Is it possible to have framebuffer based vt's on the second connector of the ATI board?
> > : > -How should I proceed (modules, options, etc)?
> > : 
> > : I don't think radeonfb does real multi-head yet.
> > 
> > **** If you ever find some info about this, or if it is other the module for it,
> > please let me know.
> 
> Ben Herrenschmidt is working on a new version of the driver (see
> bk://ppc.bkbits.net/linuxppc-2.5-benh). Multihead support is not there
> yet, but it's in the TODO list. 

Definitely. I'm not yet sure how I'll deal with some issues related
to multihead, like enabling/disabling mirroring, telling XFree (when
using UseFBDev) which /dev/fbs are multiple heads of the same card,
etc... All that is basically lacking in the fbdev API at this point.

I'm also a bit swamped with work lately so I had to put my radeonfb
work on hold for a while. Of course, any help on that is welcome ;)

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

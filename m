From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: New radeonfb, mostly untested
Date: Sat, 13 Sep 2003 00:45:13 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030912224513.GA29997@dreamland.darkstar.lan>
References: <20030912193603.GA16977@dreamland.darkstar.lan> <Pine.LNX.4.44.0309122317180.5017-100000@phoenix.infradead.org>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xwgh-0002M4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 15:46:47 -0700
Received: from mail-6.tiscali.it ([195.130.225.152])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xwgg-0006Fs-MO
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 15:46:46 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309122317180.5017-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Fri, Sep 12, 2003 at 11:20:13PM +0100, James Simmons ha scritto: 
> > Also, modes  from fb_get_mode  are different from  XFree modes  so every
> > time I switch from console to X I have to re-center the screen.
> > 
> > This happens only when modedb is created from edid, not when using the
> > standard modedb.
> > 
> > Currently create_modedb is unused (the new radeon driver is the first
> > user of edid stuff) so we may be hitting a real bug.
> 
> Sounds like bugs in the code. The code was never tested before.
> 
> 
> BTW where can I find the latest Radeon code. I like to test it myself.

You can find it in Ben's tree: bk://ppc.bkbits.net/linuxppc-2.5-benh

It's easier to  test it userspace, I've adapted fbmon.c  and modedb.c to
work in userspace (trivial)  so that I can fopen the  dump of edid block
and pass it to create_modedb.

I'll send you my edid block if you need it.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
E' stato a causa di una donna che ho cominciato a bere e non ho mai
avuto la cortesia di ringraziarla.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

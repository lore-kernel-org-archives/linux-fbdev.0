From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: fbdev timings
Date: Mon, 15 Sep 2003 18:07:39 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915160739.GC1980@dreamland.darkstar.lan>
References: <20030915073029.GA13799@guug.org>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yvtP-0002gW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 09:07:59 -0700
Received: from mail-8.tiscali.it ([195.130.225.154])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yvtO-0005hr-Lp
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 09:07:58 -0700
Content-Disposition: inline
In-Reply-To: <20030915073029.GA13799@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Il Mon, Sep 15, 2003 at 01:30:29AM -0600, Otto Solares ha scritto: 
> finally i am coding the video part of a "desktop engine",
> but i want something that works profesionally, i'm using
> fbdev and embedded mesa for it, i am trying to get the
> video modes as automagically as posible, in that regard
> my plan is to hack get-edid (cause we don't have a proper
> mechanism from userspace, yea modedb is marked _init
> and the new edid just works in radeons and only usable
> too from kernelspace -end of critic :)

Userspace can access edid block via sysfs and can do its own parsing.

> into my software
> and fallback to a text database like hwdata to obtain
> monitor specs if edid doesn't work, but i have a problem,
> how i am supposed to construct fbdev timings with just
> this info:
> 
> - resolution (width x height, 800x600).
> - hsync range (31-49 Khz)
> - vsync range (48-80 hz)

You can use vesa_modes (in modedb.c) or you can use fb_get_mode (see
fbmon.c).

> i do know that is possible to contruct such timings
> because the monitor specs in windows xp are stored
> in /windows/inf/monitor.inf and contains only that
> variables.  Please any detailed response in how can
> they construct their timings with just this variables
> and how can i use it with fbdevs from userspace in 2.6?

You can get  the whole var usign ioctls. Also, once  the class_dev stuff
is in place  (I'll send patches in few minutes)  every driver can export
its own stuff via sysfs.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Non capisco tutta questa eccitazione per il Multitasking: 
io sono anni che leggo in bagno.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

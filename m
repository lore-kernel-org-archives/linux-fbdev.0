From: James Simmons <jsimmons@infradead.org>
Subject: [BK console] console updates.
Date: Wed, 30 Oct 2002 13:56:38 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210301343580.1392-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi folks!!!

   Along with the new fbdev api I also have rewritten the console layer.
The goals are:

1) The idea here was to move alot of the basic functionaly present in
   alot of low level drivers into the the higher layers thus making the
   low level drivers smaller and cleaner. A good example is using the
   /dev/fb interface to resize a VC. That is just plain dumb.

2) The second goal was to seperate out the terminal emulation to allow
   for a light weight printk. Also the idea was to make the VT console
   system modular. On embedded devices then we can insmod the VT
   console system. This is partially done.

3) Multi-desktop systems. Already done this. The current code in BK
   doesn't support this just yet as I have a few bug to beat out for
   single headed systems. It will take about one more week to get this
   ready.


I doubt this code will go into 2.5.X but it is avaiable for anyone to play
with it.

bk://linuxconsole.bkbits.net

BTW I will make patches avaiable as soon as 2.5.45 comes out.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en

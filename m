From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Subject: RE: 2.5 atyfb on Sparc question
Date: Thu, 3 Oct 2002 14:49:10 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <61DB42B180EAB34E9D28346C11535A780112FDED@nocmail101.ma.tmpw.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailsorter.ma.tmpw.net ([63.112.169.25])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17xByu-0003my-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 03 Oct 2002 12:49:56 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'James Simmons' <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

James,

In a blast from the past, not sure if your still interested, but I have not
had a whole lot of time to look at these, due to my job/life, etc,etc...

If I apply the latest bk to it, I get the following compile error.  As I
said, I haven't even had time to grep through the thing to even begin to
look, but wanted to report them anyways...

fbmem.c: In function `fbmem_read_proc':
fbmem.c:380: structure has no member named `modename'
make[2]: *** [fbmem.o] Error 1
make[2]: Leaving directory `/home/bruce/sparctest/drivers/video'
make[1]: *** [video] Error 2
make[1]: Leaving directory `/home/bruce/sparctest/drivers'
make: *** [drivers] Error 2

Bruce H..

> -----Original Message-----
> From: James Simmons [mailto:jsimmons@infradead.org]
> Sent: Thursday, August 22, 2002 3:22 PM
> To: Holzrichter, Bruce
> Cc: linux-fbdev-devel@lists.sourceforge.net
> Subject: RE: [Linux-fbdev-devel] 2.5 atyfb on Sparc question
> 
> 
> 
> > > Oops. Fixed now.
> > >
> > Whoa, that was neat!  ;o)
> 
> Can you try the latest changes in my BK tree.
> 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

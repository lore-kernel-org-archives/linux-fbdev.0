From: James Simmons <jsimmons@infradead.org>
Subject: RE: 2.5 atyfb on Sparc question
Date: Sun, 13 Oct 2002 13:08:08 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210131307110.5997-100000@maxwell.earthlink.net>
References: <61DB42B180EAB34E9D28346C11535A780112FDED@nocmail101.ma.tmpw.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120] helo=albatross.prod.itd.earthlink.net)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 180p8F-0007NP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Oct 2002 13:14:35 -0700
In-Reply-To: <61DB42B180EAB34E9D28346C11535A780112FDED@nocmail101.ma.tmpw.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


Sorry I have been going threw alot of chabnges recently. Try my lastest
tree. I just updated it and I'm nearly done change the api.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

On Thu, 3 Oct 2002, Holzrichter, Bruce wrote:

> James,
>
> In a blast from the past, not sure if your still interested, but I have not
> had a whole lot of time to look at these, due to my job/life, etc,etc...
>
> If I apply the latest bk to it, I get the following compile error.  As I
> said, I haven't even had time to grep through the thing to even begin to
> look, but wanted to report them anyways...
>
> fbmem.c: In function `fbmem_read_proc':
> fbmem.c:380: structure has no member named `modename'
> make[2]: *** [fbmem.o] Error 1
> make[2]: Leaving directory `/home/bruce/sparctest/drivers/video'
> make[1]: *** [video] Error 2
> make[1]: Leaving directory `/home/bruce/sparctest/drivers'
> make: *** [drivers] Error 2
>
> Bruce H..
>
> > -----Original Message-----
> > From: James Simmons [mailto:jsimmons@infradead.org]
> > Sent: Thursday, August 22, 2002 3:22 PM
> > To: Holzrichter, Bruce
> > Cc: linux-fbdev-devel@lists.sourceforge.net
> > Subject: RE: [Linux-fbdev-devel] 2.5 atyfb on Sparc question
> >
> >
> >
> > > > Oops. Fixed now.
> > > >
> > > Whoa, that was neat!  ;o)
> >
> > Can you try the latest changes in my BK tree.
> >
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

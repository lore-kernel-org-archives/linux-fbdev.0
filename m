From: Kyrian <kyrian@ore.org>
Subject: Re: Linux-kernel-digest digest, Vol 1 #4001 - 23 msgs
Date: Thu, 17 Oct 2002 21:42:07 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200210172043.g9HKhdL23919@mailhost.orenet.co.uk>
References: <20021017190301.28005.83482.Mailman@lists.us.dell.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from lestat.ore.org ([195.82.99.77] helo=mailhost.orenet.co.uk)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182HUa-0004cU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Oct 2002 13:43:40 -0700
Received: (from cyrus@localhost)
	by mailhost.orenet.co.uk (8.11.6/8.9.3) id g9HKhe123961
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Oct 2002 21:43:40 +0100
Received: from ore.org (marius.orenet.co.uk [195.13.114.100])
	by mailhost.orenet.co.uk (8.11.6/8.9.3) with SMTP id g9HKhdL23919
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Oct 2002 21:43:39 +0100
In-Reply-To: <20021017190301.28005.83482.Mailman@lists.us.dell.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

Assuming this is a better place to post fbdev issues than the kernel devel
list (someone let me know if not please? and/or point me to a more
appropriate place to post?)

Basically I still can't get the aty128fb.c driver to compile, for what still
look like API change reasons, even having downloaded the kernel from
BitKeeper again after receiving the below announcement from James...

  gcc -Wp,-MD,drivers/video/.aty128fb.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=aty128fb   -c -o drivers/video/aty128fb.o
drivers/video/aty128fb.c
drivers/video/aty128fb.c:85:30: video/fbcon-cfb8.h: No such file or
directory
drivers/video/aty128fb.c:86:31: video/fbcon-cfb16.h: No such file or
directory
drivers/video/aty128fb.c:87:31: video/fbcon-cfb24.h: No such file or
directory
drivers/video/aty128fb.c:88:31: video/fbcon-cfb32.h: No such file or
directory
drivers/video/aty128fb.c:397: unknown field `fb_set_var' specified in
initializer
drivers/video/aty128fb.c:397: `gen_set_var' undeclared here (not in a
function)
drivers/video/aty128fb.c:397: initializer element is not constant
drivers/video/aty128fb.c:397: (near initialization for
`aty128fb_ops.fb_open')
drivers/video/aty128fb.c:400: unknown field `fb_get_cmap' specified in
initializer
drivers/video/aty128fb.c:400: `gen_get_cmap' undeclared here (not in a
function)drivers/video/aty128fb.c:400: initializer element is not constant
drivers/video/aty128fb.c:400: (near initialization for
`aty128fb_ops.fb_cursor')drivers/video/aty128fb.c:401: unknown field
`fb_set_cmap' specified in initializer
drivers/video/aty128fb.c:401: `gen_set_cmap' undeclared here (not in a
function)drivers/video/aty128fb.c:401: initializer element is not constant
drivers/video/aty128fb.c:401: (near initialization for
`aty128fb_ops.fb_setcolreg')
drivers/video/aty128fb.c:403: warning: initialization from incompatible
pointer
type
drivers/video/aty128fb.c:405: warning: initialization from incompatible
pointer
type
drivers/video/aty128fb.c: In function `aty128_init':
drivers/video/aty128fb.c:1510: structure has no member named `modename'
drivers/video/aty128fb.c:1513: structure has no member named `fontname'
drivers/video/aty128fb.c:1514: structure has no member named `changevar'
drivers/video/aty128fb.c:1515: structure has no member named `switch_con'
drivers/video/aty128fb.c:1515: `gen_switch' undeclared (first use in this
function)
drivers/video/aty128fb.c:1515: (Each undeclared identifier is reported only
oncedrivers/video/aty128fb.c:1515: for each function it appears in.)
drivers/video/aty128fb.c:1516: structure has no member named `updatevar'
drivers/video/aty128fb.c:1516: `gen_update_var' undeclared (first use in
this function)
drivers/video/aty128fb.c:1594: warning: implicit declaration of function
`gen_set_disp'
drivers/video/aty128fb.c:1597: warning: implicit declaration of function
`gen_set_var'
drivers/video/aty128fb.c: In function `aty128_pci_register':
drivers/video/aty128fb.c:1694: structure has no member named `disp'
drivers/video/aty128fb.c:1730: too many arguments to function
`aty128find_ROM'
drivers/video/aty128fb.c:1736: warning: passing arg 1 of
`aty128_get_pllinfo' from incompatible pointer type
drivers/video/aty128fb.c: At top level:
drivers/video/aty128fb.c:1402: warning: `aty128fb_rasterimg' defined but not
used
make[2]: *** [drivers/video/aty128fb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2
[root@marius linux-20021017]#

Err... help?

Yours,

Kev.


> Message: 17
> Date: Thu, 17 Oct 2002 11:42:27 -0700 (PDT)
> From: James Simmons <jsimmons@infradead.org>
> To: Russell King <rmk@arm.linux.org.uk>
> cc: Linux Fbdev development list 
>	<linux-fbdev-devel@lists.sourceforge.net>,
>   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
>   Linux console project <linuxconsole-dev@lists.sourceforge.net>
> Subject: Re: [Linux-fbdev-devel] Re: [ANNOUCE] fbdev changes finished.
> 
> > > Give it a try. For people who want a diff it is avaiable at
> > >
> > > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz


--
Kev Green, aka Kyrian. Email: kyrian&#64;ore.org Web: http://kyrian.ore.org/
  [ Looking for ISP contract work, CV at http://kyrian.ore.org/cv.html ]
               "Be excellent to each other" -- Bill & Ted.


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm

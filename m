From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Subject: 2.5 atyfb on Sparc question
Date: Tue, 6 Aug 2002 10:31:04 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <61DB42B180EAB34E9D28346C11535A780112F965@nocmail101.ma.tmpw.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailsorter.ma.tmpw.net ([63.112.169.25])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17c6Io-0007OK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 06 Aug 2002 08:31:18 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'linux-fbdev-devel@lists.sourceforge.net'" <linux-fbdev-devel@lists.sourceforge.net>

Quick question..  I was wondering if there is still a bk tree for fbdev
work, or are you pushing direct to Linus?

I am getting the following errors when compiling on a sparc64 machine from
the latest BK 2.5 tree, and was wondering if a fix may already be around.  I
am not subscribed to this list, but a quick search didn't turn up anything.
Thanks in advance..

Thanks,
Bruce H. 

atyfb_base.c: In function `atyfb_set_dispsw':
atyfb_base.c:1098: warning: assignment discards `const' from pointer target
type
atyfb_base.c:1101: warning: assignment discards `const' from pointer target
type
atyfb_base.c:1105: warning: assignment discards `const' from pointer target
type
atyfb_base.c:1109: warning: assignment discards `const' from pointer target
type
atyfb_base.c: In function `atyfb_set_var':
atyfb_base.c:1191: warning: implicit declaration of function
`do_install_cmap'
atyfb_base.c: In function `atyfb_ioctl':
atyfb_base.c:1258: `info2' undeclared (first use in this function)
atyfb_base.c:1258: (Each undeclared identifier is reported only once
atyfb_base.c:1258: for each function it appears in.)
atyfb_base.c:1253: warning: `disp' might be used uninitialized in this
function
atyfb_base.c: In function `atyfb_save_palette':
atyfb_base.c:1447: warning: passing arg 2 of `aty_ld_8' from incompatible
pointer type
atyfb_base.c:1448: `par' undeclared (first use in this function)
atyfb_base.c:1450: warning: passing arg 3 of `aty_st_8' from incompatible
pointer type
atyfb_base.c:1451: warning: passing arg 3 of `aty_st_8' from incompatible
pointer type
atyfb_base.c: In function `atyfb_init':
atyfb_base.c:2204: parse error before `struct'
atyfb_base.c:2231: `default_par' undeclared (first use in this function)
atyfb_base.c:2261: `par' undeclared (first use in this function)
atyfb_base.c:2268: warning: assignment makes pointer from integer without a
cast
atyfb_base.c:2364: warning: passing arg 2 of `aty_ld_le32' from incompatible
pointer type
atyfb_base.c:2366: warning: passing arg 2 of `aty_ld_le32' from incompatible
pointer type
atyfb_base.c:2388: warning: passing arg 2 of `aty_ld_le32' from incompatible
pointer type
atyfb_base.c:2392: warning: passing arg 3 of `aty_st_le32' from incompatible
pointer type
atyfb_base.c:2434: warning: passing arg 2 of `aty_ld_le32' from incompatible
pointer type
atyfb_base.c:2437: warning: passing arg 2 of `aty_ld_le32' from incompatible
pointer type
atyfb_base.c:2439: warning: passing arg 2 of `aty_ld_le32' from incompatible
pointer type
atyfb_base.c:2442: warning: passing arg 2 of `aty_ld_le32' from incompatible
pointer type
atyfb_base.c:2444: warning: passing arg 2 of `aty_ld_le32' from incompatible
pointer type
atyfb_base.c:2455: warning: passing arg 2 of `aty_ld_8' from incompatible
pointer type
atyfb_base.c:2458: warning: passing arg 2 of `aty_ld_pll' from incompatible
pointer type
atyfb_base.c:2560: invalid operands to binary &
atyfb_base.c: At top level:
atyfb_base.c:136: warning: `atyfb_fix' defined but not used
make[3]: *** [atyfb_base.o] Error 1
make[3]: Leaving directory `/home/bruce/sparctest/drivers/video/aty'
make[2]: *** [aty] Error 2
make[2]: Leaving directory `/home/bruce/sparctest/drivers/video'
make[1]: *** [video] Error 2
make[1]: Leaving directory `/home/bruce/sparctest/drivers'
make: *** [drivers] Error 2


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

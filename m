From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Subject: RE: 2.5 atyfb on Sparc question
Date: Fri, 9 Aug 2002 13:18:53 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <61DB42B180EAB34E9D28346C11535A780112F9A3@nocmail101.ma.tmpw.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailsorter.ma.tmpw.net ([63.112.169.25])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17dEMJ-000469-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Aug 2002 11:19:35 -0700
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
To: 'James Simmons' <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

> 
> http://fbdev.bkbits.net:8080/fbdev-2.5
> 

Closer, closer....

Here's an FYI.  I haven't looked into it any further yet...

B.

make[3]: Entering directory `/home/bruce/sparctest/drivers/video/aty'
  sparc64-linux-gcc -Wp,-MD,./.atyfb_base.o.d -D__KERNEL__
-I/home/bruce/sparctest/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu
-mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7
-Wno-sign-compare -Wa,--undeclared-regs -nostdinc -iwithprefix include
-DKBUILD_BASENAME=atyfb_base   -c -o atyfb_base.o atyfb_base.c
atyfb_base.c: In function `atyfb_ioctl':
atyfb_base.c:1075: `info2' undeclared (first use in this function)
atyfb_base.c:1075: (Each undeclared identifier is reported only once
atyfb_base.c:1075: for each function it appears in.)
atyfb_base.c:1070: warning: `disp' might be used uninitialized in this
function
atyfb_base.c: In function `atyfb_init':
atyfb_base.c:2086: warning: assignment makes pointer from integer without a
cast
atyfb_base.c:2184: `defualt_par' undeclared (first use in this function)
atyfb_base.c:2376: invalid operands to binary &
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

From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: matroxfb broken in 2.5.51 ?
Date: Wed, 11 Dec 2002 13:42:58 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021211124258.GA9108@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254] helo=mel-rto2.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18M6Cg-0000dT-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Dec 2002 04:43:06 -0800
Received: from mel-rta10.wanadoo.fr (193.252.19.193) by mel-rto2.wanadoo.fr (6.7.015)
        id 3DF630960007D034 for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Dec 2002 13:42:59 +0100
Received: from iliana (80.14.193.77) by mel-rta10.wanadoo.fr (6.7.015)
        id 3DF6325A0006393C for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Dec 2002 13:42:59 +0100
Received: from luther by iliana with local (Exim 3.36 #1 (Debian))
	id 18M6CY-0002NJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Dec 2002 13:42:58 +0100
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Hello, ...

matroxfb seems broken in 2.5.51 :

  gcc -Wp,-MD,drivers/video/matrox/.matroxfb_base.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc -iwithprefix include -DKBUILD_BASENAME=matroxfb_base -DKBUILD_MODNAME=matroxfb_base -DEXPORT_SYMTAB  -c -o drivers/video/matrox/matroxfb_base.o
  drivers/video/matrox/matroxfb_base.c
  In file included from drivers/video/matrox/matroxfb_base.c:105:
  drivers/video/matrox/matroxfb_base.h:52: video/fbcon.h: No such file or directory
  drivers/video/matrox/matroxfb_base.h:53: video/fbcon-cfb4.h: No such file or directory
  drivers/video/matrox/matroxfb_base.h:54: video/fbcon-cfb8.h: No such file or directory
  drivers/video/matrox/matroxfb_base.h:55: video/fbcon-cfb16.h: No such file or directory
  drivers/video/matrox/matroxfb_base.h:56: video/fbcon-cfb24.h: No such file or directory
  drivers/video/matrox/matroxfb_base.h:57: video/fbcon-cfb32.h: No such file or directory
  In file included from drivers/video/matrox/matroxfb_base.c:105:
  drivers/video/matrox/matroxfb_base.h:341: warning: `struct display' declared inside parameter list
  drivers/video/matrox/matroxfb_base.h:341: warning: its scope is only this definition or declaration, which is probably not what you want.

Mmm, maybe it is only because the fbcon.h and co did not get moved to
the right place or something such, will check.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

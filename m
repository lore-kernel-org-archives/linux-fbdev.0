From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 3946] New: sis/sis_main.c compilation error
Date: Sat, 25 Dec 2004 14:31:18 -0800
Message-ID: <20041225143118.0303ccc3.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CiKS3-0007SY-Nq
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 25 Dec 2004 14:31:55 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CiKS2-0006OS-Uj
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 25 Dec 2004 14:31:55 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-fbdev-devel@lists.sourceforge.net



Begin forwarded message:

Date: Sat, 25 Dec 2004 10:17:21 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 3946] New: sis/sis_main.c compilation error


http://bugme.osdl.org/show_bug.cgi?id=3946

           Summary: sis/sis_main.c compilation error
    Kernel Version: 2.6.10
            Status: NEW
          Severity: normal
             Owner: drivers_video-other@kernel-bugs.osdl.org
         Submitter: public@kurt.hindenburg.name


/usr/src/linux-2.6.10)> make
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-i386/asm_offsets.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC      drivers/video/sis/sis_main.o
drivers/video/sis/sis_main.c: In function `sisfb_set_par':
drivers/video/sis/sis_main.c:1817: error: structure has no member named `currcon'
make[3]: *** [drivers/video/sis/sis_main.o] Error 1
make[2]: *** [drivers/video/sis] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2




(/usr/src/linux-2.6.10)> grep sis .config -i
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_SIS900 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y


(/usr/src/linux-2.6.10)> gcc -v
Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/specs
Configured with:
/mnt/part6/portage-tmp/portage/gcc-3.3.4-r1/work/gcc-3.3.4/configure
--prefix=/usr --bindir=/usr/i686-pc-linux-gnu/gcc-bin/3.3
--includedir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/include
--datadir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3
--mandir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3/man
--infodir=/usr/share/gcc-data/i686-pc-linux-gnu/3.3/info --enable-shared
--host=i686-pc-linux-gnu --target=i686-pc-linux-gnu --with-system-zlib
--enable-languages=c,c++ --enable-threads=posix --enable-long-long
--disable-checking --disable-libunwind-exceptions --enable-cstdio=stdio
--enable-version-specific-runtime-libs
--with-gxx-include-dir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/include/g++-v3
--with-local-prefix=/usr/local --enable-shared --enable-nls
--without-included-gettext --disable-multilib --enable-__cxa_atexit
--enable-clocale=generic
Thread model: posix
gcc version 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

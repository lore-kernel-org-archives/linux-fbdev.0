From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Subject: RE: 2.5 atyfb on Sparc question
Date: Mon, 12 Aug 2002 13:42:58 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <61DB42B180EAB34E9D28346C11535A780112F9C1@nocmail101.ma.tmpw.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailsorter.ma.tmpw.net ([63.112.169.25])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17eKAF-0001VS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 12 Aug 2002 11:43:39 -0700
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
> Try it again. I pushed some fixes.
> 

Here's a simple one liner fix, pretty self explanatory, if you haven't
caught it yet.  ;o)

--- atyfb_base.c.old    Mon Aug 12 11:34:44 2002
+++ atyfb_base.c        Mon Aug 12 10:57:11 2002
@@ -2241,7 +2241,7 @@
                                    aty_ld_le32(CRTC_H_TOTAL_DISP,
default_par);
                                crtc.h_sync_strt_wid =
                                    aty_ld_le32(CRTC_H_SYNC_STRT_WID,
-                                               defualt_par);
+                                               default_par);
                                crtc.v_tot_disp =
                                    aty_ld_le32(CRTC_V_TOTAL_DISP,
default_par);
                                crtc.v_sync_strt_wid =

Now looking to track this one down.  Haven't found it yet....

  ld -m elf64_sparc -T arch/sparc64/vmlinux.lds arch/sparc64/kernel/head.o
arch/sparc64/kernel/init_task.o init/init.o --start-group
arch/sparc64/kernel/kernel.o arch/sparc64/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o security/built-in.o arch/sparc64/math-emu/math-emu.o
/home/bruce/sparctest/lib/lib.a lib/lib.a
/home/bruce/sparctest/arch/sparc64/prom/promlib.a
/home/bruce/sparctest/arch/sparc64/lib/lib.a drivers/built-in.o
sound/sound.o net/network.o --end-group -o vmlinux
drivers/built-in.o: In function `console_init':
drivers/built-in.o(.text.init+0xa78): undefined reference to
`uart_console_init'
make: *** [vmlinux] Error 1

B.







-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31

From: James Simmons <jsimmons@infradead.org>
Subject: RE: 2.5 atyfb on Sparc question
Date: Mon, 12 Aug 2002 23:15:54 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208122315140.2411-100000@maxwell.earthlink.net>
References: <61DB42B180EAB34E9D28346C11535A780112F9C1@nocmail101.ma.tmpw.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from gull.mail.pas.earthlink.net ([207.217.120.84])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17eV41-0007R8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 12 Aug 2002 23:21:57 -0700
In-Reply-To: <61DB42B180EAB34E9D28346C11535A780112F9C1@nocmail101.ma.tmpw.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


> Here's a simple one liner fix, pretty self explanatory, if you haven't
> caught it yet.  ;o)

Oops. Fixed now.

> Now looking to track this one down.  Haven't found it yet....
>
>   ld -m elf64_sparc -T arch/sparc64/vmlinux.lds arch/sparc64/kernel/head.o
> arch/sparc64/kernel/init_task.o init/init.o --start-group
> arch/sparc64/kernel/kernel.o arch/sparc64/mm/mm.o kernel/kernel.o mm/mm.o
> fs/fs.o ipc/ipc.o security/built-in.o arch/sparc64/math-emu/math-emu.o
> /home/bruce/sparctest/lib/lib.a lib/lib.a
> /home/bruce/sparctest/arch/sparc64/prom/promlib.a
> /home/bruce/sparctest/arch/sparc64/lib/lib.a drivers/built-in.o
> sound/sound.o net/network.o --end-group -o vmlinux
> drivers/built-in.o: In function `console_init':
> drivers/built-in.o(.text.init+0xa78): undefined reference to
> `uart_console_init'

New serial tty code. Have no idea for the fix.



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31

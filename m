From: James Simmons <jsimmons@transvirtual.com>
Subject: [PATCH] New Console system BK
Date: Mon, 1 Jul 2002 12:52:00 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <afqca1$961$2@main.gmane.org>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Since 2.5.1 I have placed into the kernel part of the new console system
code into the DJ tree. So it has been well tested. I was hoping to have
all the keyboard devices ported over to the input api and the fbdev
drivers over to the new api. Unfortunely due to time restraints this will
not be the case. So here goes the first installment of the new console
system. Please test it yourselves and I will push it to Linus soon.

The goal is to create a system we can use keyboards without the console
system and the same true for framebuffer devices. This is most helpful on
embedded devices. The other goals to make the VT console system more
modular and lighter weight. The other goal is to make the VT tty system
multi-desktop.

Here are the changes so far:

I) Removal of struct kbd_struct from the sysrq handler. Why drag itr along
   when only two sysrq functions actually use it.

II) Massive rewrite and cleanup of keybaord.c.

III) Place struct tty_struct into struct vc_data. This sets up a one to
     one relationship. Avoids the nasty tricks of playing with fields from
     console_driver.

IV) Cleanup of VT tty/console initialization. A vty_init function to make
    it cleaner.

diffstat:

 arch/i386/kernel/apm.c         |    2
 arch/ppc/xmon/start.c          |    2
 arch/ppc64/xmon/start.c        |    2
 drivers/acpi/system.c          |    2
 drivers/char/console.c         |   82 ++--
 drivers/char/keyboard.c        |  779 +++++++++++++++++++++--------------------
 drivers/char/sysrq.c           |   46 +-
 drivers/char/tty_io.c          |   15
 include/linux/console_struct.h |    1
 include/linux/sysrq.h          |   13
 11 files changed, 485 insertions(+), 459 deletions(-)


The BK patch is at:

 http://linuxconsole.bkbits.net/dev

diff:

 http://www.transvirtual.com/~jsimmons/console.diff.gz

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

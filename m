From: James Simmons <jsimmons@transvirtual.com>
Subject: [PATCH] Console/tty system patch. II
Date: Wed, 3 Jul 2002 15:58:45 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207031556140.26377-100000@www.transvirtual.com>
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


I fixed that bug with VT switching. Give the new patch a try so I can push
it to Linus. Thanks!!

BK:
	http://linuxconsole.bkbits.net:8080/dev

diff:
	http://www.transvirtual.com/~jsimmons/console.diff.gz

diffstat:

 arch/i386/kernel/apm.c         |    2
 arch/ppc/xmon/start.c          |    2
 arch/ppc64/xmon/start.c        |    2
 drivers/acpi/system.c          |    2
 drivers/char/console.c         |   82 ++--
 drivers/char/keyboard.c        |  781 +++++++++++++++++++++--------------------
 drivers/char/sysrq.c           |   46 +-
 drivers/char/tty_io.c          |   15
 include/linux/console_struct.h |    1
 include/linux/sysrq.h          |   13
 11 files changed, 487 insertions(+), 459 deletions(-)

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf

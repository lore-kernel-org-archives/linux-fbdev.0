From: James Simmons <jsimmons@transvirtual.com>
Subject: [PATCH] fbdev updates.
Date: Wed, 22 May 2002 09:54:04 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10205220936580.4611-100000@www.transvirtual.com>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux console project <linuxconsole-dev@lists.sourceforge.net>


Hi!

   I just ported over a few driver to the new api. I also included a few
bug fixes as well as a few new drivers. Please try it out and send me any
patches. Once the testing is done I will ask Linus to included into his
tree. If you look at skeletonfb.c you will see actual info on the new api
to help you port it over to the new api.

BK:

   http://fbdev.bkbits.net:8080/fbdev-2.5

Diff:

   http://www.transvirtual.com/~jsimmons/fbdev.diff

P.S
   Yes with with new api I haven't finished the drawing penguin code so
you don't see a penguin yet. I will but I figured the new api is more
important.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm

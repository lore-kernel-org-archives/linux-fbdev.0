From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] New radeonfb fork
Date: 06 Apr 2003 17:29:14 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049642954.550.41.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-5-206.abo.wanadoo.fr ([217.128.250.206] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 192C1l-0001Rm-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 06 Apr 2003 08:25:49 -0700
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
To: linux-kernel@vger.kernel.org, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Hi !

As I told a while ago, I'm forking radeonfb for now, at least
until Ani (current maintainer) either give me maintainership
or gets all that stuff in the official version.

I need testers, and I'd appreciate any patches people may have
for it as well since I know a bunch of ppl have been spreading
various radeonfb patches around, I want to take over all of these
and see what is worth getting in. For 2.5, I'm working on a
complete rewrite (& split) of the driver.

So far, I already have something to play with that fixes a
bunch of issues. Patches against 2.4.20 and 2.4.21-pre7 can
be found here: (too big to inline). Note that I also bring
in various other pci_ids.h updates but that shouldn't harm
you and is easier that way for me ;)

http://penguinppc.org/~benh/radeonfb-040603-2.4.20.diff
http://penguinppc.org/~benh/radeonfb-040603-2.4.21-pre7.diff

NOTE: It's known that radeonfb is incompatible with ATI binary
GL drivers (at least it crashes the machine on a friend's r300),
I'm investigating.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/

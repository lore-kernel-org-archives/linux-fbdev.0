From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: endian problem ?
Date: Sun, 13 Oct 2002 20:49:21 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021013184921.4571@192.168.4.1>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-3-116.abo.wanadoo.fr ([193.253.250.116] helo=zion.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 180nnx-0000kS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Oct 2002 11:49:34 -0700
Received: from local-mol ([192.168.4.2])
	by zion.wanadoo.fr with esmtp (Exim 3.35 #1 (Debian))
	id 180nsK-0000Jv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Oct 2002 20:54:04 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Ok, I've ported radeonfb, controlfb and platinumfb to the
new API (which is quite nice since allowed me to remove
a whole bunch of cruft from these drivers, good job !)

However, I'm having a problem: With controlfb and
radeonfb (couldn't test platinum yet but it's very similar
to controlfb), the console is fine in 8 bpp, but text is
plain blue in any higher bit depth (15, 16 or 32).

X with "fbdev" driver works fine, so I think setcolreg
works properly. All those drivers are set to DIRECTCOLOR
for these bit depth. Maybe I've missed something about
the pseudo_palette thing (is it documented somewhere ?)
or are there known endian bugs in the cfb_* routines ?

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

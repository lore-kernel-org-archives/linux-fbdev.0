From: nomero <nomero@users.sourceforge.net>
Subject: My Matrox G200 died with 2.5.51
Date: Mon, 16 Dec 2002 10:47:16 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3DFDA124.10707@users.sf.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from relay-3.fastweb.it ([213.140.2.42] helo=mailres.fastwebnet.it)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18NrqP-0005UX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 16 Dec 2002 01:47:25 -0800
Received: from users.sf.net (1.21.244.113) by mailres.fastwebnet.it (6.5.032)
        id 3DEB93B60019D242 for linux-fbdev-devel@lists.sourceforge.net; Mon, 16 Dec 2002 10:47:17 +0100
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi all.
I compiled the new 2.5.51 kernel and enabled the new framebuffer with 
the VESA generic driver.
My system is a Slackware 8.0. My graphic card was a Matrox G200 and the 
resolution of fb console was 1024 X 768, 16M of colors (0x318).
When I rebooted with my new kernel, i noted that fb didn't work well 
(when i switched from a tty to another, some parts of the first tty were 
"pasted" to the second).
When I rebooted, my Matrox G200 died definetly.  I've made something 
wrong or it's an fb's bug?
If it is a bug, I hope to have been helpful.
see you,

    Moreno




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

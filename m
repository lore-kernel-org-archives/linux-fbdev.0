From: joachim.henke@stud.tu-ilmenau.de
Subject: 3DFX framebuffer driver v0.2.2
Date: 16 Dec 2002 18:45 UT
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <E18O0I8-0005IH-00@sc8-sf-list1.sourceforge.net>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-a.d2-net.de ([139.7.30.102])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18O0I8-0005IH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 16 Dec 2002 10:48:36 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

On http://www.medex.hu/~danthe/tdfx/ I found a newer version of the tdfxfb
driver. It was a patch against linux 2.4.4 . I don't know why it never went
into the kernel. Maybe Linus was too busy at that time?

The current kernel still contains version 0.1.3 which is rather old. Much
work has been done until version 0.2.2, mainly support for:

* non-8 dot wide fonts
* multihead
* full 8/16/24/32 bit color (fixes the ugly bootup penguin)
* MIPS
* module options

I think it's worth to give it a chance and to continue development on the
base of that code. So I "ported" it to kernel 2.4.2x. Get this new patch
here:

http://tu-ilmenau.de/~johe-ii/3dfx-0.2.2-2.4.21-pre1.diff.gz

I just merged the improvements that happened to v0.1.3 while it was in the
kernel and did some source formating.

Be encouraged to test it, do further improvements and please take it into
the kernel!

Thank you
	Joachim



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: dual seat ...
Date: Wed, 9 Apr 2003 20:04:09 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030409180409.GA2551@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp2.wanadoo.fr ([193.252.22.26] helo=mwinf0502.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 193Jvl-0001jf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 09 Apr 2003 11:04:18 -0700
Received: from iliana (AStrasbourg-206-1-20-236.abo.wanadoo.fr [81.49.169.236])
	by mwinf0502.wanadoo.fr (SMTP Server) with ESMTP id 3C446E804FAC
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  9 Apr 2003 20:04:10 +0200 (CEST)
Received: from luther by iliana with local (Exim 3.36 #1 (Debian))
	id 193Jvd-0000gQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 09 Apr 2003 20:04:09 +0200
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hello, ...

I am in urgent need of running the X server on gdb, which is really hard
to do when one doesn't have a second computer at hand, as X starts in
gdb all right, but doesn't enable one to switch back to the console to
start the apps that cause the crash.

I have two ideas to solve this, the first one is to use a diskless
notebook i have attached to a null modem and use a serial console, i
would need a root disk containing minicom to do this, or a MS-dos
minicom like app.

The other would be to run Linux as dual-seat, with my pci matrox
millenium as the main head (with the keyboard attached to it) and
running X on the second head, with just the mouse and a dummy keyboard.

Is this already possible with 2.5.x ? Any hint on how to best go about
with this, and is the matroxfb finally ported to the new API, or do i
need to apply a patch or something.

Thanks for your help.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com

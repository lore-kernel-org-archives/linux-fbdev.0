From: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Problem using both framebuffers with matrox G550
Date: Fri, 17 Oct 2003 21:58:54 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031017195854.GA7999@hh.idb.hist.no>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAajq-0001KK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 12:58:18 -0700
Received: from hermine.idb.hist.no ([158.38.50.15])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1AAajU-0000kU-Cp
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Oct 2003 12:57:56 -0700
Received: from helgehaf by hh.idb.hist.no with local (Exim 3.36 #1 (Debian))
	id 1AAakQ-00025H-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 21:58:54 +0200
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

I have a matrox G550, which have two vga connectors.  (One of them is
a digital connector with a converter.)

The 2.6.0-test7 kernel creates two framebuffers as expected,
/dev/fb/0 and /dev/fb/1.

Unfortunately, /dev/fb/0 is shown on both screens, I want
/dev/fb/1 on the other one.  The goal is
to run framebuffer X on the second head until I find
a good pci card for the second monitor, so I can have
two users on one machine.  The X setup *seems* to work,
but is of little use as long as the framebuffer is invisible.

The two displays become identical as soon as the kernel
initialize the framebuffer console (when the penguins appear)
and it stays like that.  Do I need some kernel parameter or
other trick to make this work?

Helge Hafting 


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com

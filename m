From: Jon Smirl <jonsmirl@yahoo.com>
Subject: insmod and aty128fb
Date: Mon, 19 May 2003 10:41:24 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030519174124.98259.qmail@web14912.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14912.mail.yahoo.com ([216.136.225.248])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19HodY-0005lH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 May 2003 10:41:24 -0700
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
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

I can't get aty128fb to initialize if I insmod it. It
works fine on the same machine if I compile it in. I
added a printk to the probe function and probe is not
getting called. Is is behaving like the PCI ID for my
card is not supported, but it is - PD 1002:5044
(Rage128 AIW PCI). insmod fails if the card is either
primary or secondary.

I can modprobe radeonfb on the same system (2.5.69)
without trouble.

As card as I can tell no aty128fb code is getting
called. This seems to be something to do with the
kernel not thinking there is a Rage card in the system
and thus not initializing the driver. 

Any ideas?

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge

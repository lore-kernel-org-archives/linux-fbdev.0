From: Jon Smirl <jonsmirl@yahoo.com>
Subject: fbmem.c - fb_mmap
Date: Tue, 17 Dec 2002 19:01:13 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021218030113.4999.qmail@web14901.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14901.mail.yahoo.com ([216.136.225.53])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18OUSW-0000XM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 17 Dec 2002 19:01:20 -0800
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

fb_mmap contains an ifdef for every architecture on
Linux.  Is it possible to implement this using
something like ioremap_nocache() and avoid the ifdefs?

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

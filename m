From: Otto Solares <solca@guug.org>
Subject: fbdev proposed change
Date: Thu, 27 Nov 2003 12:16:07 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031127181607.GA10773@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APQgS-0001ef-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Nov 2003 10:16:08 -0800
Received: from guug.galileo.edu ([168.234.203.30])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1APQgS-0006uL-HH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Nov 2003 10:16:08 -0800
Received: from solca by guug.galileo.edu with local (Exim 3.36 #1 (Debian))
	id 1APQgR-0002pB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Nov 2003 12:16:07 -0600
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

Hi!

Is there any way to know the bus topology of a framebuffer
device?, i want to get this info from fbdev so i can integrate
this info from the info libhal provides me, explicitly
having something like fb_fix_screeninfo.bus_id will be a
good idea IMO.

bus_id should be something like this for pci:

fb_fix_screeninfo.bus_id = "PCI:1.5.0"

or for sbus:

fb_fix_screeninfo.bus_id = "SBUS:cgsix"

Is just a few bytes and all drivers already know their bus
topology, this info is extremelly useful for detecting the
exact device a fbdev is attached.

-solca



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

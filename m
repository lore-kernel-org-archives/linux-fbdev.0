From: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Subject: Driver replacement
Date: Mon, 25 Aug 2003 20:56:13 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200308252056.13587.gkajmowi@tbaytel.net>
Reply-To: gkajmowi@tbaytel.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19rTSD-0004mC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Aug 2003 19:21:05 -0700
Received: from air.nwconx.net ([216.211.26.26] helo=air.on.ca)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19rTS3-0007fs-J9
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Aug 2003 19:20:56 -0700
Received: from [216.211.45.96] (HELO 192.168.0.199)
  by air.on.ca (CommuniGate Pro SMTP 3.4.7)
  with ESMTP id 39963856 for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Aug 2003 20:57:11 -0400
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
To: linux-fbdev-devel@lists.sourceforge.net

I am working on a thin-client system, and ahve the following problem:

I would like to boot up using VESA, but replace the driver if other hardware 
is supported (ie Riva TNT).  Unfortunately, from the few tests that I have 
done, all that happens is a second fb device is created which displays to a 
non-existant video card.  Those were the results from con2fb, anyways.

I would consider not using VESA if there was another option (like VGA256).

Any suggesions?

Garrett Kajmowicz
gkajmowi@tbaytel.net



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0

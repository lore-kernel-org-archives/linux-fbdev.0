From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Merge of Luca and Ben's sysfs work for Radeon
Date: Thu, 25 Sep 2003 13:35:35 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030925203535.54019.qmail@web14909.mail.yahoo.com>
References: <20030925192116.GA9615@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2cpt-00009Z-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 13:35:38 -0700
Received: from web14909.mail.yahoo.com ([216.136.225.61])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A2cps-0008CJ-UP
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Sep 2003 13:35:36 -0700
In-Reply-To: <20030925192116.GA9615@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

R128 is more a problem. No one has written the code to get EDID info from the
R128.
There is a 2.4 R128 FB driver here: http://www.saftware.de/ that has I2C
support.

A good project would be to take code from that driver plus look at benh's new
radeon driver and try to make a new 2.6 R128 driver that can read EDID. Once
the driver can get to the EDID block it is easy to export it from sysfs.
Radeons are very similar to R128's so benh's EDID code may just work on a R128.

I have a merge between benh and kronos' Radeon work. I'm working on finding a
place to keep it.


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

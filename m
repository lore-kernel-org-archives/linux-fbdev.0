From: Jon Smirl <jonsmirl@yahoo.com>
Subject: VGA routing
Date: Sat, 6 Dec 2003 23:34:48 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031207073448.83488.qmail@web14911.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AStRI-0001eu-LH
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Dec 2003 23:34:48 -0800
Received: from web14911.mail.yahoo.com ([216.136.225.249])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AStRI-0004NS-Bx
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Dec 2003 23:34:48 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

My machine has three busses.
1) on chip
2) AGP
3) PCI

My primary display is on a PCI card.
When I boot the VGA ports are routed through the PCI bridge.
I'm running X on the PCI card.

Now I load a device driver that enables the AGP card. After doing this the VGA
ports are routed to the AGP bus. Where does this happen?

Now if I do a VT switch the VGA ports get routed back to the PCI bridge. Where
does this happen?

Thanks for the help. I'm trying to figure out the right way to initialize a
secondary card by jumping to C000:0003 in it's BIOS. Does Xfree jump to
C000:0003? I can't find where it does that in the source.



=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

From: niteowl@altern.org
Subject: Multiple simultaneous FB output.
Date: Mon, 23 Aug 2004 23:28:33 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408232328.33371.niteowl@altern.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BzMMt-0002Be-Kx
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Aug 2004 14:28:43 -0700
Received: from vsmtp2alice.tin.it ([212.216.176.142] helo=vsmtp2.tin.it)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BzMMq-0001hE-SN
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Aug 2004 14:28:43 -0700
Received: from storm.ade (62.211.233.78) by vsmtp2.tin.it (7.0.027)
        id 411B8CBC00128741 for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Aug 2004 23:28:35 +0200
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi all!
Is it possible to use multiple graphic cards (i.e. a AGP G200 and a pair of 
PCI Milennium II) and to visualize multiple fremebuffers *simultaneously*?

All I want to do is to use a text console or X on the G200 (/dev/fb0) and to 
visualize some application's output on /dev/fb1 and /dev/fb2 without having 
to switch console and, above all, avoiding the system to blank consoles 
without focus.

Thanks.

--Niteowl


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285

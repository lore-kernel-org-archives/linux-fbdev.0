From: Dave Jones <davej@redhat.com>
Subject: vga16fb mode change.
Date: Fri, 23 Jan 2004 15:33:54 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040123153354.GB19002@redhat.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Al3Wg-0003xU-Qy
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Jan 2004 01:59:26 -0800
Received: from delerium.codemonkey.org.uk ([81.187.208.145])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Ak3L4-00049D-Ex
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Jan 2004 07:35:18 -0800
Received: from delerium.codemonkey.org.uk (localhost.localdomain [127.0.0.1])
	by delerium.codemonkey.org.uk (8.12.10/8.12.10) with ESMTP id i0NFXs5h026748
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 23 Jan 2004 15:33:54 GMT
Received: (from davej@localhost)
	by delerium.codemonkey.org.uk (8.12.10/8.12.10/Submit) id i0NFXstH026746
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Jan 2004 15:33:54 GMT
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Guys,
 How come the 2.6 vga16fb driver doesn't change the display
to the framebuffer when it's modprobe'd any more like the 2.4
used to ?

Is this an intentional change, or a regression?

		Dave


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

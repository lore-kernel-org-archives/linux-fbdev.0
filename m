From: James Simmons <jsimmons@infradead.org>
Subject: Re: About framebuffer driver
Date: Mon, 2 Feb 2004 18:00:05 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402021759470.27538-100000@phoenix.infradead.org>
References: <20040201013833.23666.qmail@vip.sina.com.cn>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AniMk-0000Ju-VT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 02 Feb 2004 10:00:10 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AniMk-0008HU-J6
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 02 Feb 2004 10:00:10 -0800
In-Reply-To: <20040201013833.23666.qmail@vip.sina.com.cn>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rosemaryai@vip.sina.com
Cc: linux-fbdev-devel@lists.sourceforge.net


> The kernel I am using is 2.4. When I copy test.bin to /dev/fbdir/0, which function does the Linux call?

fb_write.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: About framebuffer driver
Date: 05 Feb 2004 07:52:42 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1075938767.1700.41.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0402021759470.27538-100000@phoenix.infradead.org> 
	<002801c3e9f2$c63fe720$3d01a8c0@tcentel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoWrG-0006e6-CW
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 15:55:02 -0800
Received: from rizzo.jerky.net ([38.113.2.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoWrF-0007zx-Rv
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 15:55:01 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by rizzo.jerky.net (Postfix) with SMTP id 710BB32037
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  4 Feb 2004 23:52:47 +0000 (UTC)
In-Reply-To: <002801c3e9f2$c63fe720$3d01a8c0@tcentel.com>
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
To: Ai Chengshi <rosemaryai@vip.sina.com>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-02-03 at 09:12, Ai Chengshi wrote:
> If I want to transfer data in frame buffer to LCD GRAM, where should I add this function to?
> 

fb_write() is called by the virtual filesystem itself. You do not call
this directly.

To transfer contents to/from framebuffer, you might need to make code
that will periodically do a memcopy (or similar) that is triggered
perhaps by a timer or during vsync/vblank.

Tony





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

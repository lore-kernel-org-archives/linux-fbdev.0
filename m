From: James Simmons <jsimmons@infradead.org>
Subject: Re: When copy, which function the operation
 system calls
Date: Tue, 20 Jan 2004 00:23:00 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401200021510.2709-100000@phoenix.infradead.org>
References: <00d301c3dcd4$67afae50$3d01a8c0@tcentel.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aijfe-0006vo-Uk
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Jan 2004 16:23:06 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Aijfe-0003xl-FV
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Jan 2004 16:23:06 -0800
In-Reply-To: <00d301c3dcd4$67afae50$3d01a8c0@tcentel.com>
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
To: Ai Chengshi <rosemaryai@vip.sina.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


> Hi,
> 
> When I typed cp test.bin /dev/fbdir/0, which function does the Linux call? 

fb_write in fbmem.c.

> And if I want to write the content in the buffer to LCD controller GRAM, 
> where should I add this function?

Which kernel, v2.4 or v2.6? The api is different in each case.





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

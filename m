From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Newest fbdev patch to go mainline.
Date: Tue, 10 Feb 2004 19:04:13 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040210190413.A8470@infradead.org>
References: <20040210173551.GC27779@kroah.com> <Pine.LNX.4.44.0402101747450.6600-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqdBR-0001dY-LL
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 11:04:33 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AqdBL-0003jE-1H
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 11:04:27 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402101747450.6600-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Tue, Feb 10, 2004 at 05:49:52PM +0000
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
To: James Simmons <jsimmons@infradead.org>
Cc: Greg KH <greg@kroah.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 10, 2004 at 05:49:52PM +0000, James Simmons wrote:
> Thats coming :-) The problem only showes itself with modular drivers 
> correct. So I will submit patches for those first. I just wanted to polish 
> off a few really tiny patches fist.

You just copletly b0rked up lifetime rules.  Please revert the sysfs patch
and add it back when all drivers are fixed.  



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

From: Greg KH <greg@kroah.com>
Subject: Re: Newest fbdev patch to go mainline.
Date: Tue, 10 Feb 2004 09:57:39 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040210175739.GF28111@kroah.com>
References: <Pine.LNX.4.44.0402101747450.6600-100000@phoenix.infradead.org> <Pine.LNX.4.44.0402101750150.6600-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aqc9B-0002bq-0I
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 09:58:09 -0800
Received: from mail.kroah.org ([65.200.24.183] helo=perch.kroah.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aqc96-0000uD-Bj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 09:58:04 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402101750150.6600-100000@phoenix.infradead.org>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 10, 2004 at 05:51:26PM +0000, James Simmons wrote:
> 
> One more thing. What should I use for devices like vesafb? Should I use 
> the platform_bus_type like sa1100fb.c?

That sounds reasonable, if there is no other place the vesafb device
lives off of in the driver model.

thanks,

greg k-h


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

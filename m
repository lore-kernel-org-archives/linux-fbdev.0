From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] class device cleanup for fbdev
Date: Mon, 12 Feb 2007 11:46:39 -0800
Message-ID: <20070212194639.GA789@kroah.com>
References: <Pine.LNX.4.64.0702071950110.9071@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HGh95-0007ek-Mo for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Feb 2007 11:47:27 -0800
Received: from mail.kroah.org ([69.55.234.183] helo=perch.kroah.org)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HGh94-0002Ps-56
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Feb 2007 11:47:27 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702071950110.9071@pentafluge.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Feb 07, 2007 at 07:53:09PM +0000, James Simmons wrote:
> 
> Let me know if this is the right approach. This patch uses the class field 
> in struct device.

Yes, it looks like the correct thing to do.

thanks,

greg k-h

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

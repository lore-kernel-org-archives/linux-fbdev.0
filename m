From: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: fbdev sysfs support.
Date: Sat, 7 Feb 2004 01:29:04 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040207012904.GU21151@parcelfarce.linux.theplanet.co.uk>
References: <20040207011916.GD4492@kroah.com> <Pine.LNX.4.44.0402070122270.19559-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ApHHO-0007pK-H0
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 Feb 2004 17:29:06 -0800
Received: from parcelfarce.linux.theplanet.co.uk
	([195.92.249.252] helo=www.linux.org.uk ident=93)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1ApHHN-0003t1-Ss
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 Feb 2004 17:29:06 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402070122270.19559-100000@phoenix.infradead.org>
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
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Feb 07, 2004 at 01:23:29AM +0000, James Simmons wrote:
> 
> > This function will not get called until the sysfs node stops being busy,
> > so it should all work properly.  But only if that fb_info structure was
> > allocated dynamically, unlike all of the current fb drivers (see my
> > other comment about this patch.)
> > 
> > So in that case, this will cause us to try to call kfree on a static
> > structure :(
> 
> I plan to move every driver to framebuffer_alloc. 

Erm...  You know, it would be much better to do that _before_ sysfs-related
merge.  With framebuffer_release() being originally defined as kfree(),
so that no breakage would happen during the transition.  Once everything is
using dynamic allocation with framebuffer_alloc()/framebuffer_free(), add
sysfs bits.  That way you get the same total size of patches in the series
and avoid the breakage on intermediate stages...


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

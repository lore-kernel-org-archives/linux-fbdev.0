From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Sysfs for framebuffer
Date: Sat, 20 Mar 2004 13:30:30 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040320213030.GA3950@kroah.com>
References: <20040320174956.GA3177@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4o3d-0002iL-Pj
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Mar 2004 13:31:05 -0800
Received: from mail.kroah.org ([65.200.24.183] helo=perch.kroah.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B4o3b-0005B5-1o
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Mar 2004 13:31:03 -0800
Content-Disposition: inline
In-Reply-To: <20040320174956.GA3177@dreamland.darkstar.lan>
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
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

On Sat, Mar 20, 2004 at 06:49:56PM +0100, Kronos wrote:
> Hi,
> the following patch (against 2.6.5-rc2) teaches fb to use class_simple.
> With this patch udev will automagically create device nodes for each
> framebuffer registered. Once all drivers are converted to
> framebuffer_{alloc,release} we can switch to our own class.

yeah, it's about time!  Didn't I post this patch a few months ago... :)

Anyway, it looks good, I only have one comment:

> notebook:~# tree /sys/class/graphics/
> /sys/class/graphics/

"graphics"?  Why that?  Why not "fb"?

It doesn't really matter to me, just curious.

thanks,

greg k-h


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

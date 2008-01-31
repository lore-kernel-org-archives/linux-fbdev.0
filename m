From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: modesetting and fbdev
Date: Wed, 30 Jan 2008 20:55:21 -0800
Message-ID: <200801302055.21825.jbarnes@virtuousgeek.org>
References: <eb77d7060801301155gbbd2d3eie9f12108425cb0b1@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKRSi-0008E9-0Y for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jan 2008 20:55:44 -0800
Received: from outbound-mail-114.bluehost.com ([69.89.24.4])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JKRSg-0004CG-Ld
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jan 2008 20:55:43 -0800
In-Reply-To: <eb77d7060801301155gbbd2d3eie9f12108425cb0b1@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jorge Luis Zapata Muga <jorgeluis.zapata@gmail.com>

On Wednesday 30 January 2008 11:55:19 am Jorge Luis Zapata Muga wrote:
> Hi all, I've seen some patches and discussions about modesetting into
> the kernel and fb devices, what is the relation or plans with that
> beside the pros and cons? keep the fb api? some kind of merge between
> both?

The DRM modesetting code preserves compatibility with the fb interfaces, so if 
you write a DRM based modesetting driver, fb applications can run on top 
unmodified.  Also, the existing fb stuff won't go away (though some 
maintainers may choose to replace their fb drivers with DRM modesetting based 
ones).  Which type of driver to write just depends on what your hw is capable 
of and whether you feel the slightly higher complexity of a DRM based driver 
is justified (it probably will be if you ever plan on adding 3d support to 
your stack or if you want to exploit the fancy output control that the DRM 
based API provides).

Hope that helps.

Jesse

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

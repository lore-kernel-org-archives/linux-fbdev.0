From: Fredrik Noring <noring@nocrew.org>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
	2.5.5[45]
Date: 19 Jan 2003 12:29:41 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042975785.1296.31.camel@h9n1fls20o980.telia.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailf.telia.com ([194.22.194.25])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18aDdA-0004yp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 19 Jan 2003 03:28:48 -0800
Received: from h9n1fls20o980.telia.com (h9n1fls20o980.telia.com [213.65.208.9])
	by mailf.telia.com (8.12.5/8.12.5) with ESMTP id h0JBSERq009367
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 19 Jan 2003 12:28:14 +0100 (CET)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

> To summarise:
>  insmod rivafb causes "Badness in kobject_register" every time 
>    ( after pci_register_driver() in rivafb_init(),see below )
>  after insmod rivafb, I have a green screen, which can be cleared by fbset
>   ( fbset now changes resolution of all VTs, this is different from 2.4.x )
>  after clearing green screen using fbset, text colours are wrong

I get similar results, but I have to run and stop XFree86 4.2 before 
"insmod rivafb". Otherwise the screen will not be cleared by fbset.

>  now ( 2.5.59 ), I can insmod fbcon, and screen looks OK again ( apart from
>   the left-hand-most column of screen appears at right-hand side of screen )

With 2.5.59 with and without the patch Antonino Daplas sent to the
kernel list (17 Jan), loading fbcon only displays garbage on the screen.
The graphics card is TNT AGP.

The rivafb module works pretty well in Linux 2.4.21-pre2, except that
certain modes involving sync polarity and interlace don't work (these
modes work fine with XFree86 4.2). I was hoping that these would work
with rivafb in 2.5.59. Any thoughts?

	Fredrik




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en

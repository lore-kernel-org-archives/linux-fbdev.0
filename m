From: Andrew Walrond <andrew@walrond.org>
Subject: Re: x86_64 64bit kernel rivafb broke between 2.6.8.1 and linus bk as of today
Date: Wed, 17 Nov 2004 00:33:38 +0000
Message-ID: <200411170033.38614.andrew@walrond.org>
References: <200411162244.37709.andrew@walrond.org> <200411170815.45567.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUDlV-0003Vx-T6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Nov 2004 16:33:41 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CUDlU-00039J-Sx
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Nov 2004 16:33:41 -0800
In-Reply-To: <200411170815.45567.adaplas@hotpop.com>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wednesday 17 Nov 2004 00:15, Antonino A. Daplas wrote:
>
> There was a bunch of IO access fixes in rivafb.  Can you narrow it down to
> a particular function?  Replace the following...
>
>  .fb_fillrect  = rivafb_fillrect,
>  .fb_copyarea  = rivafb_copyarea,
>  .fb_imageblit  = rivafb_imageblit,
>  .fb_cursor = rivafb_cursor,
>
> ..with:
>
>  .fb_fillrect  = cfb_fillrect,
>  .fb_copyarea  = cfb_copyarea,
>  .fb_imageblit  = cfb_imageblit,
>  .fb_cursor = soft_cursor,
>
> And make sure that 'info->pixmap.scan_align = 4' if using rivafb_imageblit
> and 'info->pixmap.scan_align = 1' if using cfb_imageblit. (The scan
> alignment is adjusted in rivafb_set_par() and riva_set_fbinfo()).
>
> Using the soft drawing functions (cfb_*), in theory, should always produce
> a working console. Then just bring back the rivafb_* functions one by one.
>

Ok, it works using all the soft functions. I'll swap them out now...


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: x86_64 64bit kernel rivafb broke between 2.6.8.1 and linus bk as of today
Date: Wed, 17 Nov 2004 08:15:42 +0800
Message-ID: <200411170815.45567.adaplas@hotpop.com>
References: <200411162244.37709.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUDUk-0002Ke-98
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Nov 2004 16:16:22 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CUDUi-0004c5-2w
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Nov 2004 16:16:22 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id EDF059FA5FC
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 17 Nov 2004 00:16:08 +0000 (UTC)
In-Reply-To: <200411162244.37709.andrew@walrond.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Walrond <andrew@walrond.org>

On Wednesday 17 November 2004 06:44, Andrew Walrond wrote:
> Hi guys,
>
> I just upgraded my kernel to linus latest bk head, booting with a built in
> rivafb as usual, but I get a corrupted display.
>
> 2.6.8.1 worked just fine.
>
> The two pengiun logos seem fine (but ontop of garbage), but the text is
> totally screwed and spread all over the screen in little chunks
>
> Before I start hunting down the problem, has anybody got any ideas/fixes?
>
> This is a 64bit kernel on a dual opteron system.

There was a bunch of IO access fixes in rivafb.  Can you narrow it down to a particular
function?  Replace the following...

	.fb_fillrect 	= rivafb_fillrect,
	.fb_copyarea 	= rivafb_copyarea,
	.fb_imageblit 	= rivafb_imageblit,
	.fb_cursor	= rivafb_cursor,	

..with:

	.fb_fillrect 	= cfb_fillrect,
	.fb_copyarea 	= cfb_copyarea,
	.fb_imageblit 	= cfb_imageblit,
	.fb_cursor	= soft_cursor,

And make sure that 'info->pixmap.scan_align = 4' if using rivafb_imageblit
and 'info->pixmap.scan_align = 1' if using cfb_imageblit. (The scan
alignment is adjusted in rivafb_set_par() and riva_set_fbinfo()).

Using the soft drawing functions (cfb_*), in theory, should always produce a
working console. Then just bring back the rivafb_* functions one by one.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

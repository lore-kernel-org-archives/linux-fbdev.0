From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: Virtual framebuffer driver - mmap problem
Date: Thu, 9 Sep 2004 18:16:51 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409091816.51541.adaplas@hotpop.com>
References: <77e82a3f0409080651732d891e@mail.gmail.com> <200409090831.21966.adaplas@hotpop.com> <Pine.GSO.4.58.0409091029190.10508@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5Ly7-0001Wu-NW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 03:15:55 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C5Ly5-0002C1-UT
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 03:15:55 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 0B5C38048B7
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  9 Sep 2004 10:15:33 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0409091029190.10508@waterleaf.sonytel.be>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Shivappa Kushtagi <kushtagi@gmail.com>

On Thursday 09 September 2004 16:31, Geert Uytterhoeven wrote:
> >
> > So if PAGE_SIZE is 4096, to allocate 8192 bytes, use order = 1. Note that
> > there is an upper limit to order, so keep videomemorysize small.
>
> And the upper limit is 128 kiB on most platforms. Hence even 640x480 in 8
> bpp won't fit...
>
> Probably you can make a fb_mmap() hook that's compatible with the
> vmalloc()'ed frame buffer and thus doesn't suffer from this limitation, but
> it will require more code and more knowledge of memory management
> internals.
>

Actually, I discovered that MAX_ORDER in 2.4 is 10 (4MiB) and 11 in 2.6 
(8MiB), so it's probably not as limiting as it seems. However, the 
probability of __get_free_pages() failing at such a high order is very high.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click

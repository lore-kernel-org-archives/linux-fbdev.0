From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [patch] (Preliminary) Geode framebuffer driver.
Date: Sat, 12 Feb 2005 04:39:10 +0800
Message-ID: <200502120438.27671.adaplas@gawab.com>
References: <420C92F0.1090409@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzhZY-0000YG-4f
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Feb 2005 12:39:28 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CzhZX-0006pF-Hj
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Feb 2005 12:39:28 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 0D9C6E1A5E7
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 11 Feb 2005 20:39:15 +0000 (UTC)
In-Reply-To: <420C92F0.1090409@arcom.com>
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
To: linux-fbdev-devel@lists.sourceforge.net, David Vrabel <dvrabel@arcom.com>

On Friday 11 February 2005 19:11, David Vrabel wrote:
> Hi,
>
> Attached is a patch (against 2.6.10) for a framebuffer driver for the
> Geode family of processors.  It does not use AMD's horrible Durango API.
>  It is, however, rather feature incomplete at the moment.
>
> 	* Only Geode GX1 (with CS5530 companion chip) is supported.
> 	* Tested resolutions: 640x480 to 1280x1024.
> 	* Supported bit depths: 8 bit palette, 16 bit RGB 5-6-5.
> 	* CRT output only.
> 	* No accelerated features.
> 	* Compression is not enabled.
>
> (Flat panel support and compression will likely be added next week, and
> acceleration after that.)
>
> Could this patch be considered for inclusion, please?

Yes.

However, I would prefer that instead of:

struct geodefb_info {
    	struct fb_info fb;
	...

use struct fb_info.par for all driver private data and use
framebuffer_release()/framebuffer_alloc() to de/allocate the fb_info
structure.

You can also make the check_var() function less strict.  You can
attempt to round up values instead of returning -EINVAL.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [PATCH] Allow core fb to be built as a module
Date: Wed, 2 Mar 2005 17:32:28 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0503021730340.20488@pentafluge.infradead.org>
References: <9e4733910502241239268ca595@mail.gmail.com> 
 <Pine.LNX.4.56.0502282010070.16877@pentafluge.infradead.org> 
 <200503012031.50512.adaplas@hotpop.com> <9e473391050302092834dc6e36@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6Xi5-0007MU-Aa
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 09:32:33 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D6Xi3-0006pS-Ko
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 09:32:33 -0800
In-Reply-To: <9e473391050302092834dc6e36@mail.gmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@pentafluge.infradead.org>


> > It does have a few problems.  Drivers that are bool, instead of tristate
> > such as vesafb, can still be selected even if fbcore is selected as module.
> 
> Then it is needs (FB = y) like this...
> If you leave them as checks they will be built and linked into the FB module.

Send another patch with the below and we will include it.
 
> [jonsmirl@jonsmirl video]$ bk diffs -u
> ===== Kconfig 1.76 vs edited =====
> --- 1.76/drivers/video/Kconfig  2005-02-17 19:09:04 -05:00
> +++ edited/Kconfig      2005-03-02 12:25:28 -05:00
> @@ -269,11 +269,11 @@
> 
>  config FB_ASILIANT
>         bool "Chips 69000 display support"
> -       depends on FB && PCI
> +       depends on (FB = y) && PCI
> 
>  config FB_IMSTT
>         bool "IMS Twin Turbo display support"
> -       depends on FB && PCI
> +       depends on (FB = y) && PCI
>         help
>           The IMS Twin Turbo is a PCI-based frame buffer card bundled with
>           many Macintosh and compatible computers.
> @@ -330,7 +330,7 @@
> 
>  config FB_VESA
>         bool "VESA VGA graphics support"
> -       depends on FB && (X86 || X86_64)
> +       depends on (FB = y) && (X86 || X86_64)
>         help
>           This is the frame buffer device driver for generic VESA 2.0
>           compliant graphic cards. The older VESA 1.2 cards are not supported.
> [jonsmirl@jonsmirl video]$
> 
> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

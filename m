From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [patch] framebuffer Kconfig -- add option
 for building cfb*.o (0/2)
Date: Mon, 14 Feb 2005 17:25:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502141724240.6781@pentafluge.infradead.org>
References: <421096C6.3030105@arcom.com> <Pine.GSO.4.61.0502141322060.16209@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0jyy-0005Ir-FW
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 09:26:00 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D0jyu-00086W-0U
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 09:26:00 -0800
In-Reply-To: <Pine.GSO.4.61.0502141322060.16209@waterleaf.sonytel.be>
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
To: linux-fbdev-devel list <linux-fbdev-devel@lists.sourceforge.net>
Cc: David Vrabel <dvrabel@arcom.com>


> > This set of two patches add a new option (FB_SOFTWARE_CFB_OPS) to the
> > framebuffer Kconfig to enable building the generic software cfbfillrect,
> > cfbcopyarea and cfbimageblt objects.  This cuts out a lot of stuff from
> > the Makefile and allows drivers in their own directory to be more
> > self-contained.
> > 
> > 1/2 -- add the FB_SOFTWARE_CFB_OPS option to Kconfig and Makefile
> > 2/2 -- make all drivers (where appropriate) select FB_SOFTWARE_CFB_OPS
> > 
> > Please consider applying, thanks.
> 
> Thanks, good idea!
> 
> But I'd prefer to have 3 separate options, since some drivers don't need all 3
> of them, e.g.:
>   - CONFIG_CFB_FILLRECT
>   - CONFIG_CFB_COPYAREA
>   - CONFIG_CFB_IMAGEBLT

We should have CONFIG_SOFT_CURSOR for the sotftware cursor, softcursor.c, as 
well. David could you add that as well? 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

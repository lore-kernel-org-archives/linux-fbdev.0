From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: PATCH Proposal make FB_ACCEL_ private to
 the driver
Date: Sun, 27 Feb 2005 19:28:47 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0502271926560.3143@numbat.sonytel.be>
References: <20050227032611.GB14968@systol.god.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D5TA1-0005Am-Pa
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 27 Feb 2005 10:28:57 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D5T9z-0007i5-3M
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 27 Feb 2005 10:28:57 -0800
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j1RISpGU011012
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 27 Feb 2005 19:28:52 +0100 (MET)
In-Reply-To: <20050227032611.GB14968@systol.god.lan>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 27 Feb 2005, Henk Vergonet wrote:
> This post was originally posted to the kernel-janitors list. After which
> I learned there was an active development-list for linux-framebuffer stuff. 

I'm afraid you will never see this reply, as rememberme@systol.god.lan won't
resolve....

> I want to propose to localize the maintenance and registration of the
> FB_ACCEL_ id's and remove it from the public fb.h include file.
> 
> Motivation:
> - This removes an unneeded dependency to fb.h if an additional cards/chips are
>   introduced. (These id's are only interesting for the driver anyhow. 
>   Only fbset will print out the id, but I'll doubt this is used by anyone.)

Yes, it's used by userspace apps that need to know the graphics card type (e.g.
DirectFB and the good old XF68_FBDev).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

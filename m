From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 1/10] fbdev: Add mode changing via sysfs
Date: Mon, 7 Mar 2005 13:14:52 -0500
Message-ID: <9e473391050307101466feadb7@mail.gmail.com>
References: <200503060816.28615.adaplas@hotpop.com>
	 <Pine.LNX.4.56.0503071809260.21233@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Mkp-0007sq-9M
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 10:14:55 -0800
Received: from rproxy.gmail.com ([64.233.170.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8Mko-0006G6-R4
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 10:14:55 -0800
Received: by rproxy.gmail.com with SMTP id z35so2014522rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Mar 2005 10:14:54 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0503071809260.21233@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@www.infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>

On Mon, 7 Mar 2005 18:10:44 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> 
> > diff -Nru a/include/linux/fb.h b/include/linux/fb.h
> > --- a/include/linux/fb.h      2005-03-05 00:18:26 +08:00
> > +++ b/include/linux/fb.h      2005-02-18 15:17:45 +08:00
> > @@ -715,8 +715,10 @@
> >       struct fb_pixmap sprite;        /* Cursor hardware mapper */
> >       struct fb_cmap cmap;            /* Current cmap */
> >       struct list_head modelist;      /* mode list */
> > +     struct fb_videomode *mode;      /* current mode */
> >       struct fb_ops *fbops;
> >       struct device *device;
> > +     struct class_device *class_device; /* sysfs per device attrs */
> >  #ifdef CONFIG_FB_TILEBLITTING
> 
> Why do we need a mode pointer when we have a function that translates the
> mode to a var?
> 

So that the sysfs attribute can display the name of the current mode. 


-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

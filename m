From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Patch to add mode setting to sysfs
Date: Fri, 18 Feb 2005 08:04:46 +0800
Message-ID: <200502180804.46005.adaplas@hotpop.com>
References: <9e4733910502161430ff1dad1@mail.gmail.com> <200502172150.16256.adaplas@hotpop.com> <9e47339105021712494955212d@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1vdl-00008Y-B7
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 16:05:01 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D1vdj-00062k-Nv
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 16:05:01 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 1A2BE14024D5
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Feb 2005 00:04:54 +0000 (UTC)
In-Reply-To: <9e47339105021712494955212d@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>, adaplas@pol.net, James Simmons <jsimmons@www.infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Friday 18 February 2005 04:49, Jon Smirl wrote:
> On Thu, 17 Feb 2005 21:50:16 +0800, Antonino A. Daplas
>
> <adaplas@hotpop.com> wrote:
> > Instead of hardcoding some of the fields in var, why not
> > copy it from the current var?  Ie:
> >
> > var = info->var;
> > fb_videomode_to_var(&var, mode);
>
> I added this change, plus more robust error handing. Add attributes
> for virtual resolution and bpp.
>
> I also fixed fb so that it works as module.

If possible, separate the sysfs patch from making fbcore as module.

+static ssize_t store_modes(struct class_device *class_device, const
char * buf, size_t count)
+{
+       struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+       int i = count / sizeof(struct fb_videomode);
+       if (i * sizeof(struct fb_videomode) != count)
+               return -EINVAL;
+
+       fb_destroy_modelist(&fb_info->modelist);

This is dangerous.  For one, if the mode in info->var does not match any of
the entries in the modelist, you can get a screwed up display.  Secondly,
fbcon refers to info->modelist to store settings for each console.  Thus
it is better to check first if the mode in the modelist is currently in use.

A safer way is to loop through each entries of the old modelist, call 
fb_set_var() with the FB_ACTIVATE_INV_MODE set in var->activate. This
process will safely remove each mode from the modelist.  Not all entries
will be deleted of course. After that, loop through each entries of the new
modedb array, and use fb_add_videomode() to add each entry to the modelist.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

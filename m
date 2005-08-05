From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: framebuffer-driver-for-mq11xx-graphics-chip.patch
 added to -mm tree
Date: Fri, 5 Aug 2005 21:08:07 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508052106420.19722@pentafluge.infradead.org>
References: <200508050719.j757JZ5J032664@shell0.pdx.osdl.net>
 <20050805140834.GC3852@mipter.zuzino.mipt.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E18UI-00080c-Dy
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Aug 2005 13:08:14 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E18UI-0003Cq-3W
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Aug 2005 13:08:14 -0700
In-Reply-To: <20050805140834.GC3852@mipter.zuzino.mipt.ru>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jamey@handhelds.org, anpaza@mail.ru, akpm@osdl.org


> > +static int mq1100fb_probe (struct device *dev, struct mediaq11xx_base *base)
> > +{
> 
> > +	info = kmalloc (sizeof (struct mq1100fb_info), GFP_KERNEL);
> > +	memset (info, 0, sizeof (struct mq1100fb_info));
> 
> Unchecked kmalloc().

Please use the framebuffer_alloc and framebuffer_release api in fbsysfs.c. 
Otherwise your driver wil not show up in the sysfs filesystem.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

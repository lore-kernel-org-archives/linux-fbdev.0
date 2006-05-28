From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/5] au1100fb: Add power management support
Date: Sat, 27 May 2006 23:21:17 -0700
Message-ID: <20060527232117.715e6a60.akpm@osdl.org>
References: <4478F1FD.2080702@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FkEaM-0004Pt-LU
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 23:17:10 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1FkEaL-0002W7-CB
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 23:17:10 -0700
In-Reply-To: <4478F1FD.2080702@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, ralf@linux-mips.org

On Sun, 28 May 2006 08:42:37 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> From: Rodolfo Giometti <giometti@linux.it>
> 
> Add power management support.
> 
>  int au1100fb_drv_suspend(struct device *dev, pm_message_t state)
>  {
> -	/* TODO */
> +	struct au1100fb_device *fbdev = (struct au1100fb_device*) dev_get_drvdata(dev);
>  
>  int au1100fb_drv_resume(struct device *dev)
>  {
> -	/* TODO */
> +	struct au1100fb_device *fbdev = (struct au1100fb_device*) dev_get_drvdata(dev);

These typecasts of void* are unneeded.  They are in fact undesirable - if
someone were to change the type of dev_get_drvdata() to return some
non-pointer type then this code would still silently swallow it without
warning us of the bug.

Plus typecasts are ugly.


This patch doesn't apply, probably due to the earlier mangled one whihc I dropped.
Please redo and resend this one as well.



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642

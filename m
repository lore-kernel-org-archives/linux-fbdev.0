From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [patch] fix oops with no /proc
Date: Wed, 25 Nov 2009 18:46:41 +0100
Message-ID: <4B0D6D81.8010702@gmx.de>
References: <20091122142111.GA28155@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <FlorianSchandinat@gmx.de>) id 1NDLxA-0005Dl-3B
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Nov 2009 17:46:56 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by sfi-mx-1.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NDLx9-0003iK-3G for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Nov 2009 17:46:55 +0000
In-Reply-To: <20091122142111.GA28155@bicker>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <error27@gmail.com>
Cc: JosephChan@via.com.tw, Andrew Morton <akpm@linux-foundation.org>, ScottFang@viatech.com.cn, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Hi,

nice catch. Your patch is obviously correct.
Please send it to Andrew Morton <akpm@linux-foundation.org> to get it 
into mainline.

Dan Carpenter schrieb:
> Fixed a typo:  missing *.  This would lead to a kernel oops if the kernel
> was compiled without support for the /proc file system.
> 
> Found with a static checker.  Compile tested.
> 
> regards,
> dan carpenter
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
Acked-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> 
> --- orig/drivers/video/via/viafbdev.c	2009-11-21 14:44:33.000000000 +0200
> +++ devel/drivers/video/via/viafbdev.c	2009-11-21 14:44:43.000000000 +0200
> @@ -1797,7 +1797,7 @@ static const struct file_operations viaf
>  static void viafb_init_proc(struct proc_dir_entry **viafb_entry)
>  {
>  	*viafb_entry = proc_mkdir("viafb", NULL);
> -	if (viafb_entry) {
> +	if (*viafb_entry) {

Thanks,

Florian Tobias Schandinat

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july

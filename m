From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbmem.c : FBIOGETCMAP
Date: Sun, 5 Jan 2003 20:35:57 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301052034420.24903-100000@phoenix.infradead.org>
References: <20030105201837.26561.qmail@web14914.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18VHVc-00075w-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 05 Jan 2003 12:36:37 -0800
In-Reply-To: <20030105201837.26561.qmail@web14914.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


> I'm using 2.53 and I ran into this when running
> fbtest. It looks like a return went missing.
> 
> 	case FBIOGETCMAP:
> 		if (copy_from_user(&cmap, (void *) arg,
> sizeof(cmap)))
> 			return -EFAULT;
> 		fb_copy_cmap(&info->cmap, &cmap, 0);
> 	case FBIOPAN_DISPLAY:
> 
> In 2.4 it looked like this:
> 
> 	case FBIOGETCMAP:
> 		if (copy_from_user(&cmap, (void *) arg,
> sizeof(cmap)))
> 			return -EFAULT;
> 		return (fb->fb_get_cmap(&cmap, 0,
> PROC_CONSOLE(info), info));
> 	case FBIOPAN_DISPLAY:

In the latest code there is a return 0 after fb_copy_cmap. So it is fixed 
with the latest tree.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

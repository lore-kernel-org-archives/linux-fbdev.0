From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbmem.c : FBIOGETCMAP
Date: Sun, 5 Jan 2003 20:52:37 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301052048270.24903-100000@phoenix.infradead.org>
References: <20030105204033.19207.qmail@web14904.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18VHlf-0001E2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 05 Jan 2003 12:53:12 -0800
In-Reply-To: <20030105204033.19207.qmail@web14904.mail.yahoo.com>
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


> It needs a copy_to_user too to work. Probably doesn't
> need the copy_from_user.
> 
> Is the right fix?
> 
> 	case FBIOGETCMAP:
> 		fb_copy_cmap(&info->cmap, &cmap, 0);
> 		if (copy_to_user((void *) arg, &cmap, sizeof(cmap)))
> 			return -EFAULT;
> 		return 0;

Oops. I see the problem. It should be 

  fb_copy_cmap(&info->cmap, &cmap, 2);

This tells it to use copy_to_user. I see a few mistakes here. Fixing...

There are several bugs here. I have to cleanup it up. FOr example in 
fb_copy_cmap there is test for a EFAULT for any copy_* function. This is 
just broken. It has been broken for a long time. Will fix. Will you test 
my patch as soon as it is ready?




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: fbmem.c : FBIOGETCMAP
Date: Sun, 5 Jan 2003 12:40:33 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030105204033.19207.qmail@web14904.mail.yahoo.com>
References: <Pine.LNX.4.44.0301052034420.24903-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14904.mail.yahoo.com ([216.136.225.56])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18VHZT-0007Z0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 05 Jan 2003 12:40:35 -0800
In-Reply-To: <Pine.LNX.4.44.0301052034420.24903-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

It needs a copy_to_user too to work. Probably doesn't
need the copy_from_user.

Is the right fix?

	case FBIOGETCMAP:
		fb_copy_cmap(&info->cmap, &cmap, 0);
		if (copy_to_user((void *) arg, &cmap, sizeof(cmap)))
			return -EFAULT;
		return 0;


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

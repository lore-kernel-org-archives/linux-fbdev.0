From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbmem.c : FBIOGETCMAP
Date: Tue, 7 Jan 2003 22:37:35 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301072230180.17129-100000@phoenix.infradead.org>
References: <20030107165740.53554.qmail@web14906.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W2ML-0003WT-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 14:38:10 -0800
In-Reply-To: <20030107165740.53554.qmail@web14906.mail.yahoo.com>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I can run the fb color map tests now if you had a
> chance to fix the code.
> 
> I am just running fbtest from the sourceforge fb cvs.

I'm CC the fbdev list because the fb color map code is a mess. I like to 
know what the best approach would be to clean it up.

FIrst the main bug. In fb_copy_cmap we should be testing to see if 
copy_from[to]_user fails. We don't. The other issue is for fb_copy_cmap
We handle memcpy, copy_from_user, and copy)to_user. Now in fb_set_cmap
we use get_user also without any checks. 

So we could have fb_copy_cmap keep handling all these issues and remove 
get_user from fb_set_cmap. We would just pass in fbcmap we got from 
fb_copy_cmap and pass into fb_set_cmap. The other approach is to 
remove copy_from_user in fb_copy_cmap and place it int fb_set_cmap. 

What do you think is the best approach to this?



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

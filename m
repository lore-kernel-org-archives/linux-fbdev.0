From: James Simmons <jsimmons@infradead.org>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
 2.5.5[45]
Date: Wed, 12 Feb 2003 20:13:21 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302122010580.31435-100000@phoenix.infradead.org>
References: <1043967276.1002.21.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18j3GY-0000IW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Feb 2003 12:13:59 -0800
In-Reply-To: <1043967276.1002.21.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jak <rfjak@eircom.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> >From what I understand about sysfs, you can only have one type per file,
> so each field will have to be in separate files.  

Correct.

> To synchronize, we can
> perhaps use a file ('sync', 'lock', 'update' or whatever) which is
> similar in function to fb_var_screeninfo.activate. Only when the user
> writes to this file that the new settings are synchronized and we call
> fb_set_var() or whatever.

This doesn't bother me. I cna live with that. Actually it is a good idea 
to do it that way. THis way if we have graphics clients we can invalidate 
them when switch the entire graphics state. The accel engine will switch 
behavior on changing the video mode.

> How do you think sysfs support will be written?  Will this mean that the
> framebuffer system has to register its own kobject as the top level
> entry in sysfs, no?  

I think so. I haven't looked down this aveue yet. This is a latter time 
project.

> This would also mean that we need something similar
> for the console subsystem if it has to support additional features, ie
> rotation?

I'm not to thrilled about this idea.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: James Simmons <jsimmons@infradead.org>
Subject: Re: Move softcursor out of fbdev to fbcon
Date: Thu, 28 Jul 2005 19:39:01 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507281937370.28080@pentafluge.infradead.org>
References: <42E73C6E.1090205@gmail.com> <9e473391050727073269e33a44@mail.gmail.com>
 <42E7D77F.6020005@gmail.com> <Pine.LNX.4.56.0507272313530.4063@pentafluge.infradead.org>
 <42E83F06.3000508@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyDHw-0006v9-It
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 11:39:24 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1DyDHv-0007wV-Aj
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 11:39:24 -0700
In-Reply-To: <42E83F06.3000508@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> >>>> And the next step is to eliminate all fbcon-specific fields from
> >>>> fb_info to another structure, such as fb_imageblit, fb_fillrect,
> >>>> fb_cursor, fb_copyarea.  We'll have a smaller kernel size for
> >>>> if fbcon is not enabled.
> > 
> > Yipes!!! That will be really hard for hardware accelerated drivers. You 
> > have to make fbdv drivers be aware of when fbcon is loaded. Then check to 
> > see if the device maps to a range of VCs. Then register with the fbcon 
> > layer. Really nasty. More bloat in the long run.
> 
> You're making it more complicated than it sounds.  As an initial step,
> fields in struct fb_info that are fbcon-specific are placed in another
> struct, say struct fbcon_info. 

That is what struct display os for in fbcon.

> In register_framebuffer, both fb_info
> and fbcon_info are registered. If CONFIG_FRAMEBUFFER_CONSOLE = n, struct
> fbcon_info will either be null or just end up containing NULL/dummy
> entries. The end result will be a smaller and cleaner fb_info.
>
> There is really no need for fbdev drivers to detect that fbcon is loaded
> or not, since they do not know anything about it. They just need to check
> if CONFIG_FRAMEBUFFER_CONSOLE is set or not.

This would work for the case of everything being statically built into the 
kernel. With modular fbdev drivers and in the future a modular fbcon then 
it would get messy.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

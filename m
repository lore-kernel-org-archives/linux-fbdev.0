From: James Simmons <jsimmons@infradead.org>
Subject: Re: 2.5 fbdev & driver initial mode
Date: Thu, 9 Jan 2003 00:32:35 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301090027200.4976-100000@phoenix.infradead.org>
References: <1042062770.551.9.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WQdG-0008Ug-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Jan 2003 16:33:15 -0800
In-Reply-To: <1042062770.551.9.camel@zion.wanadoo.fr>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> How is a driver supposed to set the default mode on init lately ?
> 
> Looking at rivafb, it fills info->var from fb_find_mode with the mode
> option if any, but then does nothing with it (and does nothing if
> no mode option is passed).
> 
> On radeonfb, I fill a var  with the default mode obtained
> from EDID or the option if any. Then, I basically do
> 
> 	info->var = var;
> 	var.activate = FB_ACTIVATE_NOW;
> 	fb_set_var(&var, info);
> 
> before calling register_framebuffer.
> 
> What is the right way to do ?

Sorry about the confusion. The answer depends on the driver. For the 
rivafb driver because it has a VGA core we have it NOT switch to a 
graphics state. The reason is 


1) If we run a /dev/fb app was can save the hardware text mode state and
    restore it on closing /dev/fb. You can see this in rivafb_open and
   rivafb_release. 

2) We can test loading it as a module as see debugging info while still
   having a VGA text mode. Makes life a little easier. The other thing 
   I like to do is run mdacon and just the fbdev driver by itself. I can 
   then test the fbdev driver. When I get really brave I test fbcon.c and
   can debug it.

Now for graphics hardware built in that has no hardware text mode. It is 
better to set the video mode right away.





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

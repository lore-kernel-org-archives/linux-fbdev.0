From: James Simmons <jsimmons@infradead.org>
Subject: Re: Move softcursor out of fbdev to fbcon
Date: Wed, 27 Jul 2005 23:17:26 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507272313530.4063@pentafluge.infradead.org>
References: <42E73C6E.1090205@gmail.com> <9e473391050727073269e33a44@mail.gmail.com>
 <42E7D77F.6020005@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxuDV-000250-9S
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 15:17:33 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1DxuDU-0007du-OS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 15:17:33 -0700
In-Reply-To: <42E7D77F.6020005@gmail.com>
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


> >> And the next step is to eliminate all fbcon-specific fields from
> >> fb_info to another structure, such as fb_imageblit, fb_fillrect,
> >> fb_cursor, fb_copyarea.  We'll have a smaller kernel size for
> >> if fbcon is not enabled.

Yipes!!! That will be really hard for hardware accelerated drivers. You 
have to make fbdv drivers be aware of when fbcon is loaded. Then check to 
see if the device maps to a range of VCs. Then register with the fbcon 
layer. Really nasty. More bloat in the long run.

> > It has always bugged me that there was no real interface between
> > fbconsole and fbdev. For example I tried to write a wrapper for DRM so
> > that fbconsole could use DRM for accelerated console. But fbconsole is
> > so tied into the fbdev data structures writing the wrapper required me
> > to build most of an fbdev driver. I shouldn't need to do that,
> > fbconsole should not be poking at fb_info, it should use an API for
> > making changes.
> 
> Yes. I think I'm planning to do that in small steps. I'm thinking first of
> separating all fbcon-specific fields and place them in another structure,
> ie, fbcon_info.  This struct will be registered separately from fb_info,
> and only if fbcon is enabled.

Thats why its called the framebuffer console. It used the framebuffer api. 
Making a API between fbconsole and fbdev would be more bloat and whould 
have a performance it. The idea is to go as fast as possible.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

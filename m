From: James Simmons <jsimmons@infradead.org>
Subject: Re: Move softcursor out of fbdev to fbcon
Date: Wed, 27 Jul 2005 23:04:30 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507272302500.3729@pentafluge.infradead.org>
References: <42E73C6E.1090205@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dxu2e-0001VR-O9
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 15:06:20 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Dxu2d-0005AB-EA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 15:06:20 -0700
In-Reply-To: <42E73C6E.1090205@gmail.com>
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


> The changelog says it all. This is a modification of Jon's patch, but
> I have moved softcursor.c to the console directory.  Also I removed
> the "select FB_SOFTCURSOR" from video/Kconfig and made the compilation
> of softcursor unconditional, if framebuffer console is enabled.
> 
> I don't think the fb_cursor hook is usable by other programs, so we
> should just restrict this hook for fbcon use only.  For userspace cursor
> support, we need a new one.  But instead of one function, I believe
> it's better to provide several.  Ie, something like below:
> 
> fbcursor_show()         
> fbcursor_move()
> fbcursor_loadimage()
> fbcursor_loadpalette()
> fbcursor_start()
> fbcursor_stop() 
> 
> No need to pass all variables to just, say, move the cursor to x,y.
> 
> And the next step is to eliminate all fbcon-specific fields from
> fb_info to another structure, such as fb_imageblit, fb_fillrect,
> fb_cursor, fb_copyarea.  We'll have a smaller kernel size for
> if fbcon is not enabled.
> 
> Comments?

Its way to big and gross. Please keep it simple!!!!!! 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

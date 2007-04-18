From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: Radeon X300, radeonfb, dual head
Date: Wed, 18 Apr 2007 15:26:57 +0200
Message-ID: <200704181526.57746.hjk@linutronix.de>
References: <200704181409.51475.hjk@linutronix.de>
	<4240b9160704180558t6a81f81eoe4a8c768ae6d0929@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HeABk-00064t-48 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Apr 2007 06:27:12 -0700
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HeABi-00058s-MB
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Apr 2007 06:27:12 -0700
In-Reply-To: <4240b9160704180558t6a81f81eoe4a8c768ae6d0929@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jerome Glisse <j.glisse@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

Am Mittwoch, 18. April 2007 14:58 schrieb Jerome Glisse:

> 
> I am not at all an expert in this radeonfb + X things (somethings i avoid
> to use :)) but i think that radeonfb might get in the way of the X server

That's obvious, but why? Is it a X problem, or is it a radeonfb problem?
Several pages I found on the web suggest that somebody got these working
together. Where does the regression come from? What can I do to help?

> does mergedfb work with a kernel without any framebuffer driver ?

No, I just tried that. I only compiled in vga16, no vesafb, no radeonfb,
but no change in X server behaviour.

But one more interesting thing:

I added 
Option "MergedXineramaCRT2IsScreen0" "true"
to my Section "Device". This made kdm show its login window on my screens,
so I could login to KDE. The KDE control center displays everything as it
should be: Desktop 3360x1050, two displays with 1680x1050 each, first display
at 0,0 and second display at 1680,1050.

So obviously the X server "thinks" everything is configured as it should be.
Unfortunately, that's not reality. I still got the same content on both screens.

Hans


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

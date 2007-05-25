From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: unregister_framebuffer() and cursor
Date: Sat, 26 May 2007 05:25:09 +0800
Message-ID: <1180128309.4627.10.camel@daplas>
References: <Pine.LNX.4.62.0705041045310.9684@pademelon.sonytel.be>
	<1178271722.4722.11.camel@daplas>
	<Pine.LNX.4.62.0705251201460.2657@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HrhHg-0001Z8-V6 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 May 2007 14:25:40 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HrhHf-0000Pr-5C
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 May 2007 14:25:16 -0700
Received: by py-out-1112.google.com with SMTP id u77so1537485pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 25 May 2007 14:25:14 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0705251201460.2657@pademelon.sonytel.be>
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geoff Levand <geoffrey.levand@am.sony.com>

On Fri, 2007-05-25 at 12:13 +0200, Geert Uytterhoeven wrote:
> On Fri, 4 May 2007, Antonino A. Daplas wrote:
> > On Fri, 2007-05-04 at 10:50 +0200, Geert Uytterhoeven wrote:
> > > It looks like unregister_framebuffer() doesn't cause fbcon_del_cursor_timer()
> > > to be called.
> > > 
> > > Hence if cursor_timer_handler() runs, it will try to schedule work on
> > > fb_info.queue, which is no longer valid, and queue_work() will BUG_ON().
> > > 
> > > Or am I missing something?
> > 
> > The console cursor is not part of fbdev.  fbcon_del_cursor_timer() is
> > done in fbcon_exit() in fbcon.c. You cannot (or, rather, should not)
> > call unregister_framebuffer() unless fbcon unbinds the underlying
> > driver.
> 
> Indeed, when unbinding the console first using
> 
>     echo 0 > /sys/class/vtconsole/vtcon1/bind
>     
> the problem no longer happens on halt (Geoff: and ps3-hack-fbcon-shutdown.diff
> is no longer needed).
> 
> However there are still a few remaining issues:
>   - unbinding requires CONFIG_VT_HW_CONSOLE_BINDING=y,
>   - unbinding can be done using sysfs only (for now),
>   - worse, unbinding may fail, e.g. if the console is in graphics mode due to
>     running X.
> 
> Our problem is that we have to shutdown ps3fb on reboot/kexec, to release the
> hypervisor resources used by ps3fb. If unbinding fails, we cannot do that.

Both you and drmfb has the same problem, and Jesse submitted a patch
that will unbind fbcon prior to unregister_framebuffer(). The patch
needs a few tweaks but is fine by me in principle.

Search lkml for [PATCH 1/3] allow console unregistration.

As for the first, maybe a 

'select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE' under ps3fb?

As for the second and third concerns, Jesse's patch would take care of
that.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

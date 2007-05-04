From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: unregister_framebuffer() and cursor
Date: Fri, 04 May 2007 17:42:02 +0800
Message-ID: <1178271722.4722.11.camel@daplas>
References: <Pine.LNX.4.62.0705041045310.9684@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjuIk-0003V3-9c for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 May 2007 02:42:10 -0700
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HjuIi-0000jU-O4
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 May 2007 02:42:10 -0700
Received: by py-out-1112.google.com with SMTP id a29so635782pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 04 May 2007 02:42:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0705041045310.9684@pademelon.sonytel.be>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Geert.Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>, Geoff Levand <geoffrey.levand@am.sony.com>

On Fri, 2007-05-04 at 10:50 +0200, Geert Uytterhoeven wrote:
> 	Hi,
> 
> It looks like unregister_framebuffer() doesn't cause fbcon_del_cursor_timer()
> to be called.
> 
> Hence if cursor_timer_handler() runs, it will try to schedule work on
> fb_info.queue, which is no longer valid, and queue_work() will BUG_ON().
> 
> Or am I missing something?

The console cursor is not part of fbdev.  fbcon_del_cursor_timer() is
done in fbcon_exit() in fbcon.c. You cannot (or, rather, should not)
call unregister_framebuffer() unless fbcon unbinds the underlying
driver.

Tony  



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

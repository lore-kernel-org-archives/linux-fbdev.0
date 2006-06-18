From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: [PATCH 0/5 2.6.17-rc6-mm2] add vsync
	interrupt support to intelfb driver
Date: Sun, 18 Jun 2006 17:12:24 +1000
Message-ID: <21d7e9970606180012h64ffc552xf02b639633828b5c@mail.gmail.com>
References: <F321C0F0-2A24-4A4D-B1FE-C721C8B9DE20@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FrrSN-0004HP-PP for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 00:12:27 -0700
Received: from nz-out-0102.google.com ([64.233.162.203])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FrrSM-00006k-Ft
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 00:12:27 -0700
Received: by nz-out-0102.google.com with SMTP id z3so723205nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 18 Jun 2006 00:12:24 -0700 (PDT)
In-Reply-To: <F321C0F0-2A24-4A4D-B1FE-C721C8B9DE20@cecropia.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, Dave Airlie <airlied@skynet.ie>

> here is a series of patches for the intelfb driver that adds vsync
> interrupt support to the intelfb driver.  There are two ways to get
> at the exposed functionality -- you can use either the unofficial
> FBIO_WAITFORVSYNC ioctl or you can pass FB_ACTIVATE_VBL as a flag
> when you pan the display.  Either way, you can now get a flicker-free
> display out of the framebuffer.
>
> This functionality was modeled on existing functionality that is
> already in the aty and matrox framebuffer drivers.

Hopefully someone else can confirm this but your mailer appears to be
mangling the whitespace in your patches and it makes it quite
difficult for me to just pull them into a git tree..

I've looked at the patches with gmail and from a raw UNIX mbox and
pine.. there appears to be linewrapping on the diff headers.

Dave.

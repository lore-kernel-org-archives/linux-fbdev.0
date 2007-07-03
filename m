From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: [PATCH] pxafb: Add support for other
	palette formats
Date: Tue, 3 Jul 2007 18:45:57 +0200
Message-ID: <200707031845.57256.hjk@linutronix.de>
References: <200707031607.08511.hjk@linutronix.de>
	<18058.28725.106989.860166@ipc1.karo>
	<468A7359.5010305@grupopie.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5lVq-0007WF-A1 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 09:46:02 -0700
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I5lVo-00009C-Jc
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 09:46:01 -0700
In-Reply-To: <468A7359.5010305@grupopie.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Paulo Marques <pmarques@grupopie.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk, Lothar Wassmann <LW@karo-electronics.de>

Am Dienstag 03 Juli 2007 18:03 schrieb Paulo Marques:
> Lothar Wassmann wrote:
> > Hi,
> > 
> >> Can userspace applications work with such a weired format?
> >> If yes, I'm looking forward to your patch.
> >>
> > At least framebuffer consoles don't work with that. So you should
> > add a configuration option that allows enabling the strange PXA pixel
> > formats only when CONFIG_FRAMEBUFFER_CONSOLE is not set.
> 
> Or maybe teach fbcon to use 18bpp modes?

This would only make sense if this is a common format that other
chips use, too.

> 
> > BTW: PXA255 doesn't have an LCCR4 register.
> 
> If we make sure that we don't touch LCCR4 registers unless the platform 
> driver asks for 18bpp we should be in the clear, no?
> 
> However, the current patch does write to LCCR4 without checking this, 
> but this should be a no-op if there is no register there, AFAICS.

Arrg, no, you can't do this. Even if it works on your current PXA255
revision, writing to a nonexistent register is certainly not something
we should do in a proper driver.

> 
> I'll try to handle it more correctly in my next patch, anyway.
>

So will I. I'll update my patch.

Thanks,
Hans


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

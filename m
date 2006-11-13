From: James Simmons <jsimmons@infradead.org>
Subject: Re: who is writing to my framebuffer?
Date: Mon, 13 Nov 2006 19:52:55 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611131950360.2366@pentafluge.infradead.org>
References: <bb9a78950611131119r163c4beci5559b7e6e84c3e84@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gjhrc-0008CE-GF for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 11:53:04 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gjhra-0000uj-UM
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 11:53:04 -0800
Received: from localhost ([127.0.0.1])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1GjhrT-0008Bh-RS for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 19:52:55 +0000
In-Reply-To: <bb9a78950611131119r163c4beci5559b7e6e84c3e84@mail.gmail.com>
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


> > > > Looking at the code all cursor control from the driver level has been
> > > > removed. It been put into fbcon. So if you enable fbcon then it will
> > > > activate the cursor and have full control of the cursor. Only terminal
> > > > codes will turn it off. Any reason to fbcon enabled?
> > > >
> > >
> > > Well, without fbcon I'm not too sure how we could see any of our output.
> > To
> > > view our graphics data we're reading from the framebuffer and sending
> > that
> > > data to another piece of hardware that puts it on a screen.
> > 
> > No serial port or network avaliable?
> > 
> 
> There is, but we don't want that, we'd like to put our output on a monitor
> attached to the machine.

I have noticed that alot of people work that way. The problem is for VT 
terminals the terminal code and console code are together. For example you 
can have a printer console but there is no printer tty. Unfortunely you 
can't have a VT console only. This is on my to do list. 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

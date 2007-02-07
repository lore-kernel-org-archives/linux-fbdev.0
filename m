From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/10] ps3av/fb drivers for 2.6.21
Date: Thu, 08 Feb 2007 08:07:06 +1100
Message-ID: <1170882427.2620.293.camel@localhost.localdomain>
References: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702051624410.18405@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702061559420.14230@pademelon.sonytel.be>
	<1170794953.2620.253.camel@localhost.localdomain>
	<Pine.LNX.4.62.0702070859050.31772@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702071743040.29060@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEu2t-0003Rp-2T for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 13:09:39 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1/+x4is2RFFEzH4F7H7xnOGPYDlliVNJRM=])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEu2r-0008LU-3B
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 13:09:39 -0800
In-Reply-To: <Pine.LNX.4.62.0702071743040.29060@pademelon.sonytel.be>
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
Cc: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC Development <linuxppc-dev@ozlabs.org>

On Wed, 2007-02-07 at 17:51 +0100, Geert Uytterhoeven wrote:
> On Wed, 7 Feb 2007, Geert Uytterhoeven wrote:
> > On Wed, 7 Feb 2007, Benjamin Herrenschmidt wrote:
> > > > ps3av: Use a kernel thread to handle the actual video mode setting, as this
> > > > involves some quite big delays.
> > > 
> > > The ps3 fbdev already has it's own kernel thread no ? Why use a second
> > > one ? We could just have the ps3av code keep the delays but be called by
> > > a thread ?
> > 
> > That's another possibility.  And since the screen is blanked during mode
> > change, there's no need to refresh it, and I may even get rid of the call to
> > ps3fb_flip_ctl() in ps3av.
> > 
> > I'll look into it...
> 
> Below's a new patch (take 3).
> 
> But it doesn't work well: after each mode change, the old contents of the
> screen are visible for a (noticable) fraction of a second.
> Ps3fbd doesn't refresh the screen contents until ps3av_set_video_mode()
> returns, which is longer than my display needs to sync to the new video mode
> (this was actually the reason behind the msleep() calls).
> 
> I also could not get rid of the calls to ps3fb_flip_ctl() in ps3av, as screen
> updates have to be disabled while sending other AV packets, too.
> 
> So I prefer the previous solution, using a new ps3av kernel thread.
> Unless anyone has a better solution, of course :-)

Moving the flip to ps3av ? :-)

Ben.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

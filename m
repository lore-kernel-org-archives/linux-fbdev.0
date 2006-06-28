From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] add framebuffer and display update
 module support for pnx4008
Date: Wed, 28 Jun 2006 11:42:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0606281142190.29680@pademelon.sonytel.be>
References: <20060627191747.4b455b24.vitalywool@gmail.com>
	<44A1A2A6.5080206@gmail.com>
	<20060628114633.d96c8155.vitalywool@gmail.com>
	<44A246E1.20801@gmail.com>
	<20060628133659.3a6b10e9.vitalywool@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FvWZQ-0004c6-Mr for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Jun 2006 02:42:52 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FvWZP-0006NM-4H
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Jun 2006 02:42:52 -0700
In-Reply-To: <20060628133659.3a6b10e9.vitalywool@gmail.com>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: gtolstolytkin@ru.mvista.com, "Antonino A. Daplas" <adaplas@gmail.com>

On Wed, 28 Jun 2006, Vitaly Wool wrote:
> On Wed, 28 Jun 2006 17:07:45 +0800
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
> > > Hmmm, the thing is that the frambuffer can actually be anyone of a kind.
> > > Display Update Module provides interface to the actual device and the only difference it makes is whether it's a RGB or YUV framebuffer.
> > > 
> > 
> > Well, something like pnxrgbfb, pnxyuvfb? But it's your driver, so
> > your call.
> 
> It's in pnx4008/ subdir, is it really reasonable to prefix the FB driver name with pnx?

If it's a loadable module, the name must be unique.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

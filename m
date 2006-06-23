From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2.6.17-rc6-mm2] fbdev: tag by
 scantype in sysfs
Date: Fri, 23 Jun 2006 11:16:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0606231115180.31279@pademelon.sonytel.be>
References: <4497AA7A.5050507@st.com> <4497B4FA.2080602@pol.net>
	<4497C289.5060007@st.com>  <4497CE24.7050908@gmail.com>
	<1151049881.12499.18.camel@butch.bri.st.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fthly-0002j5-BS for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 02:16:18 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fthlt-0007qC-5z
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 02:16:18 -0700
In-Reply-To: <1151049881.12499.18.camel@butch.bri.st.com>
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
To: daniel.thompson@st.com, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

On Fri, 23 Jun 2006, Daniel THOMPSON wrote:
> On Tue, 2006-06-20 at 18:29 +0800, Antonino A. Daplas wrote:
> >  /sys/class/graphics---fb0
> >                     :
> >                     --fb1
> >                     :
> >                     --fbn
> >                     :
> >                     --mode0---640x480@60
> >                     :       :
> >                     :       --1024x768@60
> >                     :  
> >                     --mode1
> 
> So the directory mode0 contains all the modes that fb0 is capable of
> displaying? Can't that go inside fb0?

Let's hope not, as most machines/fb combos don't have enough RAM to store all
modes the fb is capable of.

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

From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [Question] Colour management
Date: Sun, 1 Aug 2004 09:03:43 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408010903.43998.adaplas@hotpop.com>
References: <20040722184937.GA11361@sci.fi> <200407302012.36325.alex.kern@gmx.de> <20040731221014.GA17669@sci.fi>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Br4mF-00077m-EA
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 18:04:39 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Br4mF-0007LG-3N
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 18:04:39 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id AECD1748FE6
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  1 Aug 2004 00:13:28 +0000 (UTC)
In-Reply-To: <20040731221014.GA17669@sci.fi>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net

On Sunday 01 August 2004 06:10, Ville Syrj=E4l=E4 wrote:
> On Fri, Jul 30, 2004 at 08:12:36PM +0200, Alexander Kern wrote:
> > Hallo Tony,
> >
> > can you explain the deep mining of fb_setcolreg. Background, I observe
> > wrong palette using in 15 and 16 bpp modes, but can not understand, what
> > is the right approach. In both cases from penguin logo I can see only
> > contour in honey yellow and blue vertical string jsimmons, pretty scury
> > ;-) The rest is black! The simple text or ncurses applications have
> > always right colours. Additionally and only by 16bpp fbi shows blurry
> > images.
>
> I just had a look at the fbi code and it's wrong. It was initializing the
> clut to 555. The attached patch fixes the problem.

I know that this is just a test patch but instead of hardwiring the paramet=
ers=20
of linear_palette, why not do:

linear_palette(var.red.length, var.green.length, var.blue.length)

This way you can catch unusual RGB combinations (ie, RGB484, if there is su=
ch=20
a thing) and still get correct colors.  You can also eliminate the switch()=
=20
statement, and makes it easier to catch fbdev bugs.

>
> I think the boot logo code is broken. No, I haven't actually looked at it
> but everything else works... Or does it work on some other directcolor hw?

Yes, the logo code is broken, not the drawing code itself, but the logo=20
choosing code. As I've mentioned in another thread, 16-bit directcolor cann=
ot=20
draw 224-color logos.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com

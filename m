From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: framebuffer ioctl
Date: Wed, 8 Sep 2004 16:59:35 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040908135935.GA4661@sci.fi>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be> <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net> <200409060926.07163.adaplas@hotpop.com> <413CC0EA.8070709@comcast.net> <9e4733910409061402372095b1@mail.gmail.com> <1094505860.31465.211.camel@admin.tel.thor.asgaard.local> <9e47339104090707172cdc258d@mail.gmail.com> <1094572321.6095.10.camel@admin.tel.thor.asgaard.local> <9e47339104090722437b81b373@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C52z3-0004OJ-Ha
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 06:59:37 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C52z2-0005a8-Lm
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 06:59:37 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id E6E08518A6
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  8 Sep 2004 16:59:35 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <9e47339104090722437b81b373@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Wed, Sep 08, 2004 at 01:43:42AM -0400, Jon Smirl wrote:
> On Tue, 07 Sep 2004 11:52:00 -0400, Michel D=E4nzer <michel@daenzer.net=
> wrote:
> > All I'm saying is that it reflects badly on you if you need to resort=
 to
> > skewed numbers.
>=20
> I don't think they are skewed. Most desktops today have hardware
> OpenGL and software Render. The ratios are an accurate reflection of
> what a normal user would see when comparing Cairo on X vs Cairo on
> OpenGL. You may try to change the platform in the future but hardware
> Render is not deployed anywhere currently.

AFAIK neither is Cairo.

If I had too much time on my hands I might port glitz to DirectFB so you=20
could quote some more meaningful benchmarks ;)

> Even KeithP says he would rather be on OpenGL than to continue
> accelerating Render functions and he designed Render. The argument is
> not about the technical merits of Render vs OpenGL, it's about the
> fact that OpenGL is a widely available standard that is well
> documented. Thousands of people can program to the OpenGL APL while
> only very few know about Render. Let's stand on the shoulders of other
> programmers (you're one of them since you helped with mesa) rather
> than build everything again.

No one is preventing you from doing that. But other people have other=20
priorities and you constantly ignoring that fact doesn't help matters. Yo=
u=20
can dream of world domination all you want but in the world of open sourc=
e=20
people tend to do what they find interesting.

I welcome you work on the drm since it appears to reduce the amount of=20
unnecessary user space init code. When the drm gets easier to use other=20
projects may adopt it.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click

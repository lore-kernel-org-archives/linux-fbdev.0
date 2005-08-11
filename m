From: Antonino Daplas <adaplas@gmail.com>
Subject: Re: mono, gray and index configs
Date: Thu, 11 Aug 2005 19:08:34 +0800
Message-ID: <b00ca3bd05081104086fa9e639@mail.gmail.com>
References: <9e47339105081020216574ac7e@mail.gmail.com>
	 <42FAE3F8.8080902@gmail.com>
	 <Pine.LNX.4.62.0508111020520.1037@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3AvQ-00027m-QF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Aug 2005 04:08:40 -0700
Received: from zproxy.gmail.com ([64.233.162.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E3AvQ-0002P7-Em
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Aug 2005 04:08:40 -0700
Received: by zproxy.gmail.com with SMTP id 9so225067nzo
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 11 Aug 2005 04:08:34 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0508111020520.1037@numbat.sonytel.be>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jon Smirl <jonsmirl@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>

On 8/11/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, 11 Aug 2005, Antonino A. Daplas wrote:
> > that all the lengths =3D 1 and offsets =3D 0.  Currently, we have no wa=
y to
> > specifically request for mono01, mono10, or 1-bit pseudocolor. Just che=
ck
> > for fix->visual afterwards.
>=20
> For mono01 or mono10, if the visual is pseudocolor, just set the colormap=
 to
> black/white or white/black.


I don't know. If I can change the colormap, I would  advertise this as
1-bit pseudocolor, not monochrome.  Otherwise, why differentiate
between mono01 and mono10 if I can control what color is 0 and what
color is 1.  I think the closest definition of monochrome is 1-bit
static pseudocolor.  And we just have mono01 and mono10 to advertise
how hardware treats 0/1 (background/foreground or reverse).

I have a few things that are still not clear to me.  If I understand
it correctly, monochrome means 2 colors regardless of the bit depth.=20
So it's possible, for example, to have 8-bit monochrome that has only
two colors, ie 0x00 and 0xff.   If this was 8-bit static pseudocolor,
then it has 256 different colors.

(Depending on how correct I am with the interpretation, there might be
some bugs in fbdev on how it determines the color depth. No one is
complaining yet though, so greater than 1-bit monochrome is probably
rare if not nonexistent.)

>=20
> > For directcolor (indexed) vs truecolor, there is currently no way
> > to specify which visual you want.  You also have to check for fix->visu=
al
> > afterwards.
> >
> > One of the reason I also want this sysfs attribute is because in at
> > least 1 driver (i810fb), it's possible to choose between truecolor and
> > directcolor but it uses a hack by checking for the var->nonstd flag.
>=20
> So the driver should use directcolor instead of truecolor if the hardware
> supports it. The application can always set a linear colormap if it needs
> truecolor.


A few years ago, I discovered that there are several fbdev apps that
make ssumptions which are not necessarily correct.  For example, if
bits_per_pixel > 8, the app assumes the format is truecolor. So the
app produces wrong colors if fbdev is in directcolor mode (because it
failed to set the cmap).

So, it is useful to have the capability to choose between truecolor
and directcolor when dealing with those apps without rebooting or
recompiling.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

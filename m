From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: CRTC scanout buffer types
Date: Sat, 6 Aug 2005 19:27:18 -0400
Message-ID: <9e473391050806162746046410@mail.gmail.com>
References: <9e47339105080513195dee0804@mail.gmail.com>
	 <200508061924.03205.pmcfarland@downeast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1Y4a-0007xm-QA
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Aug 2005 16:27:24 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1Y4a-0004Pc-I3
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Aug 2005 16:27:24 -0700
Received: by wproxy.gmail.com with SMTP id i17so338737wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 06 Aug 2005 16:27:18 -0700 (PDT)
In-Reply-To: <200508061924.03205.pmcfarland@downeast.net>
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
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: dri-devel@lists.sourceforge.net, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On 8/6/05, Patrick McFarland <pmcfarland@downeast.net> wrote:
> On Friday 05 August 2005 04:19 pm, Jon Smirl wrote:
> > I've included the scanout types for the R200, what other ones are
> > supported by the various chips? For example I think the R300 can
> > scanout in floating point.
> >
> > 4bpp Indexed
> > 8bpp Indexed
> > 16bpp aRGB 1555
> > 16bpp RGB 565
> > 24bpp RGB 888
> > 32bpp aRGB 8888
> > 16bpp aRGB 4444
> > 16bpp aIndex 88
> > 32bpp aRGB 2:10:10:10 palette bypassed
> >
> > Note, the r200 supports a lot more buffer formats, but these are the
> > only ones valid for scanout.
>=20
> What does scanout mean?

A scanout buffer is a buffer that the graphics chip reads from to
directly display on the screen.  There are other buffer types like
texture and pbuffer that are not directly displayable. For example the
Radeon r200 does not allow floating point colors in scanout buffers
but they can be used in other buffer types.


>=20
> --
> Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
> "Computer games don't affect kids; I mean if Pac-Man affected us as kids,=
 we'd
> all be running around in darkened rooms, munching magic pills and listeni=
ng to
> repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989
>=20
>=20
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

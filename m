From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: radeonfb on pegasos powerpc motherboard and X endianess problem
Date: Wed, 4 Jun 2003 17:39:16 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030604153916.GA23620@iliana>
References: <20030604145423.GA22876@iliana> <1054740419.27389.332.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp6.wanadoo.fr ([193.252.22.28] helo=mwinf0301.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19NaMH-0000F1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 04 Jun 2003 08:39:25 -0700
Content-Disposition: inline
In-Reply-To: <1054740419.27389.332.camel@thor.holligenstrasse29.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Sven Luther <sven.luther@wanadoo.fr>, linux-fbdev-devel@lists.sourceforge.net

On Wed, Jun 04, 2003 at 05:27:00PM +0200, Michel D=E4nzer wrote:
> On Wed, 2003-06-04 at 16:54, Sven Luther wrote:
> >=20
> > I finally have a working pegasos motherboard as well as a working kernel
> > with a 1.6 radeonfb. I have also installed Daniel Stone's X 4.3.0
> > debian/sid packages, and notice the following :
> >=20
> >   1) radeonfb works fine in 8bpp and 32bpp but depth 15 and 16 only give
> >   me some very dark grey.
> >=20
> >   2) when running X with the UseFBDev option the colors are bad, i guess
> >   it is an endianess problem. (with and without accel)
>=20
> You want radeonfb from a recent benh kernel, anything else is more or
> less broken.

A, ok, but then, i think i will not worry about this, and simply port
the pegasos changes to the latest benh kernel (or maybe i can simply
replace the radeonfb.c file ? Mmm, i will try it). By recent benh
kernel, you mean the one from the linuxppc_2_4_devel tree or the one from t=
he
linuxppc_2_4 tree ? Or maybe both are the same.

> >   3) When running X without the UseFBDev option, the colors are good,
> >   but i get garbage when i return to the console. Not exactly garbage,
> >   at first it is ok, but when i enter a line or somehow pan the screen,
> >   the corruption start. Doing a vt switch and back redraws a clean
> >   screen.
>=20
> Sounds like the radeon driver doesn't restore the framebuffer aperture
> byte swapping correctly.

Yep. same solution as above i guess.

Sound is also messed up, i guess it is also an endianess issue, but most
probably due to endianess issue in the VT82Cxx driver, and no other
powerpc box should use this, i think.

Thanks.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.

From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: radeonfb on pegasos powerpc motherboard
	and X endianess problem
Date: 04 Jun 2003 17:27:00 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1054740419.27389.332.camel@thor.holligenstrasse29.lan>
References: <20030604145423.GA22876@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [195.141.226.27] (helo=netline-mail1.netline.ch)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19NaAM-00059I-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 04 Jun 2003 08:27:06 -0700
In-Reply-To: <20030604145423.GA22876@iliana>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 2003-06-04 at 16:54, Sven Luther wrote:
>=20
> I finally have a working pegasos motherboard as well as a working kernel
> with a 1.6 radeonfb. I have also installed Daniel Stone's X 4.3.0
> debian/sid packages, and notice the following :
>=20
>   1) radeonfb works fine in 8bpp and 32bpp but depth 15 and 16 only give
>   me some very dark grey.
>=20
>   2) when running X with the UseFBDev option the colors are bad, i guess
>   it is an endianess problem. (with and without accel)

You want radeonfb from a recent benh kernel, anything else is more or
less broken.

>   3) When running X without the UseFBDev option, the colors are good,
>   but i get garbage when i return to the console. Not exactly garbage,
>   at first it is ok, but when i enter a line or somehow pan the screen,
>   the corruption start. Doing a vt switch and back redraws a clean
>   screen.

Sounds like the radeon driver doesn't restore the framebuffer aperture
byte swapping correctly.


--=20
Earthling Michel D=E4nzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.

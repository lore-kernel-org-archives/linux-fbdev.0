From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: X endianess problem
Date: 13 Jun 2003 18:57:16 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1055523436.1863.104.camel@thor.holligenstrasse29.lan>
References: <200306131005.h5DA5Qp00126@panix3.panix.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [195.141.226.27] (helo=netline-mail1.netline.ch)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Qrrc-0007TB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 Jun 2003 09:57:20 -0700
In-Reply-To: <200306131005.h5DA5Qp00126@panix3.panix.com>
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
To: Jochen Roth <jochen@panix.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 2003-06-13 at 12:05, Jochen Roth wrote:
>=20
> > > BTW, based on my debug output X never turns off the accelerator. Is
> > > that OK?
> >=20
> > fbdevHWMapMMIO() in 4.3.0 seems to disable it.

Whoops, I just realize the fbdev driver doesn't use fbdevHWMapMMIO()...
maybe it's harmless to leave it enabled as long as you don't use the
accelerator yourself then.


> I also would have expected for the X server to just go and talk to
> the fbdev kernel driver, instead of still mucking with the hardware
> directly.=20

That's the idea. The fbdev driver doesn't even know how to talk to any
hardware directly. On the other hand, the X server itself may still
insist on fiddling with things like the PCI config space, but I wouldn't
expect that to cause a mode change...


--=20
Earthling Michel D=E4nzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5

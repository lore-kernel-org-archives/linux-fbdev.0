From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: X endianess problem
Date: 13 Jun 2003 11:27:38 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1055496457.1853.88.camel@thor.holligenstrasse29.lan>
References: <200306101104.h5AB40k12305@panix3.panix.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [195.141.226.27] (helo=netline-mail1.netline.ch)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19QkqU-0004ya-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 Jun 2003 02:27:42 -0700
In-Reply-To: <200306101104.h5AB40k12305@panix3.panix.com>
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

On Tue, 2003-06-10 at 13:04, Jochen Roth wrote:=20
> I just finished reading through the radeonfb/endianness thread. I am
> working on an old IBM PReP thin client with an S3 Trio64V2/DX.
>=20
> I started out with 2.4.19 from kernel.org and added startup code and
> some patches for prep_pci.c etc. I am testing this under XFree86
> 4.1.0.1 with the fbdev module, current stable ppc off of debian.org.
>=20
> I got the 16bit console stuff working by byte-swapping the packed
> rgb words in the _setcolreg handler. Same code basically as in the
> clgenfb.c, for instance.
>=20
> Neither X nor fbi get the byte order right, though.

I think they just assume native byte order.


> BTW, based on my debug output X never turns off the accelerator. Is
> that OK?

fbdevHWMapMMIO() in 4.3.0 seems to disable it.


> The hardware documentation for my chip says that there is supposed to
> be an endian-swapped mapping for the frame buffer, essentially the
> second 32MB of the 64MB total bar0. As far as I can tell this second
> mapping does not byte-swap the video buffer.

Well, there's no single byte swapping working for all cases, maybe you
need to configure it by writing to some register(s)?

If there's indeed no way to have the hardware handle the byte order,
you'd probably have to fix each app. Should be relatively easy in the X
fbdev driver by using a special shadowUpdate function.


--=20
Earthling Michel D=E4nzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5

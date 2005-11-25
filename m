From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: RFC: bitmap line alignment
Date: Fri, 25 Nov 2005 20:36:39 +0800
Message-ID: <43870557.2090005@gmail.com>
References: <438700A3.3070503@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Efcou-0004vS-Bn
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Nov 2005 04:36:52 -0800
Received: from wproxy.gmail.com ([64.233.184.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Efcot-00005l-HG
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Nov 2005 04:36:52 -0800
Received: by wproxy.gmail.com with SMTP id i24so1274922wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 25 Nov 2005 04:36:50 -0800 (PST)
In-Reply-To: <438700A3.3070503@t-online.de>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Knut Petersen <Knut_Petersen@t-online.de>

Knut Petersen wrote:
> Hi everybody
>=20
> I learned the hard way that image->width*image->height is not equal to =
the
> number of bits consumed by the image bitmap. Every single line of bits =
is
> aligned to a byte boundary.
>=20
> Wouldn=B4t it be much more efficient to align every line to an u32 boun=
dary?
> Despite the obvious advantages of aligned cpu access to large arrays it
> would also help to simplify the code for at least the cyberblade
> acceleration
> engine.

If you create your own info->pixmap and an info->pixmap.scan_align =3D 4,=
 the
driver will be fed a bitmap that have a scanline that is 32-bit aligned.
The default if you don't specify anything, of course, will be an 8-bit
aligned bitmap which, for the sake of code efficiency, is the alignment
assumed by the cfb_* drawing functions.

(An example usage is in the patch I attached just a few days ago when
I commented how the cyberblade should be intelligent enough to handle
bitmaps with variable widths.)
>=20
> The cyberblade always requires 32 bit quantities, so if the width of th=
e
> image
> is eg. 33, I have to feed _two_ u32 to it for every pixel line. Is the
> same true
> for other acceleration engines?

Yes, nvidiafb, rivafb and savagefb all require a scan_align of 4, the
i810fb needs u16 (scan_align =3D 2).

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick

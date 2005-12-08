From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: scroll modes
Date: Fri, 09 Dec 2005 04:57:17 +0800
Message-ID: <43989E2D.8030308@gmail.com>
References: <438D9E60.7040007@t-online.de> <Pine.LNX.4.62.0511301347230.2123@pademelon.sonytel.be> <438DE211.2060900@t-online.de> <438E0E23.2000203@gmail.com> <43902813.2010604@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkTFu-0001Ni-1y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 13:24:46 -0800
Received: from xproxy.gmail.com ([66.249.82.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkTFt-0000ad-JA
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 13:24:46 -0800
Received: by xproxy.gmail.com with SMTP id s6so502454wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 08 Dec 2005 13:24:45 -0800 (PST)
In-Reply-To: <43902813.2010604@t-online.de>
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
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

Knut Petersen wrote:
> Hi Tony
>=20
> first of all, in updatescrollmode we introduce a the local fh, but late=
ron
> vc->vc_font.height is often read again. Fixing that would be a cosmetic
> change, as
> the compiler should optimize that anyway.
>=20
>> diff --git a/drivers/video/console/fbcon.c
>> b/drivers/video/console/fbcon.c
>> index 1a8f0ea..5ebe68f 100644
>> --- a/drivers/video/console/fbcon.c
>> +++ b/drivers/video/console/fbcon.c
>> @@ -1972,12 +1972,6 @@ static __inline__ void updatescrollmode(
>>     int fast_imageblit =3D (cap & FBINFO_HWACCEL_IMAGEBLIT) &&
>>         !(cap & FBINFO_HWACCEL_DISABLED);
>>
>> -    p->vrows =3D vyres/fh;
>> -    if (yres > (fh * (vc->vc_rows + 1)))
>> -        p->vrows -=3D (yres - (fh * vc->vc_rows)) / fh;
>> -    if ((yres % fh) && (vyres % fh < yres % fh))
>> -        p->vrows--;
>> -
>>     if (good_wrap || good_pan) {
>>         if (reading_fast || fast_copyarea)
>>             p->scrollmode =3D good_wrap ?
>> @@ -1991,6 +1985,16 @@ static __inline__ void updatescrollmode(
>>         else
>>             p->scrollmode =3D SCROLL_REDRAW;
>>     }
>> +
>> +    p->vrows =3D vyres/fh;
>> =20
>>
> ok, does not change anything.
>=20
>> +
>> +    if (p->scrollmode !=3D SCROLL_WRAP_MOVE &&
>> +        (yres > (fh * (vc->vc_rows + 1))))
>> +            p->vrows -=3D (yres - (fh * vc->vc_rows)) / fh;
>> +
>> =20
>>
> 1024x768, vyres 2048, seems to  work with and without that extra
> "p->scrollmode !=3D SCROLL_WRAP_MOVE", but could you please
> explain when  "yres > (fh * (vc->vc_rows + 1))" will be true?

If console window size is less than display resolution.  For example,
1024x768 with 8x16 font will have rows =3D=3D 48.  It is possible to do a=
n
stty rows 40 and still maintain a 1024x768 resolution, ie vesafb.

>=20
>> +    if ((yres % fh) && (vyres % fh < yres % fh))
>> +        p->vrows--;
>> =20
>>
> ok, does not change anything.
>=20
> Further comments to updatescrollmode:
>=20
>      int good_wrap =3D (cap & FBINFO_HWACCEL_YWRAP) &&
>              divides(ywrap, vc->vc_font.height) &&
>              divides(vc->vc_font.height, vyres);
>=20
> is broken as it does not check that vyres * vxres =3D=3D whole availabl=
e video
> memory.

The driver's check_var should have done that for you.

> Or is there hardware that has an adjustable wrap address? Hmm, I
> even can think of a way to reprogram the cyberblade/i1 to wrap at the 1=
, 2,
> 4 or 8MB boundaries while the system is running.
>=20
> Even if that additional check would be introduced it would have problem=
s
> - with drivers like vesafb that do not map all available memory
> - with drivers that do not know about all available memory
> - with drivers that allow users to specify arbitraty values for the
> video memory size.

When that happens, the driver should disable ywrap by setting ywrapstep t=
o
zero, or clearing the HWACCEL_YWRAP flag during set_par.

>=20
> I don=B4t like the whole concept of updatescrollmode based on the evalu=
ation
> of various flags, asumptions and values.
>=20
> Scrolling with YWRAP_MOVE is faster than scrolling with YPAN_MOVE,
> often much faster. Execution time of  a "cat testfile" drops for mode
> 1024x768-32
> from 1.225s to 0.835s with cyblafb.
>=20
> But I don=B4t like that the bottom status line of my curses based edito=
r
> jumps while
> scrolling up/down. So I have several options:
>=20
>  - Don=B4t use ywrap scrolling
>  - Ignore the anoying flicker of the base line
>  - change the working YWRAP_MOVE
>  - submit an alternative YWRAP_SOMETHING

You can implement YWRAP_REDRAW.  As mentioned in fbcon.h, this is the
scrollmode that is not implemented yet. You can also optimize=20
SCROLL_WRAP_MOVE so it eliminates extra blits.

>=20
> But how should that YWRAP_SOMETHING be selected by updatescrollmode?
> The individual driver does know best about the hardware about user
> preferences
> and of the supported scroll modes in any situation.

See fbcon.h. For example to prefer YWRAP_REDRAW from YWRAP_MOVE, one
can clear the HWACCEL_COPYAREA and set HWACCEL_IMAGEBLIT.


Tony



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick

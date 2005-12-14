From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: [PATCH 1/1: 2.6.15-rc5-git3] Fixed and
 updated CyblaFB
Date: Thu, 15 Dec 2005 06:43:30 +0800
Message-ID: <43A0A012.9070300@gmail.com>
References: <439EF4CB.8030007@t-online.de> <43A03568.6010602@gmail.com> <43A06771.6060808@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmfLV-0000i3-Se
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Dec 2005 14:43:37 -0800
Received: from zproxy.gmail.com ([64.233.162.199])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EmfLV-0003qA-Gy
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Dec 2005 14:43:38 -0800
Received: by zproxy.gmail.com with SMTP id o1so243665nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 14 Dec 2005 14:43:34 -0800 (PST)
In-Reply-To: <43A06771.6060808@t-online.de>
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
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Antonino Daplas wrote:
>=20
>> But current users of cyblafb will be affected if your patch
>> does have a problem.
>>
>> =20
>>
> They definitely will be affected when they lock their system
> while trying rotation options ...

You can always divide the patch into bug fix and feature addition.
The bug fix goes to mainline, the feature addition goes into trial.

It's also easier to spot regressions if you divide the patch into
logical parts. For example, the recent atyfb update was composed of
10 different patches, each doing 1 logical thing.

>=20
>>> +    // That should never happen, but it would be fatal
>>>  =20
>>
>> It won't :-)
>>
>> =20
>>
> The graphics engine would not react kindly, and it does not really hurt=
.
>=20
>>> +    if (image->width =3D=3D 0 || image->height =3D=3D 0) {
>>> +        output("imageblit: width/height 0 detected\n");
>>> +        return;
>>> +    }
>>> +
>>> +    if (bpp < 8 || bpp > 32 || bpp % 8 !=3D 0 ||
>>> +                   info->pixmap.scan_align > 4 ) {
>>>  =20
>> Why this paranoid check?  The check_var() function already
>> guaranteed that these conditions will not happen.
>>
>> =20
>>
> Yes, I am a bit paranoid. That paranoia led to the discovery of some bu=
gs
> nobody knew or cared about. But you are right, this check might be a bi=
t
> too
> paranoid.

Well yes.  But this is a fast path that will affect performance.  And the
check will tend to hide bugs than reveal them (though you do have a print=
k
function).  And thirdly, cfb_imageblit does not support scan_align !=3D 1=
.

>=20
>> Do you really have to support scan_align 1 and 2?  Why not just stick
>> with scan_align of 4, the code is so much easier to understand? I can'=
t
>> find anything useful with this, even for debugging.
>>
>> =20
>>
> Well, you are shure that there is really not a single bug left in the
> bitmap construction
> code? And that the code will never be touched again because it already
> is optimal? I
> think support for all alignment possibilities will be handy in the near
> future, and
> although it could be hidden by an #ifdef or stay a private patch, I
> prefer to include it.

It's the same code whether you use scan_align of 1, 2, 4, 8, 16, etc. So,
I still don't see any benefit. You even confused akpm et al at what it do=
es,
why you need to cast with u32. (It's because the accelerator needs u32
values, but supporting scan_align 1 and 2 means the bitmap becomes aligne=
d
at u8 and u16 boundaries).

>=20
> Currently bitmap construction takes longer than blitting the image to
> the screen with
> cyblafb, and I think I will have a very close look at that code soon.
>=20
> BTW, something fundamental: Isn=B4t the pixelmap alignment really a
> property of the
> image bitmap like the depth of the image data?

No, it's the property of the accelerator.

>=20
>>> +    // try to be smart about (x|y)res(_virtual) problems.
>>> +    //
>>> +    if (var->xres % 8 !=3D 0)
>>>        return -EINVAL;
>>>  =20
>>
>> Isn't this too much?  Why not var->xres =3D (var->xres + 7) & ~7?
>>
>> =20
>>
> Do you really think that this is a good idea? I would like to ease the
> use of
> e.g. fbset in scripts by returning -EINVAL when something as fundamenta=
l as
> the selected xres is not acceptable. Ok, it=B4s always possible to pars=
e
> the output
> of fbset -s  in those cases.

That has always been the (not often followed) rule - Round up if you can,
return -EINVAL if you can't.  Because with most user apps, finding the be=
st
mode involves many iterations of FB_ACTIVATE_TEST, so that particular met=
hod
will be speeded up if you give working values rather than -EINVAL.  And y=
es,
properly working fb apps will check the contents of fb_var_screeninfo eve=
n if
the check_var returns success.

If your user will set something crazy like 799x600, might as well give hi=
m
an 800x600. As long as you use values that are higher than requested,
it won't hurt.=20

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick

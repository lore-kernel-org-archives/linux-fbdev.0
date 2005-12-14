From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Re: [PATCH 1/1: 2.6.15-rc5-git3] Fixed and
 updated CyblaFB
Date: Wed, 14 Dec 2005 19:41:53 +0100
Message-ID: <43A06771.6060808@t-online.de>
References: <439EF4CB.8030007@t-online.de> <43A03568.6010602@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmbYo-00038q-Mt
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Dec 2005 10:41:06 -0800
Received: from mailout06.sul.t-online.com ([194.25.134.19])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EmbYn-00071F-Ts
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Dec 2005 10:41:06 -0800
In-Reply-To: <43A03568.6010602@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Antonino Daplas wrote:

>But current users of cyblafb will be affected if your patch
>does have a problem.
>
> =20
>
They definitely will be affected when they lock their system
while trying rotation options ...

>>+    // That should never happen, but it would be fatal
>>   =20
>>
>
>It won't :-)
>
> =20
>
The graphics engine would not react kindly, and it does not really hurt.

>>+    if (image->width =3D=3D 0 || image->height =3D=3D 0) {
>>+        output("imageblit: width/height 0 detected\n");
>>+        return;
>>+    }
>>+
>>+    if (bpp < 8 || bpp > 32 || bpp % 8 !=3D 0 ||
>>+                   info->pixmap.scan_align > 4 ) {
>>   =20
>>
>Why this paranoid check?  The check_var() function already
>guaranteed that these conditions will not happen.
>
> =20
>
Yes, I am a bit paranoid. That paranoia led to the discovery of some bugs
nobody knew or cared about. But you are right, this check might be a bit =
too
paranoid.

>Do you really have to support scan_align 1 and 2?  Why not just stick
>with scan_align of 4, the code is so much easier to understand? I can't
>find anything useful with this, even for debugging.
>
> =20
>
Well, you are shure that there is really not a single bug left in the=20
bitmap construction
code? And that the code will never be touched again because it already=20
is optimal? I
think support for all alignment possibilities will be handy in the near=20
future, and
although it could be hidden by an #ifdef or stay a private patch, I=20
prefer to include it.

Currently bitmap construction takes longer than blitting the image to=20
the screen with
cyblafb, and I think I will have a very close look at that code soon.

BTW, something fundamental: Isn=B4t the pixelmap alignment really a=20
property of the
image bitmap like the depth of the image data?

>>+    // try to be smart about (x|y)res(_virtual) problems.
>>+    //
>>+    if (var->xres % 8 !=3D 0)
>>        return -EINVAL;
>>   =20
>>
>
>Isn't this too much?  Why not var->xres =3D (var->xres + 7) & ~7?
>
> =20
>
Do you really think that this is a good idea? I would like to ease the=20
use of
e.g. fbset in scripts by returning -EINVAL when something as fundamental =
as
the selected xres is not acceptable. Ok, it=B4s always possible to parse=20
the output
of fbset -s  in those cases.

>>+    if (var->xres_virtual % 8 !=3D 0)
>>+        var->xres_virtual &=3D ~7;
>>   =20
>>
>
>Or just var->xres_virtual &=3D ~7 without the if (...)
> =20
>
Yes. That saves a few bytes.

>Wrong boolean check?  Should be if (vesafb & 4). Or might as
>well get rid of this check, it's redundant.
>
>Shouldn't this be if (vesafb & 4)?
> =20
>
>and this...
>
> =20
>
>and this...?
> =20
>
No, no, no, no.

cu,
 Knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick

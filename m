From: Jon Smirl <jonsmirl@gmail.com>
Subject: Choosing the correct framebuffer configuration
Date: Fri, 5 Aug 2005 21:47:24 -0400
Message-ID: <9e473391050805184756f055ea@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1Dmi-00077b-4d
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Aug 2005 18:47:36 -0700
Received: from wproxy.gmail.com ([64.233.184.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1Dmh-0000Iq-0T
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Aug 2005 18:47:36 -0700
Received: by wproxy.gmail.com with SMTP id i17so242870wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Aug 2005 18:47:24 -0700 (PDT)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

If I understand things correctly the framebuffer config is supposed to
be controlled by the transp/red/blue/green fields of fb_var_screeninfo
during check_var. These fields are then combined to compute the
bits_per_pixel.

radeonfb is working from the other direction, it starts with bpp and
then computes ARGB. This looks wrong to me.

Radeonfb supports these four configs controlled by setting BPP:
DST_8BPP =3D 8BPP indexed
DST_15BPP =3D ARGB1555
DST_16BPP =3D RGB565
DST_32BPP =3D ARGB8888

The chips actually allow nine configs (maybe more when I get a look at
the R300 doc). It is ambiguous to set these configs based on BPP since
there are multiple configs for various BPP. These configs should
instead be set with the transp/red/blue/green fields.

4bpp Index =3D /4
8bpp Index =3D /8
16bpp aRGB 1555 =3D 1/5/5/5
16bpp RGB 565 =3D /5/6/5
16bpp aRGB 4444 =3D 4/4/4/4
16bpp aIndex 88 =3D 8/8
24bpp RGB 888 =3D /8/8/8
32bpp aRGB 8888 =3D 8/8/8/8
32bpp aRGB 2:10:10:10 =3D 2/10/10/10

What is the best way to fix this? The interesting hidden config is 30b colo=
r.

I can hack it in by using ARGB if BPP is zero and the old scheme if BPP is =
set.

Do other fbdev drivers have this problem?

BTW, Xserver is limited to six of the nine configs.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

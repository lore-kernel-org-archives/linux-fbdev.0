From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Monitor failing mode validation in fb_validate_mode()
Date: Mon, 25 Apr 2005 14:00:09 -0400
Message-ID: <9e473391050425110026dfc351@mail.gmail.com>
References: <9e4733910504251003da4d47e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQ7so-0005k4-19
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Apr 2005 11:00:34 -0700
Received: from wproxy.gmail.com ([64.233.184.202])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DQ7sX-00072P-Fa
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Apr 2005 11:00:33 -0700
Received: by wproxy.gmail.com with SMTP id 69so1326078wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Apr 2005 11:00:09 -0700 (PDT)
In-Reply-To: <9e4733910504251003da4d47e@mail.gmail.com>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

This fixes the problem for me, it rounds hfreq to nearest KHz and
preserves hard dot clock limit.

=3D=3D=3D=3D=3D fbmon.c 1.22 vs edited =3D=3D=3D=3D=3D
--- 1.22/drivers/video/fbmon.c  2005-03-31 06:06:52 -05:00
+++ edited/fbmon.c      2005-04-25 13:58:13 -04:00
@@ -1242,6 +1242,8 @@
                vtotal *=3D 2;

        hfreq =3D pixclock/htotal;
+       hfreq =3D (hfreq + 500) / 1000 * 1000;
+
        vfreq =3D hfreq/vtotal;

        return (vfreq < vfmin || vfreq > vfmax ||



--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

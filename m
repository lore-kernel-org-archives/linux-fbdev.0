From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: mono, gray and index configs
Date: Fri, 19 Aug 2005 23:09:55 -0400
Message-ID: <9e473391050819200950020d7@mail.gmail.com>
References: <9e47339105081020216574ac7e@mail.gmail.com>
	 <42FAE3F8.8080902@gmail.com>
	 <Pine.LNX.4.62.0508111020520.1037@numbat.sonytel.be>
	 <b00ca3bd05081104086fa9e639@mail.gmail.com>
	 <Pine.LNX.4.62.0508111344070.1037@numbat.sonytel.be>
	 <42FB8C29.4070503@gmail.com>
	 <9e47339105081112142c67e1a8@mail.gmail.com>
	 <9e473391050819181321f2cfe5@mail.gmail.com> <43069BE0.80604@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E6JkC-0001qG-G1
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 20:10:04 -0700
Received: from wproxy.gmail.com ([64.233.184.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E6JkC-00045W-47
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 20:10:04 -0700
Received: by wproxy.gmail.com with SMTP id i3so668145wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Aug 2005 20:09:55 -0700 (PDT)
In-Reply-To: <43069BE0.80604@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

The patch is just for testing, don't send it on. The radeonfb portion
is definitely not finished.

This adds an optional function to each driver that advertises what
configs it offers.

+char *radeonfb_getconfigs(struct fb_info *info)
+{
+=09return "I4\nI8\nA1R5G5B5\nR5G6B5\nR8G8B8\nA8R8G8B8\nA4R4G4B4\nA8I8\nA2R=
10G10B10\n";
+}
=20
  static struct fb_ops radeonfb_ops =3D {
 =09.owner=09=09=09=3D THIS_MODULE,
@@ -1873,6 +1909,7 @@ static struct fb_ops radeonfb_ops =3D {
 =09.fb_fillrect=09=09=3D radeonfb_fillrect,
 =09.fb_copyarea=09=09=3D radeonfb_copyarea,
 =09.fb_imageblit=09=09=3D radeonfb_imageblit,
+=09.fb_get_configs=09=09=3D radeonfb_getconfigs,
 };

If you know what configs the driver support try setting them via the
sysfs attribute. You can also check out your config match code by
putting in non-supported configs and setting what gets returned in the
attribute.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

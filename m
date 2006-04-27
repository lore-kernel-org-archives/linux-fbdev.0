From: "Jorge Luis Zapata Muga" <jorgeluis.zapata@gmail.com>
Subject: geode problem
Date: Thu, 27 Apr 2006 03:06:19 +0200
Message-ID: <eb77d7060604261806y4faa1107l5464316fa005266e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FYuxa-0005lh-MY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Apr 2006 18:06:22 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FYuxa-0001VL-CC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Apr 2006 18:06:22 -0700
Received: from pproxy.gmail.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FYuxZ-00075Y-04
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Apr 2006 18:06:22 -0700
Received: by pproxy.gmail.com with SMTP id i49so1902031pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Apr 2006 18:06:19 -0700 (PDT)
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
To: linux-fbdev-devel@lists.sourceforge.net

hi all,
i have a problem with the geodefb driver. my board is a GX1 (GXm?)
with a CS5530 chipset. the problem itself can be seen here:
http://room42.hisham.cc/~jl/files/gx1_sshot1.jpg
http://room42.hisham.cc/~jl/files/gx1_sshot2.jpg
http://room42.hisham.cc/~jl/files/gx1_sshot3.jpg

on the third picture, there should be a gradient on the middle of the
monitor, but theres only half of it.
i dont know exactly what is the source of the problem. i already had
several issues with this board and the fb. im trying to debug
comparing the registers of this driver with the old one (kernel 2.4,
wich correctly works, only a couple of scroll issues) and i dont see
any usefull difference. i fill up a FIXME on the driver where the
GP_BLT_STATUS register should be set (screen width and bpp mode), i
set it and then the "garbage window" of the above pictures was
"resized" to almost all the screen.

does someone has any idea about this kind of error? as a note, making
a few fbset + vt switch  make the screen to display correctly, but
only once, i cant reproduce it again.

thanks for your help
regards,


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

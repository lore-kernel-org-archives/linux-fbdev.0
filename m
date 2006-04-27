From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: geode problem
Date: Thu, 27 Apr 2006 23:32:34 +0800
Message-ID: <4450E412.9080801@gmail.com>
References: <eb77d7060604261806y4faa1107l5464316fa005266e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZ8Ty-0001bk-U8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Apr 2006 08:32:42 -0700
Received: from pproxy.gmail.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZ8Tx-0004uW-Jl
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Apr 2006 08:32:43 -0700
Received: by pproxy.gmail.com with SMTP id i49so2106351pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Apr 2006 08:32:39 -0700 (PDT)
In-Reply-To: <eb77d7060604261806y4faa1107l5464316fa005266e@mail.gmail.com>
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
Cc: jorgeluis.zapata@gmail.com

Jorge Luis Zapata Muga wrote:
> hi all,
> i have a problem with the geodefb driver. my board is a GX1 (GXm?)
> with a CS5530 chipset. the problem itself can be seen here:
> http://room42.hisham.cc/~jl/files/gx1_sshot1.jpg
> http://room42.hisham.cc/~jl/files/gx1_sshot2.jpg
> http://room42.hisham.cc/~jl/files/gx1_sshot3.jpg
> 
> on the third picture, there should be a gradient on the middle of the
> monitor, but theres only half of it.
> i dont know exactly what is the source of the problem. i already had
> several issues with this board and the fb. im trying to debug
> comparing the registers of this driver with the old one (kernel 2.4,
> wich correctly works, only a couple of scroll issues) and i dont see
> any usefull difference. i fill up a FIXME on the driver where the
> GP_BLT_STATUS register should be set (screen width and bpp mode), i
> set it and then the "garbage window" of the above pictures was
> "resized" to almost all the screen.
> 
> does someone has any idea about this kind of error? as a note, making
> a few fbset + vt switch  make the screen to display correctly, but
> only once, i cant reproduce it again.
> 
>

What does fbset -i in 2.4 and 2.6 say?

Tony


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

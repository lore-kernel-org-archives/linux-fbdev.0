From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: framebuffer ioctl
Date: Wed, 8 Sep 2004 01:43:42 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <9e47339104090722437b81b373@mail.gmail.com>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be>
	 <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net>
	 <200409060926.07163.adaplas@hotpop.com> <413CC0EA.8070709@comcast.net>
	 <9e4733910409061402372095b1@mail.gmail.com>
	 <1094505860.31465.211.camel@admin.tel.thor.asgaard.local>
	 <9e47339104090707172cdc258d@mail.gmail.com>
	 <1094572321.6095.10.camel@admin.tel.thor.asgaard.local>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4vFA-0003Lp-4a
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 22:43:44 -0700
Received: from rproxy.gmail.com ([64.233.170.194] helo=mproxy.gmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4vF9-00007h-DX
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 22:43:44 -0700
Received: by mproxy.gmail.com with SMTP id 77so243341rnl
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Sep 2004 22:43:42 -0700 (PDT)
In-Reply-To: <1094572321.6095.10.camel@admin.tel.thor.asgaard.local>
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

On Tue, 07 Sep 2004 11:52:00 -0400, Michel D=E4nzer <michel@daenzer.net> wr=
ote:
> All I'm saying is that it reflects badly on you if you need to resort to
> skewed numbers.

I don't think they are skewed. Most desktops today have hardware
OpenGL and software Render. The ratios are an accurate reflection of
what a normal user would see when comparing Cairo on X vs Cairo on
OpenGL. You may try to change the platform in the future but hardware
Render is not deployed anywhere currently.

Even KeithP says he would rather be on OpenGL than to continue
accelerating Render functions and he designed Render. The argument is
not about the technical merits of Render vs OpenGL, it's about the
fact that OpenGL is a widely available standard that is well
documented. Thousands of people can program to the OpenGL APL while
only very few know about Render. Let's stand on the shoulders of other
programmers (you're one of them since you helped with mesa) rather
than build everything again.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click

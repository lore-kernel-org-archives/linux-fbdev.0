From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: framebuffer ioctl
Date: Tue, 07 Sep 2004 11:52:00 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1094572321.6095.10.camel@admin.tel.thor.asgaard.local>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be>
	 <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net>
	 <200409060926.07163.adaplas@hotpop.com> <413CC0EA.8070709@comcast.net>
	 <9e4733910409061402372095b1@mail.gmail.com>
	 <1094505860.31465.211.camel@admin.tel.thor.asgaard.local>
	 <9e47339104090707172cdc258d@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4uTB-00045V-Nd
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 21:54:09 -0700
Received: from [63.144.52.41] (helo=080relay.CIS.CIS.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C4uTB-0002rx-0R
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 21:54:09 -0700
In-Reply-To: <9e47339104090707172cdc258d@mail.gmail.com>
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

On Tue, 2004-09-07 at 10:17 -0400, Jon Smirl wrote:
> The numbers compare two peices of software that exist.  Sure you could
> probably write a super optimized library for CPU based drawing in 2D
> mode that would be faster, but this library doesn't exist. No matter
> what you do using the GPU to draw is always going to beat using the
> CPU by a wide margin because of the memory bandwidth difference.
>=20
> Would Cairo on hardware OpenGL vs Cairo on software only OpenGL be a
> better comparison? Those ratios are even worse.

Examples of fair comparisons would be:

Software rendered OpenGL vs. software rendered Render extension
Hardware-accelerated OpenGL vs. hardware-accelerated Render extension
...

> Why does everyone want to write another accelerated drawing library
> when we already have a really good one that follows standards and has
> excellent documentaition? Why not help integrate DRM and fbdev
> instead.

All I'm saying is that it reflects badly on you if you need to resort to
skewed numbers.


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click

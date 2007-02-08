From: James Simmons <jsimmons@infradead.org>
Subject: Re: intelfb not working on Thinkpad R60
Date: Thu, 8 Feb 2007 18:56:56 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702081850460.7686@pentafluge.infradead.org>
References: <eqeuc6$irv$1@sea.gmane.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1831524198-349855714-1170961016=:7686"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFESD-0002Wy-WA for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 10:57:10 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HFESB-0008Cv-DI
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 10:57:09 -0800
In-Reply-To: <eqeuc6$irv$1@sea.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Marcus Better <marcus@better.se>
Cc: linux-fbdev-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1831524198-349855714-1170961016=:7686
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



>*First, if I compile intelfb and fbcon into the kernel, and no other=20
>frame buffer modules, I don't think the "vga" parameter is ever=20
>processed. I get a blank console and the famous message =A0 intelfb: Vid=
eo=20
>mode must be programmed at boot time. in the log.

That is correct vga=3D is only used by vga console or vesafb. What vga=3D=
 does=20
is pass a mode that the BIOS can set.

>(Side question: Should CONFIG_VIDEO_SELECT really depend on
>CONFIG_VGA_CONSOLE?)

No. CONFIG_VIDEO_SELECT is used with vesafb as well.

>*If I additionally compile in the vesafb driver, then it seems to grab=20
>the console despite the "video=3Dintelfb:..." command line argument, and=
 I=20
>get a working vesafb console.

That is correct behavior. If the native driver fails then vesafb will=20
start. I bet the mode you can passing is incomplete. Please try=20
something like this

video=3Dintelfb:mode:1024x768-8@75

---1831524198-349855714-1170961016=:7686
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
---1831524198-349855714-1170961016=:7686
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---1831524198-349855714-1170961016=:7686--

From: "ankur maheshwari" <ankur_maheshwari@procsys.com>
Subject: Re: how to enable logo
Date: Mon, 11 Sep 2006 11:14:20 +0530
Message-ID: <003701c6d565$55025ff0$f301a8c0@procsys>
References: <0ab101c69042$ed73d330$f301a8c0@procsys><Pine.LNX.4.62.0606151037450.19321@pademelon.sonytel.be><005601c6cb7b$bd9592b0$f301a8c0@procsys><Pine.LNX.4.62.0608291700130.3907@pademelon.sonytel.be><021b01c6d292$94469670$f301a8c0@procsys>
	<Pine.LNX.4.62.0609071745120.8714@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GMeWO-0000r2-Mw for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Sep 2006 22:39:52 -0700
Received: from [61.95.199.26] (helo=mailsvr.procsys.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GMeWN-0005jz-QQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Sep 2006 22:39:52 -0700
Received: from ankurmaheshwari ([192.168.1.243])
	by mailsvr.procsys.com (8.12.10/8.12.10) with SMTP id k8B5bxrQ007692
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 11 Sep 2006 11:08:00 +0530
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi Geert,

I have only one cpu on my board.

Logo is coming some thing like following

--------------------------------
logo   logo   logo   logo  |
                                     |
                                     |
                                     |
--------------------------------
After few seconds

--------------------------------
                                       |
                                       |
                                       |
logo   logo   logo    logo   |
---------------------------------

Is there any issue with scrolling, I feel I need to go through the code
where logo is shown .... fb_show_logo();

thanks
Ankur




----- Original Message -----
From: "Geert Uytterhoeven" <geert@linux-m68k.org>
To: "Linux Frame Buffer Device Development"
<linux-fbdev-devel@lists.sourceforge.net>
Sent: Thursday, September 07, 2006 9:15 PM
Subject: Re: [Linux-fbdev-devel] how to enable logo


> On Thu, 7 Sep 2006, ankur maheshwari wrote:
> > Also console is showing multiple logos, running horizontally and
vertically.
>
> Wow, it should draw one logo for each CPU you have. How many CPUs do you
have?
>
> Gr{oetje,eeting}s,
>
> Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
But
> when I'm talking to journalists I just say "programmer" or something like
that.
>     -- Linus Torvalds
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

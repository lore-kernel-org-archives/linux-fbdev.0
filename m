From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: problem setting up a rivafb driver for GUI Applcations
Date: Tue, 21 Sep 2004 18:44:53 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409211844.53873.adaplas@hotpop.com>
References: <4EE0CBA31942E547B99B3D4BFAB34811107BAE@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9i90-0007mD-L3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Sep 2004 03:45:10 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1C9i8z-0007t4-Hj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Sep 2004 03:45:10 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 75B2E71A4B
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Sep 2004 10:44:53 +0000 (UTC)
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811107BAE@mail.esn.co.in>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, "Mukund JB." <mukundjb@esntechnologies.co.in>

On Tuesday 21 September 2004 17:53, Mukund JB. wrote:
> Hai all ,
>
> I think u can help me in regard to setting up fb driver for GUI
> applications.
>
>
>
> I have a Nvidia Riva TNT card as a Graphical card on my system. I could
> some how setup a Rivafb driver module on my system manually with debug
> mode enabled. When I switch between consoles, I am able to find that my
> driver ( rivafb) is invoved. It is also invoked when I switch from
> console to GUI /GUI to console mode.
>
>
>
> Here comes my the question/doubt:-
>
>
>
> Why is my rivafb not invoked when ever I open any GUI Application( I
> found no debug mesaages).
>
> I performed some performance tests on Xserver with "x11perf" command
>
> i.e
>
> # X11perf  complex10
>
>
>
> This command does it job and my fb driver is not called even now.
>
> I thought when we run an application on X server, X server will directly
> interacts with the fb driver rather than hardware and so I thought the
> rivafb driver should be called.
>
> Is it like, there are different framebuffer drivers for console as well
> as GUI( I don't thing so).
>
> How do I activate framebuffer for my GUI Applications (X server).
>

You need to tell X to use fbdev.  

Open /etc/X11/XF86Config

In Section "Device", change 

Driver "xxx" <-- probably nv or nvidia

to 

Driver "fbdev"

Restart X.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php

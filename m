From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: how to activate X with famebuffer
Date: Wed, 29 Sep 2004 05:33:51 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409290533.51839.adaplas@hotpop.com>
References: <4EE0CBA31942E547B99B3D4BFAB3481110808C@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CCPen-0005WX-S2
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 28 Sep 2004 14:37:09 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CCPel-0002zJ-6H
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 28 Sep 2004 14:37:09 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id C8FF286B82F
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 28 Sep 2004 21:36:05 +0000 (UTC)
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB3481110808C@mail.esn.co.in>
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
Content-Type: text/plain; charset="utf-8"
To: linux-fbdev-devel@lists.sourceforge.net, "Mukund JB." <mukundjb@esntechnologies.co.in>

On Tuesday 28 September 2004 19:27, Mukund JB. wrote:
>
> ACCORDING TO FRAMEBUFFER DEFINITION :-
> A framebuffer device is an abstraction for the graphic hardware. It
> represents the frame buffer of some video hardware, and allows application
> software to access the graphic hardware through a well=E2=88=92defined in=
terface,
> so that the software doesn't need to know anything about the low=E2=88=92=
level
> interface stuff
>
> This is taken from Geert Uytterhoeven's framebuffer.txt in the linux kern=
el
> sources. In the above definition what is an Application? Is it the X
> server, Applications above it?

'Application' is any process, user or kernel, that directly runs on top of =
the=20
framebuffer. It can be X, or the framebuffer console.  It can be a process=
=20
that totally bypasses X, such as directfb or mplayer -vo fbdev. Any process=
=20
that does not run directly on top of the framebuffer is not considered as=20
part of the 'Application' layer, such as kwrite on X on fbdev, or 'mplayer=
=20
=2Dvo directfb' on directfb on fbdev.

But X on fbdev or direcfb on fbdev or mplayer on fbdev are all considered p=
art=20
of the 'Application' layer.

>
> Suppose there is a kwrite application, obviously running over X server.
> Looking at this angle the flow is as follows:-
>
>
> 	NORMAL Applications ( Kwrite)
> 	-------------------
> 		X Server
> 	-------------------
> 	Framebuffer Driver
> 	-------------------
> 		HARDWARE
>

Yes, above is how it works.  In this case, Kwrite doesn't know a thing abou=
t=20
the framebuffer, as it runs on top of X.  Or more properly, something like=
=20
this:

NORMAL Applications such as X, DirectFB, mplayer, etc
=2D------------------
=46ramebuffer Driver
=2D------------------
HARDWARE

The X server is considered as part of 'NORMAL Applications'.

> Is it Applications like Kwrite should support Framebuffer in order the X
> server makes use of it. If this is the case, the flow will be as follows:-
>
> 	NORMAL Applications (Apps instructs X server - Use fb or don't use)
>    -------------------------
> 		X Server
>    -------------------------
> Framebuffer / NON-Framebuffer
> 		 Driver
>    -------------------------
> 		HARDWARE

No, the above is not the case.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

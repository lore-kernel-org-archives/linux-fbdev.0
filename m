From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Confused about atyfb status.
Date: Sat, 17 Jan 2004 19:36:45 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0401171935320.1950@waterleaf.sonytel.be>
References: <200401170123.23351.alex.kern@gmx.de> <4008B958.7010104@bitworks.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhvJY-0001yl-Du
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 17 Jan 2004 10:36:56 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhvJX-0004p6-T8
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 17 Jan 2004 10:36:56 -0800
In-Reply-To: <4008B958.7010104@bitworks.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Richard Smith <rsmith@bitworks.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 16 Jan 2004, Richard Smith wrote:
> I'm trying to use the atyfb on a Rage Mobility M1 but I'm confused on
> which source tree has the best chance of getting to work.
>
> Grepping through both the 2.4.24 and 2.6.1rc3 tree I find that the
> 2.4.24 tree has several references to a mobility M1 in the comments.
>
> The 2.6.1rc3 tree does not.
>
> Neither tree however has an entry for my device.  Neither will detect m=
y
> device which has an id of 0x4c52.
>
> If I copy one of the "3D RAGE Mobility" id lines and change the clocks
> to what I think they should be the device gets detected but various
> specifications (like ammount and type of RAM) are incorrect.
>
> So if I am about to start hacking on a tree to figure out whats wrong
> what tree should I use?  Where is the most advanced tree for the atyfb
> located?

2.4.24 has the Mobility M1 support, 2.6 hasn't.

BTW, I already forwarded your previous message to Dani=EBl Mantione (who =
did the
M1 support), in case he missed your message on the list. Let's hope he kn=
ows
what's wrong.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

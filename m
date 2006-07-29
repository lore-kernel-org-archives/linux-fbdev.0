From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Cyblafb driver
Date: Sat, 29 Jul 2006 13:30:15 +0200
Message-ID: <44CB46C7.5040908@t-online.de>
References: <20060725200032.BE69A2BEC@ctb-mesg5.saix.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G6mxi-00022w-Bl for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 29 Jul 2006 04:26:30 -0700
Received: from mailout02.sul.t-online.com ([194.25.134.17])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G6mxg-0004JN-Ur
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 29 Jul 2006 04:26:30 -0700
In-Reply-To: <20060725200032.BE69A2BEC@ctb-mesg5.saix.net>
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
To: Gareth Lester-Olivier <gareth@calcom.co.za>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Gareth!

Well, the quality of the video signal is not optimal at 1024x768-32, but
distortions should be hardly noticeable.

Try to keep margins small, this will help a bit (reduced dot clock).

Do you really need 32bpp? The cyberblade/i1 is much faster at 16bpp.

Using a 16bpp mode instead of an otherwise identical 32bpp mode reduces the
internal clock frequency to 50%, thus you will see a _dramatic_ =

improvement in
video signal quality.

What exactly do you mean by "glitches"? I suspect that you see some =

flickering
(fast changes in brightness). Correct?

Have a look at the mainboard. Have a look at2 =

http://en.wikipedia.org/wiki/Capacitor_plague.
Are your caps ok? I had to replace some caps on an epia board some weeks =

ago ;-(

>   on a EPIA (duh) with 128mb PC100, P3 Celeron 1.1ghz.
>
>
Don=B4t know that model, tell me more.

cu,
 Knut


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV

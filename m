From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: Re: [PATCH] matroxfb: another attempt to
 rectify jitter (G450/G550)
Date: Thu, 15 Feb 2007 14:47:27 -0600
Message-ID: <45D4C6DF.5050002@us.ibm.com>
References: <45B55422.4070401@us.ibm.com> <45BC58E9.9020306@vandrovec.name>
	<45BFA90D.5050207@us.ibm.com> <20070131115430.GB5039@sci.fi>
	<45C110F3.10202@us.ibm.com> <20070131222500.GA16283@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHnWK-0008SR-CG for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 12:48:00 -0800
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HHnWH-0000c9-LM
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 12:48:00 -0800
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1FKlS6v013851
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 15 Feb 2007 15:47:28 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1FKlSvY189048 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 15 Feb 2007 15:47:28 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1FKlSLX005968 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 15 Feb 2007 15:47:28 -0500
In-Reply-To: <20070131222500.GA16283@sci.fi>
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
To: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org, Petr Vandrovec <petr@vandrovec.name>

Ville,

Ville Syrj=E4l=E4 wrote:
> I see. It seems to always use VIDPLL with CRTC2. So if DVICLK is to be =

> used with CRTC2 it apparently needs to be added in the VIDPLL case. =

> Hmmm. I wonder if the code even supports CRTC2+DVI because the CRTC2 =

> code seems to leave the C2PIXCLK selection to PCICLK if CRTC2 drives DVI =

> only. Did you try to map CRTC2 to DVI?

So, I just (finally) ran the following tests, on a SLES10 system (2.6.16+) =
with =

G450, both with and without the patch (results were identical):

- with "video=3Dmatroxfb:outputs:012"
                   D-shell               DVI-D
on boot             OK                   junk
X dual fb0/fb1      OK                    OK
X fb0 only         black(!)              junk
X fb1 only        signal problems(!)     OK, but yellow(?)

- with "video=3Dmatroxfb:outputs:021"
                   D-shell               DVI-D
on boot            junk                   OK
X dual fb0/fb1      OK                    OK
X fb0 only         junk                   OK
X fb1 only        OK, but yellow        OK (blank)

Note that I ignored the DVI-A output, which is apparently the first "output=
". =

Earlier testing showed pretty much what I'd expect on that channel.

So, it appears that CRTC2 can indeed drive DVI-D.

It also appears that this area still needs work, but any objections to movi=
ng =

the suggested patch into -mm ?  It provides clean signals and removes the =

platform-specific hacked ifdefs.

-- =

Regards,
Paul Clarke

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV

From: Jim Hague <jim.hague@acm.org>
Subject: Re: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Thu, 09 Jun 2005 15:35:53 +0100 (BST)
Message-ID: <XFMail.20050609153553.jim.hague@acm.org>
References: <Pine.LNX.4.60.0505280126280.22226@poirot.grange>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgO8d-0003TF-25
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Jun 2005 07:36:07 -0700
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DgO8a-0007Yb-F6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Jun 2005 07:36:06 -0700
In-Reply-To: <Pine.LNX.4.60.0505280126280.22226@poirot.grange>
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
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Guennadi,

> Confirmed - with CONFIG_FB_PM2_FIFO_DISCONNECT fb is still orange, with=
out=20
> - no problem.

I've just acquired a GLoria Synergy+ off EBay, and you'll be glad to hear=
 it is
showing the same symptoms that you're seeing. Booting with FIFO_DISCONNEC=
T gies
orange text on black background, 640x480, ignoring the requested video mo=
de.
Depending on the phase of the moon, the 3c905 can't read it's MAC address=
 or
the sound card driver fails to start.

Switching off FIFO_DISCONNECT turns the text white, *but* the other probl=
ems
persist for me. There's definitely something quite horrible going on. I w=
ill be
investigating when I get the time.

--=20
Jim Hague - jim.hague@acm.org          Never trust a computer you can't l=
ift.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you sho=
tput
a projector? How fast can you ride your desk chair down the office luge t=
rack?
If you want to score the big prize, get to know the little guy. =20
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=3D20

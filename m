From: Jim Hague <jim.hague@acm.org>
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Mon, 07 Mar 2005 22:08:32 -0000 (GMT)
Message-ID: <XFMail.20050307220832.jim.hague@acm.org>
References: <Pine.LNX.4.60.0503072119420.6636@poirot.grange>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8QPy-0005YF-P3
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 14:09:38 -0800
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D8QPx-0007Qf-1o
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 14:09:38 -0800
In-Reply-To: <Pine.LNX.4.60.0503072119420.6636@poirot.grange>
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
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Hi Guennadi,

> Thanks for the patch. Yes, it does fix switching between X and VT.

OK, good.

> As for colours / graphics, disabling CONFIG_FB_PM2_FIFO_DISCONNECT fixe=
s
> that too, but it worked under 2.6.10-rc2 with that option on too. What =
does
> it do and why I cannot use it under 2.6.11 any more? The help text to t=
his=20
> option is not very enlightening...

(To be honest, I've never looked closely at this but inherited it from Il=
lo's
2.4 driver. Cue scrabbling around in manuals...)

pm2fb programs the Permedia registers by writing to a FIFO. Normally if y=
ou
attempt to write to the FIFO and the FIFO is full, the write is lost. So =
pm2fb
checks before writing that there is sufficient space in the FIFO to hold =
the
full command sequence, and if not it loops waiting for the FIFO to empty
sufficiently.

Enabling FIFO_DISCONNECT enables PCI Disconnect. In this mode, if a write=
 to
the FIFO occurs when the FIFO is full, the Permedia chip enables PCI Disc=
onnect
which causes the processor to keep retrying the write cycle until the FIF=
O
empties and the write succeeds.

On the one hand this allows faster download to the Permedia because you d=
on't
have to check the FIFO space, but at a cost of hogging the PCI bus (and p=
ossibly
causing interrupt loss) until the Permedia is ready. The programmers manu=
al
cautions that it should only be used when you know that the Permedia can
consume data faster than the host can generate it and/or where there are =
no
time-critical periperals on the PCI bus.

All of which sounds to me like enabling PCI Disconnect isn't a great idea=
 and
offers at best infinitesimal speedups. Having said that, the X driver doe=
s seem
to turn it on, which probably shows how much I know. As to why it's sudde=
nly
stopped working, I have no idea. I'll try it out and see if I see the sam=
e
problems.

--=20
Jim Hague - jim.hague@acm.org          Never trust a computer you can't l=
ift.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick

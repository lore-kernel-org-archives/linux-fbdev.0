From: Jim Hague <jim.hague@acm.org>
Subject: Re: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Tue, 08 Mar 2005 23:08:23 -0000 (GMT)
Message-ID: <XFMail.20050308230823.jim.hague@acm.org>
References: <XFMail.20050307220832.jim.hague@acm.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8noZ-0001dF-Mu
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Mar 2005 15:08:35 -0800
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D8noY-0002rU-48
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Mar 2005 15:08:35 -0800
In-Reply-To: <XFMail.20050307220832.jim.hague@acm.org>
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

On 07-Mar-2005 Jim Hague wrote:
>> As for colours / graphics, disabling CONFIG_FB_PM2_FIFO_DISCONNECT fix=
es
>> that too, but it worked under 2.6.10-rc2 with that option on too. What=
 does
>> it do and why I cannot use it under 2.6.11 any more? The help text to =
this=20
>> option is not very enlightening...
> [..]
> to turn it on, which probably shows how much I know. As to why it's sud=
denly
> stopped working, I have no idea. I'll try it out and see if I see the s=
ame
> problems.

I can't reproduce problems with FIFO Disconnect on my machine. To check I=
'm
looking at the right thing, what resolution and colour depth did you have
problems with?

--=20
Jim Hague - jim.hague@acm.org          Never trust a computer you can't l=
ift.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick

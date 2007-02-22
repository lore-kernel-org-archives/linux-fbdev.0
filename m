From: "Orczykowski, Juergen" <juergen.orczykowski@siemens.com>
Subject: Re: bug in intelfbhw.c
Date: Thu, 22 Feb 2007 13:02:16 +0100
Message-ID: <3E56BFF2E134A44A98D9FFDB710688DF011D40E1@ERLD151A.ww004.siemens.net>
References: <1172136478.4086.19.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKCej-0006K0-6a for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 04:02:37 -0800
Received: from dragon3.automation.siemens.com ([194.138.39.158])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKCeh-0007db-8y
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 04:02:36 -0800
Content-class: urn:content-classes:message
In-Reply-To: <1172136478.4086.19.camel@daplas>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net
Cc: Dave Airlie <airlied@gmail.com>

Hi Tony,
Sorry, but in the diff, we miss our (similar) change in the function refres=
h_ring.

Best regards

Juergen Orczykowski

Siemens AG
Automation and Drives, A&D MC RD 37
Tel.  : +49 (9131) 98-3599
Fax.  : +49 (9131) 98-2360
mailto:juergen.orczykowski@siemens.com

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Heinrich v. =
Pierer; =

Managing Board: Klaus Kleinfeld, Chairman, President and Chief Executive Of=
ficer;
Johannes Feldmayer, Joe Kaeser, Rudi Lamprecht, Eduardo Montes, Juergen Rad=
omski,
Erich R. Reinhardt, Hermann Requardt, Uriel J. Sharef, Klaus Wucherer
Registered offices: Berlin and Munich
Commercial registries: Berlin Charlottenburg, HRB 12300, Munich, HRB 6684
WEEE Reg. No. DE 23691322


-----Urspr=FCngliche Nachricht-----
Von: Antonino A. Daplas [mailto:adaplas@gmail.com] =

Gesendet: Donnerstag, 22. Februar 2007 10:28
An: linux-fbdev-devel@lists.sourceforge.net
Cc: Dave Airlie; Orczykowski, Juergen
Betreff: Re: [Linux-fbdev-devel] bug in intelfbhw.c

On Thu, 2007-02-22 at 09:14 +0100, Orczykowski, Juergen wrote:
> Hello,
> =

> we would like to use your drivers in our software. While debugging we
> found a bug in calculating the ring_space.
> =

> If there is less then RING_MIN_FREE available in the ring buffer,
> dinfo->ring_space is set to a big value forcing wait_ring to return.
> =

> We have attached a possible solution to solve this bug.
> =


Dave,

I created a patch based on the source.  I don't have the hardware so do
you want to look at this?

Tony

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV

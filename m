From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: Atari mach64 support (fwd)
Date: Tue, 25 Oct 2005 00:13:39 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0510250013220.16455@pentafluge.infradead.org>
References: <Pine.LNX.4.62.0509221415250.18908@numbat.sonytel.be>
 <15C49DB1-DE9D-45CC-95E6-F0071601B213@kilzer.net>
 <Pine.LNX.4.56.0510242141010.13921@pentafluge.infradead.org>
 <20051024215816.GA13746@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUBVh-0006to-8W
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 16:13:45 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EUBVf-0008JO-LG
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 16:13:45 -0700
In-Reply-To: <20051024215816.GA13746@sci.fi>
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
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux/m68k <linux-m68k@vger.kernel.org>



Yeap. Your right. I will send a patch with the correct spelling.


On Tue, 25 Oct 2005, Ville [iso-8859-1] Syrj=E4l=E4 wrote:

> On Mon, Oct 24, 2005 at 09:42:42PM +0100, James Simmons wrote:
> >=20
> > Just code merger. First you had the M64_HAS test then test for=20
> > pll_ref_div. I combined the two test into one test.
> > Its not needed tho so I broke it into 2 again. I think it is time to se=
nd=20
> > this to Andrew.
>=20
> He probably meant that you've mistyped pll_ref_div as pll_ref_dev.
>=20
> --=20
> Ville Syrj=E4l=E4
> syrjala@sci.fi
> http://www.sci.fi/~syrjala/
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>=20


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information

From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: how to handle MSB framebuffer in LSBkernel?
Date: Tue, 14 Aug 2007 18:21:40 +0200
Message-ID: <46c1d694f0253@wp.pl>
References: <46c0b3de5046e@wp.pl> <1187036133.5058.3.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKz9R-00077m-4e for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Aug 2007 09:21:50 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IKz9N-000436-Ta
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Aug 2007 09:21:48 -0700
In-reply-to: <46c0b3de5046e@wp.pl> <1187036133.5058.3.camel@daplas>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: "Antonino A.Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

Dnia 13-08-2007 o godz. 22:15 Antonino A. Daplas napisa=B3(a):
> On Mon, 2007-08-13 at 21:41 +0200, Krzysztof Helt wrote:
> > Hi,
> > =

> > I have a problem how to handle MSB framebuffer (s3c2410fb) in =

LSB =

> > kernel (typical ARM kernel).
> > =

> > It is not a problem in 8+ bpp (bits per pixel) modes.
> > The problem is how to reverse pixel order in 1, 2 and 4 bpp
> > modes, because it does not work otherwise. Is there any fb =

flag
> > or something?
> =

> If 4bpp, ab|cd|ef is reversed as ba|dc|ef?

Yes.

> I don't think the drawing
> libraries do not support pixel reversal. Either the hardware =

does it, or
> we create a library for this.
> =


It may be not so important if it is difficult/slow. Most PDAs =

uses TFT so support 8+ bpp modes. If it is not easy, this may =

stay as it is (mean still broken) or these modes (1-4bpp)  can be =

removed than added fixed and tested if someone needs them.

Regards,
Krzysztof

> =

> =


----------------------------------------------------
Producenci filmu SEZON NA MISIA przedstawiaj=B1
surfuj=B1ce pingwiny w nowej, animowanej komedii
NA FALI -  w kinach od 10 sierpnia! =

http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fnafali_zwias=
tun.html&sid=3D1256



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/

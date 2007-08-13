From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: how to handle MSB framebuffer in LSB kernel?
Date: Mon, 13 Aug 2007 21:41:18 +0200
Message-ID: <46c0b3de5046e@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKfn1-0004rt-A6 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 12:41:24 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1IKfmy-0001Pb-Gl
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 12:41:20 -0700
Received: from poczta-3.free.wp-sa.pl (HELO localhost) ([10.1.1.213])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	13 Aug 2007 21:41:18 +0200
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
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

Hi,

I have a problem how to handle MSB framebuffer (s3c2410fb) in LSB =

kernel (typical ARM kernel).

It is not a problem in 8+ bpp (bits per pixel) modes.
The problem is how to reverse pixel order in 1, 2 and 4 bpp
modes, because it does not work otherwise. Is there any fb flag
or something?

Regards,
Krzysztof

----------------------------------------------------
Czy na wakacje warto zabra=E6 laptopa?
Zobacz gdzie dzia=B3aj=B1 strefy darmowego, bezprzewodowego Internetu!
Kliknij: http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd12=
8.html&sid=3D1259



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/

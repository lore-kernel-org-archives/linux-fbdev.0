From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [RFC]: s3c2410fb conversion
Date: Fri, 26 Jan 2007 09:06:44 +0100
Message-ID: <45b9b69474f01@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HAM6n-0004e6-Cl for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Jan 2007 00:06:53 -0800
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1HAM6l-0002JT-S1
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Jan 2007 00:06:53 -0800
Received: from poczta-2.free.wp-sa.pl (HELO localhost) ([10.1.1.167])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	26 Jan 2007 09:06:44 +0100
Content-Disposition: inline
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

Hello,

The s3c2410fb driver needs register values set for every
platform. A way of conversion is to move as many values to
particular fields (e.g. resolution, bit depth, etc.) and
calculate the register values from them.

I want to ask how far one should move in conversion of the
driver. Should enumerated values also be moved to separate fields
or they can be set with "or" operator (I) into existing register
fields? I mean values (usually bits) like display type (STN/TFT
bit), etc.

E.g., the pxafb driver works with the latter approach. Most of
values are calculated but some of them are set as or-ed values
into register-like fields (the bits from fields are directly
copied to register's bits and completed by bits from calculated
values).

The s3c2410fb driver does not work currently because some
conversion started and was not finished (no platform code support
it). I need to know how to fix it - either modify platform or fb
code depending on the approach.

Regards,
Krzysztof

----------------------------------------------------
Odkryj drug=B1 stron=EA ciemnego portalu - "World of War Craft" premiera:
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd59.html&sid=
=3D1000



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV

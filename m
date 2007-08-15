From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH 0/3] s3c2410fb: final registers removal
	from s3c2410fb_display
Date: Wed, 15 Aug 2007 10:23:07 +0200
Message-ID: <46c2b7eb433e5@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILE9s-0001s1-23 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Aug 2007 01:23:44 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ILE9n-0000Ta-F0
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Aug 2007 01:23:14 -0700
Received: from poczta-15.free.wp-sa.pl (HELO localhost) ([10.1.1.43])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	15 Aug 2007 10:23:07 +0200
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
Cc: Ben Dooks <ben-linux@fluff.org>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>

This set of patches remove lcdcon1 register from display modes
description and set pixclock value for all boards.

The third patch makes use of default_display value to
honor display type and select preffered display mode.

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

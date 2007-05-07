From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: pm2fb with acceleration is slow
Date: Mon, 07 May 2007 09:27:52 +0200
Message-ID: <463ed4f8341d4@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkxdY-0005Oh-Gx for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 00:28:00 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HkxdW-0004kO-1q
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 00:28:00 -0700
Received: from poczta-5.free.wp-sa.pl (HELO localhost) ([10.1.1.10])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 7 May 2007 09:27:52 +0200
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
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

Hi,

Recently, I have added accelerated methods for fillrect and
copyarea. Scrolling has become very slow (about ten times slower).

The fillrect function speeds ups things - the clear command is
few times faster and scrolling is few percent faster.

The copyarea method makes scrolling much slower. Any hints?

Regards,
Krzysztof

----------------------------------------------------
Ju=BF nied=B3ugo pierwsza komunia! Zr=F3b naprawd=EA niezapomniany prezent:
Pi=EAknie wydany i zilustrowany album do uzupe=B3nienia przez dziecko
b=EAdzie na ca=B3e =BFycie kronik=B1 Pierwszej Komunii =A6wi=EAtej - Zobacz:
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fkom.html&sid=
=3D1125



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

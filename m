From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] pm3fb: preliminary support for
	2.6kernel
Date: Tue, 08 May 2007 08:27:47 +0200
Message-ID: <464018632f390@wp.pl>
References: <463e3edaad7a2@wp.pl> <1178572074.4674.3.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlJAt-00075K-Gj for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 23:27:51 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HlJAs-0004hk-U6
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 23:27:51 -0700
In-reply-to: <463e3edaad7a2@wp.pl> <1178572074.4674.3.camel@daplas>
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
To: "Antonino A.Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>



Dnia 7-05-2007 o godz. 23:07 Antonino A. Daplas napisa=B3(a):
>
> Thanks for doing this.  I change the VESA_* constants to FB_BLANK_*
> constants. It's just a simple substitution, but let me know if it's
> correct. (I don't know what to do with FB_BLANK_UNBLANK.)
> =

> Tony
>

Thank you. I assume that FB_BLANK_NORMAL means screen off.

Add this case for FB_BLANK_UNBLANK:

case FB_BLANK_UNBLANK:
	video =3D video | PM3VideoControl_ENABLE;
	break;


Regards,
Krzysztof

----------------------------------------------------
Morderstwa i krew ofiar na =B6cianach. Mroczne miasto =

pogr=B1=BFone w chaosie. Sprawd=BC kto jest Przybywaj=B1cym!
Przybywaj=B1cy - thriller metafizyczny ju=BF w ksi=EAgarniach.
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fksiazki.wp.pl%2Fkatalog%2Fksiazki%2Fk=
siazka.html%3Fkw%3D10414&sid=3D1128



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

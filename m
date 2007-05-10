From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] smart blitter usage for scrolling
Date: Thu, 10 May 2007 07:40:59 +0200
Message-ID: <4642b06be589b@wp.pl>
References: <464172cc491d5@wp.pl> <1178720358.4861.27.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hm1Oj-0001WA-Jr for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 May 2007 22:41:05 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hm1Oi-00038F-21
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 May 2007 22:41:05 -0700
In-reply-to: <464172cc491d5@wp.pl> <1178720358.4861.27.camel@daplas>
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

Dnia 9-05-2007 o godz. 16:19 Antonino A. Daplas napisa=B3(a):
> This sounds quite logical to me.  However, I would rather that =

you
> create a new scrolling mode (ie SCROLL_MOVE_REDRAW and
> SCROLL_WRAP_REDRAW). Then create a new FBINFO_HWACCEL flag that =

will
> enable SCROLL_PAN/WRAP_MOVE_REDRAW and perhaps another one that =

will
> enable MERGE_BLIT.
> =


I understand that you want creating a new flag instead of ifdefs =

but this new method should not be much slower in the worst case =

and much faster on average. I would rather consider replacing the =

existing SCROLL_MOVE mode (so no ifdefs after some =

experimental/test period).
Also, the capabilities of hardware for the new method are exactly =

the same as for the old SCROLL_MOVE. Every time the =

HWACCEL_COPYAREA is selected the new scroll method should also be =

selected. The new HWACCEL flag seems to be alwyas a copy of =

HWACCEL_COPYAREA flag.

The MERGE_BLITS is a different story but my suspection is that =

does not give any real benefit (in the few % range plus or minus) =

and could be dropped completely. I left it to allow members of =

this list testing and return a feedback. If my supection is true =

the whole MERGE_BLITS can be dropped to simplify the code.

Kind regards,
Krzzysztof


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

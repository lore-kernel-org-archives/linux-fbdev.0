From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] skeletonfb: More corrections
Date: Tue, 1 May 2007 16:14:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705011611530.5345@pentafluge.infradead.org>
References: <4637557596419@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1831524198-922097047-1178032342=:5345"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hiu3q-0005Mg-FX for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 May 2007 08:14:39 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hiu3o-0002SI-PT
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 May 2007 08:14:38 -0700
In-Reply-To: <4637557596419@wp.pl>
Content-ID: <Pine.LNX.4.64.0705011613400.5345@pentafluge.infradead.org>
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
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1831524198-922097047-1178032342=:5345
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-ID: <Pine.LNX.4.64.0705011613401.5345@pentafluge.infradead.org>
Content-Transfer-Encoding: quoted-printable


Acked-By: James Simmons <jsimmons@infradead.org>

One thing. Please don't make your patches a attachement.

On Tue, 1 May 2007, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
>=20
> More corrections to skeletonfb.c file:
> - fixed types of more arguments
> - removed returned values in void functions
> - removed not existing fb_poll function
> - fixed closing comment typo
> - corrected misleading constant name ADDR
>=20
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>=20
> ---
>=20
> This patch requires patches already sent to mm tree.
>=20
> Somehow not all fixes went previously into my patch. Some of=20
> fixes correct changes in the last patch.
>=20
> ----------------------------------------------------
> Skorzystaj ze staro?ytnej chi?skiej m?dro?ci. Tw=F3j horoskop wiosenny
> - http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fchinsk=
i2.html&sid=3D1121
>=20
---1831524198-922097047-1178032342=:5345
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
---1831524198-922097047-1178032342=:5345
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---1831524198-922097047-1178032342=:5345--

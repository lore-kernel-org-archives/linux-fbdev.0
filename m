From: Richard Smith <smithbone@gmail.com>
Subject: Re: mono, gray and index configs
Date: Mon, 22 Aug 2005 09:36:14 -0500
Message-ID: <8a0c36780508220736662c8d18@mail.gmail.com>
References: <9e47339105081020216574ac7e@mail.gmail.com>
	 <Pine.LNX.4.62.0508111020520.1037@numbat.sonytel.be>
	 <b00ca3bd05081104086fa9e639@mail.gmail.com>
	 <Pine.LNX.4.62.0508111344070.1037@numbat.sonytel.be>
	 <42FB8C29.4070503@gmail.com> <43069BE0.80604@gmail.com>
	 <9e473391050819200950020d7@mail.gmail.com>
	 <Pine.LNX.4.62.0508221203410.24432@numbat.sonytel.be>
	 <8a0c3678050822063073c3f4f6@mail.gmail.com>
	 <Pine.LNX.4.62.0508221602040.24432@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E7DPX-0006OL-Ng
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Aug 2005 07:36:27 -0700
Received: from zproxy.gmail.com ([64.233.162.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E7DPW-0000ZF-JO
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Aug 2005 07:36:27 -0700
Received: by zproxy.gmail.com with SMTP id s18so637529nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Aug 2005 07:36:18 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0508221602040.24432@numbat.sonytel.be>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jon Smirl <jonsmirl@gmail.com>, "Antonino A. Daplas" <adaplas@gmail.com>

>=20
> No, you cut the following line:
>=20
> | var.activate |=3D FB_ACTIVATE_TEST;
>=20

Sorry. I was shorting and I went too far.

> which will cause the driver to check whether the mode is valid (or can be=
 made
> valid by rounding up).

Ah well that sounds more like was thinking of.  Is FB_ACTIVATE_TEST
new from 2.4 -> 2.6?
Be nice if SDL (and other apps) did it that way rather than actually
makeing the driver try to switch to the mode.
 =20
--=20
Richard A. Smith


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

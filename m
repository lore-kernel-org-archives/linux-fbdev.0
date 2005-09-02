From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [PATCH 8/10] fbcon: Break up bit_putcs into
 its component functions
Date: Fri, 02 Sep 2005 09:31:17 +0200
Message-ID: <4317FFC5.7090701@t-online.de>
References: <431775CA.4020509@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EB5y5-0001bZ-FV
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Sep 2005 00:28:09 -0700
Received: from mailout07.sul.t-online.com ([194.25.134.83])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EB5y3-0007sp-5A
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Sep 2005 00:28:09 -0700
In-Reply-To: <431775CA.4020509@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas schrieb:

>    The function bit_putcs() in drivers/video/console/bitblit.c is becom=
ing
>    large.  Break it up into its component functions (bit_putcs_unaligne=
d and
>    bit_putcs_aligned).
>   =20
>    Incorporated fb_pad_aligned_buffer() optimization by Roman Zippel.
>   =20
>    Signed-off-by: Antonino Daplas <adaplas@pol.net>
> =20
>

Well, breaking up bit_putcs() is ok. But I don=B4t understand why you do=20
not care about
blitting time for 16x* fonts.

cu,
 knut


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

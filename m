From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: BUG: fb_imageblit called before fb_check_var
 and fb_set_par function
Date: Thu, 25 Aug 2005 22:05:26 +0800
Message-ID: <430DD026.2070303@gmail.com>
References: <430DB8E6.8000204@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8IMh-0002JZ-Ii
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 07:05:59 -0700
Received: from wproxy.gmail.com ([64.233.184.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E8IMg-00025J-Gg
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 07:05:59 -0700
Received: by wproxy.gmail.com with SMTP id i13so333287wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Aug 2005 07:05:51 -0700 (PDT)
In-Reply-To: <430DB8E6.8000204@t-online.de>
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
Cc: Knut Petersen <Knut_Petersen@t-online.de>

Knut Petersen wrote:
> Hi everybody,
>=20
> under certain circumstances the X trident driver does disable mmio
> upon returning to a linux console. As mapped ioports are no longer
> available, this is an immediate problem.
>=20
> I never had expected that upon switching from X to a linux console
> drawing functions like fb_imageblit would be called before the
> fb_check_var and  fb_set_par functions have been called. But that=B4s
> definitely the case.
>=20

I'm surprised.  That was a problem in earlier versions of the kernel
but I think that was fixed.  If you look at fbcon code, all calls to
drawing functions:

putcs, bmove, scroll, cursor, flashcursor, etc has an=20

if (fbcon_is_inactive()) in the beginning.

And everytime the vt switches from KD_GRAPHICS to KD_TEXT (ie from X),
a set_var()/ set_par() will be called automatically to reset the fbdev
drivers before the "drawing" functions are called.

Can you instrument where this is happening?  Because if it still is,
then that is a show-stopping bug.

Tony=20


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

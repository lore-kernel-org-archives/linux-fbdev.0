From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: I can't get mapping ram work (Arm kernel
 2.4 )
Date: Fri, 26 Aug 2005 10:05:00 +0800
Message-ID: <430E78CC.4050704@gmail.com>
References: <BAY109-F21B4E3CE3F5CC94D769D58C8AB0@phx.gbl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8Tat-0004Ru-Ls
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 19:05:23 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E8Taq-0001ot-L5
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 19:05:23 -0700
Received: by wproxy.gmail.com with SMTP id 71so164840wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Aug 2005 19:05:07 -0700 (PDT)
In-Reply-To: <BAY109-F21B4E3CE3F5CC94D769D58C8AB0@phx.gbl>
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

ruben qui=F1ones ruiz wrote:
> TONY wrote:
> -----------
> How did you allocate this buffer?  Is is system RAM?  If it's system RA=
M,
> did you use kmalloc, vmalloc or __get_free_pages. (kmalloc, vmalloc usu=
ally
> do not work, you have to use __get_free_pages).
>  Tony
> ---------
>=20
> Hi Tony, yeah , I use __get_free_pages : (this function is called in in=
t=20
> init_module(void) )
>=20

Hmm, I don't see anything obviously wrong with the code.  Maybe you can
post this at the ARM mailing list (linux-arm-kernel@lists.arm.linux.org.u=
k).

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

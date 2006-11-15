From: Christian Hoffmann <chrmhoffmann@gmail.com>
Subject: Re: Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005 with radeonfb enabled
Date: Wed, 15 Nov 2006 01:54:35 +0100
Message-ID: <200611150154.39499.chrmhoffmann@gmail.com>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	<200611142247.55137.chrmhoffmann@gmail.com>
	<1163542033.5940.156.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0988477282=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gk93J-00019D-Sw for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 16:54:59 -0800
Received: from ug-out-1314.google.com ([66.249.92.169])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gk93I-0002Pj-BT
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 16:54:57 -0800
Received: by ug-out-1314.google.com with SMTP id z38so11882ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 14 Nov 2006 16:54:51 -0800 (PST)
In-Reply-To: <1163542033.5940.156.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>

--===============0988477282==
Content-Type: multipart/signed; boundary="nextPart4245875.DufH7IB6Kf";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4245875.DufH7IB6Kf
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 14 November 2006 23:07, Benjamin Herrenschmidt wrote:
> > I tried that patch, but the last message I see over netconsole (using
> > tg3) is: Suspending console(s)
> > and then nothing. Nothing on resume at all :(
> >
> > Adding some printks in the radeonfb_pci_suspend and radeonfb_pci_resume
> > (radeon_pm.c) didn't help: I don't see them. But I am not a kernel
> > programmer at all, so I might do something wrong or in the wrong place.
>
> Does it resume if you make radeon_pci_resume() a nop ?
>
> Of course, the fbdev will not come back, but will the machine overall
> resume ?
>
> Ben.
Yes, if i make radeon_pci_resume a nop, the machine resumes if i do a retur=
n 0=20
immediately.
I think I tracked it down to the call to acquire_console_sem() as the=20
following code makes the machine hang again:

int radeonfb_pci_resume(struct pci_dev *pdev)
{
        struct fb_info *info =3D pci_get_drvdata(pdev);
        struct radeonfb_info *rinfo =3D info->par;
        int rc =3D 0;
        if (pdev->dev.power.power_state.event =3D=3D PM_EVENT_ON)
                return 0;
        if (rinfo->no_schedule) {
        /*      if (try_acquire_console_sem())*/
                        return 0;
        } else
                acquire_console_sem();

        return 0;
=2E..

Chris
NB: kernel 2.6.18.1, amd64




--nextPart4245875.DufH7IB6Kf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARVplT9onrF4PGGDNAQKTLQ//T+7b7qnk4GuWrXHjcCpfP2yjvKYE3TY4
Or81CJnxjOX1LdAKBTosxPVK8d6D/CaiIDtBdivYw2tZ3a76rXWXOkY2hgxQ1jen
Agiop6UE+IdywfuwvGYxMc+6mX9Q3TbZJE1Yv1/uZujHVUhSWJVFGCh9GONO17nN
CTWW6RMZEAGEPS5EnCIPAg0V/BshSTOx8fPk0S4664KUMUv5JB65EU5dIluQOsqi
rCpO8gg+gnUf4X7UJj2XDu/GWNypgNIxzmBWDN8cNYSnptM5hDgspz4P87gZLk3E
GwCgkYBa5yZIfqvP6zQPyn4UnpCPCtj9DAw4esrU0aJ8ocwqYTYbTzge/1Hbi+aP
r6gDPxpB1T9BTk5nICne0CBS1T9b7tHZTQvRGhSoQaCYKsGEJNRf+UG6ARTAhMdz
rwmEDnhFPzGs/YVoCnoxtqxgPItoI2XdYjJD4vIusoxxXoY9IyPa5pW32+YtMWwr
a5+GhQzi640scg6jJKGc5kGxld8w57DhkfnDU/GEYqLgOnquOBCeVGabN9oOeHMQ
56af2rW9YdK+bjUjGN+n9Kl/ynFmKzMiwgaE8HfjNOJhm9QiYk+KFPVySX8pk6Hr
WnWwfxreIQmuiGwzLXD7oxu2v2G2zJmJW54qM1cf8Bqm+pLf9kO5AkSto4p1cORo
cj/jUx57XtE=
=6JOM
-----END PGP SIGNATURE-----

--nextPart4245875.DufH7IB6Kf--


--===============0988477282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0988477282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0988477282==--

From: Christian Hoffmann <chrmhoffmann@gmail.com>
Subject: Re: Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005 with radeonfb enabled
Date: Thu, 16 Nov 2006 23:17:26 +0100
Message-ID: <200611162317.30880.chrmhoffmann@gmail.com>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	<1163555308.5940.177.camel@localhost.localdomain>
	<200611151109.06956.rjw@sisk.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1816279729=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GkpYK-0006yL-CA for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Nov 2006 14:17:48 -0800
Received: from ug-out-1314.google.com ([66.249.92.171])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GkpYJ-000869-NT
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Nov 2006 14:17:48 -0800
Received: by ug-out-1314.google.com with SMTP id z38so550009ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 16 Nov 2006 14:17:46 -0800 (PST)
In-Reply-To: <200611151109.06956.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, LKML <linux-kernel@vger.kernel.org>, Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>

--===============1816279729==
Content-Type: multipart/signed; boundary="nextPart2539656.VEzSQKyLSm";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2539656.VEzSQKyLSm
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


> >
> > Well, if you acquire the console sem you need to release it too :-)
>
> Or the console semaphore is acquired too many times.
>
> Christian, could you please add release_console_sem() before 'return 0'
> and see if that makes the code work again?  If not, could you add a
> printk() in kernel/printk.c/acquire_console_sem() to see how many times it
> is called?

Ok, I did that and the machine resumes OK. Now I have the impression that=20
accessing the rinfo struct here:

if (pdev->dev.power.power_state.event =3D=3D PM_EVENT_SUSPEND) {
                /* Wakeup chip. Check from config space if we were powered =
off
                 * (todo: additionally, check CLK_PIN_CNTL too)
                 */
                if ((rinfo->pm_mode & radeon_pm_off) &&
                        radeon_restore_pci_cfg(rinfo)) {
                        if (rinfo->reinit_func !=3D NULL) {
                                rinfo->reinit_func(rinfo);
                                }
                        else {
                                goto bail;
                        }
                }
                /* If we support D2, try to resume... we should check what =
was=20
our
                 * state though... (were we really in D2 state ?). Right no=
w,=20
this code
                 * is only enable on Macs so it's fine.
                 */
                else if (rinfo->pm_mode & radeon_pm_d2){
                        radeon_set_suspend(rinfo, 0);
                }
                rinfo->asleep =3D 0; ////makes it crash
        } else {
                radeon_engine_idle();
        }

makes the resume fail. The machine locks up. I started xorg without drm/dri=
=20
and then it goes a little further and locks up in the next steps:       =20

/* Restore display & engine */
radeon_write_mode (rinfo, &rinfo->state, 1);

But it starts to get too complicated for me :(

Chris

--nextPart2539656.VEzSQKyLSm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARVzjetonrF4PGGDNAQKMRg/+KXgOaXQ9P8k8OZ0hZWGoZafBm/6q7Czw
ugfiBETifwbqRN1vEJD3aTKghJ/UFkItKssV4kqdkhssrxvAhPXW8YaGR3+JWkPv
YMmLxlMaY+KuFNd81KgUz0ogcVX736pH9CMVjyCmP1ex7+sQQJD2ZVDcm2hde3UL
9R+Fsj+osDe79GJzTr1PuZ+ZWIc8/F0xTXzM7zvLz9HzYW7SgEmYI3v9mGOBsAGv
JSlhzwLNgtz04JLB9VDbvypxriudPxIsFqws2Vd6N23JXQ/47KTCjvGFMV7Z5PxG
aCftdxz97fnRt/DnFz85jRrku8+fVVg/Rlj3EHsAu+UbrFn6fQgGFH95kJEjF9/V
fX2rCC2xgLJK9Mm2MCQ+KJ5IJXPyLQO8yHDIFs/5ZGRdPafaH7OqNIy49/vaxQ7I
ynCo7ga8Q3rq/tqXemdT6x8YKnjiH7VPIlFbiHggWBWmt+2Mef6ThSJc1Zfx3CwU
QxEF79cooefW3vX/9sGUgyS4d2L+HTR6YYm+a5ys3wHjh2v87H2iTL7GtZEP8Ocy
zvNVbChiQNFuvpZyS2iuMgnrZoRqf+j85AENfbx5jPJc3t+Xj7In/+jG5g/Pcz5F
8uN+EhyrAoe95GsRw9wGP4jQnUiCSaltUxxvhnhmsU1QoOgk4yvJDO9FfHtxoscX
HofHrY8rX1w=
=Ba+c
-----END PGP SIGNATURE-----

--nextPart2539656.VEzSQKyLSm--


--===============1816279729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1816279729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1816279729==--

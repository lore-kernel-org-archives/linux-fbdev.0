From: Jak <rfjak@eircom.net>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and 2.5.5[45]
Date: Mon, 20 Jan 2003 19:09:10 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200301201909.10951.rfjak@eircom.net>
References: <Pine.LNX.4.44.0301150042470.23774-100000@phoenix.infradead.org> <200301182028.33155.rfjak@eircom.net> <1042990390.1058.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail04.svc.cra.dublin.eircom.net ([159.134.118.20])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ahEs-0007c8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 20 Jan 2003 11:05:42 -0800
In-Reply-To: <1042990390.1058.4.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Tony,
=09thanks for your patches, they have fixed most of the problems I had.
>
> Try running stty to fix your display.
>
I can't convince stty to do anything useful for me :
=09do I need a specific/patched version ?
=09do I need to specify anything except rows cols values ?
=09how would I change the colour depth ?
=09I have 7 different lines in /etc/fb.modes related to 1024x768@8bpp,
how can I tell stty that I want to use the equivalent of the timing value=
s of
any particular one of these 7 modes ( assuming timings are still relevant=
 ) ?
=09what was wrong with fbset which I have to keep for the forseeable
future anyway until 2.6 approaches 2.4 reliability ?
>
> So can you and Jak try the attached patch?  It should prevent VGA
> console corruption on insmod and it should eliminate the kobject trace
> messages.
>
Using your 3 recent patches together clears up the green screen problem
and text corruption as well as kobject "badness".

>  int __init rivafb_init(void)
>  {
> -=09int err;
> -=09err =3D pci_module_init(&rivafb_driver);
> -=09if (err)
> -=09=09return err;
> -=09pci_register_driver(&rivafb_driver);
> -=09return 0;
> +=09return pci_module_init(&rivafb_driver);
>  }
>
This will normally return 1, not 0 as before. Is this intended ?




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en

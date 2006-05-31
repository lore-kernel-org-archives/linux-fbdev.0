From: Marcin Juszkiewicz <linux-arm@hrw.one.pl>
Subject: Re: Re: printk on framebuffer console
Date: Wed, 31 May 2006 16:45:28 +0200
Message-ID: <200605311645.28603.linux-arm@hrw.one.pl>
References: <447C03C6.3000805@singnet.com.sg> <447D189C.1010100@gmail.com> <447D5134.1090502@singnet.com.sg>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlRx1-0001QA-H7
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 07:45:35 -0700
Received: from v813.rev.tld.pl ([195.149.226.213] helo=smtp.host4.kei.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FlRx1-0005In-1z
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 07:45:35 -0700
In-Reply-To: <447D5134.1090502@singnet.com.sg>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

Dnia =B6roda, 31 maja 2006 10:17, Terence Soh napisa=B3:

> Is there any way I can disable the printf/printk once my QT-Embedded
> application starts?

You can try to use vt-switch.patch [1] from OpenEmbedded. This add option
"-terminal" which we use to move OPIE to VT2.

1. http://www.openembedded.org/repo/org.openembedded.dev/packages/qte/qte-2=
=2E3.10/vt-switch.patch

=2D-=20
JID: hrw-jabber.org
Sharp Zaurus C-760 (OZ 3.5.x)
OpenEmbedded/OpenZaurus/OPIE developer

          It's better to keep your mouth shut and appear stupid,
          than to open it and remove all doubt.


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642

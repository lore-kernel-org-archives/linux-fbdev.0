From: Dawid Kuroczko <qnex@atlantis.ssw.krakow.pl>
Subject: Re: Matrox Oopsed when using kernel with ACPI support...
Date: Wed, 7 Aug 2002 19:36:06 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208071930090.1127-100000@atlantis.ssw.krakow.pl>
References: <15239BD6CAD@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from panoramix.vasoftware.com ([198.186.202.147])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cVGZ-00031q-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 Aug 2002 11:10:39 -0700
Received: from atlantis.ssw.krakow.pl ([62.233.209.66]:32886)
	by panoramix.vasoftware.com with esmtp (Exim 4.05-VA-mm1 #1 (Debian))
	id 17cUk6-0000Re-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 Aug 2002 10:37:06 -0700
In-Reply-To: <15239BD6CAD@vcnet.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 7 Aug 2002, Petr Vandrovec wrote:

> > Code;  c024d739 <matrox_cfbX_putcs+189/280>   <=3D=3D=3D=3D=3D
> >    0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi) =
  <=3D=3D=3D=3D=3D
>=20
> Uh-oh. Impossible. Do you use multihead, or do all your ttyS belong
> to /dev/fb0? If you are using /dev/fb1 (but you should do it anyway..=
=2E)
> please apply patch from
> ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/fbset-through-vt-2.4.=
19-rc5.gz
> to your kernel. Besides that it fixes (oopses|kernel corruption) if y=
ou do=20
> 'fbset -fb /dev/fb0' while you are watching console on /dev/fb1, it a=
lso
> allows you to do 'fbset -fb /dev/tty*' - this could simplify your

Actually I have only one fbdev:
[root@atlantis ~]# cat /proc/fb
0 MATROX VGA

=2E..the trick with open/fbdev pair might

> script a lot. And no, patch is not going to the kernel. James vetoed =
it
> years ago...
Oh [ anyways the patch is great! and I runned the "ugly old script" and
it works fine too :) ]

> And while you are on it, please try
> ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/mga-2.4.19-rc5-tvout.=
gz
> too. But I believe that fbset-through-vt patch will fix your oopses, =
and
> this mga patch will not bring any new feature to your old MGA.

I applied it and appears to be rock solid.  If I experience any problem=
s,
I'll write.  The card has no TV out, so only new feature are new things
in /proc:

[root@atlantis ~]# cat /proc/driver/mga/fb0/bios                       =
                      =20
BIOS:   0.0.0
Output: 0x00
TVOut:  no
PINS:   found
Info:   c03f2a0c
[root@atlantis ~]# hexdump -c /proc/driver/mga/fb0/pins
0000000   .   A   @   =FF  \0 002   .   =C4 003  \0  \0 021   A   B   C=
   1
0000010   7   3   5   1  \0 213   X  \0   4 213   X  \0   2   0   7  \0
0000020  \0  \0   =A2   &   =FF   =FF   =FF   =FF  \0   F   F   <   =FF=
   <   2   7
0000030   =FF   =FF   =FF   =FF   =EE   =FF   =FF   =FF   =FF   =FF   =FF=
   =FF   =FF   =FF   =FF   =E0
0000040

And once again lots of thanks for quick response and solving my
problem (and for fbset-through-vt which is defenatley going to stay
in my copy of kernel :)).

   Regards,
      Dawid



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

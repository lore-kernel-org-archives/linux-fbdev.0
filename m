From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Matrox Oopsed when using kernel with ACPI support...
Date: Wed, 7 Aug 2002 12:02:06 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <15239BD6CAD@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from zikova.cvut.cz ([147.32.235.100])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cNeE-0002jC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 Aug 2002 03:02:35 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Dawid Kuroczko <qnex@atlantis.ssw.krakow.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net

On  7 Aug 02 at 10:57, Dawid Kuroczko wrote:
> No modules in ksyms, skipping objects
> Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
> Aug  7 02:08:34 atlantis kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000200
> Aug  7 02:08:34 atlantis kernel: c024d739
> Aug  7 02:08:34 atlantis kernel: *pde = 00000000
> >>EIP; c024d739 <matrox_cfbX_putcs+189/280>   <=====
> Trace; c024d88d <matrox_cfb8_putcs+5d/70>
> Trace; c0246f44 <fbcon_putcs+94/100>
> Trace; c0205257 <do_update_region+127/190>

> Code;  c024d739 <matrox_cfbX_putcs+189/280>   <=====
>    0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====

Uh-oh. Impossible. Do you use multihead, or do all your ttyS belong
to /dev/fb0? If you are using /dev/fb1 (but you should do it anyway...)
please apply patch from
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/fbset-through-vt-2.4.19-rc5.gz
to your kernel. Besides that it fixes (oopses|kernel corruption) if you do 
'fbset -fb /dev/fb0' while you are watching console on /dev/fb1, it also
allows you to do 'fbset -fb /dev/tty*' - this could simplify your
script a lot. And no, patch is not going to the kernel. James vetoed it
years ago...

And while you are on it, please try
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/mga-2.4.19-rc5-tvout.gz
too. But I believe that fbset-through-vt patch will fix your oopses, and
this mga patch will not bring any new feature to your old MGA.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

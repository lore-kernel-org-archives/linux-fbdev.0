From: Dawid Kuroczko <qnex@atlantis.ssw.krakow.pl>
Subject: Matrox Oopsed when using kernel with ACPI support...
Date: Wed, 7 Aug 2002 10:57:02 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208071047530.1178-100000@atlantis.ssw.krakow.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from atlantis.ssw.krakow.pl ([62.233.209.66])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cMdX-0002mz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 Aug 2002 01:57:47 -0700
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

I'm running kernel 2.4.19 and I'm exeriencing repeatable kernel Oops
with Matrox Mystique card.  Kernel appears OK when compiled with
APM, but oopses whem compiled with ACPI...  More below oops dump.

ksymoops 2.4.4 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsm=
od file?
Aug  7 02:08:34 atlantis kernel: Unable to handle kernel NULL pointer d=
ereference at virtual address 00000200
Aug  7 02:08:34 atlantis kernel: c024d739
Aug  7 02:08:34 atlantis kernel: *pde =3D 00000000
Aug  7 02:08:34 atlantis kernel: Oops: 0000
Aug  7 02:08:34 atlantis kernel: CPU:    1
Aug  7 02:08:34 atlantis kernel: EIP:    0010:[matrox_cfbX_putcs+393/64=
0]    Not tainted
Aug  7 02:08:34 atlantis kernel: EIP:    0010:[<c024d739>]    Not taint=
ed
Using defaults from ksymoops -t elf32-i386 -a i386
Aug  7 02:08:34 atlantis kernel: EFLAGS: 00010202
Aug  7 02:08:34 atlantis kernel: eax: 00000010   ebx: f0809000   ecx: 0=
0000004   edx: 01200010
Aug  7 02:08:34 atlantis kernel: esi: 00000200   edi: f0809000   ebp: 0=
0000010   esp: c1857e60
Aug  7 02:08:34 atlantis kernel: ds: 0018   es: 0018   ss: 0018
Aug  7 02:08:34 atlantis kernel: Process keventd (pid: 2, stackpage=3Dc=
1857000)
Aug  7 02:08:34 atlantis kernel: Stack: 00000001 011f0118 0000007f 0000=
0010 01200010 00000001 07070707 c03ec65c=20
Aug  7 02:08:34 atlantis kernel:        e607ae10 00000012 c024d88d 0707=
0707 00000000 c03ec65c e607ae58 00000040=20
Aug  7 02:08:34 atlantis kernel:        00000012 00000000 c03f0970 c03e=
c65c 00000000 c0246f44 efde7600 c03ec65c=20
Aug  7 02:08:34 atlantis kernel: Call Trace:    [matrox_cfb8_putcs+93/1=
12] [fbcon_putcs+148/256] [do_update_region+295/400] [redraw_screen+244=
/336] [complete_change_console+43/192]
Aug  7 02:08:34 atlantis kernel: Call Trace:    [<c024d88d>] [<c0246f44=
>] [<c0205257>] [<c0205d74>] [<c020378b>]
Aug  7 02:08:34 atlantis kernel:   [<c020907a>] [<c011f8cd>] [<c01286aa=
>] [<c01284a0>] [<c0105000>] [<c01073c6>]
Aug  7 02:08:34 atlantis kernel:   [<c01284a0>]
Aug  7 02:08:34 atlantis kernel: Code: f3 a5 a8 02 74 02 66 a5 a8 01 74=
 01 a4 8b 74 24 34 0f b7 96=20

>>EIP; c024d739 <matrox_cfbX_putcs+189/280>   <=3D=3D=3D=3D=3D
Trace; c024d88d <matrox_cfb8_putcs+5d/70>
Trace; c0246f44 <fbcon_putcs+94/100>
Trace; c0205257 <do_update_region+127/190>
Trace; c0205d74 <redraw_screen+f4/150>
Trace; c020378b <complete_change_console+2b/c0>
Trace; c020907a <console_callback+3a/b0>
Trace; c011f8cd <__run_task_queue+5d/70>
Trace; c01286aa <context_thread+20a/220>
Trace; c01284a0 <context_thread+0/220>
Trace; c0105000 <_stext+0/0>
Trace; c01073c6 <kernel_thread+26/30>
Trace; c01284a0 <context_thread+0/220>
Code;  c024d739 <matrox_cfbX_putcs+189/280>
00000000 <_EIP>:
Code;  c024d739 <matrox_cfbX_putcs+189/280>   <=3D=3D=3D=3D=3D
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=3D=
=3D=3D=3D=3D
Code;  c024d73b <matrox_cfbX_putcs+18b/280>
   2:   a8 02                     test   $0x2,%al
Code;  c024d73d <matrox_cfbX_putcs+18d/280>
   4:   74 02                     je     8 <_EIP+0x8> c024d741 <matrox_=
cfbX_putcs+191/280>
Code;  c024d73f <matrox_cfbX_putcs+18f/280>
   6:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c024d741 <matrox_cfbX_putcs+191/280>
   8:   a8 01                     test   $0x1,%al
Code;  c024d743 <matrox_cfbX_putcs+193/280>
   a:   74 01                     je     d <_EIP+0xd> c024d746 <matrox_=
cfbX_putcs+196/280>
Code;  c024d745 <matrox_cfbX_putcs+195/280>
   c:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c024d746 <matrox_cfbX_putcs+196/280>
   d:   8b 74 24 34               mov    0x34(%esp,1),%esi
Code;  c024d74a <matrox_cfbX_putcs+19a/280>
  11:   0f b7 96 00 00 00 00      movzwl 0x0(%esi),%edx

OK, and now for more information.  The system is SMP 2 x PIII 733
machine with:
   matroxfb: Matrox Mystique (PCI) detected
   matroxfb: MTRR's turned on
   matroxfb: 640x480x8bpp (virtual: 640x3270)
   matroxfb: framebuffer at 0xD6000000, mapped to 0xc8805000, size 2097=
152
Everything works just fine, there is an fbdev X server running on one o=
f
the consoles.  The oops results when following script is run (please no=
te
that it works fine when ACPI is not compiled in):

--- >8 --- CUT here --- /etc/rc.d/init.d/fbset
#!/bin/sh
#
# hdpram        Sets up fbcon video modes.
#
#
# chkconfig:	2345 5 30
# description:	fbset is a utility with which fbcons video modes can be =
read\
#		and changed


# Source function library
=2E /etc/rc.d/init.d/functions

# Get service config
[ -f /etc/sysconfig/fbset ] && . /etc/sysconfig/fbset

# See how we were called.
case "$1" in
  start)
	# Check if we have framebuffer in kernel.
	if [ -f /proc/fb ]; then
		# /proc files show as files with size=3D0, this is a workaround.
		cat /proc/fb | grep -q "." || exit 0
	else
		exit 0
	fi

	if [ -n "${FBMODE_default}" ]; then
		show "Setting default video mode"
		busy
		/usr/sbin/fbset -a ${FBMODE_default}
		deltext
		ok
	fi
	for tty in /dev/tty[1-9] /dev/tty[1-6][0-9]; do
		eval FBMODE=3D\${FBMODE_${tty#/dev/}}
		if [ -n "${FBMODE}" ]; then
			echo "settking $tty to $FBMODE"
			# XXX fuser $tty <- sprawdzi=E6, czy tty jest wolna.
			show "Setting $tty video mode to $FBMODE"=20
			busy
			echo -n > $tty
			/usr/bin/open -s -c ${tty#/dev/tty} -- /usr/sbin/fbset ${FBMODE}
			deltext
			ok
		fi
	done
	touch /var/lock/subsys/fbset
	;;
    stop)=09
	rm -f /var/lock/subsys/fbset
	;;
  status)
	# Check if we have framebuffer in kernel.
	if [ -f /proc/fb ]; then
		# /proc files show as files with size=3D0, this is a workaround.
		cat /proc/fb | grep -q "." || exit 0
		echo "Frame buffer present."
	fi
	;;
  restart|reload)
	$0 stop
	$0 start
	;;
  *)
	echo "Usage: $0 {start|stop|status|restart|reload}"
	exit 1
esac

exit 0
--- >8 --- END

--- >8 --- /etc/sysconfig/fbset
# This file lets you set your default console video mode and
# video modes for individual virtual consoles.
# See /etc/fb.modes for sample video mode definitions.

=46BMODE_default=3D"Q100x31"

=46BMODE_tty1=3D
=46BMODE_tty2=3D
=46BMODE_tty3=3D
=46BMODE_tty4=3D
=46BMODE_tty5=3D
=46BMODE_tty6=3D
=46BMODE_tty7=3D
=46BMODE_tty8=3D

=46BMODE_tty12=3D"Q128x48"

=46BMODE_tty21=3D"Q128x48"
=46BMODE_tty22=3D"Q80x25"
=46BMODE_tty23=3D"Q128x48"
=46BMODE_tty24=3D"Q128x48"
--- >8 --- END

If I missed any needed information, please ask. :-)

   Regards,
     Dawid
--=20
                 http://www.muppetlabs.com/~breadbox/bf/
+++++[>++++++<-]>++[>+>++>+++>++++<<<<-]>>++++.>+.>---------.<++++++++.=
--
---.<<.>+++++++.>>--.---.---.<-.>+++++++++++.<++++++++.++++.>>+++++++++=
+.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

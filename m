From: Greg KH <greg@kroah.com>
Subject: 2.5.14 oops in fb_copy_cmap
Date: Mon, 6 May 2002 10:03:57 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020506170357.GA3798@kroah.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73] helo=kroah.com)
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 174muO-0007ry-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 06 May 2002 11:08:24 -0700
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

I get the oops below at boot time if "vga=0x0305" is on the command
line.  If I take it off, I can boot just fine.

CONFIG_FB sections in my .config are:
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VESA=y
CONFIG_FB_VGA16=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_VGA_PLANES=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

More info or debugging can be done if requested.

thanks,

greg k-h


ksymoops 2.4.5 on i686 2.5.14.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.14/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000040
c01d6806
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01d6806>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c027222c   ebx: 00000020   ecx: 00000008   edx: 00000000
esi: c02e1a40   edi: 00000040   ebp: 00000040   esp: cfe63e08
ds: 0018   es: 0018   ss: 0018
Stack: 00000008 00005656 00005656 00000030 00000010 c02e1d28 00000000 00000000 
       c02e1c00 c01db3ac c027222c c02e1d28 00000000 00000010 00000010 00000010 
       00000010 c0288015 c027222c 00000001 00000000 c02e1c00 c01dbf41 0000000f 
Call Trace: [<c01db3ac>] [<c01dbf41>] [<c01d6c44>] [<c01d977d>] [<c019d1d9>] 
   [<c01a0dbc>] [<c01d65bb>] [<c0105000>] [<c0105029>] [<c0105000>] [<c0105596>] 
   [<c0105020>] 
Code: f3 a5 f6 c3 02 74 02 66 a5 f6 c3 01 74 01 a4 8b 44 24 2c 89 


>>EIP; c01d6806 <fb_copy_cmap+96/260>   <=====

>>eax; c027222c <palette_cmap+0/34>
>>esi; c02e1a40 <palette_red+0/20>
>>esp; cfe63e08 <_end+fb7e5d4/1056b7cc>

Trace; c01db3ac <gen_set_cmap+8c/a0>
Trace; c01dbf41 <vesafb_setcolreg+61/e0>
Trace; c01d6c44 <fb_set_cmap+104/130>
Trace; c01d977d <fbcon_switch+17d/1c0>
Trace; c019d1d9 <redraw_screen+c9/140>
Trace; c01a0dbc <take_over_console+ec/180>
Trace; c01d65bb <register_framebuffer+fb/130>
Trace; c0105000 <_stext+0/0>
Trace; c0105029 <init+9/140>
Trace; c0105000 <_stext+0/0>
Trace; c0105596 <kernel_thread+26/30>
Trace; c0105020 <init+0/140>

Code;  c01d6806 <fb_copy_cmap+96/260>
00000000 <_EIP>:
Code;  c01d6806 <fb_copy_cmap+96/260>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c01d6808 <fb_copy_cmap+98/260>
   2:   f6 c3 02                  test   $0x2,%bl
Code;  c01d680b <fb_copy_cmap+9b/260>
   5:   74 02                     je     9 <_EIP+0x9> c01d680f <fb_copy_cmap+9f/260>
Code;  c01d680d <fb_copy_cmap+9d/260>
   7:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c01d680f <fb_copy_cmap+9f/260>
   9:   f6 c3 01                  test   $0x1,%bl
Code;  c01d6812 <fb_copy_cmap+a2/260>
   c:   74 01                     je     f <_EIP+0xf> c01d6815 <fb_copy_cmap+a5/260>
Code;  c01d6814 <fb_copy_cmap+a4/260>
   e:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c01d6815 <fb_copy_cmap+a5/260>
   f:   8b 44 24 2c               mov    0x2c(%esp,1),%eax
Code;  c01d6819 <fb_copy_cmap+a9/260>
  13:   89 00                     mov    %eax,(%eax)

 <0>Kernel panic: Attempted to kill init!

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net

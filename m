From: Kronos <kronos@kronoz.cjb.net>
Subject: [2.5.71] Oops
Date: Mon, 16 Jun 2003 20:53:15 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030616185315.GA4092@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail-8.tiscali.it ([195.130.225.154])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Rz7k-0002x8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 16 Jun 2003 11:54:36 -0700
Received: from dreamland.darkstar.lan (217.133.169.252) by mail-8.tiscali.it (6.7.016)
        id 3EE04D7400650A3C for linux-fbdev-devel@lists.sourceforge.net; Mon, 16 Jun 2003 20:53:50 +0200
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi,
I was using mplayer 0.90 in console (using -vo sdl:fbcon) and when I
switched virtual terminal I got the following oops:


Unable to handle kernel paging request at virtual address f880c000
printing eip:
c02d5ea7
*pde = 2fcea067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02d5ea7>]    Not tainted
EFLAGS: 00010286
EIP is at bitfill32+0x67/0xd0
eax: ffffffff   ebx: f880c000   ecx: ffffffff   edx: 00002000
esi: 04210000   edi: 00002000   ebp: eff85e1c   esp: eff85e08
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=eff84000 task=c17ba740)
Stack: 00000000 ffffffff 04210000 00000000 00002000 eff85e88 c02d63c3 f880c000 
       00000000 04210000 00002000 00000000 00000000 00000010 00000000 00000000 
       00000010 00000078 00000003 00000078 00000000 c02d5e40 00000000 000001e0 
Call Trace:
 [<c02d63c3>] cfb_fillrect+0x153/0x2d0
 [<c02d5e40>] bitfill32+0x0/0xd0
 [<c02c9c81>] accel_clear_margins+0xb1/0xf0
 [<c02cc46a>] fbcon_switch+0x1ba/0x230
 [<c02603e3>] redraw_screen+0x113/0x180
 [<c025b9a8>] complete_change_console+0x38/0xf0
 [<c02634db>] console_callback+0xbb/0xc0
 [<c013afb9>] worker_thread+0x259/0x4c0
 [<c0263420>] console_callback+0x0/0xc0
 [<c011f190>] default_wake_function+0x0/0x30
 [<c010a166>] ret_from_fork+0x6/0x14
 [<c011f190>] default_wake_function+0x0/0x30
 [<c013ad60>] worker_thread+0x0/0x4c0
 [<c010744d>] kernel_thread_helper+0x5/0x18
 
Code: 8b 13 89 f0 31 d0 23 45 f0 31 d0 8d 57 e0 89 03 83 c3 04 c1 


Kernel is UP with CONFIG_PREEMPT=y, video board is a Radeon 9500Pro

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"Chi parla in tono cortese, ma continua a prepararsi, potra` andare avanti;
 chi parla in tono bellicoso e avanza rapidamente dovra` ritirarsi" 
Sun Tzu -- L'arte della guerra


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5

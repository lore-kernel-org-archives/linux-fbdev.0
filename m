From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Kernel oops with current fbdev code
Date: Thu, 13 Mar 2003 11:23:15 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E705C13.7000103@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tPuq-0008Sq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Mar 2003 02:26:24 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: jsimmons@infradead.org
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net


James, Tony, list,

the SiS X driver tries to communicate with sisfb during server startup. 
This is done by fopen()-ing "/dev/fb0" through "/dev/fb7". If the open 
succeeds, a SiS-specific ioctl is done, which is checked to originate 
from sisfb and eventually processed. (This is by the way the same way 
the fbdev X driver probes for available framebuffer devices.)

If no framebuffer is available, the fopen()-calls usually fail. If 
another framebuffer (other than sisfb) is answering, the ioctl either 
fails or does not identify correctly. So far so good.

Under 2.5.63 and 2.5.64 (haven't tried older 2.5 kernels), no matter 
whether using James' latest patch or not, the fopen()-call causes an 
Oops as soon as "/dev/fb3" is probed.

Without having looked at the relevant code, I suspect it something to do 
with the strange fact, that /dev/fbX is not "translated" to fbX as in 
2.4, but fb0, fb32, fb64 - and at fb128 (which is logically the 
"translation" of /dev/fb3) it goes boom.

Here is the syslog from the point on where /dev/fb0 was probed:

Mar  5 12:47:08 oland modprobe: FATAL: Module fb0 not found.
Mar  5 12:47:08 oland modprobe: FATAL: Module fb32 not found.
Mar  5 12:47:08 oland modprobe: FATAL: Module fb64 not found.
Mar  5 12:47:08 oland kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Mar  5 12:47:08 oland kernel:  printing eip:
Mar  5 12:47:08 oland kernel: c024ce74
Mar  5 12:47:08 oland kernel: *pde = 00000000
Mar  5 12:47:08 oland kernel: Oops: 0000
Mar  5 12:47:08 oland kernel: CPU:    0
Mar  5 12:47:08 oland kernel: EIP:    0060:[fb_open+60/180]    Not tainted
Mar  5 12:47:08 oland kernel: EIP:    0060:[<c024ce74>]    Not tainted
Mar  5 12:47:08 oland kernel: EFLAGS: 00013286
Mar  5 12:47:08 oland kernel: EIP is at fb_open+0x3c/0xb4
Mar  5 12:47:08 oland kernel: eax: 00000000   ebx: c1586000   ecx:
c03557c0   edx: 00000001
Mar  5 12:47:08 oland kernel: esi: c03be100   edi: 00000000   ebp:
d9405f28   esp: d9405f1c
Mar  5 12:47:08 oland kernel: ds: 007b   es: 007b   ss: 0068
Mar  5 12:47:08 oland kernel: Process X (pid: 995, threadinfo=d9404000
task=d8927920)
Mar  5 12:47:08 oland kernel: Stack: 00000000 d9953120 dabae6c0 d9405f44
c014792f dabae6c0 d9953120 d9953120
Mar  5 12:47:08 oland kernel:        dabae6c0 00000000 d9405f60 c01402ec
dabae6c0 d9953120 bffff818 d8b94000
Mar  5 12:47:08 oland kernel:        00000002 d9405f9c c0140203 dabb0840
dbfea560 00000002 00000006 0826d160
Mar  5 12:47:08 oland kernel: Call Trace:
Mar  5 12:47:08 oland kernel:  [chrdev_open+63/80] chrdev_open+0x3f/0x50
Mar  5 12:47:08 oland kernel:  [<c014792f>] chrdev_open+0x3f/0x50
Mar  5 12:47:08 oland kernel:  [dentry_open+220/416] dentry_open+0xdc/0x1a0
Mar  5 12:47:08 oland kernel:  [<c01402ec>] dentry_open+0xdc/0x1a0
Mar  5 12:47:08 oland kernel:  [filp_open+79/92] filp_open+0x4f/0x5c
Mar  5 12:47:08 oland kernel:  [<c0140203>] filp_open+0x4f/0x5c
Mar  5 12:47:08 oland kernel:  [sys_open+55/116] sys_open+0x37/0x74
Mar  5 12:47:08 oland kernel:  [<c014059f>] sys_open+0x37/0x74
Mar  5 12:47:08 oland kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar  5 12:47:08 oland kernel:  [<c0108ac7>] syscall_call+0x7/0xb
Mar  5 12:47:08 oland kernel:
Mar  5 12:47:08 oland kernel: Code: 8b 00 85 c0 74 16 83 38 02 74 08 ff
80 c0 00 00 00 eb 09 31

Perhaps needless to say, but under 2.4 there were no such problems.

Questions:

1) Was there any relevant change, making the method of probing /dev/fb0 
to /dev/fb7 by design incompatible?

2) Is this perhaps a bug in fb_open() or any higher level fbdev code?

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net            http://www.winischhofer.net/







-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en

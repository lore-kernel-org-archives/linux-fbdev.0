From: Dave Jones <davej@redhat.com>
Subject: Re: Fwd: [Bug 164337]  New: radeonfb oopses
Date: Thu, 28 Jul 2005 19:08:28 -0400
Message-ID: <20050728230828.GB1742@redhat.com>
References: <20050727193425.GB2388@redhat.com> <1122538735.18835.19.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyHUW-0002Bx-Sx
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 16:08:40 -0700
Received: from mx1.redhat.com ([66.187.233.31])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1DyHUU-0000BI-D7
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 16:08:40 -0700
Content-Disposition: inline
In-Reply-To: <1122538735.18835.19.camel@gaston>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, notting@redhat.com

On Thu, Jul 28, 2005 at 09:18:54AM +0100, Ben Herrenschmidt wrote:
 > On Wed, 2005-07-27 at 15:34 -0400, Dave Jones wrote:
 > > This was on a git snapshot from a day or two ago.
 > 
 > I'll have a look when I'm done travelling ... maybe this week-end or
 > monday. Can you CC the linux-fbdev list in the meantime ? I wonder if
 > it's related to some cmap handling changes I've seen floating around...
 > 
 > Thanks,
 > Ben.

BenH asked me to forward this here.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=164337

git snapshot from a few days ago yields this oops..

radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=252.00 Mhz, System=200.00 MHz
radeonfb: PLL min 20000 max 35000
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: SXGA+ Single (85MHz)
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Dynamic Clock Power Management enabled
radeonfb: forcefully enabling sleep mode
Unable to handle kernel paging request at virtual address fffffff6
 printing eip:
c02311f1
*pde = 00002067
Oops: 0000 [#1]
Modules linked in: radeonfb i2c_algo_bit nfs lockd nfs_acl tun arc4
ieee80211_crypt_wep radeon drm loop parport_pc lp parport ipv6 autofs4 sunrpc
ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod video button
battery ac pcmcia yenta_socket rsrc_nonstatic pcmcia_core uhci_hcd ehci_hcd
shpchp hw_random i8xx_tco i2c_i801 i2c_core snd_intel8x0m snd_intel8x0
snd_ac97_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq
snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore
snd_page_alloc e1000 ipw2200 ieee80211 ieee80211_crypt ext3 jbd
CPU:    0
EIP:    0060:[<c02311f1>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-1.1435_FC5)
EIP is at fb_set_logocmap+0x79/0xee
eax: 00000020   ebx: fffffff6   ecx: 00000000   edx: 00000010
esi: 00000000   edi: 00000010   ebp: 00000000   esp: ef26bc2c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 25357, threadinfo=ef26b000 task=f1b0b000)
Stack: c045f154 eb944000 00000008 00000282 00000002 00000004 d67c2208 eb944000
       00000007 00000000 00000000 f90d8000 00000010 00000001 c015cca3 d67c21f4
       de3bcb10 00ffffff 00ffff00 00000000 00000010 c04a4c60 c04a4c40 f8c03a85
Call Trace:
 [<c015cca3>] poison_obj+0x20/0x3d
 [<f8c03a85>] radeonfb_setcmap+0xc7/0x4b9 [radeonfb]
 [<c023180d>] fb_show_logo+0x1af/0x1f5
 [<c02306ce>] bit_clear_margins+0xa2/0xdb
 [<c022eaa5>] fbcon_switch+0x474/0x4c4
 [<c026f110>] redraw_screen+0xab/0x1ba
 [<c026e8df>] update_attr+0x8c/0x9d
 [<c02720eb>] take_over_console+0x26f/0x35a
 [<c015eac7>] cache_alloc_refill+0xc8/0x389
 [<c01d5113>] sysfs_make_dirent+0x13/0x81
 [<c015cca3>] poison_obj+0x20/0x3d
 [<c022b4db>] fbcon_takeover+0x69/0xa0
 [<c0135799>] notifier_call_chain+0x17/0x27
 [<c0232553>] register_framebuffer+0xd3/0x181
 [<c012df54>] process_timeout+0x0/0x5
 [<c012e334>] msleep+0x30/0x38
 [<f8c0c9d4>] radeon_pm_enable_dynamic_mode+0x1ce6/0x28c9 [radeonfb]
 [<c01227a5>] printk+0x1b/0x1f
 [<f8c07f6b>] radeonfb_pci_register+0x2e7/0x54b [radeonfb]
 [<c0216af0>] kobject_hotplug+0x2a4/0x39e
 [<c0223494>] __pci_device_probe+0x30/0x3d
 [<c02234bf>] pci_device_probe+0x1e/0x35
 [<c0291a3d>] driver_probe_device+0x35/0x9e
 [<c0291b58>] __driver_attach+0x45/0x47
 [<c02912f5>] bus_for_each_dev+0x3c/0x5a
 [<c0291b70>] driver_attach+0x16/0x1a
 [<c0291b13>] __driver_attach+0x0/0x47
 [<c02916be>] bus_add_driver+0x66/0xaf
 [<c02236a4>] pci_register_driver+0x97/0xb7
 [<c01486c4>] sys_init_module+0xca/0x1c4
 [<c0103b15>] syscall_call+0x7/0xb
Code: 31 d2 89 c7 29 d7 89 fa 83 ff 10 7e 0a bf 10 00 00 00 ba 10 00 00 00 8d 45
20 89 44 24 68 89 54 24 6c 85 ff 7e 53 31 f6 8d 0c 36 <0f> b6 03 89 c2 c1 e2 08
66 0f b6 c0 09 c2 8b 44 24 70 66 89 14




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

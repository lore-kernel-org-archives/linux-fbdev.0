From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: mode setting and console locking, nvidia failure
Date: Sun, 16 May 2004 21:51:45 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040517045145.3255.qmail@web14921.mail.yahoo.com>
References: <1084767356.7777.25.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPa6L-00062Y-EB
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 21:51:45 -0700
Received: from web14921.mail.yahoo.com ([216.136.225.5])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BPa6L-000669-5u
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 21:51:45 -0700
In-Reply-To: <1084767356.7777.25.camel@gaston>
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
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

I'll debug this more in the morning. I tried swapping a Geforce2 for my Radeon
just to see if I got the same failure. I can't tell since every mode I tried
setting on the Geforce2 faults the drivers.

rivafb: nVidia device/chipset 10DE0150
rivafb: RIVA MTRR set to ON
rivafb: PCI nVidia NV10 framebuffer ver 0.9.5b (nVidiaGeForce2-G, 32MB @ 0xF0000
000)
divide error: 0000 [#1]
SMP
Modules linked in: snd_mixer_oss rivafb vgastate cfbimgblt snd_intel8x0 snd_ac97
_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_devi
ce snd soundcore lm85 i2c_i801 eeprom i2c_sensor ipv6 parport_pc lp parport auto
fs4 sunrpc e1000 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables ide_
cd cdrom floppy sg ohci1394 ieee1394 8250 serial_core nls_iso8859_1 nls_cp437 vf
at fat joydev evdev usbhid ehci_hcd uhci_hcd usbcore thermal processor fan butto
n raid1 md ata_piix libata sd_mod scsi_mod
CPU:    0
EIP:    0060:[<f8ae3d10>]    Not tainted
EFLAGS: 00010202   (2.6.6)
EIP is at nv10CalcArbitration+0xf6/0x352 [rivafb]
eax: 03a2c940   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 01036640   edi: 0fffffff   ebp: ed195c14   esp: ed195bb4
ds: 007b   es: 007b   ss: 0068
Process fbset (pid: 4381, threadinfo=ed194000 task=f70ae640)
Stack: c16ebae0 01036640 0000003d 01e84800 00030f00 c16ebae0 00000001 00000001
       00000011 ed195c14 00000000 00000000 000061e0 00000000 00000200 00000001
       00000013 00000008 00000000 00000002 00000010 0fffff0f 00000000 0fffffff
Call Trace:
 [<c0106b4b>] show_stack+0x80/0x96
 [<c0106ce2>] show_registers+0x15f/0x1ae
 [<c0106e57>] die+0x8d/0xfb
 [<c0106f83>] do_divide_error+0xbe/0xdd
 [<c01067f1>] error_code+0x2d/0x38
 [<f8ae404e>] nv10UpdateArbitrationSettings+0xe2/0x11d [rivafb]
 [<f8ae44d1>] CalcStateExt+0x1d6/0x2b5 [rivafb]
 [<f8ae07f2>] riva_load_video_mode+0x473/0x625 [rivafb]
 [<f8ae1000>] rivafb_set_par+0x1d/0x54 [rivafb]
 [<c02315f2>] fb_set_var+0xe8/0xea
 [<c02317fc>] fb_ioctl+0x10f/0x28c
 [<c0161781>] sys_ioctl+0xfe/0x258
 [<c0105d35>] sysenter_past_esp+0x52/0x71
 
Code: f7 7d d4 8b 55 e0 69 d2 40 42 0f 00 89 45 bc 89 d0 99 f7 7d
  


=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click

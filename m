From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [2.6.10-bk6] oops in load of atyfb
Date: Wed, 5 Jan 2005 16:56:15 -0800
Message-ID: <20050105165615.1f3bfd94.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__5_Jan_2005_16_56_15_-0800_CL9yULfOP7wMOdi5"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CmLx3-0006Zx-Sf
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 Jan 2005 16:56:33 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CmLwz-0002ls-3v
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 Jan 2005 16:56:33 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Bill Davidsen <davidsen@tmr.com>

This is a multi-part message in MIME format.

--Multipart=_Wed__5_Jan_2005_16_56_15_-0800_CL9yULfOP7wMOdi5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Wed, 5 Jan 2005 16:24:02 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6.10-bk6] oops in load of atyfb


After some hours of trying to get video to the atyfb instead of vga16, I 
got this. The video= boot option didn't seem to work, loading the module 
caused an oops.

Something borked, out of time to fight with it.


--Multipart=_Wed__5_Jan_2005_16_56_15_-0800_CL9yULfOP7wMOdi5
Content-Type: TEXT/PLAIN;
 name="kso-atyfb"
Content-Disposition: attachment;
 filename="kso-atyfb"
Content-Transfer-Encoding: 7bit

ksymoops 2.4.4 on i686 2.6.7-rc1-mm1nd.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.10-bk6/ (specified)
     -m /boot/System.map-2.6.10-bk6 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jan  3 18:37:45 oddball kernel:   Receiver lock-up bug exists -- enabling work-around.
Jan  5 14:30:04 oddball kernel:   Receiver lock-up bug exists -- enabling work-around.
Jan  5 14:33:48 oddball kernel:   Receiver lock-up bug exists -- enabling work-around.
Jan  5 14:43:45 oddball kernel:   Receiver lock-up bug exists -- enabling work-around.
Jan  5 15:18:21 oddball kernel:   Receiver lock-up bug exists -- enabling work-around.
Jan  5 15:25:39 oddball kernel:   Receiver lock-up bug exists -- enabling work-around.
Jan  5 15:32:52 oddball kernel:   Receiver lock-up bug exists -- enabling work-around.
Jan  5 15:41:34 oddball kernel:   Receiver lock-up bug exists -- enabling work-around.
Jan  5 15:46:03 oddball kernel: debug atyfb: Mach64 non-shadow register values:
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x2000:  004F0063 000C0052 01DF020C 000201EA
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x2010:  015C0000 14000000 00000000 0B000200
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x2020:  005807EE 007607A5 00000000 00382848
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x2030:  00000000 00000202 00000000 0000C000
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x2040:  00000000 00000000 00000000 056007F2
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x2050:  03F805B5 00000000 00000000 00000000
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x2060:  FFFFFF00 00000000 000FFF80 006F0334
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x2070:  00000000 00000000 00007FDD 00803800
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x2080:  04100400 00801000 00000000 00000000
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x2090:  00A63003 00000000 02030000 00000000
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x20A0:  7B23A150 00000000 00000000 75000C01
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x20B0:  10753A7B 00010000 00010000 00000000
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x20C0:  00FF00FD 87010102 00000000 00000000
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x20D0:  00000188 00000170 00000000 00003D46
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x20E0:  7C004742 00000014 00000000 00000000
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x20F0:  00000000 00004FA8 F42004F8 00000000
Jan  5 15:46:03 oddball kernel: debug atyfb: Mach64 PLL register values:
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x00:  ADD51F64 D803FFDA F5DADA01 A61B0000
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x10:  00008000 10A2CC10 00000000 00000000
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x20:  ADD51F64 D803FFDA F5DADA01 A61B0000
Jan  5 15:46:03 oddball kernel: debug atyfb: 0x30:  00008000 10A2CC10 00000000 00000000
Jan  5 15:46:03 oddball kernel: Unable to handle kernel paging request at virtual address c04cc2dc
Jan  5 15:46:03 oddball kernel: c023ce46
Jan  5 15:46:03 oddball kernel: *pde = 0053e027
Jan  5 15:46:03 oddball kernel: Oops: 0000 [#1]
Jan  5 15:46:03 oddball kernel: CPU:    0
Jan  5 15:46:03 oddball kernel: EIP:    0060:[<c023ce46>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Jan  5 15:46:03 oddball kernel: EFLAGS: 00010286   (2.6.10-bk6) 
Jan  5 15:46:03 oddball kernel: eax: 000001e0   ebx: c3e8a000   ecx: 00000008   edx: c04cc2d4
Jan  5 15:46:03 oddball kernel: esi: c882b400   edi: 00000001   ebp: 0000001e   esp: c3f75bec
Jan  5 15:46:03 oddball kernel: ds: 007b   es: 007b   ss: 0068
Jan  5 15:46:03 oddball kernel: Stack: 00000008 c3e8a000 00000720 c0236127 c3e8a000 00000018 00000020 0000000b 
Jan  5 15:46:03 oddball kernel:        00000060 00000002 00000003 00000000 00000000 00000000 00000050 0000001e 
Jan  5 15:46:03 oddball kernel:        00000050 c882b400 c3e8a000 c882b400 0000001e 00000001 c0237143 c882b400 
Jan  5 15:46:03 oddball kernel:  [<c0236127>] fbcon_prepare_logo+0x57/0x3e0
Jan  5 15:46:03 oddball kernel:  [<c0237143>] fbcon_init+0x263/0x2e0
Jan  5 15:46:03 oddball kernel:  [<c027bb89>] visual_init+0xd9/0x150
Jan  5 15:46:03 oddball kernel:  [<c027f766>] take_over_console+0x196/0x390
Jan  5 15:46:03 oddball kernel:  [<c013de67>] alloc_slabmgmt+0x57/0x70
Jan  5 15:46:03 oddball kernel:  [<c0236098>] fbcon_takeover+0x78/0xb0
Jan  5 15:46:03 oddball kernel:  [<c023b3d6>] fbcon_fb_registered+0x76/0x90
Jan  5 15:46:03 oddball kernel:  [<c023b45b>] fbcon_event_notify+0x6b/0xa0
Jan  5 15:46:03 oddball kernel:  [<c01270cd>] notifier_call_chain+0x2d/0x50
Jan  5 15:46:03 oddball kernel:  [<c023e06f>] register_framebuffer+0xff/0x190
Jan  5 15:46:03 oddball kernel:  [<c0240021>] fb_alloc_cmap+0xb1/0xf0
Jan  5 15:46:03 oddball kernel:  [<ca854578>] aty_init+0x488/0x950 [atyfb]
Jan  5 15:46:03 oddball kernel:  [<c04b4780>] modedb+0x0/0xb60
Jan  5 15:46:03 oddball kernel:  [<c011b6ff>] call_console_drivers+0x6f/0x130
Jan  5 15:46:03 oddball kernel:  [<ca8bf8b9>] atyfb_pci_probe+0x1d9/0x250 [atyfb]
Jan  5 15:46:03 oddball kernel:  [<c0230702>] pci_device_probe_static+0x52/0x70
Jan  5 15:46:03 oddball kernel:  [<c023075c>] __pci_device_probe+0x3c/0x50
Jan  5 15:46:03 oddball kernel:  [<c023079c>] pci_device_probe+0x2c/0x50
Jan  5 15:46:03 oddball kernel:  [<c02a80ef>] driver_probe_device+0x2f/0x80
Jan  5 15:46:03 oddball kernel:  [<c02a823c>] driver_attach+0x5c/0x90
Jan  5 15:46:03 oddball kernel:  [<c02a875d>] bus_add_driver+0x9d/0xd0
Jan  5 15:46:03 oddball kernel:  [<c02a8d6f>] driver_register+0x2f/0x40
Jan  5 15:46:03 oddball kernel:  [<c0230a24>] pci_register_driver+0x64/0x90
Jan  5 15:46:03 oddball kernel:  [<ca854c3f>] init_module+0xf/0x20 [atyfb]
Jan  5 15:46:03 oddball kernel:  [<c0131dcc>] sys_init_module+0x1ac/0x1d0
Jan  5 15:46:03 oddball kernel:  [<c0102f23>] syscall_call+0x7/0xb
Jan  5 15:46:03 oddball kernel: Code: f9 03 77 7e 83 f9 02 74 6d 8d b6 00 00 00 00 8d bf 00 00 00 00 89 14 24 e8 b8 f7 ff ff a3 18 3d 51 c0 85 c0 89 c2 74 08 8b 43 0c <39> 42 08 76 16 31 db 31 c0 89 1d 18 3d 51 c0 8b 5c 24 04 8b 7c 

>>EIP; c023ce46 <fb_prepare_logo+76/110>   <=====
Code;  c023ce1b <fb_prepare_logo+4b/110>
00000000 <_EIP>:
Code;  c023ce1b <fb_prepare_logo+4b/110>
   0:   f9                        stc    
Code;  c023ce1c <fb_prepare_logo+4c/110>
   1:   03 77 7e                  add    0x7e(%edi),%esi
Code;  c023ce1f <fb_prepare_logo+4f/110>
   4:   83 f9 02                  cmp    $0x2,%ecx
Code;  c023ce22 <fb_prepare_logo+52/110>
   7:   74 6d                     je     76 <_EIP+0x76> c023ce91 <fb_prepare_logo+c1/110>
Code;  c023ce24 <fb_prepare_logo+54/110>
   9:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c023ce2a <fb_prepare_logo+5a/110>
   f:   8d bf 00 00 00 00         lea    0x0(%edi),%edi
Code;  c023ce30 <fb_prepare_logo+60/110>
  15:   89 14 24                  mov    %edx,(%esp,1)
Code;  c023ce33 <fb_prepare_logo+63/110>
  18:   e8 b8 f7 ff ff            call   fffff7d5 <_EIP+0xfffff7d5> c023c5f0 <fb_find_logo+0/30>
Code;  c023ce38 <fb_prepare_logo+68/110>
  1d:   a3 18 3d 51 c0            mov    %eax,0xc0513d18
Code;  c023ce3d <fb_prepare_logo+6d/110>
  22:   85 c0                     test   %eax,%eax
Code;  c023ce3f <fb_prepare_logo+6f/110>
  24:   89 c2                     mov    %eax,%edx
Code;  c023ce41 <fb_prepare_logo+71/110>
  26:   74 08                     je     30 <_EIP+0x30> c023ce4b <fb_prepare_logo+7b/110>
Code;  c023ce43 <fb_prepare_logo+73/110>
  28:   8b 43 0c                  mov    0xc(%ebx),%eax
Code;  c023ce46 <fb_prepare_logo+76/110>   <=====
  2b:   39 42 08                  cmp    %eax,0x8(%edx)   <=====
Code;  c023ce49 <fb_prepare_logo+79/110>
  2e:   76 16                     jbe    46 <_EIP+0x46> c023ce61 <fb_prepare_logo+91/110>
Code;  c023ce4b <fb_prepare_logo+7b/110>
  30:   31 db                     xor    %ebx,%ebx
Code;  c023ce4d <fb_prepare_logo+7d/110>
  32:   31 c0                     xor    %eax,%eax
Code;  c023ce4f <fb_prepare_logo+7f/110>
  34:   89 1d 18 3d 51 c0         mov    %ebx,0xc0513d18
Code;  c023ce55 <fb_prepare_logo+85/110>
  3a:   8b 5c 24 04               mov    0x4(%esp,1),%ebx
Code;  c023ce59 <fb_prepare_logo+89/110>
  3e:   8b                        .byte 0x8b
Code;  c023ce5a <fb_prepare_logo+8a/110>
  3f:   7c                        .byte 0x7c

Jan  5 16:01:18 oddball kernel:   Receiver lock-up bug exists -- enabling work-around.
Jan  5 16:04:09 oddball kernel:   Receiver lock-up bug exists -- enabling work-around.
Jan  5 16:05:34 oddball kernel: debug atyfb: Mach64 non-shadow register values:
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x2000:  004F0063 000C0052 01DF020C 000201EA
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x2010:  015C0000 14000000 00000000 0B000200
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x2020:  005807EE 007607A5 00000000 00382848
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x2030:  00000000 00000202 00000000 0000C000
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x2040:  00000000 00000000 00000000 056007F2
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x2050:  03F805B5 00000000 00000000 00000000
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x2060:  FFFFFF00 00000000 00000000 00000000
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x2070:  00000000 00000000 00007FDD 00803800
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x2080:  04100400 00801000 00000000 00000000
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x2090:  00A63003 00000000 02030000 00000000
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x20A0:  7B23A150 00000000 00000000 75000C01
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x20B0:  10753A7B 00010000 00010000 00000000
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x20C0:  00FF0010 87010182 00000000 00000000
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x20D0:  00000108 00000170 00000000 00003D42
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x20E0:  7C004742 00000014 00000000 00000000
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x20F0:  00000000 00004FA8 F42004F8 00000000
Jan  5 16:05:34 oddball kernel: debug atyfb: Mach64 PLL register values:
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x00:  ADD51F64 D803FFDA F5DADA01 A61B0000
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x10:  00008000 10A2CC10 00000000 00000000
Jan  5 16:05:34 oddball kernel: debug atyfb: 0x20:  ADD51F64 D803FFDA F5DADA01 A61B0000
Jan  5 16:05:35 oddball kernel: debug atyfb: 0x30:  00008000 10A2CC10 00000000 00000000
Jan  5 16:05:35 oddball kernel: Unable to handle kernel paging request at virtual address c04cc2dc
Jan  5 16:05:35 oddball kernel: c023ce46
Jan  5 16:05:35 oddball kernel: *pde = 0053e027
Jan  5 16:05:35 oddball kernel: Oops: 0000 [#1]
Jan  5 16:05:35 oddball kernel: CPU:    0
Jan  5 16:05:35 oddball kernel: EIP:    0060:[<c023ce46>]    Not tainted VLI
Jan  5 16:05:35 oddball kernel: EFLAGS: 00010286   (2.6.10-bk6) 
Jan  5 16:05:35 oddball kernel: eax: 000001e0   ebx: c736f800   ecx: 00000008   edx: c04cc2d4
Jan  5 16:05:35 oddball kernel: esi: c1146000   edi: 00000001   ebp: 0000001e   esp: c731dbec
Jan  5 16:05:35 oddball kernel: ds: 007b   es: 007b   ss: 0068
Jan  5 16:05:35 oddball kernel: Stack: 00000008 c736f800 00000720 c0236127 c736f800 00000018 00000020 0000000b 
Jan  5 16:05:35 oddball kernel:        00000060 00000002 00000003 00000000 00000000 00000000 00000050 0000001e 
Jan  5 16:05:35 oddball kernel:        00000050 c1146000 c736f800 c1146000 0000001e 00000001 c0237143 c1146000 
Jan  5 16:05:35 oddball kernel:  [<c0236127>] fbcon_prepare_logo+0x57/0x3e0
Jan  5 16:05:35 oddball kernel:  [<c0237143>] fbcon_init+0x263/0x2e0
Jan  5 16:05:35 oddball kernel:  [<c027bb89>] visual_init+0xd9/0x150
Jan  5 16:05:35 oddball kernel:  [<c027f766>] take_over_console+0x196/0x390
Jan  5 16:05:35 oddball kernel:  [<c013de67>] alloc_slabmgmt+0x57/0x70
Jan  5 16:05:35 oddball kernel:  [<c0236098>] fbcon_takeover+0x78/0xb0
Jan  5 16:05:35 oddball kernel:  [<c023b3d6>] fbcon_fb_registered+0x76/0x90
Jan  5 16:05:35 oddball kernel:  [<c023b45b>] fbcon_event_notify+0x6b/0xa0
Jan  5 16:05:35 oddball kernel:  [<c01270cd>] notifier_call_chain+0x2d/0x50
Jan  5 16:05:35 oddball kernel:  [<c023e06f>] register_framebuffer+0xff/0x190
Jan  5 16:05:35 oddball kernel:  [<c0240021>] fb_alloc_cmap+0xb1/0xf0
Jan  5 16:05:35 oddball kernel:  [<ca854578>] aty_init+0x488/0x950 [atyfb]
Jan  5 16:05:35 oddball kernel:  [<c04b4780>] modedb+0x0/0xb60
Jan  5 16:05:35 oddball kernel:  [<c011b6ff>] call_console_drivers+0x6f/0x130
Jan  5 16:05:35 oddball kernel:  [<ca8a28b9>] atyfb_pci_probe+0x1d9/0x250 [atyfb]
Jan  5 16:05:35 oddball kernel:  [<c0230702>] pci_device_probe_static+0x52/0x70
Jan  5 16:05:35 oddball kernel:  [<c023075c>] __pci_device_probe+0x3c/0x50
Jan  5 16:05:35 oddball kernel:  [<c023079c>] pci_device_probe+0x2c/0x50
Jan  5 16:05:35 oddball kernel:  [<c02a80ef>] driver_probe_device+0x2f/0x80
Jan  5 16:05:35 oddball kernel:  [<c02a823c>] driver_attach+0x5c/0x90
Jan  5 16:05:35 oddball kernel:  [<c02a875d>] bus_add_driver+0x9d/0xd0
Jan  5 16:05:35 oddball kernel:  [<c02a8d6f>] driver_register+0x2f/0x40
Jan  5 16:05:35 oddball kernel:  [<c0230a24>] pci_register_driver+0x64/0x90
Jan  5 16:05:35 oddball kernel:  [<ca854c3f>] init_module+0xf/0x20 [atyfb]
Jan  5 16:05:35 oddball kernel:  [<c0131dcc>] sys_init_module+0x1ac/0x1d0
Jan  5 16:05:35 oddball kernel:  [<c0102f23>] syscall_call+0x7/0xb
Jan  5 16:05:35 oddball kernel: Code: f9 03 77 7e 83 f9 02 74 6d 8d b6 00 00 00 00 8d bf 00 00 00 00 89 14 24 e8 b8 f7 ff ff a3 18 3d 51 c0 85 c0 89 c2 74 08 8b 43 0c <39> 42 08 76 16 31 db 31 c0 89 1d 18 3d 51 c0 8b 5c 24 04 8b 7c 

>>EIP; c023ce46 <fb_prepare_logo+76/110>   <=====
Code;  c023ce1b <fb_prepare_logo+4b/110>
00000000 <_EIP>:
Code;  c023ce1b <fb_prepare_logo+4b/110>
   0:   f9                        stc    
Code;  c023ce1c <fb_prepare_logo+4c/110>
   1:   03 77 7e                  add    0x7e(%edi),%esi
Code;  c023ce1f <fb_prepare_logo+4f/110>
   4:   83 f9 02                  cmp    $0x2,%ecx
Code;  c023ce22 <fb_prepare_logo+52/110>
   7:   74 6d                     je     76 <_EIP+0x76> c023ce91 <fb_prepare_logo+c1/110>
Code;  c023ce24 <fb_prepare_logo+54/110>
   9:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c023ce2a <fb_prepare_logo+5a/110>
   f:   8d bf 00 00 00 00         lea    0x0(%edi),%edi
Code;  c023ce30 <fb_prepare_logo+60/110>
  15:   89 14 24                  mov    %edx,(%esp,1)
Code;  c023ce33 <fb_prepare_logo+63/110>
  18:   e8 b8 f7 ff ff            call   fffff7d5 <_EIP+0xfffff7d5> c023c5f0 <fb_find_logo+0/30>
Code;  c023ce38 <fb_prepare_logo+68/110>
  1d:   a3 18 3d 51 c0            mov    %eax,0xc0513d18
Code;  c023ce3d <fb_prepare_logo+6d/110>
  22:   85 c0                     test   %eax,%eax
Code;  c023ce3f <fb_prepare_logo+6f/110>
  24:   89 c2                     mov    %eax,%edx
Code;  c023ce41 <fb_prepare_logo+71/110>
  26:   74 08                     je     30 <_EIP+0x30> c023ce4b <fb_prepare_logo+7b/110>
Code;  c023ce43 <fb_prepare_logo+73/110>
  28:   8b 43 0c                  mov    0xc(%ebx),%eax
Code;  c023ce46 <fb_prepare_logo+76/110>   <=====
  2b:   39 42 08                  cmp    %eax,0x8(%edx)   <=====
Code;  c023ce49 <fb_prepare_logo+79/110>
  2e:   76 16                     jbe    46 <_EIP+0x46> c023ce61 <fb_prepare_logo+91/110>
Code;  c023ce4b <fb_prepare_logo+7b/110>
  30:   31 db                     xor    %ebx,%ebx
Code;  c023ce4d <fb_prepare_logo+7d/110>
  32:   31 c0                     xor    %eax,%eax
Code;  c023ce4f <fb_prepare_logo+7f/110>
  34:   89 1d 18 3d 51 c0         mov    %ebx,0xc0513d18
Code;  c023ce55 <fb_prepare_logo+85/110>
  3a:   8b 5c 24 04               mov    0x4(%esp,1),%ebx
Code;  c023ce59 <fb_prepare_logo+89/110>
  3e:   8b                        .byte 0x8b
Code;  c023ce5a <fb_prepare_logo+8a/110>
  3f:   7c                        .byte 0x7c

Jan  5 16:09:11 oddball kernel:   Receiver lock-up bug exists -- enabling work-around.

1 error issued.  Results may not be reliable.

--Multipart=_Wed__5_Jan_2005_16_56_15_-0800_CL9yULfOP7wMOdi5
Content-Type: TEXT/PLAIN;
 name="dmesg-2.6.10-bk6-atyfb"
Content-Disposition: attachment;
 filename="dmesg-2.6.10-bk6-atyfb"
Content-Transfer-Encoding: 7bit

Linux version 2.6.10-bk6 (root@newsmst01b.news.prodigy.com) (gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-42)) #4 Wed Jan 5 15:09:32 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e7400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000040fdc00 (usable)
 BIOS-e820: 00000000040fdc00 - 00000000040ff800 (ACPI data)
 BIOS-e820: 00000000040ff800 - 00000000040ffc00 (ACPI NVS)
 BIOS-e820: 00000000040ffc00 - 000000000a000000 (usable)
 BIOS-e820: 00000000fffe7400 - 0000000100000000 (reserved)
160MB LOWMEM available.
On node 0 totalpages: 40960
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 36864 pages, LIFO batch:9
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
__iounmap: bad address c00f0000
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6f50
ACPI: RSDT (v001 PTLTD    RSDT   0x00000000 PTL  0x01000000) @ 0x040fdfef
ACPI: FADT (v001 DELL   WILLIAM  0x00000000 PTL  0x000f4240) @ 0x040ff78c
ACPI: DSDT (v001  Intel   AR44BX 0x00000000 MSFT 0x01000000) @ 0x00000000
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=2.6.10-bk6 ro root=303 BOOT_FILE=/boot/vmlinuz-2.6.10-bk6 nmi_watchdog=2 acpi=force video=atyfb:1024x768-24 lapic
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c04da000 soft=c04d9000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 348.614 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 157032k/163840k available (2686k kernel code, 6236k reserved, 1011k data, 216k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 686.08 BogoMIPS (lpj=343040)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0183fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps:        0183fbf7 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Deschutes) stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0e08)
testing NMI watchdog ... OK.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 211k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd994, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041210
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:00' and the driver 'system'
pnp: 00:00: ioport range 0x7000-0x700f has been reserved
pnp: 00:00: ioport range 0x8000-0x803f could not be reserved
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
vesafb: probe of vesafb0 failed with error -6
ACPI: Fan [FAN1] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2])
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 123M
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized drm 1.0.0 20040925
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:09' and the driver 'serial'
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256) (6 bit encapsulation enabled).
CSLIP: code copyright 1989 Regents of the University of California.
SLIP linefill/keepalive option.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1080-0x1087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1088-0x108f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 90845D4, ATA DISK drive
hdb: WDC AC31600H, ATA DISK drive
hdb: Disabling (U)DMA for WDC AC31600H (blacklisted)
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
hdc: NEC CD-ROM DRIVE:28C, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdb: max request size: 128KiB
hdb: 3173184 sectors (1624 MB) w/128KiB Cache, CHS=3148/16/63
hdb: cache flushes not supported
 hdb: hdb1 hdb2 hdb3
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
input: PC Speaker
NET: Registered protocol family 26
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (1280 buckets, 10240 max) - 336 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
IPVS: Registered protocols (TCP, UDP, AH, ESP)
IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
IPVS: Each connection entry needs 120 bytes at least
IPVS: ipvs loaded.
IPVS: [rr] scheduler registered.
IPVS: [wrr] scheduler registered.
IPVS: [lc] scheduler registered.
IPVS: [wlc] scheduler registered.
IPVS: [lblc] scheduler registered.
IPVS: [lblcr] scheduler registered.
IPVS: [dh] scheduler registered.
IPVS: [sh] scheduler registered.
IPVS: [sed] scheduler registered.
IPVS: [nq] scheduler registered.
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ACPI wakeup devices: 
PCI0 USB0 UAR1 
ACPI: (supports S0 S1 S4 S5)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 216k freed
Adding 200804k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
spurious 8259A interrupt: IRQ7.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdc: DMA disabled
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:0a' and the driver 'parport_pc'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: Legacy device
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 9 (level, low) -> IRQ 9
eth0: 0000:00:06.0, 00:90:27:07:F2:9E, IRQ 9.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 713807-002, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
lp0: using parport0 (interrupt-driven).
lp0: console ready
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: CPU0 updated from revision 0x29 to 0x40, date = 05251999 
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
cdrom: This disc doesn't have any tracks I recognize!

--Multipart=_Wed__5_Jan_2005_16_56_15_-0800_CL9yULfOP7wMOdi5
Content-Type: TEXT/PLAIN;
 name="lspci-atyfb"
Content-Disposition: attachment;
 filename="lspci-atyfb"
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Flags: bus master, medium devsel, latency 64
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f4200000-f5ffffff

00:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05)
	Subsystem: Intel Corp. 82558 10/100 with Wake on LAN
	Flags: bus master, medium devsel, latency 66, IRQ 9
	Memory at f4121000 (32-bit, prefetchable) [size=4K]
	I/O ports at 1000 [size=32]
	Memory at f4000000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 1

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 64
	I/O ports at 1080 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at 1020 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Flags: medium devsel, IRQ 9

00:0e.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device 1234
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at 1040 [size=32]
	Capabilities: [80] Power Management version 2

00:0e.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device 1234
	Flags: bus master, medium devsel, latency 64, IRQ 3
	I/O ports at 1060 [size=32]
	Capabilities: [80] Power Management version 2

00:0e.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 20 [EHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device 1234
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at f4120000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

00:10.0 Multimedia audio controller: Aureal Semiconductor Vortex 1 (rev 02)
	Subsystem: Voyetra Technologies Montego
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at f4100000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at 1098 [size=8]
	I/O ports at 1090 [size=8]
	Capabilities: [dc] Power Management version 1

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c) (prog-if 00 [VGA])
	Subsystem: Intel Corp. Xpert 98D AGP 2X
	Flags: bus master, stepping, medium devsel, latency 66, IRQ 11
	Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	I/O ports at 9000 [size=256]
	Memory at f4200000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0


--Multipart=_Wed__5_Jan_2005_16_56_15_-0800_CL9yULfOP7wMOdi5--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

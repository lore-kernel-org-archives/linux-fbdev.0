From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 18912] New: BUG: unable to
 handle kernel NULL pointer dereference at (null)
Date: Mon, 20 Sep 2010 16:18:40 -0700
Message-ID: <20100920161840.300d1b53.akpm@linux-foundation.org>
References: <bug-18912-10286@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1OxpWb-0001E3-C0
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Sep 2010 23:11:53 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OxpWX-000382-SL
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Sep 2010 23:11:53 +0000
In-Reply-To: <bug-18912-10286@https.bugzilla.kernel.org/>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: thomas.creutz@gmx.de, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Mon, 20 Sep 2010 22:34:17 GMT bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=18912
> 
>            Summary: BUG: unable to handle kernel NULL pointer dereference
>                     at (null)
>            Product: IO/Storage
>            Version: 2.5
>     Kernel Version: 2.6.35
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>         AssignedTo: io_other@kernel-bugs.osdl.org
>         ReportedBy: thomas.creutz@gmx.de
>         Regression: No
> 
> 
> Created an attachment (id=30872)
>  --> (https://bugzilla.kernel.org/attachment.cgi?id=30872)
> full dmesg
> 
> at restart with ubuntu mainline kernel from there
> (http://kernel.ubuntu.com/~kernel-ppa/mainline/v2.6.35.4-maverick/) I get the
> following bug:

This is a bit strange.  We dereferenced a NULL pointer in
__mutex_lock_slowpath(), but where did it come from?  fb_release() does

	mutex_lock(&info->lock);

but for that to be exactly zero, `info' must have been a small negative
number.


> [   43.635104] BUG: unable to handle kernel NULL pointer dereference at (null)
> [   43.635125] IP: [<ffffffff81576249>] __mutex_lock_slowpath+0xa9/0x170
> [   43.635144] PGD 2333cd067 PUD 2333ce067 PMD 0 
> [   43.635159] Oops: 0002 [#1] SMP 
> [   43.635171] last sysfs file: /sys/devices/platform/f71882fg.2560/temp3_input
> [   43.635185] CPU 4 
> [   43.635188] Modules linked in: ipt_LOG ip6t_LOG ip6t_rt ipt_REDIRECT
> xt_multiport xt_recent xt_tcpudp xt_limit nf_conntrack_ipv6 xt_state
> ip6table_filter ip6_tables iptable_mangle iptable_nat nf_nat iptable_filter
> nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4 ip_tables x_tables nouveau ttm
> drm_kms_helper drm i7core_edac i2c_algo_bit edac_core f71882fg coretemp raid10
> raid456 async_raid6_recov async_pq raid6_pq async_xor xor async_memcpy async_tx
> raid0 multipath linear raid1 r8169 mii ahci libahci
> [   43.635293] 
> [   43.635297] Pid: 451, comm: plymouthd Not tainted 2.6.35-02063504-generic
> #201008271919 MSI X58 Pro-E (MS-7522)/MS-7522
> [   43.635305] RIP: 0010:[<ffffffff81576249>]  [<ffffffff81576249>]
> __mutex_lock_slowpath+0xa9/0x170
> [   43.635315] RSP: 0018:ffff8802331cbe18  EFLAGS: 00010246
> [   43.635321] RAX: ffff8802331cbe28 RBX: ffff88023429000c RCX:
> 00000000ffffffff
> [   43.635327] RDX: 0000000000000000 RSI: 00000000ffffffff RDI:
> ffff88023429000c
> [   43.635334] RBP: ffff8802331cbe78 R08: 0000000000000000 R09:
> 0000000000000000
> [   43.635340] R10: 00007fff508c4d70 R11: 0000000000000246 R12:
> ffff880234290008
> [   43.635346] R13: ffff880232fa8000 R14: ffff880232fa8000 R15:
> ffff880234290010
> [   43.635353] FS:  00007f374ac96700(0000) GS:ffff880001e80000(0000)
> knlGS:0000000000000000
> [   43.635360] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   43.635365] CR2: 0000000000000000 CR3: 00000002331a0000 CR4:
> 00000000000006a0
> [   43.635372] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [   43.635378] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400
> [   43.635385] Process plymouthd (pid: 451, threadinfo ffff8802331ca000, task
> ffff880232fa8000)
> [   43.635392] Stack:
> [   43.635395]  ffff8802331cbe28 ffffffff815774fe ffff880234290010
> ffffffff8113e2a6
> [   43.635407] <0> ffff880001e8f970 ffffea0007ad5ff0 ffff880231892cf0
> ffff880234290008
> [   43.635420] <0> ffff880234290008 ffff8802342980d0 ffff880226b35c00
> ffff8802342980d0
> [   43.635434] Call Trace:
> [   43.635440]  [<ffffffff815774fe>] ? _raw_spin_lock+0xe/0x20
> [   43.635447]  [<ffffffff8113e2a6>] ? add_partial+0x56/0x90
> [   43.635453]  [<ffffffff81575ecb>] mutex_lock+0x2b/0x50
> [   43.635460]  [<ffffffff812e4839>] fb_release+0x29/0x70
> [   43.635467]  [<ffffffff81152d63>] __fput+0xf3/0x220
> [   43.635472]  [<ffffffff81152eac>] fput+0x1c/0x30
> [   43.635478]  [<ffffffff8114f6bd>] filp_close+0x5d/0x90
> [   43.635484]  [<ffffffff8115095f>] sys_close+0xaf/0x110
> [   43.635492]  [<ffffffff8100b072>] system_call_fastpath+0x16/0x1b
> [   43.635591] Code: 75 07 41 83 7e 20 63 7f b1 49 8d 5c 24 04 4d 8d 7c 24 08
> 48 89 df e8 b7 12 00 00 49 8b 57 08 48 8d 45 b0 4c 89 7d b0 49 89 47 08 <48> 89
> 02 48 89 55 b8 ba ff ff ff ff 4c 89 75 c0 89 d0 41 87 04 
> [   43.635716] RIP  [<ffffffff81576249>] __mutex_lock_slowpath+0xa9/0x170
> [   43.635724]  RSP <ffff8802331cbe18>
> [   43.635728] CR2: 0000000000000000
> [   43.635732] ---[ end trace 977d55bf15636e33 ]---
> 
> 
> Kernel is 2.6.35-02063504-generic
> 


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev

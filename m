From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: Radeon 9000 on a linux 2.4.18 kernel.
Date: Fri, 24 Jan 2003 19:31:39 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030124183139.GA21161@iliana>
References: <20030124090423.GA1690@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23] helo=mel-rto4.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18c8cG-0002UD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jan 2003 10:31:48 -0800
Content-Disposition: inline
In-Reply-To: <20030124090423.GA1690@iliana>
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
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, Jan 24, 2003 at 10:04:23AM +0100, Sven Luther wrote:
> Hello, ...
> 
> I am trying to use a Radeon 9000 on my pegasos board, and had the same
> success with it as with the matrox millenium II i used previously. Well,
> it is even worse, since radeonfb doesn't even output a bit in the boot
> log.
> 
> After a bit of thinking, i realize that this is quite normal, sine i
> have to use a 2.4.18 kernel, which knows nothing of the Radeon 9000,
> since it did not exist at that time.
> 
> So, my questions are :
> 
>   1) is it ok to just add the Radeon 9000 pci ids and whatever to the
>   2.4.28 kernel and hope it works. (Maybe not, but then the Radeon 9000
>   and the Radeon 8500 are supposed to be really similar).

Mmm, i got the info from the 2.5.x radeonfb, and added it to the 2.4.18
radeonfb (just the pll thingies and the chip detection, as i didn't see
anything else specific in the 2.5.X radeonfb.c).

but the kernel dies with :

Oops: kernel access of bad area, sig: 11
NIP: C012DD40 XER: 20000000 LR: C012DD40 SP: C07F7E90 REGS: c07f7de0 TRAP:
0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 40000000
TASK = c07f6000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C012DD40 C07F7E90 C07F6000 00000000 C01E1DF0 C02ADF4C C07DA299 00000003
GPR08: C01E1AC4 00000001 00000006 00000000 82002022 FFFC507C 00000034 00000014
GPR16: FFFFFFFF FDFFFDF7 FFFFDFFF FFFFFFFF 003FF000 C07DA299 00EFFF48 00EFFF4C
GPR24: 00000000 002AF8FC 40010000 C07DA288 C07EC000 C07DA000 C07EC000 C07DA000
Call backtrace:
C012DD40 C012D364 C012CD9C C0122598 C012262C C023EF64 C023E114
C0236294 C02267B0 C02267FC C0003F1C C0006AB4

the call trace corresponds to :

radeon_read_OF
radeon_get_pllinfo
radoenfb_pci_register
...

I suppose there is something wrong with the data passed from OF, but may
be wrong. I will now try to dump the content of the OF that is created
by the kernel in the begining, just to check it is ok. Any hint on how
to best do this ?

Friendly,

Sven Luther


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

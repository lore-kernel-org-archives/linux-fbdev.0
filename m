From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] two warning fixes
Date: Wed, 18 Jul 2007 20:05:17 -0400
Message-ID: <469EAABD.4010504@garzik.org>
References: <20070718235504.GA9601@havoc.gtf.org> <200707190159.22654.ak@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936710AbXGSAFf@vger.kernel.org>
In-Reply-To: <200707190159.22654.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org

Andi Kleen wrote:
> On Thursday 19 July 2007 01:55:04 Jeff Garzik wrote:
>> Please pull from 'warnings' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git warnings
>>
>> to receive the following updates:
>>
>>  drivers/video/aty/radeon_base.c |   23 ++++++++++++++++++-----
>>  include/asm-x86_64/tlbflush.h   |    6 +++++-
>>  2 files changed, 23 insertions(+), 6 deletions(-)
>>
>> Jeff Garzik (2):
>>       drivers/video/aty/radeon_base: fix radeonfb_pci_register() err handling
>>       [X86-64] make flush_tlb_kernel_range() a static inline function
> 
> I already got that patch queued. Why don't you send them through the maintainers?

Because in both cases the maintainers never responded to me, indicating 
they were queued?

Also, you haven't pushed anything upstream during this merge window 
AFAICS, and I didn't want to miss it because you were being slow.

	Jeff

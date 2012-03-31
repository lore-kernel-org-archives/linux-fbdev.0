From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 31 Mar 2012 21:31:11 +0000
Subject: Re: [PATCH] video:uvesafb: Fix oops that uvesafb try to execute NX-protected page
Message-Id: <4F77779F.3010607@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120327100136.GA3829@udknight> <20120327143243.015ecff6@pyramind.ukuu.org.uk>
In-Reply-To: <20120327143243.015ecff6@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Wang YanQing <udknight@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, spock@gentoo.org

On 03/27/2012 01:32 PM, Alan Cox wrote:
> On Tue, 27 Mar 2012 18:01:36 +0800
> Wang YanQing <udknight@gmail.com> wrote:
> 
>>
>> Ok! I try to check pcibios_enabled first, but get some opposition by Alan Cox,
>> but I want to make thing work and fix the oops, so I choice the simple way to
>> check the (__supported_pte_mask & _PAGE_NX) instead of to check this variable plus
>> pci kernel boot parameter, pci mmconfig works or not, and more, and more. It is not
>> the best method, but it works and maybe all will feel happy.

Wang, could you please write a better commit message, at least you could
include the oops that your patch fixes.

> Apart from adding a helper in the includes for the arch code of
> 
> 	static inline is_nx_enabled(void)
> 	{
> 		return !!(__supported_pte_mask & _PAGE_NX);
> 	}

As this check is already done in a few other places I think there should
be a separate patch that adds this helper and ports all existing code to
use it.

So, does anyone have any objection against me taking this patch as is?


Thanks,

Florian Tobias Schandinat

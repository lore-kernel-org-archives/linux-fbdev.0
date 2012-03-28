From: Hein_Tibosch <hein_tibosch@yahoo.es>
Date: Wed, 28 Mar 2012 15:36:00 +0000
Subject: Re: [PATCH] video:uvesafb: Fix oops that uvesafb try to execute NX-protected page
Message-Id: <4F732FE0.1070708@yahoo.es>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120327100136.GA3829@udknight> <20120327143243.015ecff6@pyramind.ukuu.org.uk>
In-Reply-To: <20120327143243.015ecff6@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Wang YanQing <udknight@gmail.com>, FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, spock@gentoo.org

On 3/27/2012 9:32 PM, Alan Cox wrote:
> On Tue, 27 Mar 2012 18:01:36 +0800
> Wang YanQing <udknight@gmail.com> wrote:
>
>> Ok! I try to check pcibios_enabled first, but get some opposition by Alan Cox,
>> but I want to make thing work and fix the oops, so I choice the simple way to
>> check the (__supported_pte_mask & _PAGE_NX) instead of to check this variable plus
>> pci kernel boot parameter, pci mmconfig works or not, and more, and more. It is not
>> the best method, but it works and maybe all will feel happy.
> Okay let me ask the obvious question - why is it not the best method ?
>
> Apart from adding a helper in the includes for the arch code of
>
> 	static inline is_nx_enabled(void)
> 	{
> 		return !!(__supported_pte_mask & _PAGE_NX);
> 	}
>
> is there anything else it lacks ?

maybe giving this inline function a return type ?


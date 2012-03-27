From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 27 Mar 2012 13:32:43 +0000
Subject: Re: [PATCH] video:uvesafb: Fix oops that uvesafb try to execute NX-protected page
Message-Id: <20120327143243.015ecff6@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120327100136.GA3829@udknight>
In-Reply-To: <20120327100136.GA3829@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wang YanQing <udknight@gmail.com>
Cc: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, spock@gentoo.org

On Tue, 27 Mar 2012 18:01:36 +0800
Wang YanQing <udknight@gmail.com> wrote:

> 
> Ok! I try to check pcibios_enabled first, but get some opposition by Alan Cox,
> but I want to make thing work and fix the oops, so I choice the simple way to
> check the (__supported_pte_mask & _PAGE_NX) instead of to check this variable plus
> pci kernel boot parameter, pci mmconfig works or not, and more, and more. It is not
> the best method, but it works and maybe all will feel happy.

Okay let me ask the obvious question - why is it not the best method ?

Apart from adding a helper in the includes for the arch code of

	static inline is_nx_enabled(void)
	{
		return !!(__supported_pte_mask & _PAGE_NX);
	}

is there anything else it lacks ?

Yes ideally we'd set the relevant ROM areas executable, but for a simple
fix is there anything else that's a problem with it ?

Alan

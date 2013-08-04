From: "H. Peter Anvin" <hpa@zytor.com>
Date: Sun, 04 Aug 2013 17:33:46 +0000
Subject: Re: [PATCH] fbdev: suppress warning when assigning vga-save/restore base
Message-Id: <51FE907A.2090201@zytor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375637141-2878-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1375637141-2878-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ondrej Zajicek <santiago@crfreenet.org>, David Miller <davem@davemloft.net>

On 08/04/2013 10:25 AM, David Herrmann wrote:
> If drivers use "struct resource" objects to retrieve the vga-base, they
> must correctly cast the integer to pointer. With x86+PAE we have 32bit
> pointers but 64bit resource_size_t. Hence, cast it to "unsigned long"
> before casting to "void*" to suppress warnings due to size differences.
> 
> As IO addresses are always low addresses, we can safely drop the higher
> part of the address. This is what these drivers did before, anyway.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> Reported-by: H. Peter Anvin <hpa@zytor.com>

I'm still bothered here.  Casting between resource_size_t and void *
implies a confusion between physical and virtual addresses.  That may be
unavoidable for some reason, but I'd like to know what exactly is confused.

Anyone who can dig backwards and summarize?  In other words:

Where in the current code do we stuff a physical address in a pointer,
or a virtual address into a non-pointer?

	-hpa



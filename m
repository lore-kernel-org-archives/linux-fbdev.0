From: han jonghun <jonghun79.han@gmail.com>
Date: Mon, 04 Oct 2010 07:33:25 +0000
Subject: How to allocate framebuffer bigger than 4MB
Message-Id: <AANLkTinCCoQD8dpz_MPr-CcghrmHF0rEMYgtnaD-e9ht@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

I have a question how to allocate framebuffer bigger than 4MB.
I usually allocate framebuffer via dma_alloc_writecombine.

When I use dma_alloc_writecombine, I can allocate framebuffer less
than 4MB due to MAX_ORDER(11).
Before 2.6.36, I allocated framebuffer via bootmem and then I remaped
the fb via ioremap_wc for non-cacheable operation.
But from 2.6.36, I cannot use ioremap_wc for the memory which is
allocate by kernel.
How can I allocate framebuffer bigger than 4MB ?

Can anyone help me?

Thanks

Best regards,
Jonhun Han.

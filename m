From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome LCD ?
Date: Fri, 17 Nov 2006 21:42:50 +0100
Message-ID: <cda58cb80611171242sb40a53bvd02145364551b5a2@mail.gmail.com>
References: <45535C08.5020607@innova-card.com>
	 <Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org>
	 <cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com>
	 <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org>
	 <cda58cb80611131027h5052bf80va06003c23b844fe@mail.gmail.com>
	 <Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org>
	 <cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com>
	 <Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755892AbWKQUmy@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On 11/17/06, James Simmons <jsimmons@infradead.org> wrote:
>
> Are those actually numbers? If they are the problem isn't byte reversal
> but bit shifting.
>
> 1010100 = 54
> 0101010 = 2A

It's not byte reversal, but _bits_ of each bytes have been inversed
(bit7->bit0, bit6->bit1, bit5->bit2, bit4->bit3, bit3->bit4, ...)
after calling slow_imageblit(). Is it something expected ?

> I really don't understand why fbmem.c has its own routines to handle the logo for the color > map. I can set creating a fbcmap and calling fb_set_cmap instead.

Unfortunately I cannot help you on this point...

> That will be a  separte patch.
>

Thanks
-- 
               Franck

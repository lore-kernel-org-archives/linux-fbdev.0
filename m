From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 12 Mar 2018 15:58:38 +0000
Subject: Re: [PATCH] video: fbdev: vermilion: use 64-bit arithmetic instead of 32-bit
Message-Id: <3883400.1vCYa0i6ig@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180207000429epcas3p49ce7f7528d02b9799713e8806d77847d@epcas3p4.samsung.com>
 <20180207000424.GA32680@embeddedgus>
In-Reply-To: <20180207000424.GA32680@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tuesday, February 06, 2018 06:04:24 PM Gustavo A. R. Silva wrote:
> Cast _pitch_ to u64 in order to give the compiler complete information
> about the proper arithmetic to use. Notice that this variable is
> being used in a context that expects an expression of type u64
> (64 bits, unsigned).
> 
> The expression pitch * var->yres_virtual is currently being evaluated
> using 32-bit arithmetic and the result of the operation is being stored
> into variable mem, which is a variable of type u64. Based on that,
> chances are there is a potential integer overflow as a result of the
> operation.
> 
> Addresses-Coverity-ID: 200655 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


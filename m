From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Thu, 15 Dec 2011 21:13:35 +0000
Subject: Re: Should I use FBINFO_VIRTFB?
Message-Id: <20111215211335.GA12524@phenom.dumpdata.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4EEA5DA7.3010406@freescale.com>
In-Reply-To: <4EEA5DA7.3010406@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Dec 15, 2011 at 02:50:47PM -0600, Timur Tabi wrote:
> I'm cleaning up my fbdev driver, and I just noticed FBINFO_VIRTFB:
> 
> #define FBINFO_VIRTFB		0x0004 /* FB is System RAM, not device. */
> 
> I am currently not setting this flag, but I am allocating my framebuffer in system ram via dma_alloc_coherent().  I don't see any good documentation for this flag, but I suspect I should be enabling it.  What exactly does this flag do?

It basically inhibits from using VM_IO which should not be set on
System RAM. In your case you are using System RAM, so please do set it.

> 
> I'd also like some explanation for these two macros, which appear to be related:
> 
> #define FBINFO_PARTIAL_PAN_OK	0x0040 /* otw use pan only for double-buffering */
> #define FBINFO_READS_FAST	0x0080 /* soft-copy faster than rendering */

Not really. They have a different function, but you are better of looking in the code
to see how they are used.
> 
> -- 
> Timur Tabi
> Linux kernel developer at Freescale
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

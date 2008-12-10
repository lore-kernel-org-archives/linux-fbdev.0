From: "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/4 v2] dmaengine: add a tx_free method to struct dma_async_tx_descriptor
Date: Wed, 10 Dec 2008 12:58:09 -0700
Message-ID: <e9c3a7c20812101158h3de9c604i1c88bb7c412ccf02@mail.gmail.com>
References: <Pine.LNX.4.64.0812101122250.4578@axis700.grange>
	 <Pine.LNX.4.64.0812101129340.4578@axis700.grange>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756680AbYLJT6X@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0812101129340.4578@axis700.grange>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.arm.linux.org.uk

On Wed, Dec 10, 2008 at 3:36 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> From: Guennadi Liakhovetski <lg@denx.de>
>
> Some users reuse DMA transaction descriptors multiple times and need an
> explicit call to release them. An example of such a user is Video4Linux, which
> has to be able to release descriptors on ioctl(VIDIOC_DQBUF).
>
> Signed-off-by: Guennadi Liakhovetski <lg@denx.de>


Hi Guennadi,

Other dmaengine drivers have tasklets that scan the list of completed
descriptors and free the "acked" ones.  This happens in the cleanup
tasklet...
/me looks
...hmm this driver does not have a cleanup routine?  Ideally support
for ioctl(VIDIOC_DQBUF) could be achieved through this mechanism
without needing to increase the size of dma_async_tx_descriptor (which
has cache utilization impacts on other drivers).

--
Dan

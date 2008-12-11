From: "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/4 v2] dmaengine: add a tx_free method to struct dma_async_tx_descriptor
Date: Wed, 10 Dec 2008 19:01:49 -0700
Message-ID: <e9c3a7c20812101801r19c8fb40s6b8ce9bd6c565fed@mail.gmail.com>
References: <Pine.LNX.4.64.0812101122250.4578@axis700.grange>
	 <Pine.LNX.4.64.0812101129340.4578@axis700.grange>
	 <e9c3a7c20812101158h3de9c604i1c88bb7c412ccf02@mail.gmail.com>
	 <Pine.LNX.4.64.0812110011440.8273@axis700.grange>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755996AbYLKCCB@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0812110011440.8273@axis700.grange>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.arm.linux.org.uk

On Wed, Dec 10, 2008 at 5:30 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Hi Dan,
>
> On Wed, 10 Dec 2008, Dan Williams wrote:
>
>> On Wed, Dec 10, 2008 at 3:36 AM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > From: Guennadi Liakhovetski <lg@denx.de>
>> >
>> > Some users reuse DMA transaction descriptors multiple times and need an
>> > explicit call to release them. An example of such a user is Video4Linux, which
>> > has to be able to release descriptors on ioctl(VIDIOC_DQBUF).
>> >
>> > Signed-off-by: Guennadi Liakhovetski <lg@denx.de>
>>
>>
>> Hi Guennadi,
>>
>> Other dmaengine drivers have tasklets that scan the list of completed
>> descriptors and free the "acked" ones.  This happens in the cleanup
>> tasklet...
>> /me looks
>> ...hmm this driver does not have a cleanup routine?  Ideally support
>> for ioctl(VIDIOC_DQBUF) could be achieved through this mechanism
>> without needing to increase the size of dma_async_tx_descriptor (which
>> has cache utilization impacts on other drivers).
>
> You mean there are drivers, that have struct dma_async_tx_descriptor on
> stack?

huh?

> And you mean, that increasing the size
> of the struct by one pointer and letting users explicitly free those
> descriptors when they want is worse than introducing a tasklet that will
> have to periodically scan the list of descriptors while other hot paths
> will move elements to and from this list, look for acked elements, lock
> the list and free those elements? Periodically, because although we have
> an event when to free them - on ioctl - there is no API to trigger that
> tasklet.

There are a few events that trigger this: completion interrupt,
someone polls is_tx_complete, we run out of descriptors.

> Or am I missing something? I can do this, it just sounds strange
> to me.

You are missing that existing drivers need to do this anyway to to
handle operation completion actions.  So, while they are at it they
also free the descriptor which relieves client code from needing to
track what it has in-flight versus completed, especially since clients
may not get a handle to each descriptor a driver creates on its
behalf.

What I am suggesting is that other dmaengine drivers would handle this
implicitly after one of the above events...  can this happen in the
ipu_idmac case as well?

Thanks,
Dan

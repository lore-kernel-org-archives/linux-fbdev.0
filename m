From: Alexander Graf <agraf@suse.de>
Subject: Re: [Linux-fbdev-devel] [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 3 Nov 2009 00:24:15 +0100
Message-ID: <5B01907D-86BE-4693-81BA-23CB81B8B047@suse.de>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <20091102223249.GC22301@localhost> <D295329B-4DE0-4935-8C6B-D45042E72826@suse.de>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <D295329B-4DE0-4935-8C6B-D45042E72826@suse.de>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, qemu-devel <qemu-devel@nongnu.org>, Anthony Liguori <anthony@codemonkey.ws>, kvm list <kvm@vger.kernel.org>


On 02.11.2009, at 23:42, Alexander Graf wrote:

>
> Am 02.11.2009 um 23:32 schrieb Ondrej Zajicek  
> <santiago@crfreenet.org>:
>
>> On Mon, Nov 02, 2009 at 11:09:19PM +0100, Alexander Graf wrote:
>>> When we want to create a full VirtIO based machine, we're still
>>> missing
>>> graphics output. Fortunately, Linux provides us with most of the
>>> frameworks
>>> to render text and everything, we only need to implement a  
>>> transport.
>>>
>>> So this is a frame buffer backend written for VirtIO. Using this
>>> and my
>>> patch to qemu, you can use paravirtualized graphics.
>>
>> Just a note: it might be useful to allow paravirtualized graphics to
>> handle text mode. In that case, it can be done in fbdev layer using
>> tileblit operations.
>
> Is there any real driver implementing this already? I'd prefer to copy
> from working code instead of writing my own :-).
>
> Also, we still need to keep the local frame buffer copy in sync so we
> can mmap and read from it, right? So it's not really worth it
> probably...

But then again we could just try to be closer to a real graphics card.  
What if we'd set up a memory region on the host that is basically our  
graphics frame buffer? For S390 we could just append the graphics  
memory to the guest's memory.

We could use that as backing buffer in the qemu graphics frontend and  
as frame buffer in the Linux fbdev layer, similar to what real  
graphics cards set up.

Then we could send all those fancy commands that we have already over  
to the host, that renders them and thanks to the mapping have a  
consistent frame buffer we can mmap. It'd even simplify the deferred  
IO stuff, making it basically a notify that something changed, but the  
changes already being written to the frame buffer.

On sync we'd just have to make sure the virtio buffer was processed  
completely.


That would get rid of all sys_* calls, a lot of copying and the  
duplicate frame buffer we have right now. Wow.

Alex


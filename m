From: Alexander Graf <agraf@suse.de>
Subject: Re: [Linux-fbdev-devel] [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 3 Nov 2009 00:59:47 +0100
Message-ID: <732F0ECC-4FA3-4211-BFC4-A4B10382DE99@suse.de>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <20091102223249.GC22301@localhost> <D295329B-4DE0-4935-8C6B-D45042E72826@suse.de> <5B01907D-86BE-4693-81BA-23CB81B8B047@suse.de> <20091102235733.GB28292@localhost>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20091102235733.GB28292@localhost>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, qemu-devel <qemu-devel@nongnu.org>, Anthony Liguori <anthony@codemonkey.ws>, kvm list <kvm@vger.kernel.org>


On 03.11.2009, at 00:57, Ondrej Zajicek wrote:

> On Tue, Nov 03, 2009 at 12:24:15AM +0100, Alexander Graf wrote:
>>> Also, we still need to keep the local frame buffer copy in sync so  
>>> we
>>> can mmap and read from it, right? So it's not really worth it
>>> probably...
>>
>> But then again we could just try to be closer to a real graphics  
>> card.
>> What if we'd set up a memory region on the host that is basically our
>> graphics frame buffer? For S390 we could just append the graphics  
>> memory
>> to the guest's memory.
>>
>> We could use that as backing buffer in the qemu graphics frontend  
>> and as
>> frame buffer in the Linux fbdev layer, similar to what real graphics
>> cards set up.
>
> Using shared memory pages between host and guest seems like a natural
> way to implement paravirtualized graphics card. Most things are
> straightforward, only a little problematic thing is when fbdev
> is mmaped from guest to userspace - you have to detect writes
> and notify host that it changed.

Yes, currently I use the deferred IO stuff and send over "write"  
commands with the full contents of the frame buffer.

But having a shared frame buffer really sounds better.
The major thing I really want to do different from xenfb though is  
that the _host_ renders. That way "copy" operations still work as  
designed, enabling vnc to pass them through directly. That might also  
allow for some sort of DRI interface to pass through 3d data to the  
host... at least in the future :-).


Alex


From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Thu, 05 Nov 2009 21:05:11 -0600
Message-ID: <4AF39267.9060104@codemonkey.ws>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <4AEFCBED.50804@redhat.com> <20091106023915.GO21630@shareable.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20091106023915.GO21630@shareable.org>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jamie Lokier <jamie@shareable.org>
Cc: Avi Kivity <avi@redhat.com>, Alexander Graf <agraf@suse.de>, linux-fbdev-devel@lists.sourceforge.net, qemu-devel@nongnu.org, kvm@vger.kernel.org

Jamie Lokier wrote:
> Avi Kivity wrote:
>   
>> On 11/03/2009 12:09 AM, Alexander Graf wrote:
>>     
>>> When we want to create a full VirtIO based machine, we're still missing
>>> graphics output. Fortunately, Linux provides us with most of the frameworks
>>> to render text and everything, we only need to implement a transport.
>>>
>>> So this is a frame buffer backend written for VirtIO. Using this and my
>>> patch to qemu, you can use paravirtualized graphics.
>>>       
>> What does this do that cirrus and/or vmware-vga don't?
>>     
>
> *This* virtio-fb doesn't, but one feature I think a lot of users
> (including me) would like is:
>
>    Option to resize the guest desktop when the host desktop / host
>    window / VNC client resizes.
>
>    Tell the guest to provide multiple desktops when the host has
>    multiple desktops, so things like twin monitors work nicely with
>    guests.
>
>    Relay EDID/Xrandr information and updates from host to guest, and
>    generally handle hotplugging host monitors nicely.
>
> Are there any real hardware standards worth emulating which do that?
>   

vmware-vga.

If you have a little tool in a guest that uses the X extension that 
vmware vga implements, it actually works in qemu too.

Regards,

Anthony Liguoru

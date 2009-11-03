From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 03 Nov 2009 08:21:33 +0200
Message-ID: <4AEFCBED.50804@redhat.com>
References: <1257199759-2941-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1257199759-2941-1-git-send-email-agraf@suse.de>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Alexander Graf <agraf@suse.de>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-fbdev-devel@lists.sourceforge.net, anthony@codemonkey.ws

On 11/03/2009 12:09 AM, Alexander Graf wrote:
> When we want to create a full VirtIO based machine, we're still missing
> graphics output. Fortunately, Linux provides us with most of the frameworks
> to render text and everything, we only need to implement a transport.
>
> So this is a frame buffer backend written for VirtIO. Using this and my
> patch to qemu, you can use paravirtualized graphics.
>
>    

What does this do that cirrus and/or vmware-vga don't?

> This is especially important on machines that can't do MMIO, as all current
> graphics implementations qemu emulates I'm aware of so far fail here.
>    

s390 virtual desktops?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


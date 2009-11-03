From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 1/2] Add emulation for VirtIO Frame Buffer device
Date: Tue, 03 Nov 2009 08:22:16 +0200
Message-ID: <4AEFCC18.8030408@redhat.com>
References: <1257199910-3197-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1257199910-3197-1-git-send-email-agraf@suse.de>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Alexander Graf <agraf@suse.de>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-fbdev-devel@lists.sourceforge.net, anthony@codemonkey.ws

On 11/03/2009 12:11 AM, Alexander Graf wrote:
> Since Linux now understands how to talk to us graphics over VirtIO, let's
> add support for it in qemu.
>
> The good part about graphics over VirtIO is that you don't need PCI to use
> it. So if there's any platform out there trying to use graphics, but not
> capable of MMIO, it can use this one!
>    

Which platforms are these?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


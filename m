From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Fri, 6 Nov 2009 02:39:15 +0000
Message-ID: <20091106023915.GO21630@shareable.org>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <4AEFCBED.50804@redhat.com>
Mime-Version: 1.0
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4AEFCBED.50804@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Avi Kivity <avi@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, linux-fbdev-devel@lists.sourceforge.net, qemu-devel@nongnu.org, kvm@vger.kernel.org

Avi Kivity wrote:
> On 11/03/2009 12:09 AM, Alexander Graf wrote:
> >When we want to create a full VirtIO based machine, we're still missing
> >graphics output. Fortunately, Linux provides us with most of the frameworks
> >to render text and everything, we only need to implement a transport.
> >
> >So this is a frame buffer backend written for VirtIO. Using this and my
> >patch to qemu, you can use paravirtualized graphics.
> 
> What does this do that cirrus and/or vmware-vga don't?

*This* virtio-fb doesn't, but one feature I think a lot of users
(including me) would like is:

   Option to resize the guest desktop when the host desktop / host
   window / VNC client resizes.

   Tell the guest to provide multiple desktops when the host has
   multiple desktops, so things like twin monitors work nicely with
   guests.

   Relay EDID/Xrandr information and updates from host to guest, and
   generally handle hotplugging host monitors nicely.

Are there any real hardware standards worth emulating which do that?

-- Jamie

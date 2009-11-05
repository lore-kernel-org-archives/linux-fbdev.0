From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Thu, 05 Nov 2009 11:04:57 +0200
Message-ID: <4AF29539.6070905@redhat.com>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <4AEFCBED.50804@redhat.com> <DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de> <4AEFCCBA.9050408@redhat.com> <8BA1853F-11C9-44B1-9FDB-1DFDAED40E1B@suse.de> <4AEFCEDA.4030308@redhat.com> <87F51670-CB3F-431C-87B4-A8746F996C6F@suse.de> <20091103112543.GA24834@snarc.org> <4AEFFA0A.4040105@redhat.com> <20091104160931.GA3647@snarc.org> <4AF1AD5E.5040205@codemonkey.ws>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4AF1AD5E.5040205@codemonkey.ws>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Vincent Hanquez <tab@snarc.org>, linux-fbdev-devel@lists.sourceforge.net, Alexander Graf <agraf@suse.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org

On 11/04/2009 06:35 PM, Anthony Liguori wrote:
> Vincent Hanquez wrote:
>> On Tue, Nov 03, 2009 at 11:38:18AM +0200, Avi Kivity wrote:
>>> On 11/03/2009 01:25 PM, Vincent Hanquez wrote:
>>>> not sure if i'm missing the point here, but couldn't it be 
>>>> hypothetically
>>>> extended to stuff 3d (or video&  more 2d accel ?) commands too ? I 
>>>> can't
>>>> imagine the cirrus or stdvga driver be able to do that ever ;)
>>> cirrus has pretty good 2d acceleration.  3D is a mega-project though.
>>
>> absolutely huge indeed, but still alexander's code is pretty much the
>> only way, to start such a project. with maybe added benefits on more
>> and easier 2d acceleration.
>>
>> or otherwise wait for SR-IOV graphics cards (or similar tech)...
>
> I think the real question is do we paravirtualize a VGA device or a 
> framebuffer.
>
> Obviously, the advantage of doing a framebuffer is that it works for 
> s390.
>
> A VGA device has better backwards compatibility on PCs although it's 
> obviously more complex.  In an ideal world, we could expose the virtio 
> framebuffer device as part of PCI device that was also VGA capable 
> (virtio-pci-vga transport?).
>
> But then there's QXL on the horizon which complicates matters further.
>

qxl is vga compatible.

> I'd say that virtio-fb should just focus on the s390 use case for 
> now.  Let things evolve as needed.
>

Sure.

-- 
error compiling committee.c: too many arguments to function


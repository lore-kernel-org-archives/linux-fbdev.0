From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 3 Nov 2009 07:22:54 +0100
Message-ID: <DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <4AEFCBED.50804@redhat.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4AEFCBED.50804@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Avi Kivity <avi@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-fbdev-devel@lists.sourceforge.net, anthony@codemonkey.ws


On 03.11.2009, at 07:21, Avi Kivity wrote:

> On 11/03/2009 12:09 AM, Alexander Graf wrote:
>> When we want to create a full VirtIO based machine, we're still  
>> missing
>> graphics output. Fortunately, Linux provides us with most of the  
>> frameworks
>> to render text and everything, we only need to implement a transport.
>>
>> So this is a frame buffer backend written for VirtIO. Using this  
>> and my
>> patch to qemu, you can use paravirtualized graphics.
>>
>>
>
> What does this do that cirrus and/or vmware-vga don't?

Work on non-MMIO machines.

>> This is especially important on machines that can't do MMIO, as all  
>> current
>> graphics implementations qemu emulates I'm aware of so far fail here.
>>
>
> s390 virtual desktops?

Well - have you ever tried installing SLES / RHEL on an S390? If not,  
give it a shot and comment again :-)

Alex


From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/2] Add emulation for VirtIO Frame Buffer device
Date: Tue, 3 Nov 2009 07:23:58 +0100
Message-ID: <FBC9ADBF-F50B-4A55-9C7F-826AD95C38A3@suse.de>
References: <1257199910-3197-1-git-send-email-agraf@suse.de> <4AEFCC18.8030408@redhat.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4AEFCC18.8030408@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Avi Kivity <avi@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-fbdev-devel@lists.sourceforge.net, anthony@codemonkey.ws


On 03.11.2009, at 07:22, Avi Kivity wrote:

> On 11/03/2009 12:11 AM, Alexander Graf wrote:
>> Since Linux now understands how to talk to us graphics over VirtIO,  
>> let's
>> add support for it in qemu.
>>
>> The good part about graphics over VirtIO is that you don't need PCI  
>> to use
>> it. So if there's any platform out there trying to use graphics,  
>> but not
>> capable of MMIO, it can use this one!
>>
>
> Which platforms are these?

For now S390 comes to mind first ... :-). I'd use and improve the  
spice stuff, but that hasn't exactly been open-source friendly so far...

Alex


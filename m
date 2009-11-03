From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 3 Nov 2009 07:27:06 +0100
Message-ID: <8BA1853F-11C9-44B1-9FDB-1DFDAED40E1B@suse.de>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <4AEFCBED.50804@redhat.com> <DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de> <4AEFCCBA.9050408@redhat.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4AEFCCBA.9050408@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Avi Kivity <avi@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-fbdev-devel@lists.sourceforge.net, anthony@codemonkey.ws


On 03.11.2009, at 07:24, Avi Kivity wrote:

> On 11/03/2009 08:22 AM, Alexander Graf wrote:
>>
>>>> This is especially important on machines that can't do MMIO, as  
>>>> all current
>>>> graphics implementations qemu emulates I'm aware of so far fail  
>>>> here.
>>>>
>>>
>>> s390 virtual desktops?
>>
>> Well - have you ever tried installing SLES / RHEL on an S390? If  
>> not, give it a shot and comment again :-)
>>
>
> I won't be able to until qemu support s390.

I'm pretty sure RH has some S390 lying around ...

> How does it work today?

You boot into a TERM=dumb line based emulation on 3270 (worst thing  
haunting people's nightmares ever), trying to get out of that mode as  
quickly as possible and off into SSH / VNC.

> Does installation over vnc work?

Yes, but it requires a working network setup. That's a pretty  
requirement on guests IMHO.

Alex


From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 03 Nov 2009 08:24:58 +0200
Message-ID: <4AEFCCBA.9050408@redhat.com>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <4AEFCBED.50804@redhat.com> <DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Alexander Graf <agraf@suse.de>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-fbdev-devel@lists.sourceforge.net, anthony@codemonkey.ws

On 11/03/2009 08:22 AM, Alexander Graf wrote:
>
>>> This is especially important on machines that can't do MMIO, as all 
>>> current
>>> graphics implementations qemu emulates I'm aware of so far fail here.
>>>
>>
>> s390 virtual desktops?
>
> Well - have you ever tried installing SLES / RHEL on an S390? If not, 
> give it a shot and comment again :-)
>

I won't be able to until qemu support s390.

How does it work today?

Does installation over vnc work?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


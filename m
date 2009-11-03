From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 3 Nov 2009 07:39:34 +0100
Message-ID: <87F51670-CB3F-431C-87B4-A8746F996C6F@suse.de>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <4AEFCBED.50804@redhat.com> <DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de> <4AEFCCBA.9050408@redhat.com> <8BA1853F-11C9-44B1-9FDB-1DFDAED40E1B@suse.de> <4AEFCEDA.4030308@redhat.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4AEFCEDA.4030308@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Avi Kivity <avi@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-fbdev-devel@lists.sourceforge.net, anthony@codemonkey.ws


On 03.11.2009, at 07:34, Avi Kivity wrote:

> On 11/03/2009 08:27 AM, Alexander Graf wrote:
>>
>>> How does it work today?
>>
>> You boot into a TERM=dumb line based emulation on 3270 (worst thing  
>> haunting people's nightmares ever), trying to get out of that mode  
>> as quickly as possible and off into SSH / VNC.
>
> Despite the coolness factor, IMO a few minutes during install time  
> do not justify a new hardware model and a new driver.

It's more than just coolness factor. There are use cases out there (www.susestudio.com 
) that don't want to rely on the guest exporting a VNC server to the  
outside just to access graphics. You also want to see boot messages,  
have a console login screen, be able to debug things without switching  
between virtio-console and vnc, etc. etc.

The hardware model isn't exactly new either. It's just the next  
logical step to a full PV machine using virtio. If the virtio-fb stuff  
turns out to be really fast and reliable, I could even imagine it  
being the default target for kvm on ppc as well, as we can't switch  
resolutions on the fly there atm.

>>> Does installation over vnc work?
>>
>> Yes, but it requires a working network setup. That's a pretty  
>> requirement on guests IMHO.
>
> Why?  the guest will typically have networking when it's set up, so  
> it should have network access during install.  You can easily use  
> slirp redirection and the built-in dhcp server to set this up with  
> relatively few hassles.

That's how I use it right now. It's no fun.


Alex

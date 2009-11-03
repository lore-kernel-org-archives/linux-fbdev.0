From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 03 Nov 2009 09:43:49 +0200
Message-ID: <4AEFDF35.3020806@redhat.com>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <4AEFCBED.50804@redhat.com> <DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de> <4AEFCCBA.9050408@redhat.com> <8BA1853F-11C9-44B1-9FDB-1DFDAED40E1B@suse.de> <4AEFCEDA.4030308@redhat.com> <87F51670-CB3F-431C-87B4-A8746F996C6F@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <87F51670-CB3F-431C-87B4-A8746F996C6F@suse.de>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Alexander Graf <agraf@suse.de>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-fbdev-devel@lists.sourceforge.net, anthony@codemonkey.ws

On 11/03/2009 08:39 AM, Alexander Graf wrote:
>
> On 03.11.2009, at 07:34, Avi Kivity wrote:
>
>> On 11/03/2009 08:27 AM, Alexander Graf wrote:
>>>
>>>> How does it work today?
>>>
>>> You boot into a TERM=dumb line based emulation on 3270 (worst thing 
>>> haunting people's nightmares ever), trying to get out of that mode 
>>> as quickly as possible and off into SSH / VNC.
>>
>> Despite the coolness factor, IMO a few minutes during install time do 
>> not justify a new hardware model and a new driver.
>
> It's more than just coolness factor. There are use cases out there 
> (www.susestudio.com) that don't want to rely on the guest exporting a 
> VNC server to the outside just to access graphics. 

Instead you rely on the guest using virtio-fb. Since we have to make 
guest modifications, why not go for the simpler ones?

> You also want to see boot messages, have a console login screen, 

virtio-console does that, except for the penguins.  Better, since you 
can scroll back.

> be able to debug things without switching between virtio-console and 
> vnc, etc. etc.

Render virtio-console on your vnc session.  We do that already, no? 
(well, the host's vnc session, not the guest's).

> The hardware model isn't exactly new either. It's just the next 
> logical step to a full PV machine using virtio. If the virtio-fb stuff 
> turns out to be really fast and reliable, I could even imagine it 
> being the default target for kvm on ppc as well, as we can't switch 
> resolutions on the fly there atm.
>

We could with vmware-vga.

>>
>> Why?  the guest will typically have networking when it's set up, so 
>> it should have network access during install.  You can easily use 
>> slirp redirection and the built-in dhcp server to set this up with 
>> relatively few hassles.
>
> That's how I use it right now. It's no fun.
>

The toolstack should hide the unfun parts.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


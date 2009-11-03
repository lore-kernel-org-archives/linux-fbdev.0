From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 3 Nov 2009 09:26:10 +0100
Message-ID: <A955776B-6A8F-491B-969F-28BD8EB8F206@suse.de>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <4AEFCBED.50804@redhat.com> <DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de> <4AEFCCBA.9050408@redhat.com> <8BA1853F-11C9-44B1-9FDB-1DFDAED40E1B@suse.de> <4AEFCEDA.4030308@redhat.com> <87F51670-CB3F-431C-87B4-A8746F996C6F@suse.de> <4AEFDF35.3020806@redhat.com> <8EA2855E-4209-4CCA-9E87-1D652A72F8FE@suse.de> <4AEFE7DA.30105@redhat.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4AEFE7DA.30105@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Avi Kivity <avi@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-fbdev-devel@lists.sourceforge.net, anthony@codemonkey.ws


On 03.11.2009, at 09:20, Avi Kivity wrote:

> On 11/03/2009 09:50 AM, Alexander Graf wrote:
>>
>> Ok, imagine this was not this unloved S390 odd architecture but  
>> X86. The only output choices you have are:
>>
>> 1) virtio-console
>> 2) VNC / SSH over network
>> 3) virtio-fb
>>
>> Now you want to configure a server, probably using yast and all  
>> those nice graphical utilities, but still enable a firewall so  
>> people outside don't intrude your machine. Well, you managed to  
>> configure the firewall by luck to allow VNC, but now you  
>> reconfigured it and something broke - but VNC was your only chance  
>> to access the machine. Oops...
>
> x86 has real framebuffers, so software and people expect it.  s390  
> doesn't.  How do people manage now?

They cope with what's there. Fortunately we're in a position to change  
things, so we don't have to stick with the worse.

>>>> You also want to see boot messages, have a console login screen,
>>>
>>> virtio-console does that, except for the penguins.  Better, since  
>>> you can scroll back.
>>
>> It doesn't do graphics. Ever used yast in text mode?
>
> Once you're in, start ssh+X or vnc.  Again, what do people do now?

Exactly that. Again, it works but is not ideal. If we can improve user  
experience why work against it?

>>>> The hardware model isn't exactly new either. It's just the next  
>>>> logical step to a full PV machine using virtio. If the virtio-fb  
>>>> stuff turns out to be really fast and reliable, I could even  
>>>> imagine it being the default target for kvm on ppc as well, as we  
>>>> can't switch resolutions on the fly there atm.
>>>>
>>>
>>> We could with vmware-vga.
>>
>> The vmware-port stuff is pretty much tied onto X86. I don't think  
>> modifying EAX is that easy on PPC ;-).
>
> Yes, though we can probably make it work on ppc with minimal  
> modifications.

Is it worth it? We can also just implement a virtio mouse event dev  
plus fb and be good. That way we control the whole stack without  
risking to break vmware.

>>>>> Why?  the guest will typically have networking when it's set up,  
>>>>> so it should have network access during install.  You can easily  
>>>>> use slirp redirection and the built-in dhcp server to set this  
>>>>> up with relatively few hassles.
>>>>
>>>> That's how I use it right now. It's no fun.
>>>>
>>>
>>> The toolstack should hide the unfun parts.
>>
>> You can't hide guest configuration. We as a distribution control  
>> the kernel. We don't control the user's configuration as that's by  
>> design the user's choice. The only thing we can do is give users  
>> meaningful choices to choose from - and having graphics available  
>> is definitely one of them.
>
> Well, if the user chooses not to have networking then vnc or ssh+x  
> definitely fail.  That would be a strange choice for a server machine.

It's actually rather common on S390, though admittedly not that much  
on Linux+S390. There are more ways for inter node communication than  
networking. You can talk to another VM on the same machine without any  
network whatsoever. That way you can set up an isolated job (your bank  
transfer database for example) that is always protected by a proxy to  
the outside world.

>> Seriously, try to ask someone internally to get access to an S390.  
>> I think you'll understand my motivations a lot better after having  
>> used it for a bit.
>
> I actually have a s390 vm (RHEL 4 IIRC).  It acts just like any  
> other remote machine over ssh except that it's especially slow  
> (probably the host is overloaded).  Of course I wouldn't dream of  
> trying to install something like that though.

Exactly. In fact, I'm even scared to reboot mine because I might end  
up in a 3270 terminal. The whole text only crap keeps people from  
using this platform! And that's what I want to change here.

Alex

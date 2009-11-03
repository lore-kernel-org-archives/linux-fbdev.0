From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 03 Nov 2009 10:20:42 +0200
Message-ID: <4AEFE7DA.30105@redhat.com>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <4AEFCBED.50804@redhat.com> <DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de> <4AEFCCBA.9050408@redhat.com> <8BA1853F-11C9-44B1-9FDB-1DFDAED40E1B@suse.de> <4AEFCEDA.4030308@redhat.com> <87F51670-CB3F-431C-87B4-A8746F996C6F@suse.de> <4AEFDF35.3020806@redhat.com> <8EA2855E-4209-4CCA-9E87-1D652A72F8FE@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <8EA2855E-4209-4CCA-9E87-1D652A72F8FE@suse.de>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Alexander Graf <agraf@suse.de>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-fbdev-devel@lists.sourceforge.net, anthony@codemonkey.ws

On 11/03/2009 09:50 AM, Alexander Graf wrote:
>
> Ok, imagine this was not this unloved S390 odd architecture but X86. 
> The only output choices you have are:
>
> 1) virtio-console
> 2) VNC / SSH over network
> 3) virtio-fb
>
> Now you want to configure a server, probably using yast and all those 
> nice graphical utilities, but still enable a firewall so people 
> outside don't intrude your machine. Well, you managed to configure the 
> firewall by luck to allow VNC, but now you reconfigured it and 
> something broke - but VNC was your only chance to access the machine. 
> Oops...

x86 has real framebuffers, so software and people expect it.  s390 
doesn't.  How do people manage now?

>>> You also want to see boot messages, have a console login screen,
>>
>> virtio-console does that, except for the penguins.  Better, since you 
>> can scroll back.
>
> It doesn't do graphics. Ever used yast in text mode?

Once you're in, start ssh+X or vnc.  Again, what do people do now?

>
>>> The hardware model isn't exactly new either. It's just the next 
>>> logical step to a full PV machine using virtio. If the virtio-fb 
>>> stuff turns out to be really fast and reliable, I could even imagine 
>>> it being the default target for kvm on ppc as well, as we can't 
>>> switch resolutions on the fly there atm.
>>>
>>
>> We could with vmware-vga.
>
> The vmware-port stuff is pretty much tied onto X86. I don't think 
> modifying EAX is that easy on PPC ;-).

Yes, though we can probably make it work on ppc with minimal modifications.

>>>> Why?  the guest will typically have networking when it's set up, so 
>>>> it should have network access during install.  You can easily use 
>>>> slirp redirection and the built-in dhcp server to set this up with 
>>>> relatively few hassles.
>>>
>>> That's how I use it right now. It's no fun.
>>>
>>
>> The toolstack should hide the unfun parts.
>
> You can't hide guest configuration. We as a distribution control the 
> kernel. We don't control the user's configuration as that's by design 
> the user's choice. The only thing we can do is give users meaningful 
> choices to choose from - and having graphics available is definitely 
> one of them.

Well, if the user chooses not to have networking then vnc or ssh+x 
definitely fail.  That would be a strange choice for a server machine.

> Seriously, try to ask someone internally to get access to an S390. I 
> think you'll understand my motivations a lot better after having used 
> it for a bit.

I actually have a s390 vm (RHEL 4 IIRC).  It acts just like any other 
remote machine over ssh except that it's especially slow (probably the 
host is overloaded).  Of course I wouldn't dream of trying to install 
something like that though.

-- 
error compiling committee.c: too many arguments to function


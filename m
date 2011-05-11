From: Tim Gardner <tim.gardner@canonical.com>
Date: Wed, 11 May 2011 14:09:29 +0000
Subject: Re: [PATCH V3] fbcon -- fix race between open and removal of framebuffers
Message-Id: <4DCA9899.6070403@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1304617307-7389-1-git-send-email-tim.gardner@canonical.com>	<4DC94314.8050701@canonical.com> <20110510234424.5a5b7a08@neptune.home>
In-Reply-To: <20110510234424.5a5b7a08@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-fbdev@vger.kernel.org, lethal@linux-sh.org, linux-kernel@vger.kernel.org, Andy Whitcroft <andy.whitcroft@canonical.com>

On 05/10/2011 11:44 PM, Bruno Pr=E9mont wrote:
> On Tue, 10 May 2011 Tim Gardner<tim.gardner@canonical.com>  wrote:
>>  From ca3ef33e2235c88856a6257c0be63192ab56c678 Mon Sep 17 00:00:00 2001
>> From: Andy Whitcroft<apw@canonical.com>
>> Date: Thu, 29 Jul 2010 16:48:20 +0100
>> Subject: [PATCH] fbcon -- fix race between open and removal of framebuff=
ers
>>
>> Currently there is no locking for updates to the registered_fb list.
>> This allows an open through /dev/fbN to pick up a registered framebuffer
>> pointer in parallel with it being released, as happens when a conflicting
>> framebuffer is ejected or on module unload.  There is also no reference
>> counting on the framebuffer descriptor which is referenced from all open
>> files, leading to references to released or reused memory to persist on
>> these open files.
>>
>> This patch adds a reference count to the framebuffer descriptor to preve=
nt
>> it from being released until after all pending opens are closed.  This
>> allows the pending opens to detect the closed status and unmap themselve=
s.
>> It also adds locking to the framebuffer lookup path, locking it against
>> the removal path such that it is possible to atomically lookup and take a
>> reference to the descriptor.  It also adds locking to the read and write
>> paths which currently could access the framebuffer descriptor after it
>> has been freed.  Finally it moves the device to FBINFO_STATE_REMOVED to
>> indicate that all access should be errored for this device.
>
> What framebuffer drivers was this patch tested with? Just x86 with
> mainstream GPU (intel/amd/nvidia KMS) in compination with vgafb/vesafb or
> did it see some testing with other framebuffers like those from embedded
> world?
>

This patch is also in all of the armel (OMAP3/OMAP4) kernels.

> Otherwise a much smaller (memory leaking) patch would be to just change
> vesafb/vgafb to not free their fb_info after unregistration as was sugges=
ted
> by Alan Cox.
>

Sure, I suppose thats possible, but this is the patch that I have working.

<snip>

>
> This only partially protects the list and count as two concurrent
> framebuffer registrations do still race against each other.
> For the issue addressed by this patch I don't think it makes sense to
> have this spinlock at all as it's only used in get_framebuffer_info()
> and in put_framebuffer_info() and put_framebuffer_info() doesn't even
> look at registered_fb or num_registered_fb.
> Such a spinlock makes sense in a separate patch that really protects
> all access to registered_fb or num_registered_fb, be it during framebuffer
> (un)registration or during access from fbcon.
>

Our goal was merely to stop the user space open/close races. I agree=20
that the framebuffer registration list needs more orthogonal protection,=20
but that is going to be a much larger patch.

rtg
--=20
Tim Gardner tim.gardner@canonical.com

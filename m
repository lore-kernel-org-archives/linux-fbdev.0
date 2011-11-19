From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 19 Nov 2011 12:08:51 +0000
Subject: Re: [PATCH] fb: split out framebuffer initialization from allocation
Message-Id: <4EC79C53.5030800@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321308088-6327-1-git-send-email-timur@freescale.com>
In-Reply-To: <1321308088-6327-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Bruno,

On 11/19/2011 11:47 AM, Bruno Pr=E9mont wrote:
> Hi Florian, Timur,
>=20
> On Sat, 19 November 2011 Florian Tobias Schandinat <FlorianSchandinat@gmx=
.de> wrote:
>> On 11/17/2011 08:19 PM, Timur Tabi wrote:
>>> Timur Tabi wrote:
>>>> Introduce functions framebuffer_init() and framebuffer_cleanup() to al=
low
>>>> the initialization of a user-allocated fb_info object.
>>>>
>>>> framebuffer_alloc() allows for appending a private data structure when=
 it
>>>> allocates the fb_info object.  However, a driver that registers multip=
le
>>>> framebuffers for one device may also need another private data structu=
re
>>>> for the device itself.  framebuffer_init() allows such drivers to store
>>>> the fb_info objects in the device-specific private data structure,
>>>> thereby simplifying memory allocation.
>>>>
>>>> Signed-off-by: Timur Tabi <timur@freescale.com>
>>>
>>> Florian,
>>>
>>> Any comments on this patch?  If you're okay with the change, I want to =
take
>>> advantage of it in my framebuffer driver.
>>
>> Of course you want, otherwise I'd be wondering why you are sending this =
patch
>> at all.
>>
>> But I don't see any advantages of your approach. Instead of pointers to =
fb_info
>> with this patch you could embed fb_info directly in your data structure =
but that
>> is barely a difference for a programmer I'd think. You'd still have to c=
all your
>> new functions on init/exit so the amount of function calls needed is the=
 same
>> with or without the patch (I could see an advantage if alloc and release=
 were
>> pure memory allocations). Or is this all about handling the case when fb=
_alloc
>> fails?
>> Historically some drivers don't even call alloc but have their own fb_in=
fo and
>> call only register. I do not want to add yet another way of doing frameb=
uffer
>> initialization unless you can clearly show its benefits.
>=20
> Wouldn't it even make sense to move some more of the initialization of fb=
_info
> out of fb registration into this new init funtion? (I'm thinking about in=
itializing
> mutexes and the like)

This would require someone going through all framebuffers and change them t=
o use
the new fb_init function if they don't use fb_alloc. I'd accept this patch =
as an
improvement iff someone would do this. Than the number of variation of doing
framebuffer initialization would remain the same. Of course the same should=
 be
done for fb_cleanup.


Best regards,

Florian Tobias Schandinat

> This way fb_info could be used before being registered. Registration woul=
d then
> be reduced to makeing the framebuffer visible to userspace and listed in
> registered_fb[].
>=20
> This way framebuffer_alloc() would be no more that kzalloc(), framebuffer=
_init()
> would setup all "non-zero" fields of fb_info (including setup of all mute=
xes, one
> of which is currently being done by framebuffer_alloc() and the rest by
> do_register_framebuffer()!).
>=20
> Bruno
>=20
>> Best regards,
>>
>> Florian Tobias Schandinat
>=20


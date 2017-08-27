From: "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Date: Sun, 27 Aug 2017 16:47:49 +0000
Subject: Re: [PATCH] vgacon, x86/boot: Prevent faulty bootparams.screeninfo from causing harm
Message-Id: <3c750b1c-8238-ca25-26ef-482678189cfc@amazon.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1503842206-30039-1-git-send-email-jschoenh@amazon.de>
In-Reply-To: <1503842206-30039-1-git-send-email-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On 08/27/2017 05:05 PM, Greg Kroah-Hartman wrote:
> On Sun, Aug 27, 2017 at 03:56:46PM +0200, Jan H. Sch=F6nherr wrote:
>> If a zero for the number of colums or rows manages to slip through,
>> gotoxy() will underflow vc->vc_pos, causing the next action on the
>> referenced memory to end with a page fault.
>>
>> Make the check in vgacon more pessimistic to prevent that. Also change
>> a similar check in the x86 boot code with a similar problem.
>>
>> Signed-off-by: Jan H. Sch=F6nherr <jschoenh@amazon.de>
>> ---
>> Let me know, if I should split this into two patches.
>>
>>  arch/x86/boot/compressed/misc.c | 3 +--
>>  drivers/video/console/vgacon.c  | 5 ++---
>>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> Why send this patch to me?

Because there isn't a clear maintainer: The drivers/video catch-all in MAIN=
TAINERS
is captioned as "Framebuffer layer",  but all recent patches to vgacon.c we=
nt through
your hands.

> And yes, of course you have to split this up, these two files have
> nothing to do with each other...

Okay, then ignore this patch, and I'll split this down. I'll send the vgaco=
n.c part
through Bartlomiej Zolnierkiewicz, then.

Regards
Jan


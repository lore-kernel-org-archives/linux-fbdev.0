From: David Herrmann <dh.herrmann@gmail.com>
Date: Sat, 03 Aug 2013 15:46:33 +0000
Subject: Re: [PATCH RESEND 0/8] x86 platform framebuffers
Message-Id: <CANq1E4SjN-=3oyRp2zXaQ+aaJB8yEVmJzcPvbxQxu1MTc8JjiQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375445127-15480-1-git-send-email-dh.herrmann@gmail.com>
	<51FC431F.1080405@zytor.com>
In-Reply-To: <51FC431F.1080405@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>, Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Warren <swarren@wwwdotorg.org>, Peter Jones <pjones@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-fbdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hi

On Sat, Aug 3, 2013 at 1:39 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 08/02/2013 05:05 AM, David Herrmann wrote:
>> Hi
>>
>> I cut down my previous series to no longer include the SimpleDRM driver.=
 If
>> anyone is interested, you can find it here:
>>   http://lwn.net/Articles/558104/
>> I will resend it once these preparation patches are in.
>>
>> Changes since v2:
>>  - added common x86 formats (reported by hpa) (patch #5)
>>
>> This whole series (including simpledrm) is tested by Stephen and me. I w=
ould be
>> glad if maintainers could ack/nack this so I can continue my work.
>>
>> This series is pretty small and just converts x86 to use platform-devices
>> instead of global objects to pass framebuffer data to drivers. The commit
>> messages explain everything in detail.
>> The idea is to create a "platform-framebuffer" device which drivers can =
bind to.
>> If x86 boot code detectes efi or vesa framebuffers, it creates efi-frame=
buffer
>> or vesa-framebuffer devices instead.
>>
>> Additionally, if the modes are compatible, "simple-framebuffer" devices =
are
>> created so simplefb can be used on x86. This feature is only enabled if
>> CONFIG_X86_SYSFB is selected (off by default) so users without simplefb =
still
>> get boot logs.
>>
>>  @Stephen: I wasn't sure whether you tested the efi/vesa framebuffer cha=
nges,
>> too, so I didn't add your tested-by there. And I changed patch #5 so I d=
ropped
>> it there, too. Thanks for testing!
>>
>
> I am getting a bunch of new warnings with this patchset, typically of
> the form:
>
>
> /home/hpa/kernel/distwork/drivers/video/arkfb.c:1019:23: warning: cast
> to pointer from integer of different size [-Wint-to-pointer-cast]
>   par->state.vgabase =3D (void __iomem *) vga_res.start;
>                        ^
> /home/hpa/kernel/distwork/drivers/video/s3fb.c: In function =91s3_pci_pro=
be=92:
> /home/hpa/kernel/distwork/drivers/video/s3fb.c:1186:23: warning: cast to
> pointer from integer of different size [-Wint-to-pointer-cast]
>   par->state.vgabase =3D (void __iomem *) vga_res.start;
>                        ^
> I have pushed it out to a topic branch in the tip tree, partly to give
> Fengguang's build bot a run at it (it is excellent at spotting the
> origin of new warnings), but this needs to be fixed; we will not merge
> this branch in its current form.

Thanks for looking at it. However, these warnings seem unrelated to my
patchset. I didn't change any vga/fb headers nor did I touch
arkfb/s3fb. Furthermore, I cannot reproduce these warnings. "vga_res"
is a "struct resource", "->start" is of type "resource_size_t" which
is typedef'ed to "phys_addr_t". Seems like the build-bot used some
random config with CONFIG_PHYS_ADDR_T_64BIT set but building on 32bit
(or something like that).

Is there any place where I can see the compiler log? Or the used .config fi=
le?

Thanks
David

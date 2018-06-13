From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 13 Jun 2018 15:22:25 +0000
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if translated by the bridge
Message-Id: <CAKv+Gu_ZRNvW9CeqRyUpQGnrkkoOi1Hh08re=_Gz=EGVTAvbsA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org> <26470c5c-55db-9dff-3794-4e4a96c8bcb6@codeaurora.org>
 <CAKv+Gu8UG_D0AAR8Usdi7DrucqaEs+f-JTU1voR-CcrtNY2ZEQ@mail.gmail.com> <442896963833043f84dd9d0c14d88351@codeaurora.org>
In-Reply-To: <442896963833043f84dd9d0c14d88351@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sinan Kaya <okaya@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Peter Jones <pjones@redhat.com>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>

On 13 June 2018 at 17:17,  <okaya@codeaurora.org> wrote:
> On 2018-06-13 11:06, Ard Biesheuvel wrote:
>>
>> On 13 June 2018 at 16:22, Sinan Kaya <okaya@codeaurora.org> wrote:
>>>
>>> Hi Ard,
>>>
>>> On 5/18/2018 10:17 AM, Sinan Kaya wrote:
>>>>
>>>> A host bridge is allowed to remap BAR addresses using _TRA attribute in
>>>> _CRS windows.
>>>>
>>>> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff
>>>> window] (bus address [0x00100000-0x1fffffff])
>>>> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
>>>>
>>>> When a VGA device is behind such a host bridge and the resource is
>>>> translated efifb driver is trying to do ioremap against bus address
>>>> rather than the resource address and is failing to probe.
>>>>
>>>> efifb: probing for efifb
>>>> efifb: cannot reserve video memory at 0x1e000000
>>>> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
>>>> efifb: mode is 800x600x32, linelength200, pages=1
>>>> efifb: scrolling: redraw
>>>> efifb: Truecolor: size=8:8:8:8, shift$:16:8:0
>>>>
>>>> Use the host bridge offset information to convert bus address to
>>>> resource address in the fixup.
>>>>
>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>>> ---
>>>
>>>
>>> I didn't see any messages about these getting picked up for 4.18.
>>>
>>> Are they queued on your own branch?
>>>
>>
>> No, you never cc'ed me on them until now.
>
>
> Ouch, I hoped that you would get it via get_maintainer script. Sorry for
> that.

Actually, get_maintainer is right: this should go through the fbdev
tree not the EFI tree

Were you going to resend them? If not, I can find them in my archive
and ack them, and we will ask Bartlomiej to take them for v4.19

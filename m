From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 18 Jun 2018 08:43:38 +0000
Subject: Re: [PATCH 2/2] efifb: Copy the ACPI BGRT boot graphics to the framebuffer
Message-Id: <CAKv+Gu_gS+f_TLWzQfVd+EjT3Bmb_wm7Afcmjz2iryNmytXHcQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180617153235.16219-1-hdegoede@redhat.com>
 <20180617153235.16219-3-hdegoede@redhat.com>
 <CAKv+Gu8xHTtHGi=WXHchk+avwResQR2sWgTWw-PyOD8ewkCV_w@mail.gmail.com>
 <08e59509-d790-b33d-99f4-20410726279f@redhat.com>
In-Reply-To: <08e59509-d790-b33d-99f4-20410726279f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 18 June 2018 at 10:30, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 18-06-18 09:36, Ard Biesheuvel wrote:
>>
>> Hallo Hans,
>>
>> On 17 June 2018 at 17:32, Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> On systems where fbcon is configured for deferred console takeover, the
>>> intend is for the framebuffer to show the boot graphics (e.g a vendor
>>> logo) until some message (e.g. an error) is printed or a graphical
>>> session takes over.
>>>
>>> Some firmware however relies on the OS to show the boot graphics
>>> (indicated by bgrt_tab.status being 0) and the boot graphics may have
>>> been destroyed by e.g. the grub boot menu.
>>>
>>> This patch adds support to efifb to show the boot graphics and
>>> automatically enables this when fbcon is configured for deferred
>>> console takeover.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>>
>> I have tested this code on ARM QEMU/mach-virt, and with a little tweak
>> (which I will post separately), the code works as expected, i.e., it
>> redraws the boot logo based on the contents of the BGRT table.
>
>
> That is great.
>
>> However, what it doesn't do is clear the screen, which means the logo
>> is drawn on top of whatever the boot environment left behind, and I
>> end up with something like this.
>>
>> http://people.linaro.org/~ard.biesheuvel/mach-virt-bgrt-logo-redrawn.png
>
>
> Hmm, less great. I'm not sure how to deal with this, on x86 it is more
> or less guaranteed that the screen is already cleared when we load and
> clearing a 4k screen means writing about 32MB, which I guess with modern
> RAM speeds is not that bad actually.
>
> I see that you got this picture by manual booting from the EFI shell,
> in what state does the firmware / bootloader normally leave the
> framebuffer?

UEFI does not usually clear the screen when it boots the default
entry, so it is entirely dependent on the boot loader that runs next.
I guess GRUB usually clears the screen unconditionally?

In any case, I think it is reasonable to clear the screen if you
redraw the logo, but I do wonder if it is safe to assume that the
background color is black.

Instead, we may decide to clear the screen before ExitBootServices()
[using EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.ClearScreen()].

>  I'm asking because if normally it is either cleared
> to black, or already showing the logo I wonder if we should take the
> (small) penalty of clearing ?
>
> Given that we are talking about only 32 MB I could do a v2 which just
> memsets the rest of the screen to 0.
>
> So we get:
>
>         for (y= 0; y < height; y++) {
>                 if (line_part_of_bgrt) {
>                         memset(left-of-bgrt);
>                         draw_bgrt_line(y);
>                         memset(right-of-bgrt);
>                 } else {
>                         memset(line);
>                 }
>         }
>
> Note I've deliberately done the if on a per line
> base to keep the actual blit part of the loop
> efficient and without any extra conditionals in
> there. I also don't simply first memset the entire
> fb to 0 to avoid a flash / tearing if the bgrt
> image is already in place (which happens often on
> x86).
>
> Implementing this is easy and as said the extra execution time should
> be quite small, still I wonder what others think about this?
>
> I'm leaning towards doing the clearing / memsets since I've seen
> some firmwares leave some artifacts from not completely clearing
> things like a "Press F2 to enter setup" message, missing a few
> pixels and leaving those on screen.
>

I think the overhead of doing the clearing is not going to be the
bottleneck. But redrawing a logo on black background that was designed
to be displayed over another color is going to look really ugly ...

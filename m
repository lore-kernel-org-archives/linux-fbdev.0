From: =?UTF-8?Q?M=c3=b4she_van_der_Sterre?= <me@moshe.nl>
Date: Mon, 18 Jun 2018 08:53:30 +0000
Subject: Re: [PATCH 2/2] efifb: Copy the ACPI BGRT boot graphics to the framebuffer
Message-Id: <c8d28a61-46ed-c066-5a23-e74e9327380c@moshe.nl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180617153235.16219-1-hdegoede@redhat.com>
 <20180617153235.16219-3-hdegoede@redhat.com>
In-Reply-To: <20180617153235.16219-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Hi Hans,

On 06/17/2018 05:32 PM, Hans de Goede wrote:
> On systems where fbcon is configured for deferred console takeover, the
> intend is for the framebuffer to show the boot graphics (e.g a vendor
> logo) until some message (e.g. an error) is printed or a graphical
> session takes over.
> 
> Some firmware however relies on the OS to show the boot graphics
> (indicated by bgrt_tab.status being 0) and the boot graphics may have
> been destroyed by e.g. the grub boot menu.

It may be clearer to just say that the boot graphics may have been destroyed. The reference to the status field and firmware expectations only confuses the intention of this patch, imho.
(This ties in to what I say below)

> This patch adds support to efifb to show the boot graphics and
> automatically enables this when fbcon is configured for deferred
> console takeover.
> 
> +	/*
> +	 * We do not check bgrt_tab.status here because this seems to only
> +	 * reflect if the firmware has shown the boot graphics at all, if it
> +	 * later got destroyed by something status will still be 1.
> +	 * Since we draw the exact same graphic at the exact same place this
> +	 * will not lead to any tearing if the boot graphic is already there.
> +	 */

I agree that ignoring bgrt_tab.status is the absolute best option.

The status (valid-bit) can, in the real world, be any value with any meaning.
I checked this on a few machines as part of commit 66dbe99cfe30.
 - My workstation always has 0.
 - An old server that I checked always has 1.
 - My laptop has 1 if the boot is uninterrupted, 0 if I request the UEFI boot menu.

So, I have the same reservation about this comment as I have about the commit message. Imho, simply mentioning that the status field cannot be relied upon (in any case), would get the point across.

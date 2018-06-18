From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 18 Jun 2018 09:08:17 +0000
Subject: Re: [PATCH 2/2] efifb: Copy the ACPI BGRT boot graphics to the framebuffer
Message-Id: <8bdcb7fa-ab78-86b5-17bf-3015fe41f0eb@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180617153235.16219-1-hdegoede@redhat.com>
 <20180617153235.16219-3-hdegoede@redhat.com>
 <c8d28a61-46ed-c066-5a23-e74e9327380c@moshe.nl>
In-Reply-To: <c8d28a61-46ed-c066-5a23-e74e9327380c@moshe.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?M=c3=b4she_van_der_Sterre?= <me@moshe.nl>
Cc: linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Hi,

On 18-06-18 10:53, M=C3=B4she van der Sterre wrote:
> Hi Hans,
>=20
> On 06/17/2018 05:32 PM, Hans de Goede wrote:
>> On systems where fbcon is configured for deferred console takeover, the
>> intend is for the framebuffer to show the boot graphics (e.g a vendor
>> logo) until some message (e.g. an error) is printed or a graphical
>> session takes over.
>>
>> Some firmware however relies on the OS to show the boot graphics
>> (indicated by bgrt_tab.status being 0) and the boot graphics may have
>> been destroyed by e.g. the grub boot menu.
>=20
> It may be clearer to just say that the boot graphics may have been destro=
yed. The reference to the status field and firmware expectations only confu=
ses the intention of this patch, imho.
> (This ties in to what I say below)
>=20
>> This patch adds support to efifb to show the boot graphics and
>> automatically enables this when fbcon is configured for deferred
>> console takeover.
>>
>> +	/*
>> +	 * We do not check bgrt_tab.status here because this seems to only
>> +	 * reflect if the firmware has shown the boot graphics at all, if it
>> +	 * later got destroyed by something status will still be 1.
>> +	 * Since we draw the exact same graphic at the exact same place this
>> +	 * will not lead to any tearing if the boot graphic is already there.
>> +	 */
>=20
> I agree that ignoring bgrt_tab.status is the absolute best option.
>=20
> The status (valid-bit) can, in the real world, be any value with any mean=
ing.
> I checked this on a few machines as part of commit 66dbe99cfe30.
>   - My workstation always has 0.
>   - An old server that I checked always has 1.
>   - My laptop has 1 if the boot is uninterrupted, 0 if I request the UEFI=
 boot menu.
>=20
> So, I have the same reservation about this comment as I have about the co=
mmit message. Imho, simply mentioning that the status field cannot be relie=
d upon (in any case), would get the point across.

Ok, I will simplify both the commit message and comment bits to just state
that the status field is unreliable.

Regards,

Hans

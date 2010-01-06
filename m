From: Miles Lane <miles.lane@gmail.com>
Date: Wed, 06 Jan 2010 17:42:59 +0000
Subject: Re: 2.6.33-rc3 -- Intel 945GME (inteldrmfb) -- Two Tux images
Message-Id: <a44ae5cd1001060942p7672768yec3b1f5ea2426682@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <a44ae5cd1001060916s4db1d94fsb7e012ab80ce6add@mail.gmail.com>
	 <alpine.LFD.2.00.1001061736080.5372@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1001061736080.5372@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: James Simmons <jsimmons@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, linux-fbdev@vger.kernel.org

On Wed, Jan 6, 2010 at 12:37 PM, James Simmons <jsimmons@infradead.org> wro=
te:
>
>> For a long time I have gotten two pictures of Tux showing up when I
>> include the Tux display option in my custom kernel builds. =A0I don't
>> know how many kernel revisions ago it was when I started noticing
>> this. =A0It seems like it might have been early in the 2.6 series
>> kernels.
>>
[...]
>> # Frame buffer hardware drivers
>> #
>> CONFIG_FB_VESA=3Dy
>> CONFIG_FB_EFI=3Dy
>
> Try disabling these two above options.

Well, that means that I don't get Tux at all.  The point is that only
one copy should be displayed.

      Miles

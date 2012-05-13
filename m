From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 13 May 2012 13:04:10 +0000
Subject: Re: [PATCH] video/sis: Annotate SiS_DRAMType as __devinitconst
Message-Id: <4FAFB14A.2020705@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FAB0986.6090006@gmx.de> <201205102339.09295.PeterHuewe@gmx.de>
In-Reply-To: <201205102339.09295.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Peter_H=FCwe?= <PeterHuewe@gmx.de>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Peter,

On 05/10/2012 09:39 PM, Peter H=FCwe wrote:
> Am Donnerstag 10 Mai 2012, 02:19:18 schrieb Florian Tobias Schandinat:
>> Good that you did this one, it was more to be done than I expected. I
>> ignored the checkpatch errors as you didn't introduce them but maybe it
>> wouldn't be a bad idea to fix things up if you touch them. Applied.
>=20
> Oh sorry, usually I do checkpatch, but I missed it on this one somehow.
> If you want, I can do a checkpatch cleanup for the whole sis driver as=20
> compensation ;)

That's not necessary.
I just wanted to highlight that I prefer it if people fix the style
on-the-fly while working on things rather than sending me individual
patches for each line and not even fixing the complete line but only one
special aspect of it so that checkpatch complains about their style fixes.

btw. Special characters are allowed in sign-offs.


Best regards,

Florian Tobias Schandinat

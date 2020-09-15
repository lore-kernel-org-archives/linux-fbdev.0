From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Tue, 15 Sep 2020 14:03:57 +0000
Subject: Re: [PATCH] docs: fb:  Remove scrollback option
Message-Id: <20200915135157.GB30746@Gentoo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NMuMz9nt05w80d4+"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200915132736.5264-1-unixbhaskar@gmail.com>
 <20200915134127.GA873393@kroah.com>
In-Reply-To: <20200915134127.GA873393@kroah.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15:41 Tue 15 Sep 2020, Greg KH wrote:
>On Tue, Sep 15, 2020 at 06:57:36PM +0530, Bhaskar Chowdhury wrote:
>>=20
>> This patch remove the scrollback option under boot option.
>> Plus readjust the numbers for the options in that section.
>>=20
>> This is the effect of these commits:
>>=20
>> 973c096(vgacon: remove software scrollback support)
>> 5014547(fbcon: remove soft scrollback code)
>
>The kernel documentation file:
>	https://www.kernel.org/doc/html/latest/process/submitting-patches.html

>in section 2, describes how to show git ids within changelog text
>properly (the number of characters and the rest.)

Okay, I have only included 7 instead of 12 ... :(=20
>
>Can you fix this up and resend?

Certain.
>
>And this is a v2 patch, right?  Always document what changed from
>previous patches below the --- line, as the above link asks for.

No ...no Greg ..  I shall be sending afresh ...kindly ignore all the previo=
us and
this one too..=20

>
>thanks,
>
>greg k-h

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9gxvoACgkQsjqdtxFL
KRUHAQgArmFJVrc6dwRjlNuO95r92Rk8vcvoeOtfkMN6LQ454PW5VakoCan6j11a
5WnzD39nqfjtcLNPuX1Bb6WGRUNAPp6THDn42miNC55SbRwqrCLxgjKvI017dytm
XOVPbDZxfmGU33IWvA7mmyqRHvMTsSZcfK7ShRNY2s6UeIgo9gA5SkY4K4jg4PXC
OQqntGGrX24whZ8hvKqv6yMDaZqL4dRIkB1i6GVMs0k+h7UetiqrPtJJftqBh4OU
WE5T/8K0ejag1VKDfjIoOCxa3KAbiz6+MruyhAhrwkvyd/hGvKjkuQoiIHiWUMP4
2zSGw50aYOi/GkjNsMvEQer0yAL21A==
=N8Nj
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--

From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Thu, 17 Sep 2020 08:23:58 +0000
Subject: Re: [PATCH v3] docs: fb: Remove framebuffer scrollback boot option
Message-Id: <20200917081158.GA19903@OpenSuse>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200916230150.14516-1-unixbhaskar@gmail.com>
 <20200917074747.GA3332340@kroah.com>
In-Reply-To: <20200917074747.GA3332340@kroah.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09:47 Thu 17 Sep 2020, Greg KH wrote:
>On Thu, Sep 17, 2020 at 04:31:50AM +0530, Bhaskar Chowdhury wrote:
>> This patch remove reference to this option in this document and=20
>> renumbered the sections. This is related to below commits.
>>=20
>> Commit 973c096f6a85(vgacon: remove software scrollback support)
>> Commit 50145474f6ef(fbcon: remove soft scrollback code)
>> =20
>>=20
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>> This version try to correct the previous errors, proper changelog text, =
subject
>> Trying to incorporate Willy's & Greg's suggestions
>
>Better, but...
>
>This should be a patch series, properly numbered and threaded, right?
>
>The text above still has the commit ids not properly referenced, and you
>have trailing whitespace in the text too.
>
I will certainly fix that in the upcoming version.

>Writing the changelog is often times the hardest part of a patch, as you
>are finding out.
>
Yes..true.
>How about this example, for this specific patch, as a changelog text:
>
>---------
>In commit 50145474f6ef ("fbcon: remove soft scrollback code"), the
>framebuffer scrollback mode was removed, but the documentation was not
>updated.  Properly update the documentation by removing the option that
>is no longer present, and update the section numbering because of the
>removal.
>---------
Just like an pointed arrow ..perfect...cut to the cheese!
>
>Doesn't that make more sense about what is happening here, and provide
>enough information that when someone 10+ years from now goes and tries
>to find out why a boot option went away, what exactly happened and why?
>
Absolutely.

>Can you make this type of change to all 4 of these patches and resend
>them, with the proper change information below the --- line as a v4
>series?
>

Certain thing...will incorporate your suggestions in V4 and send.

>thanks,

Indebted for your and others patience for standing this long ..thank you!
>
>greg k-h

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9jGkQACgkQsjqdtxFL
KRUH8wf/ZIheAFYvmppgZeg3wK1xvppY4mlIXylSs8h9vJSQXteqacyfYmP4Z1Fl
euh7VXq8ll+swv0JsNT+hfb7MfQ9mIc4VDJQkdaIPngxLsPwzdBHy+3xJzZhbwCI
Ut48dWxUJSqkVZi/9hzFXu02FIQaodfXdq0KksqZUe/dlC5NKHzBdqP2RAYgF/6a
dI6SDqpNCOG2bQChpr9d1kzun7c7bGniLbiu0AFF1C6Ot4VDcZ/KzJmxi3B9sf1s
d9y/LxOqnANMhnmCipwQz62Tb0YOtWN0xyPMS6NYHGLDUcB9P79vW3qFUbB6I2nz
xpMCWr2JN7zP9S6kVVvykwCZjdnP5A==
=VFET
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

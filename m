From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 04 Jun 2015 05:55:47 +0000
Subject: Re: [PATCH v3 2/3] video: fbdev: vesafb: add missing mtrr_del() for added MTRR
Message-Id: <556FE863.9070000@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Owe21OFmuMbBtV4VT0S5eJFPRhGO3G7D4"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429648850-17902-1-git-send-email-mcgrof@do-not-panic.com> <1429648850-17902-3-git-send-email-mcgrof@do-not-panic.com> <555C594E.1010607@ti.com> <20150520194632.GY23057@wotan.suse.de>
In-Reply-To: <20150520194632.GY23057@wotan.suse.de>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, plagnioj@jcrosoft.com, hpa@zytor.com, linux-fbdev@vger.kernel.org, luto@amacapital.net, cocci@systeme.lip6.fr, Toshi Kani <toshi.kani@hp.com>, Suresh Siddha <sbsiddha@gmail.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Rob Clark <robdclark@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org

--Owe21OFmuMbBtV4VT0S5eJFPRhGO3G7D4
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 20/05/15 22:46, Luis R. Rodriguez wrote:
> On Wed, May 20, 2015 at 12:52:14PM +0300, Tomi Valkeinen wrote:

>> Hmm, this looks a bit odd... You're removing the pseudo_palette, and
>> using its memory for mtrr cookie?
>=20
> You are totally right, sorry, will spin a v3.

Did you ever send a new version (v4 actually), or have I somehow missed i=
t?

 Tomi


--Owe21OFmuMbBtV4VT0S5eJFPRhGO3G7D4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVb+hnAAoJEPo9qoy8lh710g4P/jQMrN8IbZNcNwcVQ931k9k5
v8s1BcuDRax7GJxp3Vj/XwAmVyK49hCov312XLvOilKcxwT3JH6LEL67Gl8mS4d9
OQlZcODSgOU6qXjkqfElPe0j94lQwOfBurpws7hEhzUJtIPjL4Y+is0H5lXyVaQa
DvwKepeHAQyy3OuyOTRenlfcz4xcO6RkH/BdRqGQq9WgpOga/PsoDwkr3zabgc/V
B8iBj++vM3Xd+dwHS3GOxr5PflbovIxdwfRVQFlLC07IEn0RhUaxN/8kyqSQh55s
oZLqMa8bBP/rR30eS8VEC22KbpA2N310Pxm6MClRjPrBpSHmH244Q6G43w6alAFD
wmSW33720kOauMax0gaeBXLNqnyO4rSavLckJJ4+/gLFGkOcgT4DzJY9OnXtp5vC
JmxPvogJZ2a5lzVO12mjC9DYEKT5QcRz/eN6WxyWmqHxUfxxS37W6ZsaMaFLgwow
+bB/Jchk/8klo6XUjxEHko0jxthyzwNGgkNB9jZnFhgtexFFo1XgB3LZw+NLtE62
h1yq52ELk53Txs+Xlc9+IXrI97atKedyveow1w9h/RNsts3sB/6t0WfJogbSK5/d
fn7AJM+OCjdkQ30HHpTiZc2lGafmQE06efW3S832O/4H5/Ts0Fr2qH7Ksq8MlVA2
lRclfVYtkWODDQ6yvc7g
=Ttno
-----END PGP SIGNATURE-----

--Owe21OFmuMbBtV4VT0S5eJFPRhGO3G7D4--

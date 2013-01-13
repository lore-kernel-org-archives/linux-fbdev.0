From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sun, 13 Jan 2013 15:14:38 +0000
Subject: fb: Rework locking to fix lock ordering on takeover
Message-Id: <CA+icZUVJ5hbPJvV4LMFGgD3Sto5=EV=MO9nutYdJwkiRrmpNJQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bcaec51b16d5b9da9504d32cfccb"
List-Id: <linux-fbdev.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

--bcaec51b16d5b9da9504d32cfccb
Content-Type: text/plain; charset=UTF-8

Hi Andrew,

your patch from [1] - as far as I followed - misses a lot of
Reported-by#s and Tested-by#s (Boris, Jiri, etc.).
Just one new R-b I have seen yesterday.

I have the original patch from Alan plus the two follow-ups from you
in my patch-series against v3.8-{rc2,rc3} for quite a while.
So, please feel free to add a Tested-by.

Unfortunately, your patch has introduced some (unwanted) extra chars
like "_*" (comments only).
I appreciate one single (new) patch like this, but please in a proper way.

A disappeared/busy/not-answering maintainer is not an excuse for
handling serious regressions (even here in this case there are fixes
around),
Personally, I am still missing a mei-driver fix [2] and a libata-dev fix [3].
Both issues are not new to the maintainers.
Not sure if shouting louder is the best strategy here.

It would be great to have a place like a "board of arbitration" where
someone can send blames.
And I remember vaguely Rafael had a nice list of issues (w/ reference
to patches!).
This was a real cool helpful innoivation!
I can't remember why Rafael stopped his nice service to the
Linux-kernel community.

Have fun!

Regards,
- Sedat -

[1] https://patchwork.kernel.org/patch/1969391/
[2] http://git.kernel.org/?p=linux/kernel/git/gregkh/char-misc.git;a=commitdiff;h=e6028db0146cf5a68dbd1508225ea49840997880
[3] http://patchwork.ozlabs.org/patch/206897/

--bcaec51b16d5b9da9504d32cfccb
Content-Type: application/octet-stream; 
	name="fb-Rework-locking-to-fix-lock-ordering-on-takeover-fix-comments.patch"
Content-Disposition: attachment; 
	filename="fb-Rework-locking-to-fix-lock-ordering-on-takeover-fix-comments.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hbwbm6np0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Z0L3Z0LmMgYi9kcml2ZXJzL3R0eS92dC92dC5jCmlu
ZGV4IDM0N2JlZDAuLjFkYjFjOGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Z0L3Z0LmMKKysr
IGIvZHJpdmVycy90dHkvdnQvdnQuYwpAQCAtMzY1Myw3ICszNjUzLDcgQEAgaW50IGRvX3Rha2Vf
b3Zlcl9jb25zb2xlKGNvbnN0IHN0cnVjdCBjb25zdyAqY3N3LCBpbnQgZmlyc3QsIGludCBsYXN0
LCBpbnQgZGVmbHQKIAkvKgogCSAqIElmIHdlIGdldCBhbiBidXN5IGVycm9yIHdlIHN0aWxsIHdh
bnQgdG8gYmluZCB0aGUgY29uc29sZSBkcml2ZXIKIAkgKiBhbmQgcmV0dXJuIHN1Y2Nlc3MsIGFz
IHdlIG1heSBoYXZlIHVuYm91bmQgdGhlIGNvbnNvbGUgZHJpdmVyCi0JXyogYnV0IG5vdCB1bnJl
Z2lzdGVyZWQgaXQuCisJICogYnV0IG5vdCB1bnJlZ2lzdGVyZWQgaXQuCiAJICovCiAJaWYgKGVy
ciA9PSAtRUJVU1kpCiAJCWVyciA9IDA7CkBAIC0zNjc5LDcgKzM2NzksNyBAQCBpbnQgdGFrZV9v
dmVyX2NvbnNvbGUoY29uc3Qgc3RydWN0IGNvbnN3ICpjc3csIGludCBmaXJzdCwgaW50IGxhc3Qs
IGludCBkZWZsdCkKIAkvKgogCSAqIElmIHdlIGdldCBhbiBidXN5IGVycm9yIHdlIHN0aWxsIHdh
bnQgdG8gYmluZCB0aGUgY29uc29sZSBkcml2ZXIKIAkgKiBhbmQgcmV0dXJuIHN1Y2Nlc3MsIGFz
IHdlIG1heSBoYXZlIHVuYm91bmQgdGhlIGNvbnNvbGUgZHJpdmVyCi0JXyogYnV0IG5vdCB1bnJl
Z2lzdGVyZWQgaXQuCisJICogYnV0IG5vdCB1bnJlZ2lzdGVyZWQgaXQuCiAJICovCiAJaWYgKGVy
ciA9PSAtRUJVU1kpCiAJCWVyciA9IDA7Cg==
--bcaec51b16d5b9da9504d32cfccb--

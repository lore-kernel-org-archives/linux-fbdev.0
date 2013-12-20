From: Keith Packard <keithp@keithp.com>
Date: Fri, 20 Dec 2013 07:10:39 +0000
Subject: Re: [PATCH] fbcon: Clean up fbcon data in fb_info on FB_EVENT_FB_UNBIND with 0 fbs
Message-Id: <86pposdmkw.fsf@miki.keithp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387498677-25653-1-git-send-email-keithp@keithp.com>
In-Reply-To: <1387498677-25653-1-git-send-email-keithp@keithp.com>
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Keith Packard <keithp@keithp.com> writes:

> When FB_EVENT_FB_UNBIND is sent, fbcon has two paths, one path taken
> when there is another frame buffer to switch any affected vcs to and
> another path when there isn't.

What I meant to attach to this bug report but clearly failed was that I thi=
nk
this case essentially *always* occurs if you have a generic frame buffer
driver loaded before a 'real' driver is loaded. In my case, this is
efifb. So, we have a reference to freed memory hanging out on a timer
list.

I'm really unsure why this hasn't caused more grief, but I can say that
it was greatly aggravated by adding 'fbcon=3Dvc:2-6' to the kernel command
line, which limits fbcon to supporting consoles only on vt 2-6.

Definitely one of those 'how could this ever have worked, and why hasn't
my machine been crashing every day' moments when I read through the
code.

As the patch indicates, I'm not sure this patch is actually what we
want, but I'd love to know if I've isolated the root cause correctly and
then figure out what patch we actually want.

For my own part, I've got a happy customer with the patch, which is
definitely a nice way to end the day.

=2D-=20
keith.packard@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUBUrPtb9siGmkAAAARAQhQqRAAouoxEF1w4ZelQ8UWaVDOZwOF7chbOKHU
16zulH5ehkxVxZeYhv4XKLiXYbhvs+pFkwgQljdrY7/5nx1jtfNyBe3MSIQTVK6N
cTa+tFnI8k/dX58KWTLj9csexM9QsK3+mkS6WqNLYvjmzI/IhlDBBL8Dt9cfA7wW
rbyq6FEhDcyibmGFbGDX5DE7TOtBvX2hdWhHIyFtYtIccWDDETSZdw5jt/Zv664f
qlauxuQM6Dz/bY/v3CH9d7uTjnHFZ5n9LGmRe7SLxHr2PGKefmmjzGhrNopdEdLH
MMxg3SIQWJ/hxmLuqF7pVnv28nTs9b1eChOqFSp8Zt+fgLfvho06q6ud7DyGyN3J
aI/Myin/J6faE1cMAcnzLdqRIedJoEaGfSzc5nNg2tm4eavMLGBzBEjpNSlal2Du
+SDLr3WPzWrvsFPIT/ej0TgLiskHmBizOQ76WuhksaA9SR5uXLgnA169PPq8mB8g
3aXueaYfeiJd/sPS6EwG0n9IIQIkiOfzKpoLeNt1stZz7vVNksnmc0ydGPyOVpbS
yVlgTsCS18bbrbCuntPxJ9Q/b2ICmki79f6Ah2Nk61UKoaV9R52f9a7wlmxtDfUR
2T2gtuj99cqEG85Z2gqQqmt9B2II/Tn3LqQCaCYroFIpQmmnBeAgpP0yyQxlcl1Q
qAQVVxnCcIk=
=pxpa
-----END PGP SIGNATURE-----
--=-=-=--

From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 25 Jun 2012 09:30:43 +0000
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Message-Id: <1340616643.3395.19.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-MH21gW2nipSS5Z/on5bp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340605221.12683.30.camel@lappyti>
	 <CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
In-Reply-To: <CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-MH21gW2nipSS5Z/on5bp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-25 at 14:19 +0530, Jassi Brar wrote:
> On 25 June 2012 11:50, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
> ....
> >>  Currenlty HDMI fails to come up in the suspend-resume path.
> >> This patch helps that real-world scenario.
> >
> > What is the problem there? It'd be good to explain the problem in the
> > patch description. Does the pm_runtime_get return -EACCES?
> >
> Yes, it returns -EACCESS because RPM on devices is disabled during the
> period from suspend-start to resume-finished.

So... You didn't answer my first comment, how can the code work? The
driver needs to enable the HW and the call to pm_runtime_get() is
skipped. Won't this lead to crash as the DSS registers are accessed
without the HW in enabled state? And what happens if the
pm_runtime_get() call is skipped, but pm_runtime_put() is not?

 Tomi


--=-MH21gW2nipSS5Z/on5bp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6C/DAAoJEPo9qoy8lh71E5IP/io1s9Kuyw9PMk1QBBuMyGy5
3gM88nUpYcSkoTgKDcCZCmZhJU/039Z/0DuVpeJPv91MMjvGI9Snh7YneeYGTPMX
Ih7jWUij7pvWxbTsVTQPgXKTXy5b0c47XKdWWp0Nw4elElcYPoZHOF7ZciWjUh35
oLIFv6hRR+0wNFZIuy41LcuFG8VUVvHlziShnuzPCWfTTKfAV+BkjlT/CIjA/ZBe
x7NDrRTrLh619WeJOaetn5USwlmPE5t7Q8FP5zvTRg1eGCx2oWAwJMkW+174/i6S
C9oBM9f6qe0E4E43+sayfX/523Y1UzpcjEV80z9Obs2X0fjljhmuZMfAtZ8aIhYC
tPmrVn71LfHjJm+/6mFjpQkRT2U+Hs+Z1zEPixxyAwwRvWBhBpl/HQy6I0x3oIOD
+aI4JQJZjDnMO6WBrH4/xJD5nJ3Dc4RJ88cqPo/NKr8TU2gtllgKNDeCmdiB8iJ1
Mh/ChZI0pJqYt6buv8FqoI4JSSfUfF1rdJDyhdct3BwxWOwBWVmglcpKtiRYxzOI
jXbtnyOj+80XAyeRFfeKE61Ryy31Kmr1pg40PXL7icBhB2kPmCAu3qgpmaDMNIIv
rFgearNRgksZeHPQSE944j82sqXnK60Per/SGDyCzoLKQ6O+NwB5U9koQI+YzdNd
sEsaz3WgcSy8pF+vO+/n
=u30b
-----END PGP SIGNATURE-----

--=-MH21gW2nipSS5Z/on5bp--


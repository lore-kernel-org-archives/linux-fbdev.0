From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Mon, 17 Sep 2012 09:33:24 +0000
Subject: Re: [PATCH Re-send] pwm-backlight: Use devm_pwm_get in pwm_bl.c
Message-Id: <20120917093324.GA11978@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347862847-2774-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1347862847-2774-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 17, 2012 at 11:50:47AM +0530, Sachin Kamat wrote:
> This file already makes use of device managed functions.
> Convert pwm_get() too to use it.

I find this description a bit confusing. pwm_get() is not converted, but
rather the driver is converted to use devm_pwm_get() instead of
pwm_get().

How about this:

	pwm-backlight: Use devm_pwm_get() instead of pwm_get()

	Managed versions of the pwm_get() and pwm_put() functions were recently
	added to the PWM framework. They can be used to simplify cleanup in the
	error paths and the device removal callback.

If that's okay with you, I can just replace it before pushing so there's
no need for you to resend.

Thierry

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQVu5kAAoJEN0jrNd/PrOhhEIP/1/s0shKMiMBkeU2QXv46E+Q
SpulyOAhJT7b80puLEP3s9JSFktEhXqFHZ+oD9WoEgdxV0j8JRjT478l4GN9HqdA
geLrgy2bBGUb1Q6ELiTemhc1gxAYjkIbgh/2xbLVrjVZBmvlAiZL9wp1NhiyB+wp
jbD78Ghnk+eslhhmi0uRrhfXwU8z2fdtR+Jx6i4eLYxgsRL7LEKI8vpd/vBi9W9Q
GWYgdEOfQESM21z88iUETKhqSgNqS6gzuPj9H+nzCcNomU0tEqYSxfYHoSXCXspA
O/lI4MNaJgeKYh037hceuTGRAGfLoRlclWtBBNQfRhGgBrp+r55MHUSBfP2c86lJ
ei81iULHpCinIIIS5Kl2jlXY4aj3JkUfN9lKqr4nd6xNqdBFlNK/JPRD+AuOXHvu
Nh8bLrMymquSFeMVocSavo9S5HSnRvgtpADY0viwTri0Gh0T3RGG8Ycd6aOZ4gfk
/jJKYTdF0FbD9WfImH4BX4zeTjvdZiwif2dV7aYMkFqXAvcZPXGd0RthaAkfNLtX
+NVLGYTxvmTNN38SM5XqcikxsL6z6RG3TJExaY6Zex75YtLSi9IvvUENnMhzsJUA
IuuyN4yx8p93oq3AgjZFJB50I6FZkypfs6hKx3BHaUzTr4w6o/a5+uAT8wnzsps/
c7UDdmvSCXxdH3jrTWkz
=jdPT
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

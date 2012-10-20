From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Sat, 20 Oct 2012 19:59:51 +0000
Subject: Re: [PATCH 1/2 v6] of: add helper to parse display timings
Message-Id: <20121020195950.GA13902@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349373560-11128-1-git-send-email-s.trumtrar@pengutronix.de>
 <1349373560-11128-2-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1349373560-11128-2-git-send-email-s.trumtrar@pengutronix.de>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: devicetree-discuss@lists.ozlabs.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Herring <robherring2@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 04, 2012 at 07:59:19PM +0200, Steffen Trumtrar wrote:
[...]
> diff --git a/include/linux/of_display_timings.h b/include/linux/of_display_timings.h
[...]
> +struct display_timings {
> +	unsigned int num_timings;
> +	unsigned int default_timing;
> +
> +	struct signal_timing **timings;
> +};
> +
> +struct timing_entry {
> +	u32 min;
> +	u32 typ;
> +	u32 max;
> +};
> +
> +struct signal_timing {

I'm slightly confused by the naming here. signal_timing seems overly
generic in this context. Is there any reason why this isn't called
display_timing or even display_mode?


--9amGYk9869ThD9tj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQgwK2AAoJEN0jrNd/PrOh32YQAKjuEVeFaD/3jmolgP/AGhLt
cK7cj0+eUX+fnExGUSQpGwkk+bzLVlAq84u+AeMzrEEIm5+2hsgZ344AWW0MAPDt
WkyPdDXAvtHCmGen+65xYeez3edgSTGQ3nS3yajtDzGmfhyRqgqdWrqdqM68EcqM
WO6ioWVcXpGoXd5Uju237Ngpjz6iMEHttgBgB6PJ07bt9IIDaWc/+Fbz6jeHurXV
Te9aIZg9SuFAcxqqVzFlQJlfyE0rl7Ykk5bP1HogLv4mE5ktEYQOW2PIDZWXj5jM
Q7hBuLkvhXsqhwZL5q8Ul7Rsn6gSqT9PSC5st6xVP/wxTQ5dQwyxyneZlQZrNFbs
P5+w7nPU7/rLOnzfoniYj7H4dT9FPMPmjrKdPKFxjKRojZzXi55IhPI2APeOxMFG
qAj0I7izoN+uk6H7c8oW1Oj3x4lqru1oUzScZEpjNbRHPearE8oao58//Y8ftJaK
dTlQUtfame9oTxWlooGzxDAHs0XD0fXf6vgKV74TPlYLQtc2Xw5FjYDYigBcyd8F
yDbjDNWrU3JV8quZLnk02SQCnScV1Izab4qmmBCQwVOmqVpvPlfW6HGb6ewEPvII
g3XlFr0Ic5gQ+SuYetKlz2pg+Ed/09wvtVLNeqLhdVZe97T1jj8hzwXTcjTKKwW5
eyP/5vVD4iucOvXEP7y9
=hrqF
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

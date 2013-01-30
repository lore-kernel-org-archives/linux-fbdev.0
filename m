From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Wed, 30 Jan 2013 07:24:06 +0000
Subject: Re: [RFC 3/4] drm: tegra: use the Common Display Framework
Message-Id: <20130130072406.GA17128@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359514939-15653-1-git-send-email-acourbot@nvidia.com>
 <1359514939-15653-4-git-send-email-acourbot@nvidia.com>
 <5108C298.1000500@gmail.com>
 <5108C55C.30104@nvidia.com>
In-Reply-To: <5108C55C.30104-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Mark Zhang <nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2013 at 04:01:48PM +0900, Alex Courbot wrote:
> On 01/30/2013 03:50 PM, Mark Zhang wrote:
> >>@@ -147,6 +148,9 @@ struct tegra_output {
> >>
> >>  	struct drm_encoder encoder;
> >>  	struct drm_connector connector;
> >>+	struct display_entity this;
> >>+	struct display_entity *output;
> >
> >Could you pick up a somewhat meaningful name? You know, there are too
> >many variables with name "drm/connector/output/encoder"... :)
>=20
> Well, it's supposed to be abstract. From the CDF point of view it
> could be anything besides a panel. I know this makes it an output of
> an output, but I can't think of anything better right now.

How about renaming "this" to stream to match with what the output is in
CDF speak. And the output's output is the panel, right? Why not just
call it that? Even if it isn't directly connected to a panel entity but
has indeed a whole pipeline in between, for tegra-drm it is still a
panel.

Thierry

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRCMqWAAoJEN0jrNd/PrOhezMQAJkU6eHl9u7E/Ok5OjHxq7aZ
8K+Gmt/DTlSHw0JuVGkd4FzoFGkfx2XFYGyny9uy9cz1zIjpNkJDTMDbLHqc1RM7
BS11WFvvZlQXXGB+b8l0MzGfeksQObbEIyPVxAT9Z70E6t/aW/89g9kikJ5FuOo1
8IILt2c2N2HbFITmqHDEiGTb4D5MSsLrc/0wG9kqz5hGZPEwerWV7ggNiSH9D03+
ZFiRKOdDaS2tOY0Cg1m3i72b8qrj6dsAFKx7GdXOPHjuwWBfjsKOD9iRhffgPzrJ
/AiYEPWNYnfirF85XDQ0nsB3HTEzmViTHHZBLseTfOnJRb6YLClG7B73hILb+7f3
AfbeHpM+Ck8c8aGvUnD4GpM5J+N4HnRMI5bn0pWcewrASGOYItLorLSBDwb1vUxv
Thbp3pE0xbgAsdbv/lFQZHY1v+JlAfiMKzXISF1pg0OWShCjnsVv7j6eenrN7Bm1
RlJH79q89Ana+d3hPfsdA1B20chuRXxT+i+zMR3z8f9DSsGgQwW/t6Pp59cO0XRM
bmIh9WVP5aZ7sYRMetPbDPQa+gwThJRa2Ex8meEK5a8N9BQkK/HImDbvPmeOiffn
vky5bQZCjByMpzh7LYBKJQ7epE63mLPq8oHhF4DJ4j0jBKlr9NrBLdGbuqPL9AwT
4po7D0NFMR7YuaCrJeCu
=wg57
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

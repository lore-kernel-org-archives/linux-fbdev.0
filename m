From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 13 May 2016 15:28:39 +0000
Subject: Re: [PATCH] drm: expand cea861 mode timing table
Message-Id: <20160513152839.GA24232@ulmo.ba.sec>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1463081853-14942-1-git-send-email-eric.yang2@amd.com>
In-Reply-To: <1463081853-14942-1-git-send-email-eric.yang2@amd.com>
To: Eric Yang <eric.yang2@amd.com>
Cc: linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, dri-devel@lists.freedesktop.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2016 at 03:37:33PM -0400, Eric Yang wrote:
[...]
> diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
> index e974420..edbb4fc 100644
> --- a/include/linux/hdmi.h
> +++ b/include/linux/hdmi.h
> @@ -78,6 +78,8 @@ enum hdmi_picture_aspect {
>  	HDMI_PICTURE_ASPECT_NONE,
>  	HDMI_PICTURE_ASPECT_4_3,
>  	HDMI_PICTURE_ASPECT_16_9,
> +	HDMI_PICTURE_ASPECT_64_27,
> +	HDMI_PICTURE_ASPECT_256_135,
>  	HDMI_PICTURE_ASPECT_RESERVED,
>  };

Where did you get these from? I'm asking because I sent this patch last
year (or at least I wrote it and we discussed it on IRC, since I can't
find an email archive link to it), and back at the time the picture
aspect ratio was the big question mark. My recollection is that
CEA-861-F introduces these new picture aspect ratios in the mode tables
but never specifies their values. As a matter of fact, the AVI infoframe
where these values are used only has space for 4 values (none, 4:3, 16:9
and reserved).

Would you mind pointing me at the specification for these values?

Thanks,
Thierry

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXNfKkAAoJEN0jrNd/PrOh8ggP/2AcQrdQXe4bLWeGUktFsBaA
nkORT6Cmgrvv9ZlUYAVv3VZPZ3Od97lxD9FEe4tkCgZ6hiIjmaJidFAw/PPddnQf
KNzCEIVgV3yj8l7vyCm6KZGVSlVCKfXcaegfrINeQAyQYNUOq5LGFzDYVo4pEpyz
yG718gpN0rhaO/k69Z6Ena6YFAkthBpYFLuFqp6q43ypcBbBT57xfV1W0fAhFd6S
1SpFKnsvWtZT/vdyMTXlr16eUvHv3seNEQ5E6f2whUZ5RaJNJNfYVsk30KrwOXP9
yRtWLv5ZNc/VdPHtf1SM6VXEjj+bZ5R3m/6fCm7YUmNi4+MJ/lrcv1LC4r4cqE9a
+K6voS/fXsfI8bKJw5WRpxN2OzSFhQMlb0wn5+M27NCotjHmS2KcpFjIlVh89F09
xEjHjWc9w3felMnUjDpOshaQWRC/7MYycB/JAf6PUO5iEFgEK4gibAJNvewB8DRJ
cestMI475/HI1XcDNi261s0XxlUGxyZQnrzdg0TKxr0M46GbFpo0iU+TAjAoX0JJ
4LMABMw1dfJhg1j6IiqwSqZdJoH3UQVnqRejCx3XN+Q54RKb2aHr0WEwJAENit1V
r19HdmiReM0Zq2LOlDumjAq8vkWDFQrXU7+L37sONBwu0aB0n1CENnq3qnLQv+SB
U9UOx8PA7qyXqIAFfA8T
=v2Qi
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

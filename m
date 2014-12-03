From: "Kim, Milo" <milo.kim@ti.com>
Date: Wed, 03 Dec 2014 01:56:24 +0000
Subject: Re: [PATCH v2 1/2] backlight/lp855x: Refactor dt parsing code
Message-Id: <547E6DC8.6070501@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417570752-23633-1-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1417570752-23633-1-git-send-email-seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, =?UTF-8?B?U3TDqXBoYW5lIE1hcmNoZXNpbg==?= <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

On 12/3/2014 10:39 AM, Sean Paul wrote:
> This patch refactors the dt parsing code to avoid setting platform_data,
> instead just setting lp->pdata directly. This facilitates easier
> probe deferral since the current scheme would require us to clear out
> dev->platform_data before deferring.
>
> Cc: St=C3=A9phane Marchesin<marcheu@chromium.org>
> Signed-off-by: Sean Paul<seanpaul@chromium.org>

Acked-by: Milo Kim <milo.kim@ti.com>

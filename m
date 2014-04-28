From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 28 Apr 2014 10:27:38 +0000
Subject: Re: [PATCH] video/backlight: Fix string type mismatch in s6e63m0.c
Message-Id: <20140428102738.GG21279@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398354436-25467-1-git-send-email-standby24x7@gmail.com>
In-Reply-To: <1398354436-25467-1-git-send-email-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Masanari Iida <standby24x7@gmail.com>
Cc: jg1.han@samsung.com, cooloney@gmail.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

> Fix string type mismatch in s6e63m0_sysfs_show_gamma_table().
> gamma_table_count is defined as unsigned int.
>=20
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  drivers/video/backlight/s6e63m0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

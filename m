From: Joe Perches <joe@perches.com>
Date: Tue, 30 Aug 2016 19:19:23 +0000
Subject: Re: [PATCH 7/9] staging: sm750fb: fix block comment style issues in ddk750_chip.c
Message-Id: <1472584763.5512.119.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
         <ad80e695e9730861466d5960359b06af27ca7c30.1472583825.git.mgmoshes@gmail.com>
In-Reply-To: <ad80e695e9730861466d5960359b06af27ca7c30.1472583825.git.mgmoshes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Moshe Green <mgmoshes@gmail.com>, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Tue, 2016-08-30 at 22:05 +0300, Moshe Green wrote:
> Fix block comment * prefix and trailing */ warnings found
> by the checkpatch.pl tool in ddk750_chip.c.
[]
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm75=
0fb/ddk750_chip.c
[]
> @@ -320,8 +320,10 @@ unsigned int calcPllValue(unsigned int request_orig,=
 pll_value_t *pll)
> =A0	int max_d =3D 6;
> =A0
> =A0	if (getChipType() =3D SM750LE) {
> -		/* SM750LE don't have prgrammable PLL and M/N values to work on.
> -		Just return the requested clock. */
> +		/* SM750LE don't have
> +		=A0* prgrammable PLL and M/N values to work on

Might as well fix the programmable typo too.


From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 07 Nov 2018 11:33:04 +0000
Subject: Re: [PATCH] staging: sm750fb: Add spaces around '+'
Message-Id: <20181107113304.GB31662@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181107002804.25345-1-laispc19@gmail.com>
In-Reply-To: <20181107002804.25345-1-laispc19@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?La=EDs?= Pessine do Carmo <laispc19@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org

On Tue, Nov 06, 2018 at 10:28:04PM -0200, La=EDs Pessine do Carmo wrote:
> Add spaces around '+' to correct the following checkpath.pl warnings:
>=20
> WARNING: line over 80 characters
> +                       write_dpPort(accel, *(unsigned int *)(pSrcbuf +
> (j * 4)));
>=20
> WARNING: line over 80 characters
> +                       memcpy(ajRemain, pSrcbuf+ul4BytesPerScan,
> ulBytesRemain);

No need to line-wrap these warning lines next time.

thanks,

greg k-h

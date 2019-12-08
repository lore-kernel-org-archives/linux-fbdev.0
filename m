From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Date: Sun, 08 Dec 2019 20:25:11 +0000
Subject: Re: [PATCH] video: fbdev: added driver for sharp memory lcd displays
Message-Id: <CACk9uecHrKDQHdL=fgz0xVF4oKUBOUUyRAt-cMn6m0YCOf9v_g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1575554335-27197-1-git-send-email-alencar.fmce@imbel.gov.br> <201912090055.QXDo7ygw%lkp@intel.com>
In-Reply-To: <201912090055.QXDo7ygw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rodrigo Rolim Mendes de <alencar.fmce@imbel.gov.br>

Hello,

Em dom., 8 de dez. de 2019 =C3=A0s 13:56, kbuild test robot <lkp@intel.com>=
 escreveu:
>
> Hi Rodrigo,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on linux/master]
> [also build test WARNING on robh/for-next linus/master v5.4 next-20191208]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>
> url:    https://github.com/0day-ci/linux/commits/Rodrigo-Rolim-Mendes-de-=
Alencar/video-fbdev-added-driver-for-sharp-memory-lcd-displays/20191207-112=
607
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t 26bc672134241a080a83b2ab9aa8abede8d30e1c
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-91-g817270f-dirty
>         make ARCH=3Dx86_64 allmodconfig
>         make C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
> >> drivers/video/fbdev/smemlcdfb.c:71:29: sparse: sparse: incorrect type =
in initializer (different address spaces) @@    expected unsigned char [use=
rtype] *vmem @@    got signed char [usertype] *vmem @@
> >> drivers/video/fbdev/smemlcdfb.c:71:29: sparse:    expected unsigned ch=
ar [usertype] *vmem
> >> drivers/video/fbdev/smemlcdfb.c:71:29: sparse:    got char [noderef] <=
asn:2> *screen_base
>
> vim +71 drivers/video/fbdev/smemlcdfb.c
>
>     67
>     68  static void smemlcd_update(struct smemlcd_par *par)
>     69  {
>     70          struct spi_device *spi =3D par->spi;
>   > 71          u8 *vmem =3D par->info->screen_base;

A cast is really necessary here?

>     72          u8 *buf_ptr =3D par->spi_buf;
>     73          int ret;
>     74          u32 i,j;
>     75
>     76          if (par->start + par->height > par->info->var.yres) {
>     77                  par->start =3D 0;
>     78                  par->height =3D 0;
>     79          }
>     80          /* go to start line */
>     81          vmem +=3D par->start * par->vmem_width;
>     82          /* update vcom */
>     83          par->vcom ^=3D SMEMLCD_FRAME_INVERSION;
>     84          /* mode selection */
>     85          *(buf_ptr++) =3D (par->height)? (SMEMLCD_DATA_UPDATE | pa=
r->vcom) : par->vcom;
>     86
>     87          /* not all SPI masters have LSB-first mode, bitrev8 is us=
ed */
>     88          for (i =3D par->start + 1; i < par->start + par->height +=
 1; i++) {
>     89                  /* gate line address */
>     90                  *(buf_ptr++) =3D bitrev8(i);
>     91                  /* data writing */
>     92                  for (j =3D 0; j < par->spi_width; j++)
>     93                          *(buf_ptr++) =3D bitrev8(*(vmem++));
>     94                  /* dummy data */
>     95                  *(buf_ptr++) =3D SMEMLCD_DUMMY_DATA;
>     96                  /* video memory alignment */
>     97                  for (; j < par->vmem_width; j++)
>     98                          vmem++;
>     99          }
>    100          /* dummy data */
>    101          *(buf_ptr++) =3D SMEMLCD_DUMMY_DATA;
>    102
>    103          ret =3D spi_write(spi, &(par->spi_buf[0]), par->height * =
(par->spi_width + 2) + 2);
>    104          if (ret < 0)
>    105                  dev_err(&spi->dev, "Couldn't send SPI command.\n"=
);
>    106
>    107          par->start =3D U32_MAX;
>    108          par->height =3D 0;
>    109  }
>    110
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology C=
enter
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corpor=
ation

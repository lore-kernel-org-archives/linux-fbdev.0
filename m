From: kbuild test robot <lkp@intel.com>
Date: Sun, 08 Dec 2019 16:55:22 +0000
Subject: Re: [PATCH] video: fbdev: added driver for sharp memory lcd displays
Message-Id: <201912090055.QXDo7ygw%lkp@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1575554335-27197-1-git-send-email-alencar.fmce@imbel.gov.br>
In-Reply-To: <1575554335-27197-1-git-send-email-alencar.fmce@imbel.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
Cc: kbuild-all@lists.01.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, alencar.fmce@imbel.gov.br

Hi Rodrigo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on robh/for-next linus/master v5.4 next-20191208]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Rodrigo-Rolim-Mendes-de-Alencar/video-fbdev-added-driver-for-sharp-memory-lcd-displays/20191207-112607
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 26bc672134241a080a83b2ab9aa8abede8d30e1c
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-91-g817270f-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/smemlcdfb.c:71:29: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [usertype] *vmem @@    got signed char [usertype] *vmem @@
>> drivers/video/fbdev/smemlcdfb.c:71:29: sparse:    expected unsigned char [usertype] *vmem
>> drivers/video/fbdev/smemlcdfb.c:71:29: sparse:    got char [noderef] <asn:2> *screen_base

vim +71 drivers/video/fbdev/smemlcdfb.c

    67	
    68	static void smemlcd_update(struct smemlcd_par *par)
    69	{
    70		struct spi_device *spi = par->spi;
  > 71		u8 *vmem = par->info->screen_base;
    72		u8 *buf_ptr = par->spi_buf;
    73		int ret;
    74		u32 i,j;
    75	
    76		if (par->start + par->height > par->info->var.yres) {
    77			par->start = 0;
    78			par->height = 0;
    79		}
    80		/* go to start line */
    81		vmem += par->start * par->vmem_width;
    82		/* update vcom */
    83		par->vcom ^= SMEMLCD_FRAME_INVERSION;
    84		/* mode selection */
    85		*(buf_ptr++) = (par->height)? (SMEMLCD_DATA_UPDATE | par->vcom) : par->vcom;
    86	
    87		/* not all SPI masters have LSB-first mode, bitrev8 is used */
    88		for (i = par->start + 1; i < par->start + par->height + 1; i++) {
    89			/* gate line address */
    90			*(buf_ptr++) = bitrev8(i);
    91			/* data writing */
    92			for (j = 0; j < par->spi_width; j++)
    93				*(buf_ptr++) = bitrev8(*(vmem++));
    94			/* dummy data */
    95			*(buf_ptr++) = SMEMLCD_DUMMY_DATA;
    96			/* video memory alignment */
    97			for (; j < par->vmem_width; j++)
    98				vmem++;
    99		}
   100		/* dummy data */
   101		*(buf_ptr++) = SMEMLCD_DUMMY_DATA;
   102	
   103		ret = spi_write(spi, &(par->spi_buf[0]), par->height * (par->spi_width + 2) + 2);
   104		if (ret < 0)
   105			dev_err(&spi->dev, "Couldn't send SPI command.\n");
   106	
   107		par->start = U32_MAX;
   108		par->height = 0;
   109	}
   110	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

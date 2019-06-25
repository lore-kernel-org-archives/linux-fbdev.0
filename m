From: kbuild test robot <lkp@intel.com>
Date: Tue, 25 Jun 2019 22:52:59 +0000
Subject: Re: [PATCH v4 4/7] lib/hexdump.c: Replace ascii bool in hex_dump_to_buffer with flags
Message-Id: <201906260657.2cnctJGF%lkp@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625031726.12173-5-alastair@au1.ibm.com>
In-Reply-To: <20190625031726.12173-5-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alastair D'Silva <alastair@au1.ibm.com>
Cc: linux-fbdev@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>, Petr Mladek <pmladek@suse.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>, ath10k@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, alastair@d-silva.org, intel-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@oracle.com>, Jose Abreu <Jose.Abreu@synopsys.com>, Tom Lendacky <thomas.lendacky@amd.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Kalle Valo <kvalo@codeaurora.org>, Karsten Keil <isdn@linux-pingi.de>, "Martin K. Petersen" <martin.petersen@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.>

Hi Alastair,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.2-rc6 next-20190625]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alastair-D-Silva/Hexdump-Enhancements/20190625-224046
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   sound/soc/intel/skylake/skl-debug.c:191:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:2> *to @@    got eref] <asn:2> *to @@
   sound/soc/intel/skylake/skl-debug.c:191:34: sparse:    expected void [noderef] <asn:2> *to
   sound/soc/intel/skylake/skl-debug.c:191:34: sparse:    got unsigned char *
   sound/soc/intel/skylake/skl-debug.c:191:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const *from @@    got void [noderef] <asn:2> void const *from @@
   sound/soc/intel/skylake/skl-debug.c:191:51: sparse:    expected void const *from
   sound/soc/intel/skylake/skl-debug.c:191:51: sparse:    got void [noderef] <asn:2> *[assigned] fw_reg_addr
>> sound/soc/intel/skylake/skl-debug.c:195:35: sparse: sparse: too many arguments for function hex_dump_to_buffer
--
>> drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c:93:27: sparse: sparse: too many arguments for function hex_dump_to_buffer
--
>> sound/soc/sof/xtensa/core.c:125:35: sparse: sparse: too many arguments for function hex_dump_to_buffer

vim +195 sound/soc/intel/skylake/skl-debug.c

d14700a0 Vinod Koul  2017-06-30  170  
bdd0384a Vunny Sodhi 2017-06-30  171  static ssize_t fw_softreg_read(struct file *file, char __user *user_buf,
bdd0384a Vunny Sodhi 2017-06-30  172  			       size_t count, loff_t *ppos)
bdd0384a Vunny Sodhi 2017-06-30  173  {
bdd0384a Vunny Sodhi 2017-06-30  174  	struct skl_debug *d = file->private_data;
bdd0384a Vunny Sodhi 2017-06-30  175  	struct sst_dsp *sst = d->skl->skl_sst->dsp;
bdd0384a Vunny Sodhi 2017-06-30  176  	size_t w0_stat_sz = sst->addr.w0_stat_sz;
bdd0384a Vunny Sodhi 2017-06-30  177  	void __iomem *in_base = sst->mailbox.in_base;
bdd0384a Vunny Sodhi 2017-06-30  178  	void __iomem *fw_reg_addr;
bdd0384a Vunny Sodhi 2017-06-30  179  	unsigned int offset;
bdd0384a Vunny Sodhi 2017-06-30  180  	char *tmp;
bdd0384a Vunny Sodhi 2017-06-30  181  	ssize_t ret = 0;
bdd0384a Vunny Sodhi 2017-06-30  182  
bdd0384a Vunny Sodhi 2017-06-30  183  	tmp = kzalloc(FW_REG_BUF, GFP_KERNEL);
bdd0384a Vunny Sodhi 2017-06-30  184  	if (!tmp)
bdd0384a Vunny Sodhi 2017-06-30  185  		return -ENOMEM;
bdd0384a Vunny Sodhi 2017-06-30  186  
bdd0384a Vunny Sodhi 2017-06-30  187  	fw_reg_addr = in_base - w0_stat_sz;
bdd0384a Vunny Sodhi 2017-06-30  188  	memset(d->fw_read_buff, 0, FW_REG_BUF);
bdd0384a Vunny Sodhi 2017-06-30  189  
bdd0384a Vunny Sodhi 2017-06-30  190  	if (w0_stat_sz > 0)
bdd0384a Vunny Sodhi 2017-06-30 @191  		__iowrite32_copy(d->fw_read_buff, fw_reg_addr, w0_stat_sz >> 2);
bdd0384a Vunny Sodhi 2017-06-30  192  
bdd0384a Vunny Sodhi 2017-06-30  193  	for (offset = 0; offset < FW_REG_SIZE; offset += 16) {
bdd0384a Vunny Sodhi 2017-06-30  194  		ret += snprintf(tmp + ret, FW_REG_BUF - ret, "%#.4x: ", offset);
bdd0384a Vunny Sodhi 2017-06-30 @195  		hex_dump_to_buffer(d->fw_read_buff + offset, 16, 16, 4,
bdd0384a Vunny Sodhi 2017-06-30  196  				   tmp + ret, FW_REG_BUF - ret, 0);
bdd0384a Vunny Sodhi 2017-06-30  197  		ret += strlen(tmp + ret);
bdd0384a Vunny Sodhi 2017-06-30  198  
bdd0384a Vunny Sodhi 2017-06-30  199  		/* print newline for each offset */
bdd0384a Vunny Sodhi 2017-06-30  200  		if (FW_REG_BUF - ret > 0)
bdd0384a Vunny Sodhi 2017-06-30  201  			tmp[ret++] = '\n';
bdd0384a Vunny Sodhi 2017-06-30  202  	}
bdd0384a Vunny Sodhi 2017-06-30  203  
bdd0384a Vunny Sodhi 2017-06-30  204  	ret = simple_read_from_buffer(user_buf, count, ppos, tmp, ret);
bdd0384a Vunny Sodhi 2017-06-30  205  	kfree(tmp);
bdd0384a Vunny Sodhi 2017-06-30  206  
bdd0384a Vunny Sodhi 2017-06-30  207  	return ret;
bdd0384a Vunny Sodhi 2017-06-30  208  }
bdd0384a Vunny Sodhi 2017-06-30  209  

:::::: The code at line 195 was first introduced by commit
:::::: bdd0384a5ada8bb5745e5f29c10a5ba88827efad ASoC: Intel: Skylake: Add support to read firmware registers

:::::: TO: Vunny Sodhi <vunnyx.sodhi@intel.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
